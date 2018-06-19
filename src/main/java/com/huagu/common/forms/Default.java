package com.huagu.common.forms;

import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;

public class Default extends AbstractForm {

	@Override
	public IPage execute() {
		/*return new JspPage(this, "public/hello.jsp");*/
		return new RedirectPage(this, "FrmLogin");
	}

	public IPage hello() {
		return new JspPage(this, "public/hello.jsp");
	}

	@Override
	public boolean logon() {
		return true;
	}
}
