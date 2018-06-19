package com.huagu.order.forms;

import java.util.ArrayList;
import java.util.List;

import com.huagu.common.util.ParamUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
import cn.cerc.jpage.grid.MutiPage;

/**
 *  购买订单后台
 * @author wj  
 * @date 2018年5月21日 
 *
 */
public class FrmBuyOrders extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "order/buyOrders.jsp");
		LocalService svr = new LocalService(this, "SvrBuyOrdersQuery");
		Record head = svr.getDataIn().getHead();
		head.setField("proName_", this.getRequest().getParameter("proName_"));
		head.setField("saleHomeAgency_", this.getRequest().getParameter("saleHomeAgency_"));
		head.setField("orderState_", this.getRequest().getParameter("orderState_"));
		head.setField("logisticsState_", this.getRequest().getParameter("logisticsState_"));
		head.setField("createTime_", this.getRequest().getParameter("createTime_"));
		head.setField("receiver_", this.getRequest().getParameter("receiver_"));
		head.setField("recPhone_", this.getRequest().getParameter("recPhone_"));
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		// 缓存查询条件用做导出
        try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, this.getUserCode(), "SvrBuyOrdersQuery")) {
            buff.setField("data", svr.getDataIn().getJSON());
        }
		jsp.add("buyOrders", this.setPage(jsp, svr.getDataOut()));
		jsp.add("proName_", this.getRequest().getParameter("proName_"));
		jsp.add("saleHomeAgency_", this.getRequest().getParameter("saleHomeAgency_"));
		jsp.add("orderState_", this.getRequest().getParameter("orderState_"));
		jsp.add("logisticsState_", this.getRequest().getParameter("logisticsState_"));
		jsp.add("createTime_", this.getRequest().getParameter("createTime_"));
		jsp.add("receiver_", this.getRequest().getParameter("receiver_"));
		jsp.add("recPhone_", this.getRequest().getParameter("recPhone_"));
		ParamUtil.addLog(this, "查询", "查询后台线上购买订单", "查询后台线上购买订单");
		return jsp;
	}
	
	/**
	 *   购买订单详情查看
	 *  @author wj  
	 *  @date 2018年5月21日  
	 */
	public IPage buyOrderDetails() throws Exception{
		JspPage jsp = new JspPage(this, "order/buyOrdersDetails.jsp");
		LocalService svr = new LocalService(this, "SvrBuyOrdersDetails");
		Record head = svr.getDataIn().getHead();
		head.setField("orderId_", this.getRequest().getParameter("orderId_"));
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		jsp.add("details", svr.getDataOut().getCurrent());
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
	
	
	/**
	 *   进入物流页面
	 *  @author wj  
	 *  @date 2018年5月22日
	 */
	public IPage goEntryLogistics() throws Exception {
		JspPage page = new JspPage(this, "order/addLogistics.jsp");
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
	 *   后台录入物流信息
	 *  @author wj  
	 *  @date 2018年5月22日  
	 */
	public IPage entryLogistics() throws Exception {
		String orderId_ = this.getRequest().getParameter("orderId");//订单Id
		String recLogisticsName_ = this.getRequest().getParameter("recLogisticsName");//物流名称
		String recLogisticsId_ = this.getRequest().getParameter("recLogisticsId");//物流单号
		String deliveryTime_ = this.getRequest().getParameter("deliveryTime_");//寄出时间
		String proId_ = this.getRequest().getParameter("proId");//商品ID
		String zhuCode_ = this.getRequest().getParameter("zhuCode_");//物品ID（主电子条码）
		LocalService svr = new LocalService(this, "SvrDeliveryorder.updateOrder");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("orderId_", orderId_);
		headIn.setField("recLogisticsName_", recLogisticsName_);
		headIn.setField("recLogisticsId_", recLogisticsId_);
		headIn.setField("deliveryTime_", deliveryTime_);
		headIn.setField("zhuCode_", zhuCode_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return  new RedirectPage(this, "FrmBuyOrders");
	}
	
	
	@Override
	public boolean logon() {
		// TODO Auto-generated method stub
		return true;
	}

}
