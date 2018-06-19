package com.huagu.my.forms;

import java.util.HashMap;
import java.util.Map;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;

public class FrmCollect extends AbstractForm {
    //收藏列表
    @Override
    public IPage execute() throws Exception {
        JspPage jsp = new JspPage(this, "my/FrmCollect.jsp");
        LocalService svr = new LocalService(this, "SvrCollect.search");
        if(!svr.exec()) {
            jsp.add("msg", svr.getMessage());
            return jsp;
        }
        jsp.add("collects", svr.getDataOut().getRecords());
        return jsp;
    }
    //新增收藏
    public IPage add() {
        JsonPage json = new JsonPage(this);
        Map<String, String> result = new HashMap<>();
        String zhuCode_ = this.getRequest().getParameter("zhuCode_");
        LocalService svr = new LocalService(this, "SvrCollect.add");
        if(!svr.exec("zhuCode_",zhuCode_)) {
            result.put("msg", svr.getMessage());
            return json.setData(result);
        }
        result.put("status", svr.getDataOut().getHead().getString("status_"));
        return json.setData(result);
    }
    
    //删除收藏
    public IPage delete() {
        JsonPage json = new JsonPage(this);
        Map<String, String> result = new HashMap<>();
        String proIds = this.getRequest().getParameter("proIds");
        LocalService svr = new LocalService(this, "SvrCollect.delete");
        if(!svr.exec("proIds",proIds)) {
            result.put("status", "fail");
            result.put("msg", svr.getMessage());
            return json.setData(result);
        }
        result.put("status", "success");
        result.put("msg", "删除收藏成功");
        return json.setData(result);
    }
    @Override
    public boolean logon() {
        return true;
    }
    
}
