package com.huagu.order.forms;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
import cn.cerc.jpage.grid.MutiPage;

public class FrmDeliveryGoHome extends AbstractForm{
	
	/**
	 * 送货上门
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "backstageOredr/deliveryGoHome.jsp");
		LocalService svr = new LocalService(this, "SvrDeliveryorder.findOrderList");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("orderType_", "2");
		headIn.setField("createDate_", this.getRequest().getParameter("createDate_"));
		headIn.setField("proName_", this.getRequest().getParameter("proName_"));
		headIn.setField("homeAgency_", this.getRequest().getParameter("homeAgency_"));
		headIn.setField("zhuCode_", this.getRequest().getParameter("zhuCode_"));
		headIn.setField("orderState_", this.getRequest().getParameter("orderState_"));
		headIn.setField("unlockDate_", this.getRequest().getParameter("unlockDate_"));
		headIn.setField("endDate_", this.getRequest().getParameter("endDate_"));
		headIn.setField("returnDate_", this.getRequest().getParameter("returnDate_"));
		headIn.setField("endReturnDate_", this.getRequest().getParameter("endReturnDate_"));
		headIn.setField("logisticsState_", this.getRequest().getParameter("logisticsState_"));
		headIn.setField("settleState_", this.getRequest().getParameter("settleState_"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", this.setPage(page, svr.getDataOut()));
		page.add("createDate_",this.getRequest().getParameter("createDate_"));
		page.add("proName_", this.getRequest().getParameter("proName_"));
		page.add("homeAgency_", this.getRequest().getParameter("homeAgency_"));
		page.add("zhuCode_", this.getRequest().getParameter("zhuCode_"));
		page.add("orderState_", this.getRequest().getParameter("orderState_"));
		page.add("unlockDate_", getRequest().getParameter("unlockDate_"));
		page.add("endDate_", getRequest().getParameter("endDate_"));
		page.add("returnDate_", getRequest().getParameter("returnDate_"));
		page.add("endReturnDate_", getRequest().getParameter("endReturnDate_"));
		page.add("logisticsState_", getRequest().getParameter("logisticsState_"));
		page.add("settleState_", getRequest().getParameter("settleState_"));
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
		String orderId_ = this.getRequest().getParameter("orderId");//订单Id
		String recLogisticsName_ = this.getRequest().getParameter("recLogisticsName");//物流名称
		String recLogisticsId_ = this.getRequest().getParameter("recLogisticsId");//物流单号
		String recUpTime_ = this.getRequest().getParameter("recUpTime");//寄出时间
		String proId_ = this.getRequest().getParameter("proId");//商品ID
		String zhuCode_ = this.getRequest().getParameter("zhuCode_");//物品ID（主电子条码）
		LocalService svr = new LocalService(this, "SvrDeliveryorder.updateOrder");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("orderId_", orderId_);
		headIn.setField("recLogisticsName_", recLogisticsName_);
		headIn.setField("recLogisticsId_", recLogisticsId_);
		headIn.setField("recUpTime_", recUpTime_);
		headIn.setField("zhuCode_", zhuCode_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return  new RedirectPage(this, "FrmDeliveryGoHome.execute");
	}
	
	
	/**
	 * 根据商品Id判断该主电子条码Id是否此类商品的
	 */
	public IPage findzhuCode() throws Exception {
		JsonPage page = new JsonPage(this);
		LocalService svr = new LocalService(this, "SvrAdminRentPro.findzhuCode");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("proId_",  this.getRequest().getParameter("proId_"));
		headIn.setField("zhuCode_",  this.getRequest().getParameter("zhuCode_"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		System.out.println(svr.getDataOut());
		if(!svr.getDataOut().eof()){
			Map<String, String> returnJson = new HashMap<>();
			returnJson.put("zhuCode", svr.getDataOut().getCurrent().toString());
			page.setData(returnJson);
			return page;
		}
		return null;
	}
	
	
	/**
	 * 查询配件电子条码信息
	 */
	public IPage findCixx() throws Exception {
		JsonPage page = new JsonPage(this);
		LocalService svr = new LocalService(this, "SvrAdminRentPro.findCixx");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("proId_",  this.getRequest().getParameter("proId_"));
		headIn.setField("zhuCode_",  this.getRequest().getParameter("zhuCode_"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		if(!svr.getDataOut().eof()){
			Map<String, String> returnJson = new HashMap<>();
			returnJson.put("ciCodes", svr.getDataOut().getRecords().toString());
			page.setData(returnJson);
			return page;
		}
		return null;
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
