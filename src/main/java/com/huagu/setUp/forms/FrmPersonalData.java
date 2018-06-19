package com.huagu.setUp.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

public class FrmPersonalData extends AbstractForm {

    @Override
    public IPage execute() throws Exception {
        JspPage page = new JspPage(this, "setUp/personalData.jsp");
        String userCode = this.getUserCode();
        if ("".equals(userCode)) {
            userCode = "17620458925";
        }
        LocalService svr = new LocalService(this, "SvrPersonalData.getData");
        if (!svr.exec("userCode", userCode))
            throw new RuntimeException(svr.getMessage());
        page.add("values", svr.getDataOut().getCurrent());
      /*  
		if("".equals(svr.getDataOut().getString("mobile_")) || svr.getDataOut().getString("mobile_") ==null)
			page.add("mobile_", userCode);
		else
			page.add("mobile_",svr.getDataOut().getString("mobile_"));*/
        return page;
    }

    @Override
    public boolean logon() {
        return true;
    }
}