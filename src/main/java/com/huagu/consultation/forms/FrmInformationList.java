package com.huagu.consultation.forms;
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
	*  @describe 资讯管理列表
	*  @author   李佳炫
	*  @date     2018年3月14日
	*  @return
	*/
public class FrmInformationList extends AbstractForm{
	
	/**
	 * 查看资讯管理列表
	 * @Title: publish 
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage  page = new JspPage(this, "consultation/InformationList.jsp");
		 LocalService svr = new LocalService(this, "SvrInformationList.ArticleListSel");
		 Record headIn = svr.getDataIn().getHead();
		 headIn.setField("unlockDate_", this.getRequest().getParameter("unlockDate_"));
	     headIn.setField("endDate_", this.getRequest().getParameter("endDate_"));
	     headIn.setField("type_", this.getRequest().getParameter("type_"));
		 if(!svr.exec())
			 throw new RuntimeException();
		 page.add("values", this.setPage(page, svr.getDataOut()));
		 page.add("unlockDate_", getRequest().getParameter("unlockDate_"));
	     page.add("endDate_", getRequest().getParameter("endDate_"));
	     page.add("type_", getRequest().getParameter("type_"));
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
	
	/**
	 * 	查看详情（后台）
	 * @author 王姣
	 * @date 2018年3月21日下午4:12:43
	 * @return 
	 */
	public IPage infoDetails() throws Exception{
		JspPage jsp = new JspPage(this, "consultation/infoDetail.jsp");
		LocalService svr = new LocalService(this, "SvrInformationList.infoDetail");
		Record head = svr.getDataIn().getHead();
		head.setField("type_", this.getRequest().getParameter("type_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("info", svr.getDataOut().getCurrent());
		return jsp;
	}
		
	public boolean logon() {
		return true;
	}
}

