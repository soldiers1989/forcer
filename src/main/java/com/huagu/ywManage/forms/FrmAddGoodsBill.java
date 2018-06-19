package com.huagu.ywManage.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

/**
 * 补货单
 * @author wj  
 * @date 2018年4月26日 
 *
 */
public class FrmAddGoodsBill extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "ywmanage/addGoods.jsp");
		LocalService svr = new LocalService(this, "SvrAddGoodsQuery");
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		if(!svr.getDataOut().bof())
			jsp.add("addGoods", svr.getDataOut().getRecords());
		return jsp;
	}
	
	@Override
	public boolean logon() {
		return true;
	}

}
