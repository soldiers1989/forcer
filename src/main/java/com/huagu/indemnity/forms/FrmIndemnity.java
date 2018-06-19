package com.huagu.indemnity.forms;

import java.util.List;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
/**
 * 赔付单前台展示
 * @author wj  
 * @date 2018年5月8日 
 *
 */
public class FrmIndemnity extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "indemnity/indemnityShow.jsp");
		LocalService svr = new LocalService(this ,"SvrIndemnityShow");
		Record head = svr.getDataIn().getHead();
		head.setField("mobile_", this.getRequest().getParameter("mobile_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("indemnity", svr.getDataOut().getRecords());
		return jsp;
	}
	
	/**
	 *  赔付单详情查看 
	 *  @author wj  
	 *  @date 2018年5月9日
	 */
	public IPage indemnityDetails() throws Exception{
		JspPage jsp = new JspPage(this, "indemnity/indemnityDetails.jsp");
		LocalService svr = new LocalService(this, "SvrIndemnityDetails");
		Record head = svr.getDataIn().getHead();
		head.setField("orderId_", this.getRequest().getParameter("orderId_"));
		head.setField("operateId_", this.getRequest().getParameter("operateId_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		
		
		String zhuCode_ = this.getRequest().getParameter("zhuCode_");// 主电子条码
		LocalService svrHistory = new LocalService(this, "SvrProDetails.findOrdList");
		Record headIn = svrHistory.getDataIn().getHead();
		headIn.setField("zhuCode_", zhuCode_);
		if (!svrHistory.exec())
			throw new RuntimeException(svrHistory.getMessage());
		if (!svrHistory.getDataOut().bof()) {
			List<Record> records = svrHistory.getDataOut().getRecords();
			for (Record r : records) {
				String imgPath_ = r.getString("imgPath_");
				imgPath_ = imgPath_.replace("[", "");
				imgPath_ = imgPath_.replace("]", "");
				r.setField("imgPath_", imgPath_);
			}
			jsp.add("orders", records);
		}
		jsp.add("details", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	@Override
	public boolean logon() {
		return true;
	}

}
