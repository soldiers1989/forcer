package com.huagu.product.forms;

import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

public class FrmWei_salePro extends AbstractForm{

	@Override
	public IPage execute() throws Exception {
		JspPage page=new JspPage(this,"products/FrmWei_saleProFirst.jsp");
		return page;
	}

}
