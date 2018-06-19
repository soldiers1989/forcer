package com.huagu.setUp.forms;

import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

public class FrmSetUp extends AbstractForm {

    @Override
    public IPage execute() throws Exception {
        JspPage page = new JspPage(this, "setUp/setUp.jsp");
        return page;
    }

    @Override
    public boolean logon() {
        return true;
    }
}
