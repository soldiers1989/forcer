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
 *  快递归还订单
 * @author wj  
 * @date 2018年5月23日 
 *
 */
public class FrmExpressOrders extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "order/expressOrders.jsp");
		LocalService svr = new LocalService(this, "SvrExpressOrdersQuery");
		Record head = svr.getDataIn().getHead();
		head.setField("proName_", this.getRequest().getParameter("proName_"));
		head.setField("homeAgency_", this.getRequest().getParameter("homeAgency_"));
		head.setField("orderId_", this.getRequest().getParameter("orderId_"));
		head.setField("mobile_", this.getRequest().getParameter("mobile_"));
		head.setField("settleState_", this.getRequest().getParameter("settleState_"));
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		// 缓存查询条件用做导出
        try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, this.getUserCode(), "SvrExpressOrdersQuery")) {
            buff.setField("data", svr.getDataIn().getJSON());
        }
		jsp.add("express", this.setPage(jsp, svr.getDataOut()));
		jsp.add("proName_", this.getRequest().getParameter("proName_"));
		jsp.add("homeAgency_", this.getRequest().getParameter("homeAgency_"));
		jsp.add("orderId_", this.getRequest().getParameter("orderId_"));
		jsp.add("mobile_", this.getRequest().getParameter("mobile_"));
		jsp.add("settleState_", this.getRequest().getParameter("settleState_"));
		ParamUtil.addLog(this, "查询", "查询后台快递归还订单", "查询后台快递归还订单");
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
	 *  修改物流信息
	 *  @author wj    
	 *  @date 2018年5月28日  
	 */
	public IPage modifyLogistics() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up != null && up.equals("up")){
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
			return  new RedirectPage(this, "FrmExpressOrders");
		}else{
			JspPage page = new JspPage(this, "order/updateLogistics.jsp");
			String orderId_ = this.getRequest().getParameter("orderId_");
			LocalService svr = new LocalService(this, "SvrDeliveryorder.findOrder");
			Record headIn = svr.getDataIn().getHead();
			headIn.setField("orderId_", orderId_);
			if (!svr.exec())
				throw new RuntimeException(svr.getMessage());
			page.add("value", svr.getDataOut().getCurrent());
			return page;
		}
	}
	
	@Override
	public boolean logon() {
		return true;
	}

}
