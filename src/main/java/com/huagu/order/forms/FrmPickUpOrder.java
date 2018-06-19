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

public class FrmPickUpOrder extends AbstractForm{
	
	/**
	 * 自取租赁
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "backstageOredr/pickUpRec.jsp");
		String orderType_ = this.getRequest().getParameter("orderType_"); 
		LocalService svr = new LocalService(this, "SvrDeliveryorder.findOrderList");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("orderType_", 1);
		headIn.setField("createDate_", this.getRequest().getParameter("createDate_"));
		headIn.setField("proName_", this.getRequest().getParameter("proName_"));
		headIn.setField("homeAgency_", this.getRequest().getParameter("homeAgency_"));
		headIn.setField("orderState_", this.getRequest().getParameter("orderState_"));
		headIn.setField("unlockDate_", this.getRequest().getParameter("unlockDate_"));
		headIn.setField("endDate_", this.getRequest().getParameter("endDate_"));
		headIn.setField("returnDate_", this.getRequest().getParameter("returnDate_"));
		headIn.setField("endReturnDate_", this.getRequest().getParameter("endReturnDate_"));
		headIn.setField("settleState_", this.getRequest().getParameter("settleState_"));
		headIn.setField("orderId_", this.getRequest().getParameter("orderId_"));
		headIn.setField("mobile_", this.getRequest().getParameter("mobile_"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", this.setPage(page, svr.getDataOut()));
		page.add("orderType_", orderType_);
		page.add("orderState_", this.getRequest().getParameter("orderState_"));
		page.add("unlockDate_", getRequest().getParameter("unlockDate_"));
		page.add("endDate_", getRequest().getParameter("endDate_"));
		page.add("returnDate_", getRequest().getParameter("returnDate_"));
		page.add("endReturnDate_", getRequest().getParameter("endReturnDate_"));
		page.add("proName_", getRequest().getParameter("proName_"));
		page.add("settleState_", getRequest().getParameter("settleState_"));
		page.add("homeAgency_", getRequest().getParameter("homeAgency_"));
		page.add("orderId_", getRequest().getParameter("orderId_"));
		page.add("mobile_", getRequest().getParameter("mobile_"));
		return page;

	}
	
	//进入自取租赁详情页面
	public IPage pickUpRecDetails() throws Exception {
		JspPage page = new JspPage(this, "backstageOredr/pickUpRecDetails.jsp");
		String orderId_ = this.getRequest().getParameter("orderId_");
		LocalService svr = new LocalService(this, "SvrDeliveryorder.findOrder");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("orderId_", orderId_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("value", svr.getDataOut().getCurrent());
		return page;
	}
	
	//自取租赁订单页面列表
	public IPage toCabinet() throws Exception {
		JspPage page = new JspPage(this, "backstageOredr/toCabinet.jsp");
		String orderType_ = this.getRequest().getParameter("orderType_");
		LocalService svr = new LocalService(this, "SvrDeliveryorder.findOrderList");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("orderType_", orderType_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", this.setPage(page, svr.getDataOut()));
		page.add("orderType_", orderType_);
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
