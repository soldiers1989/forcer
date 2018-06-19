package com.huagu.order.forms;

import java.util.ArrayList;
import java.util.List;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jpage.grid.MutiPage;

/**
 *  @describe 物流管理
 *  @author 王姣
 *  @date   2018年4月16日下午2:17:05
 *  @return
 */

public class FrmLogistics extends AbstractForm {

	/** 
	 *  @describe 物流管理列表（后台）
	 *  @author 王姣
	 *  @date   2018年4月16日下午2:17:22
	 *  @return
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "order/logistics.jsp");
		String content = this.getRequest().getParameter("content");//订单状态
		String orderState_ = this.getRequest().getParameter("orderState_");//订单状态
		String orderType_ = this.getRequest().getParameter("orderType_");//订单类型
		String shippingCosts_ = this.getRequest().getParameter("shippingCosts_");//快递公司是否包邮
		String deliveryTimeBegin_ = this.getRequest().getParameter("deliveryTimeBegin_");//发货开始时间
		String deliveryTimeEnd_ = this.getRequest().getParameter("deliveryTimeEnd_");//发货终止时间
		String recTimeBegin_ = this.getRequest().getParameter("recTimeBegin_");//收货开始时间
		String recTimeEnd_ = this.getRequest().getParameter("recTimeEnd_");//收货终止时间
		LocalService svr = new LocalService(this, "SvrLogisticsQuery");
		Record head = svr.getDataIn().getHead();
		head.setField("content", content);
		head.setField("orderState_", orderState_);
		head.setField("orderType_", orderType_);
		head.setField("shippingCosts_", shippingCosts_);
		head.setField("deliveryTimeBegin_", deliveryTimeBegin_);
		head.setField("deliveryTimeEnd_", deliveryTimeEnd_);
		head.setField("recTimeBegin_", recTimeBegin_);
		head.setField("recTimeEnd_", recTimeEnd_);
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		// 缓存查询条件用做导出
        try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, this.getUserCode(), "SvrLogisticsQuery")) {
            buff.setField("data", svr.getDataIn().getJSON());
        }
        jsp.add("content", content);
        jsp.add("orderState_", orderState_);
        jsp.add("orderType_", orderType_);
        jsp.add("shippingCosts_", shippingCosts_);
        jsp.add("deliveryTimeBegin_", deliveryTimeBegin_);
        jsp.add("deliveryTimeEnd_", deliveryTimeEnd_);
        jsp.add("recTimeBegin_", recTimeBegin_);
        jsp.add("recTimeEnd_", recTimeEnd_);
		jsp.add("logistics", this.setPage(jsp, svr.getDataOut()));
		return jsp;
	}
	
	//变更在库
	public IPage queryDetail() throws Exception{
		JspPage jsp = new JspPage(this, "order/logisticsDetail.jsp");
		String orderId_ = this.getRequest().getParameter("orderId_");
		LocalService svr = new LocalService(this, "SvrLogisticsQuery");
		Record head = svr.getDataIn().getHead();
		head.setField("orderId_", orderId_);
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		jsp.add("detail", svr.getDataOut().getCurrent());
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
	 * 查看物流详情
	 * @author 王姣
	 * @date 2018年4月16日下午2:38:19
	 * @return
	 */
	public IPage logisticsDetails() throws Exception{
		JspPage jsp = new JspPage(this, "order/logisticsDetails.jsp");
		LocalService svr = new LocalService(this ,"SvrLogisticsDetails");
		Record head = svr.getDataIn().getHead();
		head.setField("", this.getRequest().getParameter(""));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("details", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	@Override
	public boolean logon() {
		return true;
	}

}
