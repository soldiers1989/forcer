package com.huagu.product.forms;

import java.util.ArrayList;
import java.util.List;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jpage.grid.MutiPage;

public class FrmAdminProState extends AbstractForm  {

	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "products/FrmProState.jsp");
		String homeAgency_ = this.getRequest().getParameter("homeAgency_");
		String zhuCode_ = this.getRequest().getParameter("zhuCode_");
		String nodeState_ = this.getRequest().getParameter("nodeState_");
		String updateDate_ = this.getRequest().getParameter("updateDate_");
		LocalService svr = new LocalService(this, "SvrAdminRentPro.queryRentProList"); 
		Record head=svr.getDataIn().getHead();
		head.setField("homeAgency_", homeAgency_);
		head.setField("zhuCode_", zhuCode_);
		head.setField("nodeState_", nodeState_);
		head.setField("updateDate_", updateDate_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("homeAgency_", homeAgency_);
		page.add("zhuCode_", zhuCode_);
		page.add("nodeState_", nodeState_);
		page.add("updateDate_", updateDate_);
		page.add("values", this.setPage(page, svr.getDataOut()));
		return page;
	}
	
	/**
	 * 分页
	 * 
	 * @param page
	 * @param dataSet
	 * @return
	 */
	private List<Record> setPage(AbstractJspPage page, DataSet dataSet) {
		List<Record> records = null;
		MutiPage pages = new MutiPage();
		pages.setRequest(getRequest());
		pages.setDataSet(dataSet);
		pages.setPageSize(10);
		page.add("pages", pages);
		if (dataSet.size() > 0) {
			records = new ArrayList<>();
			for (int i = pages.getBegin(); i <= pages.getEnd(); i++) {
				dataSet.setRecNo(i + 1);
				Record record = dataSet.getCurrent();
				records.add(record);
			}
		}
		return records;
	}
	
	
	
	
	public boolean logon() {
		return true;
	}
}
