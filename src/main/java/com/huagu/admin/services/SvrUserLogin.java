package com.huagu.admin.services;

import static cn.cerc.jdb.other.utils.intToStr;
import static cn.cerc.jdb.other.utils.newGuid;
import static cn.cerc.jdb.other.utils.random;
import java.util.Date;
import org.apache.log4j.Logger;
import com.huagu.common.constant.ReportConstant;
import com.huagu.common.global.appdb;
import com.huagu.login.forms.FrmLogin;
import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.core.Application;
import cn.cerc.jbean.core.CustomHandle;
import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jbean.core.Webfunc;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jbean.other.SystemTable;
import cn.cerc.jbean.tools.MD5;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlOperator;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.mysql.Transaction;
import cn.cerc.jdb.oss.OssSession;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.services.SecurityCheckException;

/**
 * 用于用户登录
 * 
 * @author 张弓
 *
 */
public class SvrUserLogin extends CustomService {
	private Logger log = Logger.getLogger(FrmLogin.class);

	private static String GuidNull = "";
	private static int Max_Viability = 1;
	public static int VerifyCodeTimeout = 5; // 效验代码超时时间（分钟）

	/*
	 * 用户登录入口
	 */
	@SuppressWarnings("unused")
	@Webfunc
	public boolean Check() throws SecurityCheckException {
		DataSet dataIn = this.getDataIn();
		DataSet dataOut = this.getDataOut();
		Record headIn = dataIn.getHead();
		String userCode = headIn.getSafeString("Account_");
		String deviceId = headIn.getSafeString("MachineID_");
		String savePwd = headIn.getSafeString("savePwd");
		if (userCode.equals(""))
			throw new SecurityCheckException("用户帐号不允许为空！");
		String password = headIn.getSafeString("Password_");
		String deviceName = headIn.getSafeString("MachineID_");
		String md5Password = MD5.get(userCode + password);
		String type_ = headIn.getSafeString("type_"); // APP类型
		String code_ = headIn.getString("code_"); // 验证码

		log.info("设备号：" + deviceId);

		SqlQuery dsUser = new SqlQuery(this);
		dsUser.add(
				"SELECT UID_,id_,code_,corpNo_,name_,password_,mobile_,roleCode_,enabled_,isCheckPwd_,loginTime_ FROM %s",
				SystemTable.get(SystemTable.getUserInfo));
		dsUser.add(" where code_ = '%s'", userCode);
		dsUser.open();

		if (headIn.exists("loginType") && headIn.getString("loginType").equals("common")) {
			log.info("正在验证是否为后台登录用户...");
			// 后台登录
			if (dsUser.getString("roleCode_").equals("2")) {
				throw new RuntimeException("该用户不属于管理员！");
			}
			// 验证密码
			if (!dsUser.getString("password_").equals(md5Password)) {
				throw new RuntimeException("密码错误，请联系管理员！");
			}
			dsUser.edit();
			dsUser.setField("loginTime_", TDateTime.Now());
			dsUser.post();
		}

		/*if ("".equals(code_)) {
			// 如果不是微信登录则验证密码
			if (!dsUser.getString("password_").equals(md5Password)) {
				throw new RuntimeException("密码错误");
			}
		}*/

		if (dsUser.getInt("isBlack_") == 1) {
			throw new RuntimeException("账户禁用");
		}

		if ("0".equals(dsUser.getString("enabled_"))) {
			throw new RuntimeException("用户尚未启用");
		}

		// 后台用户，手机号为空时，首次登录
		/*
		 * if ((!dsUser.getString("roleCode_").equals("2")) &&
		 * StringUtils.isEmpty(dsUser.getString("mobile_"))) { throw new
		 * RuntimeException("needfirstLogin"); }
		 */

		CustomHandle sess = (CustomHandle) this.getProperty(null);
		if (headIn.exists("ClientIP_"))
			sess.setProperty(Application.clientIP, headIn.getSafeString("ClientIP_"));
		else
			sess.setProperty(Application.clientIP, "0.0.0.0");

		String token = GuidFixStr(newGuid());
		try (Transaction tx = new Transaction(this)) {
			sess.setProperty(Application.token, token);
			sess.setProperty(Application.userId, dsUser.getString("id_"));
			sess.setProperty(Application.bookNo, dsUser.getString("corpNo_"));
			sess.setProperty(Application.userCode, dsUser.getString("code_"));
			sess.setProperty(Application.roleCode, dsUser.getString("roleCode_"));
			// 更新当前用户总数
			String screen = headIn.getSafeString("screen_");
			updateCurrentUser(deviceName, screen);

			// 数据埋点 -- 登录
			updateDataPoint("Frmlogin", handle.getCorpNo(), 1);

			if (!headIn.exists("loginType") || !headIn.getString("loginType").equals("common")) {
				LocalService app = new LocalService(this, "SvrReportUserAdd");
				Record headIn1 = app.getDataIn().getHead();
				headIn1.setField("type", ReportConstant.REPORT_LOGIN);
				if (!app.exec()) {
					throw new RuntimeException("该手机号尚未注册");
				}
			}

			// 更新当前设备
			AbstractForm form = (AbstractForm) this.getHandle();
			this.updateUserTerminal(userCode, form.getClient().getId(), form.getClient().getDevice(), "727000");
			
			try (MemoryBuffer Buff = new MemoryBuffer(BufferType.getSessionInfo, (String) getProperty("UserID"),
					deviceId)) {
				Buff.setExpires(0);
				Buff.setField("UID", dsUser.getInt("UID_"));
				Buff.setField("UserID_", (String) getProperty("UserID"));
				Buff.setField("UserCode_", getUserCode());
				Buff.setField("UserName_", getUserName());
				Buff.setField("LoginTime_", sess.getProperty(Application.loginTime));

				Buff.setField("VerifyMachine", false);
			}

			// 返回值于前台
			dataOut.getHead().setField("SessionID_", (String) getProperty("ID"));
			dataOut.getHead().setField("UserID_", (String) getProperty("UserID"));
			dataOut.getHead().setField("UserCode_", getUserCode());
			dataOut.getHead().setField("CorpNo_", handle.getCorpNo());
			dataOut.appendDataSet(dsUser);
			tx.commit();
			log.info(getUserCode()+ "我登录完了");
			return true;
		}
	}

