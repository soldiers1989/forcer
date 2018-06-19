package com.huagu.setUp.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

public class FrmServiceAgreement extends AbstractForm {

    @Override
    public IPage execute() throws Exception {
        JspPage page = new JspPage(this, "setUp/serviceAgreement.jsp");
        LocalService svr = new LocalService(this, "SvrServiceAgreement.getAgreement");
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        page.add("values", svr.getDataOut().getRecords());
        return page;
    }

    @Override
    public boolean logon() {
        return true;
    }
}
