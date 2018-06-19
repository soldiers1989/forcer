package com.huagu.admin.forms;

import java.net.URLEncoder;
import javax.servlet.http.Cookie;
import org.apache.commons.lang.StringUtils;
import com.huagu.common.ui.P002Login;
import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.core.CustomHandle;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jmis.core.RequestData;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;

/**
 * 
 * @ClassName: FrmAdminLogin
 * @Description: 后台登录
 * @author li
 * @date 2017年7月25日 下午2:36:09
 *
 */
public class FrmAdminLogin extends AbstractForm {
	@Override
	public IPage execute() throws Exception {
		P002Login page = new P002Login(this);
		String loginType = this.getRequest().getParameter("loginType");
		String login_usr = this.getRequest().getParameter("login_usr");
		String login_pwd = this.getRequest().getParameter("login_pwd");
		String check = this.getRequest().getParameter("checkName");
		String loginMsg = this.getRequest().getParameter("loginMsg");
		if(StringUtils.isNotEmpty(loginMsg)){
			page.add("loginMess", loginMsg);
		}
		// 数据埋点 -- 绑定
		LocalService svr1 = new LocalService(this, "SvrDataPointLogin");
		LocalService svr2 = new LocalService(this, "SvrFindAdminLogin");
		if(this.getUserCode() != null && !this.getUserCode().equals("")){
			if(loginType == null || loginType.equals("") ){
				return page;
			}
			if(check != null && check.equals("remember")){
				Cookie nameCookie = new Cookie("userCode_", URLEncoder.encode(login_usr, "utf-8"));;
				Cookie pwdCookie = new Cookie("userPwd_", login_pwd);
				nameCookie.setMaxAge(60 * 60 * 24 * 7);
				pwdCookie.setMaxAge(60 * 60 * 24 * 7);
				this.getResponse().addCookie(nameCookie);
				this.getResponse().addCookie(pwdCookie);
			}else{
				Cookie nameCookie = new Cookie("userCode_", "");
				Cookie pwdCookie = new Cookie("userPwd_", "");
				this.getResponse().addCookie(nameCookie);
				this.getResponse().addCookie(pwdCookie);
			}
			if(loginType.equals("common"))
				svr2.exec("name",login_usr+"用户登录");
				DataSet ds = svr2.getDataOut();
				ds.append();
				if(ds.getRecords().size()==1){
					svr1.exec("DataPointName", login_usr+"用户登录", "DataPointUrl", "FrmAdminLogin", "corpNo",
							this.getCorpNo(), "TickCount", "1");
				}
				
				return new RedirectPage(this,"FrmAdminIndex");
		}
		
		return page;
	}
	
	public IPage setMobile() throws Exception{
		JspPage page = new JspPage(this, "ui/FrmFristLogin_step2.jsp");
		String code = null;
		try(MemoryBuffer buffer = new MemoryBuffer(BufferType.getGrid, "userName")){
			code = buffer.getString("userName");
		}
		if(code == null){
			return this.execute();
		}
		LocalService svr  = new LocalService(this,"SvrSetMobile");
		if(!svr.exec("mobile_",this.getRequest().getParameter("mobile"),"code",code))
			throw new Exception(svr.getMessage());
		return page;
	}

	public IPage setNewPassWord() throws Exception{
		JspPage page = new JspPage(this, "ui/FrmFristLogin_step3.jsp");
		
		LocalService svr  = new LocalService(this,"SvrUpdatePassWord");
		String userName = null;
		try(MemoryBuffer buffer = new MemoryBuffer(BufferType.getGrid, "userName")){
			userName = buffer.getString("userName");
			buffer.clear();
		}
				
		if(!svr.exec("userName", userName, "passWord", getRequest().getParameter("newPassword")))
			throw new Exception(svr.getMessage());
		
		return page;
	}
	
	public IPage exit(){
		// 清楚缓存
		/*FrmLogin.clear(this,this.getUserCode());*/
		LocalService svr = new LocalService(this, "SvrUserLogin.exitSystem");
		if (!svr.exec()) {
			throw new RuntimeException("退出错误");
		}
		CustomHandle sess = (CustomHandle) this.handle.getProperty(null);
		sess.setProperty(RequestData.appSession_Key, null);
		this.getRequest().getSession().removeAttribute(RequestData.appSession_Key);
		return new RedirectPage(this,"FrmAdminLogin");
	}
	
	@Override
	public boolean logon() {
		return true;
	}
}
