package com.huagu.my.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

public class FrmMyCenter extends AbstractForm {
    @Override
    public IPage execute() throws Exception {
        JspPage page = new JspPage(this, "my/MyCenter.jsp");
        LocalService svr = new LocalService(this, "SvrMyCenter.getMyData");
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        page.add("values", svr.getDataOut().getCurrent());
        return page;
    }

    // 跳转到运维端个人资料界面
    public IPage MyPerson() throws Exception {
        JspPage page1 = new JspPage(this, "my/MyCenterDate.jsp");
        String id_ = this.getUserCode();
        if ("".equals(id_)) {
            id_ = "17620458925";
        }
        LocalService svr = new LocalService(this, "SvrMyCenter.getMyData");
        if (!svr.exec("id_", id_))
            throw new RuntimeException(svr.getMessage());
        page1.add("values", svr.getDataOut().getCurrent());
        return page1;
    }

    // 跳转到运维端个人资料界面
    public IPage PersonSetUp() throws Exception {
        JspPage page1 = new JspPage(this, "my/PersonSetUp.jsp");
        return page1;
    }

    // 跳转到运维端意见反馈界面
    public IPage FeedBackYunWei() throws Exception {
        JspPage page1 = new JspPage(this, "my/FeedBackYunWei.jsp");
        LocalService svr = new LocalService(this, "SvrFeedBackYunWei.selectFeedBack");
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        page1.add("values", svr.getDataOut().getRecords());
        return page1;
    }

    public boolean logon() {
        return true;
    }
}
