package com.huagu.more.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;


public class FrmBussiness extends AbstractForm {

	/**
	 *  @describe 商务合作查询展示（后台）
	 *  @author 王姣
	 *  @date   2018年3月21日上午9:16:08
	 *  @return
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "more/businessQuery.jsp");
		LocalService svr = new LocalService(this ,"SvrBussinessQuery");
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("bussiness", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	/**
	 * 商务合作详情查看（后台）
	 * @author 王姣
	 * @date 2018年3月21日上午9:38:27
	 * @return
	 */ 
	public IPage businessDetails() throws Exception{
		JspPage jsp = new JspPage(this, "more/businessDetail.jsp");
		LocalService svr = new LocalService(this ,"SvrBussinessDetails");
		Record head = svr.getDataIn().getHead();
		head.setField("UID_", this.getRequest().getParameter("UID_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("bussiness", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	/**
	 * 商务合作修改信息（后台）
	 * @author 王姣
	 * @date 2018年3月21日上午10:07:04
	 * @return
	 */
	public IPage businessUpdate() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up != null && up.equals("up")){
			LocalService svr = new LocalService(this, "SvrBussinessUpdate");
			Record head = svr.getDataIn().getHead();
			head.setField("content_", this.getRequest().getParameter("content_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmBussiness");
		}else{
			JspPage jsp = new JspPage(this, "more/businessUpdate.jsp");
			LocalService svr = new LocalService(this ,"SvrBussinessDetails");
			Record head = svr.getDataIn().getHead();
			head.setField("UID_", this.getRequest().getParameter("UID_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			jsp.add("bussiness", svr.getDataOut().getCurrent());
			return jsp;
		}
		
	}
	
	/** 
	 * 商务合作，前台展示
	 * @author 王姣
	 * @date 2018年3月21日上午11:46:40
	 * @return  
	 */
	public IPage bussinessShow() throws Exception{
		JspPage jsp = new JspPage(this, "more/businessShow.jsp");
		LocalService svr = new LocalService(this ,"SvrBussinessQuery");
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("bussiness", svr.getDataOut().getCurrent());
		return jsp;
	}
	@Override
	public boolean logon() {
		return true;
	}

}