	/*
	 * 退出系统
	 */
	@Webfunc
	public boolean ExitSystem() {
		if ((String) getProperty("UserID") != null)
			MemoryBuffer.delete(BufferType.getSessionInfo, (String) getProperty("UserID"), "webclient");

		String token = (String) getProperty("ID");
		getConnection().execute(String.format("Update %s Set Viability_=-1,LogoutTime_= '%s' where LoginID_='%s'",
				SystemTable.get(SystemTable.getCurrentUser), TDateTime.Now(), token));
		return true;
	}

	// 获取登录状态
	@Webfunc
	public boolean getState() {
		getDataOut().getHead().setField("UserID_", (String) getProperty("UserID"));
		getDataOut().getHead().setField("UserCode_", getUserCode());
		getDataOut().getHead().setField("CorpNo_", handle.getCorpNo());
		return true;
	}

	@Webfunc
	public boolean autoLogin() throws SecurityCheckException {
		Record headIn = getDataIn().getHead();
		CustomHandle sess = (CustomHandle) this.getProperty(null);

		String token1 = headIn.getSafeString("token");
		// 加入ABCD是为了仅允许内部调用
		ServerConfig config = new ServerConfig();
		String token2 = config.getProperty(OssSession.oss_accessKeySecret, "") + "ABCD";
		if (!token2.equals(token1))
			throw new RuntimeException("token验证错误！"); // 如果不是内部调用，则返回false

		String userCode = headIn.getSafeString("userCode");
		String password_ = headIn.getSafeString("password_");
		String md5Password = MD5.get(userCode + password_);
		
		SqlQuery getUserInfo = new SqlQuery(this);
		getUserInfo.setMaximum(1);
		
		if("727111".equals(headIn.getString("type_"))){
			getUserInfo.add("select UID_,id_,name_,corpNo_,roleCode_,code_,password_,loginTime_ from %s", SystemTable.get(SystemTable.getUserInfo));
			getUserInfo.add("where code_ = '%s'", userCode);
			getUserInfo.add(" and password_ = '%s'", md5Password);
			getUserInfo.open();
			// 修改最新登录时间
			getUserInfo.edit();
			getUserInfo.setField("loginTime_", TDateTime.Now());
			getUserInfo.post();
			if(getUserInfo.eof())
				throw new RuntimeException("用户名或密码错误，请联系客服！");
		}else{
			getUserInfo.add("select UID_,id_,name_,corpNo_,roleCode_,code_,imgUrl_,password_,enabled_,loginTime_,sex_ from %s", SystemTable.get(SystemTable.getUserInfo));
			getUserInfo.add("where code_ = '%s'", userCode);
			getUserInfo.open();
			if(!getUserInfo.eof()) {
				// 修改最新登录时间
				getUserInfo.edit();
				getUserInfo.setField("loginTime_", TDateTime.Now());
				getUserInfo.setField("name_", headIn.getString("name"));
				getUserInfo.setField("imgUrl_", headIn.getString("imgUrl"));
				getUserInfo.setField("sex_", headIn.getString("sex_"));
				getUserInfo.post();
			}else {
				// 修改最新登录时间
				getUserInfo.append();
				getUserInfo.setField("id_", userCode);
				getUserInfo.setField("name_", headIn.getString("name"));
				getUserInfo.setField("imgUrl_", headIn.getString("imgUrl"));
				getUserInfo.setField("corpNo_", "727000");
				getUserInfo.setField("roleCode_", 2);
				getUserInfo.setField("code_", userCode);
				getUserInfo.setField("loginTime_", TDateTime.Now());
				getUserInfo.setField("enabled_", 1);
				getUserInfo.setField("createTime_", TDateTime.Now());
				getUserInfo.setField("sex_", headIn.getString("sex_"));
				getUserInfo.post();
			}
		}
		
		String token = GuidFixStr(newGuid());
		try (Transaction tx = new Transaction(this)) {
			sess.setProperty(Application.token, token);
			sess.setProperty(Application.userId, getUserInfo.getString("id_"));
			sess.setProperty(Application.bookNo, getUserInfo.getString("corpNo_"));
			sess.setProperty(Application.userCode, getUserInfo.getString("code_"));
			sess.setProperty(Application.roleCode, getUserInfo.getString("roleCode_"));
			sess.setProperty(Application.loginTime, new TDateTime());
			log.info(getUserInfo.getString("id_")+"===="+getUserInfo.getString("corpNo_")+"===="+getUserInfo.getString("code_")+"===="+getUserInfo.getString("roleCode_"));
			
			// 更新当前用户总数
			String screen = headIn.getSafeString("screen_");
			updateCurrentUser("weixin", screen);

			// 数据埋点 -- 登录
			updateDataPoint("FrmWeiXin", "727000", 1);
			try (MemoryBuffer Buff = new MemoryBuffer(BufferType.getSessionInfo, (String) getProperty("UserID"),
					userCode)) {
				log.info("SvrUserLogin 获取用户数据：" + this.getUserCode()+ "用户名：" + getUserInfo.getString("name_"));
				Buff.setField("UID", getUserInfo.getInt("UID_"));
				Buff.setField("UserID_", (String) getProperty("UserID"));
				Buff.setField("UserCode_", getUserCode());
				Buff.setField("UserName_", getUserName());
				Buff.setField("LoginTime_", sess.getProperty(Application.loginTime));
			}

			headIn.setField("Account_", userCode);
			headIn.setField("ClientName_", "Web浏览器");
			headIn.setField("ClientIP_", "127.0.0.1");

			// 返回值于前台
			dataOut.getHead().setField("SessionID_", (String) getProperty("ID"));
			dataOut.getHead().setField("UserID_", (String) getProperty("UserID"));
			dataOut.getHead().setField("UserCode_", getUserCode());
			dataOut.getHead().setField("CorpNo_", handle.getCorpNo());
			dataOut.appendDataSet(getUserInfo);
			tx.commit();
			return true;
		}

	}

