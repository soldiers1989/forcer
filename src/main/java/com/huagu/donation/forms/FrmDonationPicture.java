package com.huagu.donation.forms;

import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

public class FrmDonationPicture extends AbstractForm {

    @Override
    public IPage execute() throws Exception {
        JspPage page = new JspPage(this, "donation/donationPicture.jsp");
        return page;
    }

    @Override
    public boolean logon() {
        return true;
    }
}
