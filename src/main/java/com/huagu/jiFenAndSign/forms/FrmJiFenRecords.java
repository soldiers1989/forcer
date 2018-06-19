package com.huagu.jiFenAndSign.forms;

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


public class FrmJiFenRecords extends AbstractForm {

	/**
	 *  @describe 积分记录后台查询
	 *  @author 王姣
	 *  @date   2018年3月20日下午3:06:26
	 *  @return
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "jiFenSign/jiFenRecord.jsp");
		LocalService svr = new LocalService(this, "SvrjiFenRecordQuery");
		Record head = svr.getDataIn().getHead();
		head.setField("type_", this.getRequest().getParameter("type_"));
		head.setField("shareName", this.getRequest().getParameter("name_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("records", this.setPage(jsp, svr.getDataOut()));
		jsp.add("type_", this.getRequest().getParameter("type_"));
		jsp.add("shareName", this.getRequest().getParameter("name_"));
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
	 * 后台积分记录详情查看
	 * @author 王姣
	 * @date 2018年3月19日上午11:04:04
	 * @return  
	 */
	public IPage recordDetails() throws Exception{
		JspPage jsp = new JspPage(this, "jiFenSign/recordDetails.jsp");
		LocalService svr = new LocalService(this, "SvrjiFenRecordQueryDetails");
		Record head = svr.getDataIn().getHead();
		head.setField("userCode_", this.getRequest().getParameter("userCode_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("record", svr.getDataOut().getCurrent());
		return jsp;
	}

	@Override
	public boolean logon() {
		return  true;
	}
}
