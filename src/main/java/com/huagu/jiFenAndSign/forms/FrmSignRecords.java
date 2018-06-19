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


public class FrmSignRecords extends AbstractForm {

	/**
	 *  @describe 后台签到查询展示
	 *  @author 王姣
	 *  @date   2018年3月20日下午3:15:53
	 *  @return
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "jiFenSign/signRecord.jsp");
		LocalService svr = new LocalService(this, "SvrSignRecordQuery");
		Record head = svr.getDataIn().getHead();
		head.setField("grade_", this.getRequest().getParameter("grade_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("signs", this.setPage(jsp, svr.getDataOut()));
		jsp.add("list", svr.getDataOut().getRecords());
		jsp.add("grade_", this.getRequest().getParameter("grade_"));
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
	 * 后台签到详情查看
	 * @author 王姣
	 * @date 2018年3月19日下午6:40:19
	 * @return   
	 */
	public IPage signDetails() throws Exception{
		JspPage jsp = new JspPage(this, "jiFenSign/signDetails.jsp");
		LocalService svr = new LocalService(this, "SvrSignDetails");
		Record head = svr.getDataIn().getHead();
		head.setField("userCode_", this.getRequest().getParameter("userCode_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("sign", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	@Override
	public boolean logon() {
		return true;
	}
}
