package com.huagu.agentAndCom.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;

/**
 * 箱柜区域管理
 * @author wj
 *
 */
public class FrmBoxComm extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "cab/boxComm.jsp");
		LocalService svr = new LocalService(this, "SvrBoxCommQuery");
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("boxComms", svr.getDataOut().getRecords());
		return jsp;
	}
	
	
	/**
	 * 添加社区
	 * wj
	 * @return
	 * @throws Exception
	 */
	public IPage insertCommunity() throws Exception{
		String in = this.getRequest().getParameter("in");
		if(in != null && in.equals("in")){
			LocalService svr = new LocalService(this, "SvrInsertCommunity");
			Record head = svr.getDataIn().getHead();
			head.setField("communityName_", this.getRequest().getParameter("communityName_"));
			head.setField("communityJname_", this.getRequest().getParameter("communityJname_"));
			head.setField("wuYeJname_", this.getRequest().getParameter("wuYeJname_"));
			head.setField("wuYeName_", this.getRequest().getParameter("wuYeName_"));
			head.setField("wuYePhone_", this.getRequest().getParameter("wuYePhone_"));
			head.setField("communityArea_", this.getRequest().getParameter("communityArea_"));
			head.setField("doorPlate_", this.getRequest().getParameter("doorPlate_"));
			head.setField("address_", this.getRequest().getParameter("address_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmBoxComm");
		}else{
			JspPage jsp = new JspPage(this, "com/insertCommunity.jsp");
			return jsp;
		}
		
	}
	
	/**
	 * 修改社区信息
	 * wj
	 * @return 
	 */
	public IPage modifyCommunity() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up != null && up.equals("up")){
			LocalService svr = new LocalService(this ,"SvrComModify");
			Record head = svr.getDataIn().getHead();
			head.setField("communityName_", this.getRequest().getParameter("communityName_"));
			head.setField("communityJname_", this.getRequest().getParameter("communityJname_"));
			head.setField("wuYeJname_", this.getRequest().getParameter("wuYeJname_"));
			head.setField("wuYeName_", this.getRequest().getParameter("wuYeName_"));
			head.setField("wuYePhone_", this.getRequest().getParameter("wuYePhone_"));
			head.setField("communityArea_", this.getRequest().getParameter("communityArea_"));
			head.setField("doorPlate_", this.getRequest().getParameter("doorPlate_"));
			head.setField("address_", this.getRequest().getParameter("address_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmBoxComm");
		}else{
			JspPage jsp = new JspPage(this, "cab/modifyBoxCom.jsp");
			LocalService svr = new LocalService(this, "SvrGetComById");
			Record head = svr.getDataIn().getHead();
			head.setField("communityId_", this.getRequest().getParameter("communityId_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			jsp.add("com", svr.getDataOut().getCurrent());
			return jsp;
		}
	}
	
	/**
	 * 删除社区信息
	 * @author wj
	 * @return  
	 */
	public IPage deleteCom() throws Exception{
		LocalService svr = new LocalService(this, "SvrDeleteCom");
		Record head = svr.getDataIn().getHead();
		head.setField("communityId_", this.getRequest().getParameter("communityId_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return new RedirectPage(this, "FrmBoxComm");
	}
	@Override
	public boolean logon() {
		// TODO Auto-generated method stub
		return true;
	}

}
