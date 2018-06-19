package com.huagu.newslist.forms;

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

public class FrmNewslist extends AbstractForm{
	@Override
	//查询信息
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "newslist/newslist.jsp");
		LocalService svr = new LocalService(this, "SvrNewslist.getNews");
		Record head = svr.getDataIn().getHead();
		head.setField("unlockDate_", this.getRequest().getParameter("unlockDate_"));
	    head.setField("endDate_", this.getRequest().getParameter("endDate_"));
	    head.setField("sender_", this.getRequest().getParameter("sender_"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", this.setPage(page, svr.getDataOut()));
		page.add("unlockDate_", getRequest().getParameter("unlockDate_"));
		page.add("endDate_", getRequest().getParameter("endDate_"));
		page.add("sender_", getRequest().getParameter("sender_"));

    /*    Record record = svr.getDataIn().getHead();
        record.setField("mobile_", this.getRequest().getParameter("mobile_"));
        record.setField("unlockDate_", this.getRequest().getParameter("unlockDate_"));
        record.setField("endDate_", this.getRequest().getParameter("endDate_"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", svr.getDataOut().getRecords());
        page.add("mobile_", this.getRequest().getParameter("mobile_"));
        page.add("unlockDate_", this.getRequest().getParameter("unlockDate_"));
        page.add("endDate_", this.getRequest().getParameter("endDate_"));
*/
		return page;

	}
	//添加
	public IPage addNews() throws Exception{
		LocalService svr = new LocalService(this, "SvrNewslist.addNews");
		Record headIn=svr.getDataIn().getHead();
		headIn.setField("content_",this.getRequest().getParameter("content_"));
		headIn.setField("sendOb_",this.getRequest().getParameter("sendOb_"));
	/*	headIn.setField("sendTime_",this.getRequest().getParameter("sendTime_"));*/
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return new RedirectPage(this,"FrmNewslist");
	}
	//修改
	public IPage upNews() throws Exception{
		LocalService svr = new LocalService(this, "SvrNewslist.upNews");
		Record headIn=svr.getDataIn().getHead();
		headIn.setField("id_",this.getRequest().getParameter("id_"));
		headIn.setField("content_",this.getRequest().getParameter("content_"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return execute();
	}
	
	//删除
	public IPage delNews() throws Exception{
		String id_ = this.getRequest().getParameter("id_");
		System.out.println(id_);
		LocalService svr = new LocalService(this, "SvrNewslist.delNews");
		if (!svr.exec("id_", id_))
			throw new RuntimeException(svr.getMessage());
		return execute();	
	}
	
	//跳转到添加页面
	public IPage addPage() throws Exception{
		JspPage page = new JspPage(this, "newslist/addnews.jsp");	
		return page;
	}
	
	//跳转到修改页面
	public IPage upPage() throws Exception{
		JspPage page = new JspPage(this, "newslist/upnews.jsp");
		String id_=this.getRequest().getParameter("id_");
		LocalService svr = new LocalService(this, "SvrNewslist.getNews");
		Record headIn=svr.getDataIn().getHead();
		headIn.setField("falg",1);
		headIn.setField("id_",id_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", svr.getDataOut().getCurrent());
		return page;
	}
	
	/**
	 *   查看消息详情
	 *  @author wj  
	 *  @date 2018年5月25日
	 */
	public IPage messageDetails() throws Exception{
		JspPage page = new JspPage(this, "newslist/newsDetails.jsp");
		LocalService svr = new LocalService(this, "SvrNewslist.getNewsDetails");
		Record head = svr.getDataIn().getHead();
		head.setField("falg",1);
		head.setField("id_", this.getRequest().getParameter("id_"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("details", svr.getDataOut().getCurrent());
		return page;
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