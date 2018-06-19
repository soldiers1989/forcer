package com.huagu.admin.forms;

import java.util.HashMap;
import java.util.Map;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;

/**
 * 
 * @ClassName: FrmEditPhonePaswd
 * @Description: 后台修改密码
 * @author li
 * @date 2017年7月25日 下午2:36:09
 *
 */
public class FrmEditPhonePaswd extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "ui/FrmEditPhone.jsp");
		String newPhone = getRequest().getParameter("phone");
		if (newPhone != null && !newPhone.equals("")) {
			LocalService svr = new LocalService(this, "SvrSetMobile");
			if (!svr.exec("mobile_", newPhone, "code", getUserCode()))
				throw new RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmAdminIndex");
		}
		// LocalService svr1 = new LocalService(this, "SvrUserInfo");
		// if (!svr1.exec("code", getUserCode()))
		// throw new RuntimeException(svr1.getMessage());
		// page.add("oldPhone", svr1.getDataOut().getRecords().get(0).getItems().get("mobile_"));
		return page;
	}
	
	public IPage toFrmEditPhone2() {
		JspPage jspPage = new JspPage(this, "ui/FrmEditPhone2.jsp");
		jspPage.add("oldPhone", this.getRequest().getParameter("oldPhone"));
		
		return jspPage;
	}

	public IPage editPwd() throws Exception {
		JspPage page = new JspPage(this, "ui/FrmEditPwd.jsp");
		String oldpwd = getRequest().getParameter("oldpwd");
		String newpwd = getRequest().getParameter("newpwd");
		if (oldpwd != null && newpwd != null) {
			LocalService svr = new LocalService(this, "SvrEditPassWord");
			if (!svr.exec("oldpwd", oldpwd, "newpwd", newpwd)) {
				page.add("info", svr.getMessage());
				return new RedirectPage(this, "FrmAdminLogin");
			} else {
				return new RedirectPage(this, "FrmAdminLogin");
			}
		}
		return page;
	}

	/**
	 * 修改手机号
	 */
	public IPage updateMobile() throws Exception {
		JspPage page = new JspPage(this, "ui/FrmEditPhone.jsp");
		String newPhone = getRequest().getParameter("phone");
		String validateCode = getRequest().getParameter("validateCode");
		LocalService svr = new LocalService(this, "CheckValidateCodeService");
		if (!svr.exec("sid", this.getRequest().getSession().getId(), "mobile", newPhone, "code", validateCode)) {
			page.add("errMsg", "验证错误");
			return new RedirectPage(this, "FrmEditPhonePaswd");
		}

		if (newPhone != null && !newPhone.equals("")) {
			svr = new LocalService(this, "SvrSetMobile");
			if (!svr.exec("mobile_", newPhone, "code", getUserCode()))
				throw new RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmAdminIndex");
		}
		return page;
	}

	/**
	 * 发送验证码
	 */
	public IPage getValidate() throws Exception {
		JsonPage page = new JsonPage(this);
		String status = "success";
		Map<String, String> returnJson = new HashMap<>();
		String userName = this.getRequest().getParameter("userName");

		LocalService svr1 = new LocalService(this, "SendValidateCodeService");
		if (!svr1.exec("mobile", userName, "sid", this.getRequest().getSession().getId()))
			status = svr1.getMessage();
		returnJson.put("status", status);
		page.setData(returnJson);
		return page;
	}

	/**
	 * 验证验证码是否正确
	 */
	public IPage checkValidate() throws Exception {
		JsonPage page = new JsonPage(this);
		String status = "success";
		Map<String, String> returnJson = new HashMap<>();
		String newPhone = getRequest().getParameter("phone");
		String validateCode = getRequest().getParameter("validateCode");
		LocalService svr = new LocalService(this, "CheckValidateCodeService");
		if (!svr.exec("sid", this.getRequest().getSession().getId(), "mobile", newPhone, "code", validateCode)) {
			status = svr.getMessage();
			returnJson.put("status", status);
		}
		page.setData(returnJson);
		return page;
	}

	/**
	 * 验证原始号码是否正确
	 */
	public IPage checkOldPhone() throws Exception {
		JsonPage page = new JsonPage(this);
		String status = "success";
		Map<String, String> returnJson = new HashMap<>();
		String oldPhone = getRequest().getParameter("oldPhone");
		LocalService svr = new LocalService(this, "SvrCheckOldPhoneNum");
		if (!svr.exec("oldPhone", oldPhone)) {
			status = svr.getMessage();
			returnJson.put("status", status);
		}
		page.setData(returnJson);
		
		return page;
	}

	@Override
	public boolean logon() {
		return true;
	}

}