	private void updateUserTerminal(String userCode, String terminal, String terminaType, String corpNo) {
		SqlQuery ds = new SqlQuery(this);
		ds.setMaximum(1);
		ds.add("select UID_,terminal_,userCode_,corpNo_,type_,createTime_,updateTime_ from %s", appdb.USER_TERMINAL);
		ds.add("where corpNo_ = '%s' and userCode_ = '%s' and type_ = '%s'", corpNo, userCode, terminaType);
		ds.open();
		if (ds.eof()) {
			ds.append();
			ds.setField("userCode_", userCode);
			ds.setField("terminal_", terminal);
			ds.setField("type_", terminaType);
			ds.setField("corpNo_", corpNo);
			ds.setField("createTime_", new Date());
		} else {
			ds.edit();
			ds.setField("terminal_", terminal);
			ds.setField("updateTime_", new Date());
		}
		ds.post();
	}

	// 判断手机号码且账号类型为5是否已存在账号
	@Webfunc
	public boolean getTelToUserCode() {
		Record headIn = getDataIn().getHead();
		String userCode = headIn.getSafeString("UserCode_");

		Record headOut = getDataOut().getHead();
		if (userCode.equals("")) {
			headOut.setField("Msg_", "手机号不允许为空！");
			return false;
		}
		SqlQuery ds = new SqlQuery(this);
		ds.add("select code_ from %s", SystemTable.get(SystemTable.getUserInfo));
		ds.add("where mobile_ = '%s'", userCode);
		ds.open();
		if (ds.size() == 0) {
			headOut.setField("Msg_", "用户不存在");
			return false;
		}
		headOut.setField("UserCode_", ds.getString("code_"));
		return true;
	}

