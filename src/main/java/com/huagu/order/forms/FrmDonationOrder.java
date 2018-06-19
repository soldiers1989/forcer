package com.huagu.order.forms;

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

/**
 *  后台捐赠单
 * @author wj  
 * @date 2018年5月23日 
 *
 */
public class FrmDonationOrder extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "order/donationOrders.jsp");
		/*LocalService svr = new LocalService(this, "SvrDonationsQuery");*/
		LocalService svr = new LocalService(this, "SvrGetUserDonationOrder");
		Record head = svr.getDataIn().getHead();
		head.setField("code_", this.getRequest().getParameter("mobile_"));
		head.setField("shStatus_", this.getRequest().getParameter("shStatus_"));
		head.setField("shouhuoTime_", this.getRequest().getParameter("shouhuoTime_"));
		head.setField("maintainPhone_", this.getRequest().getParameter("maintainPhone_"));
		head.setField("status_", this.getRequest().getParameter("status_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("donations", this.setPage(jsp, svr.getDataOut()));
		jsp.add("mobile_", this.getRequest().getParameter("mobile_"));
		jsp.add("shStatus_", this.getRequest().getParameter("shStatus_"));
		jsp.add("shouhuoTime_", this.getRequest().getParameter("shouhuoTime_"));
		jsp.add("maintainPhone_", this.getRequest().getParameter("maintainPhone_"));
		jsp.add("status_", this.getRequest().getParameter("status_"));
		return jsp;
	}
	
	// 设置分页
	private List<Record> setPage(AbstractJspPage page, DataSet dataSet) {
		List<Record> records = null;
		MutiPage pages = new MutiPage();
		pages.setRequest(getRequest());
		pages.setDataSet(dataSet);
		pages.setPageSize(20);
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
	
	@Override
	public boolean logon() {
		return true;
	}
}
