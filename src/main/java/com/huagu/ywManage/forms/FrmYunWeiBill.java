package com.huagu.ywManage.forms;

import java.util.List;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
/**
 * 运维单
 * @author wj  
 * @date 2018年4月26日 
 *
 */
public class FrmYunWeiBill extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "ywmanage/yunweiBill.jsp");
		LocalService svr = new LocalService(this, "SvrYunWeiQuery");
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		if(!svr.getDataOut().bof())
			jsp.add("yunweis", svr.getDataOut().getRecords());
		return jsp;
	}
	
	/**
	 *  查看运维图片
	 *  @author wj        
	 *  @date 2018年4月26日
	 */
	public IPage lookImg() throws Exception{
		JspPage jsp = new JspPage(this, "ywmanage/yunWeiImg.jsp");
		LocalService svr = new LocalService(this, "SvrYunWeiImgQuery");
		Record head = svr.getDataIn().getHead();
		head.setField("operateId_",this.getRequest().getParameter("operateId_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		List<Record> records = svr.getDataOut().getRecords();
		for(Record r:records ){
		      String imgPath_ = r.getSafeString("imgPath_");
		      imgPath_ = imgPath_.replace("[", "");  
		      imgPath_ = imgPath_.replace("]", "");
		      r.setField("imgPath_", imgPath_);
		    }
		if(!svr.getDataOut().bof())
			jsp.add("imgs", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	/**
	 * 变更当前物品折损率
	 *  @author wj  
	 *  @date 2018年4月26日 
	 */
	public IPage modifySale() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up != null && up.equals("up") ){
			LocalService svr = new LocalService(this, "SvrModifySale");
			Record head = svr.getDataIn().getHead();
			head.setField("operateId_", this.getRequest().getParameter("operateId_"));
			head.setField("nowLoss_", this.getRequest().getParameter("nowLoss_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmYunWeiBill");
		}else{
			JspPage jsp = new JspPage(this, "ywmanage/modifySale.jsp");
			LocalService svr = new LocalService(this ,"SvrGetYunWeiBill");
			Record head = svr.getDataIn().getHead();
			head.setField("operateId_", this.getRequest().getParameter("operateId_"));
			if(!svr.exec()){
				throw new RuntimeException(svr.getMessage());
			}
			if(!svr.getDataOut().bof()){
				jsp.add("sale", svr.getDataOut().getCurrent());
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