	// return 若返回值为 true，表示已校验，否则表示需要进行认证
	@Webfunc
	public boolean verifyMachine() throws SecurityCheckException {
		return true;
	}

	@Webfunc
	public boolean sendVerifyCode() throws DataValidateException {
		try (MemoryBuffer buff = new MemoryBuffer(BufferType.getObject, getUserCode(), SvrUserLogin.class.getName(),
				"sendVerifyCode")) {
			if (!buff.isNull())
				throw new RuntimeException(String.format("请勿在  %d 分钟内重复点击获取认证码！", VerifyCodeTimeout));

			Record headIn = getDataIn().getHead();
			String userCode = getUserCode();
			DataValidateException.stopRun("用户帐号不允许为空！", userCode, "");
			String deviceId = headIn.getSafeString("deviceId");
			if ("".equals(deviceId))
				throw new RuntimeException("认证码不允许为空！ ");

			SqlQuery ds1 = new SqlQuery(this);
			SqlQuery ds2 = new SqlQuery(this);
			ds1.add("select Mobile_ from %s ", SystemTable.get(SystemTable.getUserInfo));
			ds1.add("where Code_='%s' ", userCode);
			ds1.open();
			DataValidateException.stopRun("系统检测到该帐号还未登记过手机号，无法发送认证码到该手机上，请您联系管理员，让其开一个认证码给您登录系统！", ds1.eof());
			String mobile = ds1.getString("Mobile_");

			ds2.add("select * from %s", SystemTable.get(SystemTable.getDeviceVerify));
			ds2.add("where UserCode_='%s' and MachineCode_='%s'", userCode, deviceId);
			ds2.open();
			DataValidateException.stopRun("系统出错，请您重新进入系统！", ds2.size() != 1);

			String verifyCode;
			if (ServerConfig.getAppLevel() == ServerConfig.appBeta) {
				verifyCode = "888888";
			} else {
				verifyCode = intToStr(random(900000) + 100000);
			}
			ds2.edit();
			ds2.setField("VerifyCode_", verifyCode);
			ds2.setField("DeadLine_", TDateTime.Now().incDay(1));
			ds2.post();

			// 发送认证码到手机上
			LocalService svr = new LocalService(handle, "SvrNotifyMachineVerify");
			if (svr.exec("verifyCode", verifyCode, "mobile", mobile)) {
				getDataOut().getHead().setField("Msg_", String.format("系统已将认证码发送到您尾号为 %s 的手机上，并且该认证码 %d 分钟内有效，请注意查收！",
						mobile.substring(mobile.length() - 4, mobile.length()), VerifyCodeTimeout));
				buff.setExpires(60 * VerifyCodeTimeout);
				buff.setField("VerifyCode", verifyCode);
			} else
				getDataOut().getHead().setField("Msg_", String.format("验证码发送失败，失败原因：%s！", svr.getMessage()));

			getDataOut().getHead().setField("VerifyCode_", verifyCode);

			return true;
		}
	}

