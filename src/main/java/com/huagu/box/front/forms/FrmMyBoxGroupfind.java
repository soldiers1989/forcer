package com.huagu.box.front.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

public class FrmMyBoxGroupfind extends AbstractForm {
    // 附近柜模糊查询
    @Override
    public IPage execute() throws Exception {
        JspPage page = new JspPage(this, "box/FrmMyBoxGroupSearch_user.jsp");
        // 当前的经纬度
        // String curlongitude = getRequest().getParameter("longitude");
        // String curlatitude = getRequest().getParameter("latitude");
        // if (StringUtils.isEmpty(curlongitude) ||
        // StringUtils.isEmpty(curlatitude)) {
        // // 测试数据，待删除
        // curlongitude = "113.872166";
        // curlatitude = "22.581929";
        // }

        LocalService svr = new LocalService(this, "SvrMyBoxGroupfind.findGroup");
        Record headIn = svr.getDataIn().getHead();
        headIn.setField("address_", this.getRequest().getParameter("address_"));
        headIn.setField("curlongitude", "113.882703");
        headIn.setField("curlatitude", "22.577428");
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        page.add("values", svr.getDataOut().getRecords());
        System.out.println(svr.getDataOut().getRecords());
        return page;
    }

    @Override
    public boolean logon() {
        return true;
    }
}
