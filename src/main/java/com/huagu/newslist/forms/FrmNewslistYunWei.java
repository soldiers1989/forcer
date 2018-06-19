package com.huagu.newslist.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

public class FrmNewslistYunWei extends AbstractForm {

    @Override
    public IPage execute() throws Exception {
        JspPage page = new JspPage(this, "newslist/newslistYunWei.jsp");
        LocalService svr = new LocalService(this, "SvrNewslist.getNewList");
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        page.add("values", svr.getDataOut().getRecords());
        return page;
    }

    // 跳转到消息详情（运维端）
    public IPage detail() throws Exception {
        JspPage page = new JspPage(this, "newslist/newsDetailYunWei.jsp");
        LocalService svr = new LocalService(this, "SvrNewslist.getNew");
        Record headIn = svr.getDataIn().getHead();
        headIn.setField("id_", this.getRequest().getParameter("id_"));
        System.out.println(headIn);
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
