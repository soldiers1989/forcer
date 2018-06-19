package com.huagu.newslist.forms;

import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

public class FrmMessageClass extends AbstractForm {
    // 消息分类页面
    @Override
    public IPage execute() throws Exception {
        JspPage page = new JspPage(this, "newslist/messageClass.jsp");
        return page;
    }

    @Override
    public boolean logon() {
        return true;
    }
}
