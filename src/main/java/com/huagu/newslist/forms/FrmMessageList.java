package com.huagu.newslist.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

public class FrmMessageList extends AbstractForm {
    // 查询系统消息
    @Override
    public IPage execute() throws Exception {
        JspPage page = new JspPage(this, "newslist/systemMessageList.jsp");
        LocalService svr = new LocalService(this, "SvrGetMessage.getSystem");
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        page.add("values", svr.getDataOut().getRecords());
        return page;
    }

    // 查询订单详情
    public IPage getSystemDetails() throws Exception {
        JspPage page = new JspPage(this, "newslist/systemDetails.jsp");
        LocalService svr = new LocalService(this, "SvrGetMessage.getSystemDetails");
        Record headIn = svr.getDataIn().getHead();
        headIn.setField("id_", this.getRequest().getParameter("id_"));
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        page.add("values", svr.getDataOut().getCurrent());
        return page;
    }

    // 查询订单消息
    public IPage getOrder() throws Exception {
        JspPage page = new JspPage(this, "newslist/orderMessageList.jsp");
        String userCode = this.getUserCode();
        if ("".equals(userCode)) {
            userCode = "17620458925";
        }
        LocalService svr = new LocalService(this, "SvrGetMessage.getOrder");
        if (!svr.exec("userCode", userCode))
            throw new RuntimeException(svr.getMessage());
        page.add("values", svr.getDataOut().getRecords());
        return page;
    }

    @Override
    public boolean logon() {
        return true;
    }
}
