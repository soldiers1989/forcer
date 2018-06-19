package com.huagu.common.ui;

import cn.cerc.jbean.form.IForm;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jmis.page.AbstractJspPage;

/**
 * 专用于显示列表页面
 * 
 * @author 张弓
 *
 */
public class P001List extends AbstractJspPage {

	public P001List(IForm form) {
		super(form);
		this.setJspFile("cottoms/cottoms_list_template_new.jsp");
	}

	/**
	 * 
	 * @param title
	 *            页面标题
	 */
	public void setTitle(String title) {
		this.add("headerName", title);
	}

	/**
	 * 
	 * @param dataSet
	 *            页面数据源
	 */
	public void setDataSet(DataSet dataSet) {
		this.add("dataSet", dataSet.getRecords());
	}
}
