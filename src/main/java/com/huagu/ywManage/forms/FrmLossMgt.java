package com.huagu.ywManage.forms;

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
/**
 * 折损管理
 * @author 黄培嘉 
 * 2018-4-28  
 */
public class FrmLossMgt extends AbstractForm { 
	//查询全部折损数据
	@Override
	public IPage execute() throws Exception {
		JspPage jsp =new JspPage(this,"ywmanage/lossMgt.jsp");
 		LocalService svr =new LocalService(this,"SvrLossMgt");
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		if(!svr.getDataOut().bof()) 
			jsp.add("values",this.setPage(jsp, svr.getDataOut()));
			jsp.add("lossMgt", svr.getDataOut().getRecords());
		return jsp;	
	}
	//查询单行折损数据
	public IPage getLoss() throws Exception{
		JspPage jsp =new JspPage(this,"ywmanage/upLossMgt.jsp");
		LocalService svr =new LocalService(this, "SvrLossQuery");
		Record head =svr.getDataIn().getHead();
		head.setField("UID_",this.getRequest().getParameter("UID_")); 
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage()); 
        jsp.add("values", svr.getDataOut().getCurrent());
		return jsp;
		
	}
	//修改折损信息
	public IPage updateLoss() throws Exception{
		LocalService svr = new LocalService(this, "SvrLossUpdate");
		Record head = svr.getDataIn().getHead();
		head.setField("UID_", this.getRequest().getParameter("UID_"));
		head.setField("status_", this.getRequest().getParameter("status_"));
		head.setField("payDesc_", this.getRequest().getParameter("payDesc_"));
		head.setField("pay_", this.getRequest().getParameter("pay_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return new RedirectPage(this, "FrmLossMgt");
		
	} 
/*	//判断是否损坏
	private Boolean getDamage(int returnType_){
		if(returnType_>0)
			return false;
		return true;
		
	}*/
	// 设置分页
		private List<Record> setPage(AbstractJspPage page, DataSet dataSet) {
			List<Record> records = null;
			MutiPage pages = new MutiPage();
			pages.setRequest(getRequest());
			pages.setDataSet(dataSet);
			pages.setPageSize(2);
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
