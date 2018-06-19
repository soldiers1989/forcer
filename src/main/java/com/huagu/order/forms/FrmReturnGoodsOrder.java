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
import cn.cerc.jmis.page.RedirectPage;
import cn.cerc.jpage.grid.MutiPage;
/**
 *  退货单查询展示
 * @author wj  	
 * @date 2018年5月22日   
 *
 */
public class FrmReturnGoodsOrder extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "order/returnGoods.jsp");
		LocalService svr = new LocalService(this ,"SvrReturnGoodsOrder");
		Record head = svr.getDataIn().getHead();
		head.setField("mobile_", this.getRequest().getParameter("mobile_"));
		head.setField("proName_", this.getRequest().getParameter("proName_"));
		head.setField("saleHomeAgency_", this.getRequest().getParameter("saleHomeAgency_"));
		head.setField("rgStatus_", this.getRequest().getParameter("rgStatus_"));
		head.setField("reGoodsTime_", this.getRequest().getParameter("reGoodsTime_"));
		head.setField("isAgree_", this.getRequest().getParameter("isAgree_"));
		head.setField("rgHand_", this.getRequest().getParameter("rgHand_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		// 缓存查询条件用做导出
        try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, this.getUserCode(), "SvrReturnGoodsOrder")) {
            buff.setField("data", svr.getDataIn().getJSON());
        }
		jsp.add("returngoods", this.setPage(jsp, svr.getDataOut()));
		jsp.add("mobile_", this.getRequest().getParameter("mobile_"));
		jsp.add("saleHomeAgency_", this.getRequest().getParameter("saleHomeAgency_"));
		jsp.add("rgStatus_", this.getRequest().getParameter("rgStatus_"));
		jsp.add("proName_", this.getRequest().getParameter("proName_"));
		jsp.add("isAgree_", this.getRequest().getParameter("isAgree_"));
		jsp.add("reGoodsTime_", this.getRequest().getParameter("reGoodsTime_"));
		jsp.add("rgHand_", this.getRequest().getParameter("rgHand_"));
		ParamUtil.addLog(this, "查询", "查询后台退货单列表", "查询后台退货单列表");
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
	 *  同意退货
	 *  @author wj    
	 *  @date 2018年5月30日
	 */
	public IPage agreeReturnGoods()  throws Exception{
		JsonPage json = new JsonPage(this);
		LocalService svr = new LocalService(this, "SvrAgreeReturnGoods");
		Record head = svr.getDataIn().getHead();
		head.setField("rgId_", this.getRequest().getParameter("rgId_"));
		if(!svr.exec()){
			json.setData(false);
		}else{
			json.setData(true);
		}
		return json;
	}
	
	/**
	 *   录入退货处理
	 *  @author wj  
	 *  @date 2018年6月1日
	 */
	public IPage returnHand() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up != null && up.equals("up")){
			LocalService svr = new LocalService(this, "SvrHandOrder");
			Record head = svr.getDataIn().getHead();
			head.setField("rgId_",  this.getRequest().getParameter("rgId_"));
			head.setField("rgLogisticsName_", this.getRequest().getParameter("rgLogisticsName_"));
			head.setField("rgLogisticsId_", this.getRequest().getParameter("rgLogisticsId_"));
			head.setField("check_", this.getRequest().getParameter("check_"));
			head.setField("rgStatus_", this.getRequest().getParameter("rgStatus_"));
			head.setField("rgHand_", this.getRequest().getParameter("rgHand_"));
			head.setField("rgMoney_", this.getRequest().getParameter("rgMoney_"));
			if(!svr.exec()){
				throw new RuntimeException(svr.getMessage());
			}
			return new RedirectPage(this ,"FrmReturnGoodsOrder");
		}else{
			JspPage jsp = new JspPage(this ,"order/handOrder.jsp");
			LocalService svr = new LocalService(this, "SvrGetHandOrder");
			Record head = svr.getDataIn().getHead();
			head.setField("rgId_",  this.getRequest().getParameter("rgId_"));
			head.setField("orderId_",  this.getRequest().getParameter("orderId_"));
			if(!svr.exec()){
				throw new RuntimeException(svr.getMessage());
			}
			jsp.add("hand", svr.getDataOut().getCurrent());
			return jsp;
		}
	}
	
	@Override
	public boolean logon() {
		return true;
	}
}
