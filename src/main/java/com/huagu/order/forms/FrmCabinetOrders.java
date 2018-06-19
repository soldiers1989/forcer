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
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jpage.grid.MutiPage;

/***
 *  租赁柜归还订单
 * @author wj  
 * @date 2018年5月23日 
 *
 */
public class FrmCabinetOrders extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "order/cabinetOrders.jsp");
		LocalService svr = new LocalService(this, "SvrCabinetOrdersQuery");
		Record head = svr.getDataIn().getHead();
		head.setField("proName_", this.getRequest().getParameter("proName_"));
		head.setField("homeAgency_", this.getRequest().getParameter("homeAgency_"));
		head.setField("createDate_", this.getRequest().getParameter("createDate_"));
		head.setField("orderId_", this.getRequest().getParameter("orderId_"));
		head.setField("OpenBoxTime_", this.getRequest().getParameter("OpenBoxTime_"));
		head.setField("mobile_", this.getRequest().getParameter("mobile_"));
		head.setField("returnType_", this.getRequest().getParameter("returnType_"));
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		// 缓存查询条件用做导出
        try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, this.getUserCode(), "SvrCabinetOrdersQuery")) {
            buff.setField("data", svr.getDataIn().getJSON());
        }
		jsp.add("cabinets", this.setPage(jsp, svr.getDataOut()));
		jsp.add("returnType_", this.getRequest().getParameter("returnType_"));
		jsp.add("proName_", this.getRequest().getParameter("proName_"));
		jsp.add("homeAgency_", this.getRequest().getParameter("homeAgency_"));
		jsp.add("createDate_", this.getRequest().getParameter("createDate_"));
		jsp.add("orderId_", this.getRequest().getParameter("orderId_"));
		jsp.add("OpenBoxTime_", this.getRequest().getParameter("OpenBoxTime_"));
		jsp.add("mobile_", this.getRequest().getParameter("mobile_"));
		ParamUtil.addLog(this, "查询", "查询后台租赁柜归还订单", "查询后台租赁柜归还订单");
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
	 *  发送消息
	 *  @author wj  
	 *  @date 2018年6月1日
	 */
	public IPage sendMessage() throws Exception{
		JsonPage json = new JsonPage(this);
		LocalService svr = new LocalService(this ,"SvrSendMessage");
		Record head = svr.getDataIn().getHead();
		head.setField("orderId_", this.getRequest().getParameter("orderId_"));
		if(!svr.exec()){
			json.setData(false);
		}else{
			json.setData(true);
		}
		return json;  
	}
	
	@Override
	public boolean logon() {
		// TODO Auto-generated method stub
		return true;
	}

}
