package com.huagu.ywManage.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
/**
 * 调货单
 * @author wj  
 * @date 2018年4月26日  
 *
 */  
public class FrmDiaoHuoBill extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this ,"ywmanage/diaoHuoBill.jsp");
		LocalService svr = new LocalService(this, "SvrDiaoHuoQuery");
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		if(!svr.getDataOut().bof())
			jsp.add("diaohuos", svr.getDataOut().getRecords());
		return jsp;
	}

	/**
	 *  手工变更物品位置状态为仓库手工变更物品为报修状态
	 *  @author wj  
	 *  @date 2018年4月26日
	 */
	public IPage modifyRepair() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up != null && up.equals("up")){
			LocalService svr = new LocalService(this ,"SvrModifyRepair");
			Record head = svr.getDataIn().getHead();
			head.setField("operateId_", this.getRequest().getParameter("operateId_"));
			head.setField("repairStatus_", this.getRequest().getParameter("repairStatus_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmDiaoHuoBill");
		}else{
			JspPage jsp = new JspPage(this, "ywmanage/modifyRepair.jsp");
			LocalService svr = new LocalService(this ,"SvrGetRepairInfo");
			Record head = svr.getDataIn().getHead();
			head.setField("operateId_", this.getRequest().getParameter("operateId_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			if(!svr.getDataOut().bof()){
				jsp.add("repair", svr.getDataOut().getCurrent());
			}
			return jsp;
		}
		
	}
	@Override 
	public boolean logon() {
		// TODO Auto-generated method stub
		return true;
	}
}
