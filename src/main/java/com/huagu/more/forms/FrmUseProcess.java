package com.huagu.more.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;


public class FrmUseProcess extends AbstractForm {

	/**
	 *  @describe 使用流程查询展示（后台）
	 *  @author 王姣
	 *  @date   2018年3月22日下午2:21:01
	 *  @return   
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "process/processQuery.jsp");
		LocalService svr = new LocalService(this, "SvrProcessQuery");
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("process", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	/**
	 * 查看使用流程（后台）
	 * @author 王姣
	 * @date 2018年3月22日下午3:03:36
	 * @return
	 */
	public IPage processDetails() throws Exception{
		JspPage jsp = new JspPage(this, "process/processDetails.jsp");
		LocalService svr = new LocalService(this, "SvrProcessDetails");
		Record head = svr.getDataIn().getHead();
		head.setField("UID_", this.getRequest().getParameter("UID_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("process", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	/**
	 * 修改使用流程（后台）
	 * @author 王姣
	 * @date 2018年3月22日下午3:12:49
	 * @return
	 */
	public IPage processModify() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up != null && up.equals("up")){
			LocalService svr = new LocalService(this, "SvrProcessModify");
			Record head = svr.getDataIn().getHead();
			head.setField("content_", this.getRequest().getParameter("content_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmUseProcess");  
		}else{
			JspPage jsp = new JspPage(this, "process/processModify.jsp");
			LocalService svr = new LocalService(this, "SvrProcessDetails");
			Record head = svr.getDataIn().getHead();
			head.setField("UID_", this.getRequest().getParameter("UID_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			jsp.add("process", svr.getDataOut().getCurrent());
			return jsp;
		}
	}
	
	/**
	 * 使用流程前台展示
	 * @author 王姣
	 * @date 2018年3月22日下午3:44:46
	 * @return
	 */ 
	public IPage processShow() throws Exception{
		JspPage jsp = new JspPage(this, "process/processShow.jsp");
		LocalService svr = new LocalService(this, "SvrProcessQuery");
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("process", svr.getDataOut().getCurrent());
		jsp.add("type", this.getRequest().getParameter("type"));
		return jsp;
	}
	
	@Override
	public boolean logon() {
		return true;
	}

}
