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
import cn.cerc.jmis.page.RedirectPage;
import cn.cerc.jpage.grid.MutiPage;

public class FrmDeliveryorder extends AbstractForm{
	
	/**
	 * 送货上门订单列表
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "backstageOredr/deliveryGoHome.jsp");
		LocalService svr = new LocalService(this, "SvrDeliveryorder.findOrderList");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("orderType_", "2");
		headIn.setField("orderState_", this.getRequest().getParameter("orderState_"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", this.setPage(page, svr.getDataOut()));
		page.add("orderState_", this.getRequest().getParameter("orderState_"));
		return page;

	}
	
	/*
	 * 进入录入物流信息页面
	 */
	public IPage goEntryLogistics() throws Exception {
		JspPage page = new JspPage(this, "backstageOredr/entryLogistics.jsp");
		String orderId_ = this.getRequest().getParameter("orderId_");
		LocalService svr = new LocalService(this, "SvrDeliveryorder.findOrder");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("orderId_", orderId_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("value", svr.getDataOut().getCurrent());
		return page;
	}
	
	/**
	 * 录入物流信息
	 */
	public IPage entryLogistics() throws Exception {
		String orderId_ = this.getRequest().getParameter("orderId");
		String recLogisticsName_ = this.getRequest().getParameter("recLogisticsName");
		String recLogisticsId_ = this.getRequest().getParameter("recLogisticsId");
		String recUpTime_ = this.getRequest().getParameter("recUpTime");
		LocalService svr = new LocalService(this, "SvrDeliveryorder.updateOrder");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("orderId_", orderId_);
		headIn.setField("recLogisticsName_", recLogisticsName_);
		headIn.setField("recLogisticsId_", recLogisticsId_);
		headIn.setField("recUpTime_", recUpTime_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return  new RedirectPage(this, "FrmDeliveryorder.execute");
	}
	
	//自取租赁订单页面列表
	public IPage pickUpOrder() throws Exception {
		JspPage page = new JspPage(this, "backstageOredr/pickUpRec.jsp");
		String orderType_ = this.getRequest().getParameter("orderType_");
		String createDate_ = this.getRequest().getParameter("createDate_");
		LocalService svr = new LocalService(this, "SvrDeliveryorder.findOrderList");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("orderType_", orderType_);
		headIn.setField("createDate_", createDate_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", this.setPage(page, svr.getDataOut()));
		page.add("orderType_", orderType_);
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
		pages.setPageSize(5);
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
