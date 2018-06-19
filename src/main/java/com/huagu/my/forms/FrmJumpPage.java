package com.huagu.my.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

public class FrmJumpPage extends AbstractForm {

    @Override
    public IPage execute() throws Exception {
        return null;
    }

    // 跳转到修改密码界面(运维端)
    public IPage updatePasswordYunWei() throws Exception {
    	String userid_ = this.getUserCode();
        JspPage page = new JspPage(this, "my/updatePassword.jsp");
        page.add("userid", userid_);
        return page;
    }

    // 跳转到服务协议界面(运维端)
    public IPage serviceAgreementYunWei() throws Exception {
        JspPage page = new JspPage(this, "my/serviceAgreementYunWei.jsp");
        LocalService svr = new LocalService(this, "SvrServiceAgreement.getAgreement");
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        page.add("values", svr.getDataOut().getRecords());
        return page;
    }

    // 跳转到使用帮助界面(运维端)
    public IPage helpCenterYunWei() throws Exception {
        JspPage page = new JspPage(this, "my/helpCenterYunWei.jsp");
        LocalService svr = new LocalService(this, "SvrHelpcenter.getArticle");
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        page.add("values", svr.getDataOut().getRecords());
        return page;
    }

    // 跳转到关于我们界面(运维端)
    public IPage aboutUsYunWei() throws Exception {
        JspPage page = new JspPage(this, "my/aboutUsYunWei.jsp");
        LocalService svr = new LocalService(this, "SvrAboutUsAndPhone.aboutUs");
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        page.add("values", svr.getDataOut().getRecords());
        return page;
    }

    // 跳转到客服电话界面(运维端)
    public IPage phoneYunWei() throws Exception {
        JspPage page = new JspPage(this, "my/phoneYunWei.jsp");
        LocalService svr = new LocalService(this, "SvrAboutUsAndPhone.Phone");
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        page.add("values", svr.getDataOut().getRecords());
        return page;
    }

    public boolean logon() {
        return true;
    }
}
