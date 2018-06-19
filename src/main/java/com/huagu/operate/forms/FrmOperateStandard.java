package com.huagu.operate.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;

public class FrmOperateStandard extends AbstractForm  {

	@Override
	public IPage execute() throws Exception {
		JspPage page =new JspPage(this,"operate/FrmOperateStandard.jsp");
		LocalService ls = new LocalService(this,"SvrQueryStandardList");
		if(!ls.exec()){
			throw new RuntimeException(ls.getMessage());
		}
		page.add("value", ls.getDataOut().getRecords());
		return page;
	}
	
	/**
	 * 添加运费模板
	 */
	public IPage toAddStandard() throws Exception{
		JspPage page =new JspPage(this,"operate/FrmOperate_addStandard.jsp");
		return page;
	}
	
	/**
	 * 添加运费模板
	 */
	public IPage addStandard() throws Exception{
		String name_ = this.getRequest().getParameter("name_");//模板名称
		String method_ = this.getRequest().getParameter("method_");//计费方式
		String[] baoArea_ = this.getRequest().getParameterValues("baoArea_");//包邮区域
		String[] notBaoArea_ = this.getRequest().getParameterValues("notBaoArea_");//不包邮区域
		String fristJian_ = this.getRequest().getParameter("fristJian_");//首件
		String fristJianMoney_ = this.getRequest().getParameter("fristJianMoney_");//首费
		String nextJian_ = this.getRequest().getParameter("nextJian_");//续件
		String nextJianMoney_ = this.getRequest().getParameter("nextJianMoney_");//续费
		String baoFreight_ = this.getRequest().getParameter("baoFreight_");
		LocalService ls = new LocalService(this,"SvrAddStandard");
		Record head = ls.getDataIn().getHead();
		String baoAreaNew_ = "";
		if(baoArea_.length!=0){
			for(int i=0;i<baoArea_.length;i++){
				baoAreaNew_+=baoArea_[i];
				baoAreaNew_+=" ";
			}
		}
		String notBaoAreaNew_ = "";
		if(notBaoArea_.length!=0){
			for(int i=0;i<notBaoArea_.length;i++){
				notBaoAreaNew_+=notBaoArea_[i];
				notBaoAreaNew_+=" ";
			}
		}
		head.setField("name_", name_);
		head.setField("method_", method_);
		head.setField("fristJian_", fristJian_);
		head.setField("fristJianMoney_", fristJianMoney_);
		head.setField("nextJian_", nextJian_);
		head.setField("nextJianMoney_", nextJianMoney_);
		head.setField("baoFreight_", baoFreight_);
		head.setField("baoArea_", baoAreaNew_);
		head.setField("notBaoArea_", notBaoAreaNew_);
		if(!ls.exec()){
			throw new RuntimeException(ls.getMessage());
		}
		return new RedirectPage(this, "FrmOperateStandard");
	}

	//删除运费模板
	public IPage delStandard() throws Exception{
		String nameId_ = this.getRequest().getParameter("nameId_");
		LocalService ls = new LocalService(this,"SvrDelStandard");
		Record head = ls.getDataIn().getHead();
		head.setField("nameId_", nameId_);
		if(!ls.exec()){
			throw new RuntimeException(ls.getMessage());
		}
		return new RedirectPage(this, "FrmOperateStandard");
	}
	
	//修改运费模板
	public IPage toUpdateStandard() throws Exception{
		JspPage page =new JspPage(this,"operate/FrmOperate_updateStandard.jsp");
		String nameId_ = this.getRequest().getParameter("nameId_");
		LocalService ls = new LocalService(this,"SvrQueryStandardList");
		Record head = ls.getDataIn().getHead();
		head.setField("nameId_", nameId_);
		if(!ls.exec()){
			throw new RuntimeException(ls.getMessage());
		}
		page.add("value", ls.getDataOut().getCurrent());
		return page;
	}
	//修改运费模板
	public IPage updateStandard() throws Exception{
		String name_ = this.getRequest().getParameter("name_");//模板名称
		String nameId_ = this.getRequest().getParameter("nameId_");//模板名称
		String method_ = this.getRequest().getParameter("method_");//计费方式
		String[] baoArea_ = this.getRequest().getParameterValues("baoArea_");//包邮区域
		String[] notBaoArea_ = this.getRequest().getParameterValues("notBaoArea_");//不包邮区域
		String fristJian_ = this.getRequest().getParameter("fristJian_");//首件
		String fristJianMoney_ = this.getRequest().getParameter("fristJianMoney_");//首费
		String nextJian_ = this.getRequest().getParameter("nextJian_");//续件
		String nextJianMoney_ = this.getRequest().getParameter("nextJianMoney_");//续费
		String baoFreight_ = this.getRequest().getParameter("baoFreight_");
		LocalService ls = new LocalService(this,"SvrAddStandard");
		Record head = ls.getDataIn().getHead();
		String baoAreaNew_ = "";
		if(baoArea_!=null){
			for(int i=0;i<baoArea_.length;i++){
				baoAreaNew_+=baoArea_[i];
				baoAreaNew_+=" ";
			}
		}
		String notBaoAreaNew_ = "";
		if(notBaoArea_!=null){
			for(int i=0;i<notBaoArea_.length;i++){
				notBaoAreaNew_+=notBaoArea_[i];
				notBaoAreaNew_+=" ";
			}
		}
		head.setField("name_", name_);
		head.setField("nameId_", nameId_);
		head.setField("method_", method_);
		head.setField("fristJian_", fristJian_);
		head.setField("fristJianMoney_", fristJianMoney_);
		head.setField("nextJian_", nextJian_);
		head.setField("nextJianMoney_", nextJianMoney_);
		head.setField("baoFreight_", baoFreight_);
		head.setField("baoArea_", baoAreaNew_);
		head.setField("notBaoArea_", notBaoAreaNew_);
		if(!ls.exec()){
			throw new RuntimeException(ls.getMessage());
		}
		return new RedirectPage(this, "FrmOperateStandard");
	}
	
	public boolean logon() {
		return true;
	}
}
