package com.huagu.box.manage.forms;

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
/**
 *  银行卡认证
 * @author wj  
 * @date 2018年6月4日 
 *
 */
public class FrmBankCard extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "bank/bankCard.jsp");
		LocalService svr = new LocalService(this, "SvrBankCards");
		Record head = svr.getDataIn().getHead();
		head.setField("userName_", this.getRequest().getParameter("userName_"));
		head.setField("lastDate_", this.getRequest().getParameter("lastDate_"));
		head.setField("lastMoneyTime_", this.getRequest().getParameter("lastMoneyTime_"));
		head.setField("status_",  this.getRequest().getParameter("status_"));
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		jsp.add("banks", this.setPage(jsp, svr.getDataOut()));
		jsp.add("userName_", this.getRequest().getParameter("userName_"));
		jsp.add("lastDate_", this.getRequest().getParameter("lastDate_"));
		jsp.add("lastMoneyTime_", this.getRequest().getParameter("lastMoneyTime_"));
		jsp.add("status_", this.getRequest().getParameter("status_"));
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
	
	
	@Override
	public boolean logon() {
		return true;
	}

}
