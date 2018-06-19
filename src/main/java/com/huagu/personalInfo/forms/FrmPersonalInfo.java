package com.huagu.personalInfo.forms;

import java.util.ArrayList;
import java.util.List;

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

/***
 *  个人专属信息
 * @author wj  
 * @date 2018年5月17日 
 *
 */  

public class FrmPersonalInfo extends AbstractForm {

	/**
	 *  个人交易记录
	 * @author wj  
	 * @date 2018年5月17日  
	 *  
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "person/personRecords.jsp");
		LocalService svr = new LocalService(this, "SvrGetPerRecords");
		Record head = svr.getDataIn().getHead();
		head.setField("userCode_", this.getRequest().getParameter("userCode_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("proRecords", this.setPage(jsp, svr.getDataOut()));
		return jsp;
	}
	
	/**
	 *  个人租赁订单查询	
	 *  @author wj    
	 *  @date 2018年5月17日
	 */
	public IPage  perLeaseOrders() throws Exception{
		JspPage jsp = new JspPage(this, "person/perLeaseOrders.jsp");
		LocalService svr = new LocalService(this, "SvrGetperLeaseOrders");
		Record head = svr.getDataIn().getHead();
		head.setField("code_", this.getRequest().getParameter("code_"));
		head.setField("orderId_", this.getRequest().getParameter("orderId_"));
		head.setField("beginTime_", this.getRequest().getParameter("beginTime_"));
		head.setField("proName_", this.getRequest().getParameter("proName_"));
		head.setField("dayRentMoney_", this.getRequest().getParameter("dayRentMoney_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("perLeaseOrders", this.setPage(jsp, svr.getDataOut()));
		jsp.add("orderId_", this.getRequest().getParameter("orderId_"));
		jsp.add("beginTime_", this.getRequest().getParameter("beginTime_"));
		jsp.add("proName_", this.getRequest().getParameter("proName_"));
		jsp.add("dayRentMoney_", this.getRequest().getParameter("dayRentMoney_"));
		jsp.add("code_", this.getRequest().getParameter("code_"));
		return jsp;
	}
	
	/**
	 *    个人购买订单
	 *  @author wj  
	 *  @date 2018年5月17日  
	 */
	public IPage perBuyOrders() throws Exception{
		JspPage jsp = new JspPage(this, "person/buyLeaseOrders.jsp");
		LocalService svr = new LocalService(this, "SvrGetBuyOrders");
		Record head = svr.getDataIn().getHead();
		head.setField("code_", this.getRequest().getParameter("code_"));
		head.setField("orderId_", this.getRequest().getParameter("orderId_"));
		head.setField("proName_", this.getRequest().getParameter("proName_"));
		head.setField("sumMoney_", this.getRequest().getParameter("sumMoney_"));
		head.setField("createDate_", this.getRequest().getParameter("createDate_"));
		head.setField("orderState_", this.getRequest().getParameter("orderState_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("perBuyOrders", this.setPage(jsp, svr.getDataOut()));
		jsp.add("orderId_", this.getRequest().getParameter("orderId_"));
		jsp.add("proName_", this.getRequest().getParameter("proName_"));
		jsp.add("sumMoney_", this.getRequest().getParameter("sumMoney_"));
		jsp.add("createDate_", this.getRequest().getParameter("createDate_"));
		jsp.add("orderState_", this.getRequest().getParameter("orderState_"));
		jsp.add("code_", this.getRequest().getParameter("code_"));
		return jsp;
	}
	
	/**
	 *  购买订单详情  
	 *  @author wj  
	 *  @date 2018年5月18日
	 */
	public IPage buyOrderDetails() throws Exception{
		JspPage jsp = new JspPage(this ,"person/buyOrdersDetails.jsp");
		LocalService svr = new LocalService(this, "SvrBuyOrderDetails");
		Record head = svr.getDataIn().getHead();
		head.setField("orderId_", this.getRequest().getParameter("orderId_"));
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		jsp.add("details", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	/**
	 *  修改物流单号
	 *  @author wj  
	 *  @date 2018年5月18日
	 */
	public IPage updateNumber() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up != null && up.equals("up")){
			LocalService svr = new LocalService(this, "SvrUpdateNumber");
			Record head = svr.getDataIn().getHead();
			head.setField("orderId_", this.getRequest().getParameter("orderId_"));
			head.setField("userId_", this.getRequest().getParameter("userId_"));
			head.setField("recLogisticsId_", this.getRequest().getParameter("recLogisticsId_"));
			if(!svr.exec()){
				throw new RuntimeException(svr.getMessage());
			}
			return new RedirectPage(this, "FrmPersonalInfo.perBuyOrders?code_="+this.getRequest().getParameter("userId_"));
		}else{
			JspPage jsp = new JspPage(this, "person/updateBuyOrder.jsp");
			LocalService svr = new LocalService(this, "SvrBuyOrderDetails");
			Record head = svr.getDataIn().getHead();
			head.setField("userId_", this.getRequest().getParameter("userId_"));
			head.setField("orderId_", this.getRequest().getParameter("orderId_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			jsp.add("order", svr.getDataOut().getCurrent());
			jsp.add("userId_", this.getRequest().getParameter("userId_"));
			return jsp;
		}
	}
	
	/**
	 *   客户邀请
	 *  @author wj  
	 *  @date 2018年5月17日
	 */
	public IPage perCustomerInvitation() throws Exception{
		JspPage jsp = new JspPage(this, "person/customerInvitation.jsp");
		LocalService svr = new LocalService(this, "SvrGetcustomerInvitation");
		Record head = svr.getDataIn().getHead();
		head.setField("userId_", this.getRequest().getParameter("userId_"));
		head.setField("userCode_", this.getRequest().getParameter("code_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("customerInvitation", this.setPage(jsp, svr.getDataOut()));
		jsp.add("userId_", this.getRequest().getParameter("userId_"));
		jsp.add("userCode_", this.getRequest().getParameter("code_"));
		return jsp;
	}
	
	/**
	 *  追加积分
	 *  @author wj  
	 *  @date 2018年5月18日
	 */
	public IPage addJifen() throws Exception{
		JsonPage json = new JsonPage(this);
		LocalService svr = new LocalService(this, "SvrAddPerJiFen");
		Record head = svr.getDataIn().getHead();
		head.setField("userCode_", this.getRequest().getParameter("userCode_"));
		if(!svr.exec()){
			json.setData(false);
		}else{
			json.setData(true);
		}
		return json;
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
}
