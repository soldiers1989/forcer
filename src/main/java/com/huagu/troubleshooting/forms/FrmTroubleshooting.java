package com.huagu.troubleshooting.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;

public class FrmTroubleshooting extends AbstractForm {

    @Override
    public IPage execute() throws Exception {
        JspPage page = new JspPage(this, "troubleshooting/troubleshooting.jsp");
        LocalService svr = new LocalService(this, "SvrTroubleshooting.getTroubleshooting");
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        page.add("values", svr.getDataOut().getRecords());
        return page;
    }

    // 添加
    public IPage addTroubleshooting() throws Exception {
        LocalService svr = new LocalService(this, "SvrTroubleshooting.addTroubleshooting");
        Record headIn = svr.getDataIn().getHead();
        headIn.setField("content_", this.getRequest().getParameter("content_"));
        headIn.setField("title_", this.getRequest().getParameter("title_"));
        headIn.setField("date_", this.getRequest().getParameter("date_"));
        headIn.setField("id_", this.getRequest().getParameter("id_"));
        headIn.setField("type_", this.getRequest().getParameter("type_"));
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        return new RedirectPage(this, "FrmTroubleshooting");
    }

    // 跳转到添加页面
    public IPage gotoAddTroubleshooting() throws Exception {
        JspPage page = new JspPage(this, "troubleshooting/addTroubleshooting.jsp");
        return page;
    }

    // 删除
    public IPage delTroubleshooting() throws Exception {
        String id_ = this.getRequest().getParameter("id_");
        LocalService svr = new LocalService(this, "SvrTroubleshooting.delTroubleshooting");
        if (!svr.exec("id_", id_))
            throw new RuntimeException(svr.getMessage());
        return execute();
    }

    // 跳转到修改页面
    public IPage gotoUpTroubleshooting() throws Exception {
        JspPage page = new JspPage(this, "troubleshooting/upTroubleshooting.jsp");
        String id_ = this.getRequest().getParameter("id_");
        LocalService svr = new LocalService(this, "SvrTroubleshooting.getTroubleshooting");
        Record headIn = svr.getDataIn().getHead();
        headIn.setField("falg", 1);
        headIn.setField("id_", id_);
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        page.add("values", svr.getDataOut().getCurrent());
        return page;
    }

    // 修改
    public IPage upTroubleshooting() throws Exception {
        LocalService svr = new LocalService(this, "SvrTroubleshooting.upTroubleshooting");
        Record headIn = svr.getDataIn().getHead();
        headIn.setField("id_", this.getRequest().getParameter("id_"));
        headIn.setField("title_", this.getRequest().getParameter("title_"));
        headIn.setField("content_", this.getRequest().getParameter("content_"));
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        return execute();
    }

    @Override
    public boolean logon() {
        return true;
    }

}
