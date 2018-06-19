package com.huagu.donation.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;


public class FrmDonation extends AbstractForm {

	/**
	 *  @describe 后台捐赠说明展示
	 *  @author 王姣
	 *  @date   2018年3月14日下午5:17:30
	 *  @return     
	 */   
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "donation/donationExplain.jsp");
		LocalService svr = new LocalService(this, "SvrDonaExplainshow");
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("explain", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	/**
	 * 修改捐赠说明
	 * @author 王姣
	 * @date 2018年3月14日下午6:25:07
	 * @return
	 */
	public IPage updateExplain() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up != null && up.equals("up")){
			LocalService svr = new LocalService(this, "SvrExceplainUpdate");
			Record head = svr.getDataIn().getHead();
			head.setField("explain_", this.getRequest().getParameter("explain_"));
			if(!svr.exec())
				throw new  RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmDonation");
		}else{
			JspPage jsp = new JspPage(this, "donation/explainUpdate.jsp");
			LocalService svr = new LocalService(this, "SvrGetExplainById");
			Record head = svr.getDataIn().getHead();
			head.setField("UID_", this.getRequest().getParameter("UID_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			jsp.add("explain", svr.getDataOut().getCurrent());
			return jsp;
		}
		
	}
	
	/**
	 * 后台捐赠说明详情查看
	 * @author 王姣
	 * @date 2018年3月15日上午9:18:05
	 * @return
	 */
	public IPage explainDetail() throws Exception{
		JspPage jsp = new JspPage(this, "donation/donationDetail.jsp");
		LocalService svr = new LocalService(this, "SvrGetExplainById");
		Record head = svr.getDataIn().getHead();
		head.setField("UID_", this.getRequest().getParameter("UID_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("detail", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	/**
	 * 前台捐赠说明展示
	 * @author 王姣
	 * @date 2018年3月15日下午2:17:36
	 * @return
	 */
	public IPage  explainqShow() throws Exception{
		JspPage jsp = new JspPage(this, "donation/donationExplainShow.jsp");
		LocalService svr = new LocalService(this, "SvrDonaExplainshow");
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("explain", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	/**
	 * 前台我要捐赠
	 * @author 王姣
	 * @date 2018年3月15日上午9:50:42
	 * @return   
	 */
	public IPage donationInsert() throws Exception{
		String in = this.getRequest().getParameter("in");
		if(in != null && in.equals("in")){
			LocalService svr = new LocalService(this, "SvrMyDonationInsert");
			Record head = svr.getDataIn().getHead();
			head.setField("productNum_", this.getRequest().getParameter("productNum_"));
			head.setField("proGuiGe_", this.getRequest().getParameter("proGuiGe_"));
			head.setField("proRemark_", this.getRequest().getParameter("proRemark_"));
			if(!svr.exec()){
				throw new RuntimeException(svr.getMessage());
			}
			return new RedirectPage(this, "FrmDonation.myDonation");
		}else{
			JspPage jsp = new JspPage(this, "donation/myDonation.jsp");
			return jsp;
		}
	}
	
	/***
	 * 我的捐赠前台查询展示
	 * @author 王姣
	 * @date 2018年3月15日下午2:42:05
	 * @return  
	 */
	public IPage myDonation() throws Exception{
		JspPage jsp = new JspPage(this, "donation/myDonationQuery.jsp");
		LocalService svr = new LocalService(this, "SvrMyDonationsQuery");
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("donations", svr.getDataOut().getRecords());
		return jsp;
	}
	
	/**
	 * 我的捐赠详情查看
	 * @author 王姣
	 * @date 2018年3月15日下午3:16:11
	 * @return 
	 */
	public IPage myDonationDetail() throws Exception{
		JspPage jsp = new JspPage(this, "donation/myDonationDetail.jsp");
		LocalService svr = new LocalService(this, "SvrMyDonationsDetail");
		Record head = svr.getDataIn().getHead();
		head.setField("donationId_", this.getRequest().getParameter("donationId_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("donation", svr.getDataOut().getCurrent());
		return jsp;
	}
	@Override
	public boolean logon() {
		return true;
	}
}
