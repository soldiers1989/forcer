package com.huagu.common.sesame;

import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

public class FrmSesame extends AbstractForm {

	@Override
	public IPage execute() {
		return new JspPage(this, "ali/sesame.jsp");
	}

	@Override
	public boolean logon() {
		return true;
	}
}
