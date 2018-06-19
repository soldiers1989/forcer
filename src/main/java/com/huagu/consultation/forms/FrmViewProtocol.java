package com.huagu.consultation.forms;
import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;


	/**
	*  @describe 查看协议内容
	*  @author   李佳炫
	*  @date     2018年3月14日
	*  @return
	*/

public class FrmViewProtocol extends AbstractForm{
	/**
	 * 进入协议标题超链接
	 * @Title: publish 
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage  page = new JspPage(this, "consultation/ListProtocol.jsp");
		
		// TODO Auto-generated method stub
		return page;
	}
	
	
	/**
	 * 查看协议内容
	 * @Title: publish 
	 */
	
	public IPage Protocolcontent() throws Exception {
		JspPage  page = new JspPage(this, "consultation/ViewProtocol.jsp");
		 LocalService svr = new LocalService(this, "SvrViewProtocol.Protocolcontent");
		 Record headIn = svr.getDataIn().getHead();
		 headIn.setField("type_", this.getRequest().getParameter("type_"));
		 System.out.println(this.getRequest().getParameter("type_"));
		 if(!svr.exec())
			 throw new RuntimeException();
		 page.add("values", svr.getDataOut().getCurrent());
		 return page;
	}
	
	@Override
	public boolean logon() {
		return true;
	}
}
