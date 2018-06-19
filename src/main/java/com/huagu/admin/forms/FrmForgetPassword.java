package com.huagu.admin.forms;

import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

/**
 * 后台找回密码
 * @author sun
 *
 */
public class FrmForgetPassword extends AbstractForm{

	@Override
	public IPage execute() throws Exception {
		return new JspPage(this,"admin/FrmAdminBackPwd.jsp");
	}
	
	@Override
	public boolean logon() {
		return true;
	}

}
