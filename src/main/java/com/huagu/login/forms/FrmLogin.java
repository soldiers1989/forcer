package com.huagu.login.forms;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.huagu.common.util.LoginUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.core.CustomHandle;
import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jdb.oss.OssSession;
import cn.cerc.jmis.core.ClientDevice;
import cn.cerc.jmis.core.RequestData;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;

/**
 * 
 * @ClassName: FrmLogin
 * @Description: 用户端密码登录
 * @author lxf
 * @date 2018年2月27日
 *
 */
public class FrmLogin extends AbstractForm {
	public Logger log = Logger.getLogger(this.getClass());

	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "/login/login.jsp");
		System.out.println(this.getRequest().getParameter("userId"));
		// 版本控制
		ClientDevice info = new ClientDevice(this);
		String device = info.getDevice();
		String CLIENTID = info.getId();
		/*
		 * if (this.getUserCode() != null && !this.getUserCode().equals("")) {
		 * return new RedirectPage(this, "FrmIndex"); }
		 */

		String userId = this.getRequest().getParameter("userId");
		try (MemoryBuffer buff = new MemoryBuffer(BufferType.getObject, "FrmLogin.execute", userId)) {
			if (StringUtils.isNotEmpty(buff.getString("userId"))) {
				// 执行操作
				// 给用户增加积分
				LocalService jiFenSvr = new LocalService(this, "SvrAddUserJiFen");
				if (!jiFenSvr.exec("id_", userId)) {
					throw new RuntimeException(jiFenSvr.getMessage());
				}

				// 二维码注册，自动登录
				LocalService svr = new LocalService(this, "SvrUserLogin.autoLogin");
				String token = new ServerConfig().getProperty(OssSession.oss_accessKeySecret, "") + "ABCD";
				String userPhone = getRequest().getParameter("userPhone");
				svr.exec("token", token, "userCode", userPhone);
				buff.clear();
				// 跳转进入公众号二维码展示
				JspPage jsp = new JspPage(this, "/login/erweima.jsp");
				return jsp;
			}
			if (StringUtils.isNotEmpty(userId)) {
				// 通过扫描二维码进入登录页面
				buff.setField("userId", userId);
				page.add("userId", userId);
				page.add("qrcodeIn", "true");
			}
		}
		page.add("device", device);
		page.add("CLIENTID", CLIENTID);
		System.out.println(device);
		return page;
	}

	/**
	 * 运维人员登录
	 * @return
	 * @throws Exception
	 */
	public IPage toLogin() throws Exception {
		String mobile = this.getRequest().getParameter("userName_");
		String password_ = this.getRequest().getParameter("password_");
		
		if(mobile == "" || mobile == null ){
			JspPage page = new JspPage(this, "/login/tologin.jsp");
			return page;
		}else{
			// 取得userCode
			LocalService app = new LocalService(this, "SvrUserLogin.autoLogin");
			ServerConfig config = new ServerConfig();
			String token = config.getProperty(OssSession.oss_accessKeySecret, "") + "ABCD";
			if (!app.exec("token", token, "userCode", mobile, "password_", password_, "type_", "737111")) {
				JspPage page = new JspPage(this, "/login/tologin.jsp");
				page.add("loginMsg",app.getMessage());
				return page;
			}

			String sid = app.getDataOut().getHead().getString("SessionID_");
			if (sid != null && !sid.equals("")) {
				this.getRequest().setAttribute(RequestData.appSession_Key, sid);
				this.getRequest().getSession().setAttribute(RequestData.appSession_Key, sid);
				//登录成功保存session
				getRequest().getSession().setAttribute("userCode", mobile);
				LoginUtil.sessionMap.put(mobile, getRequest().getSession().getId());
			}
			return new RedirectPage(this, "FrmMap");
		}
	}
	
	/**
	 * 用户登录
	 * @return
	 * @throws Exception
	 */
	public IPage userLogin() throws Exception {
		String mobile = this.getRequest().getParameter("login_usr");
		
		if(mobile == "" || mobile == null ){
			JspPage page = new JspPage(this, "/login/login.jsp");
			return page;
		}else{
			// 取得userCode
			LocalService app = new LocalService(this, "SvrUserLogin.autoLogin");
			ServerConfig config = new ServerConfig();
			String token = config.getProperty(OssSession.oss_accessKeySecret, "") + "ABCD";
			if (!app.exec("token",token,"userCode",mobile)) {
				JspPage page = new JspPage(this, "/login/login.jsp");
				page.add("loginMsg",app.getMessage());
				return page;
			}

			String sid = app.getDataOut().getHead().getString("SessionID_");
			if (sid != null && !sid.equals("")) {
				this.getRequest().setAttribute(RequestData.appSession_Key, sid);
				this.getRequest().getSession().setAttribute(RequestData.appSession_Key, sid);
				//登录成功保存session
				getRequest().getSession().setAttribute("userCode", mobile);
				LoginUtil.sessionMap.put(mobile, getRequest().getSession().getId());
			}
			return new RedirectPage(this, "FrmRentWei");
		}
	}

	/**
	 * 退出登录
	 * @return
	 */
	public IPage exit() {
		// 清楚缓存
		LocalService svr = new LocalService(this, "SvrUserLogin.exitSystem");
		if (!svr.exec()) {
			throw new RuntimeException("退出错误");
		}
		CustomHandle sess = (CustomHandle) this.handle.getProperty(null);
		sess.setProperty(RequestData.appSession_Key, null);
		this.getRequest().getSession().removeAttribute(RequestData.appSession_Key);
		return new RedirectPage(this, "/?" + ClientDevice.deviceType_key + "=" + this.getClient().getDevice() + "&"
				+ ClientDevice.deviceId_key + "=" + this.getClient().getId());
	}

	/**
	 * 登录校验
	 * @return
	 */
	public IPage checkCode() {
		// 用户发送验证码登录默认就登录，没有注册功能
		JsonPage page = new JsonPage(this);
		// 创建一个本地验证验证码服务
		HttpServletRequest requets = this.getRequest();
		// 获取登录端编号
		String CorpNo_ = requets.getParameter("CorpNo_");
		String password = requets.getParameter("password");
		String mobile = requets.getParameter("mobile");
		String code_;
		if ("727000".equals(CorpNo_)) {
			System.err.println("用户登录--------------");
			
			try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, mobile, "code_")) {
				code_ = buff.getString("code_");
				log.info("登录获取验证码："+ code_);
				// 后期上线要把使用的二维码clone
				/*buff.clear();*/
			}
			
			if ("0000".equals(password) || code_.equals(password)) {
				LocalService svr2 = new LocalService(this, "SvrGetUserInfoByUserPhone");
				if (!svr2.exec("mobile", mobile, "CorpNo_", CorpNo_))
					throw new RuntimeException(svr2.getMessage());

				page.setData(true);
			} else {
				page.setData("验证码有误！");
			}
		} else {
			System.err.println("运维人员登录--------------");
			LocalService svr2 = new LocalService(this, "SvrGetUserInfoByUserPhone");
			if (!svr2.exec("mobile", requets.getParameter("mobile"), "CorpNo_", CorpNo_))
				throw new RuntimeException(svr2.getMessage());

			if (svr2.getDataOut().getRecords().size() > 0)
				page.setData(true);
			else
				page.setData("您暂无此登录权限，如有疑问请联系客服。");
		}

		return page;
	}

	public static void main(String[] args) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("name", "张三");
		jsonObject.put("sex", "男");
		jsonObject.put("age", "23");
		System.out.println("jsonObject:" + jsonObject);

		HashMap<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("name", "张三");
		hashMap.put("sex", "男");
		hashMap.put("age", "24");
		System.out.println("hashMapjson:" + JSONObject.fromObject(hashMap));

		JSONArray jsonArray = new JSONArray();
		jsonArray.add(0, "张三");
		jsonArray.add(1, "男");
		jsonArray.add(2, "25");
		System.out.println("jsonArray:" + jsonArray);

		ArrayList<String> arrayList = new ArrayList<String>();
		arrayList.add("张三");
		arrayList.add("男");
		arrayList.add("26");
		System.out.println("arrayList:" + JSONArray.fromObject(arrayList));

		// 如果JSONArray解析一个HashMap，则会将整个对象的放进一个数组的值中
		System.out.println("jsonArray FROM HASHMAP：" + JSONArray.fromObject(hashMap));

		JSONObject fuzaJson = new JSONObject();
		fuzaJson.put("name", "胡晓松");
		fuzaJson.put("age", "23");
		fuzaJson.put("sex", "女");
		fuzaJson.element("Array", jsonArray);
		System.err.println("fuzaJson:" + fuzaJson);

		// 解析JSON字符串：
		String jsonString = "{\"UserName\":\"ZHULI\",\"age\":\"30\",\"workIn\":\"ALI\",\"Array\":[\"ZHULI\",\"30\",\"ALI\"]}";
		// 将Json字符串转为java对象
		JSONObject obj = JSONObject.fromObject(jsonString);
		if (obj.has("UserName")) {
			System.out.println("UserName:" + obj.getString("UserName"));
		}
		if (obj.has("Array")) {
			JSONArray transitListArray = obj.getJSONArray("Array");
			for (int i = 0; i < transitListArray.size(); i++) {
				System.out.println("Array:" + transitListArray.get(i) + "");
			}
		}

	}

	@Override
	public boolean logon() {
		return true;
	}
}
