package com.huagu.helpcenter.forms;

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

public class FrmHelpcenter extends AbstractForm{
	@Override
	//查询文章
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "helpcenter/articlelist.jsp");
		LocalService svr = new LocalService(this, "SvrHelpcenter.getArticle");
		Record head = svr.getDataIn().getHead();
	    head.setField("unlockDate_", this.getRequest().getParameter("unlockDate_"));
        head.setField("endDate_", this.getRequest().getParameter("endDate_"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", this.setPage(page, svr.getDataOut()));
		page.add("unlockDate_", getRequest().getParameter("unlockDate_"));
		page.add("endDate_", getRequest().getParameter("endDate_"));
		return page;

	}
	//添加
	public IPage addArticle() throws Exception{
		LocalService svr = new LocalService(this, "SvrHelpcenter.addArticle");
		Record headIn=svr.getDataIn().getHead();
		headIn.setField("title_",this.getRequest().getParameter("title_"));
		headIn.setField("addtime_",this.getRequest().getParameter("addtime_"));
		headIn.setField("content_",this.getRequest().getParameter("content_"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return new RedirectPage(this,"FrmHelpcenter");
	}
	//修改
	public IPage upArticle() throws Exception{
		LocalService svr = new LocalService(this, "SvrHelpcenter.upArticle");
		Record headIn=svr.getDataIn().getHead();
		headIn.setField("id_",this.getRequest().getParameter("id_"));
		headIn.setField("title_",this.getRequest().getParameter("title_"));
		headIn.setField("addtime_", this.getRequest().getParameter("addtime_"));
		headIn.setField("content_",this.getRequest().getParameter("content_"));
		
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return execute();
	}
	
	//删除
	public IPage delArticle() throws Exception{
		String id_ = this.getRequest().getParameter("id_");
		LocalService svr = new LocalService(this, "SvrHelpcenter.delArticle");
		if (!svr.exec("id_", id_))
			throw new RuntimeException(svr.getMessage());
		return execute();	
	}
	
	//跳转到添加页面
	public IPage addPage() throws Exception{
		JspPage page = new JspPage(this, "helpcenter/addarticle.jsp");
		return page;
	}
	
	//跳转到修改页面
	public IPage upPage() throws Exception{
		JspPage page = new JspPage(this, "helpcenter/uparticle.jsp");
		String id_=this.getRequest().getParameter("id_");
		LocalService svr = new LocalService(this, "SvrHelpcenter.getArticle");
		Record headIn=svr.getDataIn().getHead();
		headIn.setField("falg",1);
		headIn.setField("id_",id_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", svr.getDataOut().getCurrent());
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