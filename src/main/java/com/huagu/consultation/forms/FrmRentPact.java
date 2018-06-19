package com.huagu.consultation.forms;
import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;

/**
*  @describe 某个协议
*  @author   李佳炫
*  @date     2018年3月14日
*  @return
 */
public class FrmRentPact extends AbstractForm{
	
	/**
	 * 某篇文章查看
	 * @Title: publish 
	 */
	
	public IPage LeaseSel() throws Exception {
		JspPage  page = new JspPage(this, "consultation/Frmconsultation_update.jsp");
		 LocalService svr = new LocalService(this, "SvrRentPact.selpact");
		 Record headIn = svr.getDataIn().getHead();
		 headIn.setField("type_", this.getRequest().getParameter("type_"));
		 if(!svr.exec())
			 throw new RuntimeException();
		 page.add("values", svr.getDataOut().getCurrent());
		 System.out.println(svr.getDataOut().getCurrent().getString("type_"));
		 return page;
	}
	
	/**
	 * 某篇文章查看内容编辑
	 * @return
	 * @throws Exception
	 */
	
	public IPage LeaseUpdate() throws Exception {
		LocalService svr = new LocalService(this, "SvrRentPact.editpact");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("type_", this.getRequest().getParameter("type_"));
		headIn.setField("id_", this.getRequest().getParameter("id_"));
		headIn.setField("title_", this.getRequest().getParameter("title_"));
		headIn.setField("content_", this.getRequest().getParameter("content_"));
		headIn.setField("date_", this.getRequest().getParameter("date_"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
	/*	return new RedirectPage(this, "FrmRentPact.LeaseSel?type_="+this.getRequest().getParameter("type_"));*/
		return new RedirectPage(this, "FrmInformationList");

	}
	

	

	@Override
	public IPage execute() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	public boolean logon() {
		return true;
	}
}

