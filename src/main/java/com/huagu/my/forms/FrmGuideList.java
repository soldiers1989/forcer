package com.huagu.my.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;

/**
 * 
 * @ClassName: FrmGuideList
 * @Description: 用户使用指南
 * @author 炫
 * @date 2018年3月1日   
 *  
 */ 
public class FrmGuideList extends AbstractForm {

	public IPage addGuide() throws Exception {
		String in = this.getRequest().getParameter("in");
		if(in != null && in.equals("in")){
			LocalService svr = new LocalService(this, "SvrGuideOrder.addtitle");
			Record headIn = svr.getDataIn().getHead();
			headIn.setField("title", this.getRequest().getParameter("title"));
			headIn.setField("content", this.getRequest().getParameter("content"));
			if (!svr.exec())
				throw new RuntimeException(svr.getMessage());
			return  new RedirectPage(this, "FrmGuideList");
		}else{
			JspPage page = new JspPage(this, "my/Increaseguide.jsp");
			 return page;
		}

	}

	//删除使用指南  
	public IPage deletetitle() throws Exception {
		String id = this.getRequest().getParameter("id_");
		LocalService svr = new LocalService(this, "SvrGuideOrder.deletetitle");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("id", id);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return  new RedirectPage(this, "FrmGuideList");
	}
//
	public IPage updArcitle() throws Exception {
		JspPage page = new JspPage(this, "my/Revisionguide.jsp");
		String falg = this.getRequest().getParameter("falg");
		System.out.println(falg);
		String id = this.getRequest().getParameter("id_");
		LocalService svr = new LocalService(this, "SvrGuideOrder.querycontent");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("id", id);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", svr.getDataOut().getCurrent());
		return page;
	}
	public	IPage updArcitle1() throws Exception {
			LocalService svr = new LocalService(this, "SvrGuideOrder.modifytitle");
			Record headIn = svr.getDataIn().getHead();
			headIn.setField("id_", this.getRequest().getParameter("id_"));
			headIn.setField("title", this.getRequest().getParameter("title"));
			headIn.setField("content", this.getRequest().getParameter("content"));
			if (!svr.exec())
				throw new RuntimeException(svr.getMessage());
			return  new RedirectPage(this, "FrmGuideList");
		}
			
		
		
//前台查標題
	
	public IPage Guide() throws Exception {
		JspPage page = new JspPage(this, "my/guidesel.jsp");
		String type = this.getRequest().getParameter("type");
		LocalService svr = new LocalService(this, "SvrGuideOrder.querytitle");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("type", "0");
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", svr.getDataOut().getRecords());
		page.add("type","guide");
		return page;

	}
	
//后台查標題
	
	public IPage selGuide() throws Exception {
		JspPage page = new JspPage(this, "my/Fdguide.jsp");
		String type = this.getRequest().getParameter("type");
		LocalService svr = new LocalService(this, "SvrGuideOrder.querytitle");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("type", "0");
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		// page.add("lx",2);
		page.add("values", svr.getDataOut().getRecords());
		return page;

	}
	
	/**
	 * 查看使用指南详情(前台)
	 * @author 王姣
	 * @date 2018年4月8日上午10:29:33
	 * @return
	 */
	public IPage guideDetails() throws Exception{
		JspPage jsp = new JspPage(this, "my/guideDetails.jsp");
		LocalService svr = new LocalService(this, "SvrGuideDetails");
		Record head = svr.getDataIn().getHead();
		head.setField("id_", this.getRequest().getParameter("id_"));
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		jsp.add("details", svr.getDataOut().getCurrent());
		return jsp;
	} 
	
	
//查標題内容 
	public IPage selArcitle() throws Exception {
		JspPage page = new JspPage(this, "my/Guidetouse.jsp");
		String id = this.getRequest().getParameter("id_");
		LocalService svr = new LocalService(this, "SvrGuideOrder.querycontent");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("id", id);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", svr.getDataOut().getCurrent());
		return page;
	}

	/**
	 * 使用指南 后台列表查询
	 * @author 王姣
	 * @date 2018年4月9日下午3:38:31
	 * @return
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "my/Fdguide.jsp");
		String type = this.getRequest().getParameter("type");
		LocalService svr = new LocalService(this, "SvrGuideOrder.querytitle");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("type", "0");
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		// page.add("lx",2);
		page.add("values", svr.getDataOut().getRecords());
		return page;
	}

	@Override
	public boolean logon() {
		return true;
	}
}