	private String GuidFixStr(String guid) {
		String str = guid.substring(1, guid.length() - 1);
		return str.replaceAll("-", "");
	}

	private void updateCurrentUser(String computer, String screen) {
		getConnection().execute(String.format(
				"Update %s Set Viability_=0 Where Viability_>0 and (TIME_TO_SEC(TIMEDIFF(LogoutTime_,now())))>%d",
				SystemTable.get(SystemTable.getCurrentUser), 3600));
		String SQLCmd = String.format("update %s set Viability_=-1 where Account_='%s' and Viability_>-1",
				SystemTable.get(SystemTable.getCurrentUser), getUserCode());
		getConnection().execute(SQLCmd);
		// 增加新的记录
		Record rs = new Record();
		rs.setField("UserID_", (String) this.getProperty("UserID"));
		rs.setField("CorpNo_", handle.getCorpNo());
		rs.setField("Account_", getUserCode());
		rs.setField("LoginID_", this.getProperty("ID"));
		rs.setField("Computer_", computer);
		rs.setField("LoginTime_", TDateTime.Now());
		rs.setField("ParamValue_", handle.getCorpNo());
		rs.setField("KeyCardID_", GuidNull);
		rs.setField("Viability_", intToStr(Max_Viability));
		rs.setField("LoginServer_", ServerConfig.getAppName());
		rs.setField("Screen_", screen);
		SqlOperator opear = new SqlOperator(this);
		opear.setTableName(SystemTable.get(SystemTable.getCurrentUser));
		opear.insert(rs);
	}

	private void updateDataPoint(String DataPointUrl, String corpNo, double tickcount) {
		SqlQuery sq = new SqlQuery(this);
		sq.add("select UID_,CorpNo_,CreateTime_,UpdateTime_,DataPointUrl_,DataPointName_,TickCount_,Amount_ from %s",
				appdb.getDataPoint(this));
		sq.add("where DataPointUrl_ = '%s'", DataPointUrl);
		sq.add("and CorpNo_ = '%s'", corpNo);
		sq.open();
		if (sq.eof()) {
			sq.append();
			sq.setField("CorpNo_", corpNo);
			sq.setField("createTime_", TDateTime.Now());
			sq.setField("DataPointUrl_", DataPointUrl);
			sq.setField("DataPointName_", "用户登录");
		} else {
			sq.edit();
		}
		sq.setField("TickCount_", sq.getDouble("TickCount_") + tickcount);
		sq.setField("Amount_", sq.getDouble("Amount_") + 0);
		sq.post();
	}

}
