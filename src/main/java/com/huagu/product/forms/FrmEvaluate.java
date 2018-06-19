package com.huagu.product.forms;

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

public class FrmEvaluate extends AbstractForm{

	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "products/FrmEvaluateManage.jsp");
		String keywords = this.getRequest().getParameter("keywords");
		String beginTime_ = this.getRequest().getParameter("beginTime_");
		String endTime_ = this.getRequest().getParameter("endTime_");
		String evaLevel_ = this.getRequest().getParameter("evaLevel_");
		String evaState_ = this.getRequest().getParameter("evaState_");
		LocalService svr = new LocalService(this, "SvrEvaluate.queryUserEvaluate");
		Record head=svr.getDataIn().getHead();
		head.setField("keywords", keywords);
		head.setField("beginTime_", beginTime_);
		head.setField("endTime_", endTime_);
		head.setField("evaLevel_", evaLevel_);
		head.setField("evaState_", evaState_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("keywords", keywords);
		page.add("beginTime_", beginTime_);
		page.add("endTime_", endTime_);
		page.add("evaLevel_", evaLevel_);
		page.add("evaState_", evaState_);
		page.add("values", this.setPage(page, svr.getDataOut()));
		return page;
	}
	
	//查看并去回复 用户评价
	public IPage toQueryEvaluateById() throws Exception {
		JspPage page = new JspPage(this, "products/FrmAdminEvaluateDetail.jsp");
		String zhuCode_ = this.getRequest().getParameter("zhuCode_");
		String orderId_ = this.getRequest().getParameter("orderId_");
		LocalService svr = new LocalService(this, "SvrEvaluate.toQueryEvaluateById");
		Record head=svr.getDataIn().getHead();
		head.setField("zhuCode_", zhuCode_);
		head.setField("orderId_", orderId_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		List<Record> records = svr.getDataOut().getRecords();
		for(Record r:records ){
			String imgPath_ = r.getSafeString("imgPath_");
			imgPath_ = imgPath_.replace("[", "");	
			imgPath_ = imgPath_.replace("]", "");
			r.setField("imgPath_", imgPath_);
		}
		page.add("value", svr.getDataOut().getCurrent());
		return page;
	}
	
	//查看并去回复 用户评价
	public IPage replyEvaluateById() throws Exception {
		String adminReply_ = this.getRequest().getParameter("adminReply_");
		String orderId_ = this.getRequest().getParameter("orderId_");
		LocalService svr = new LocalService(this, "SvrEvaluate.replyEvaluateById");
		Record head=svr.getDataIn().getHead();
		head.setField("adminReply_", adminReply_);
		head.setField("orderId_", orderId_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return new RedirectPage(this,"FrmEvaluate");
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
	
	/**
	 * 删除评价
	 * wj
	 * @return  
	 * @throws Exception
	 */
	public IPage deleteEve() throws Exception{
		LocalService svr = new LocalService(this, "SvrDeleEve");
		Record head = svr.getDataIn().getHead();
		head.setField("proId_", this.getRequest().getParameter("proId_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return new RedirectPage(this, "FrmEvaluate");
	}
	
/*	public boolean logon() {
		return true;
	}*/
}
