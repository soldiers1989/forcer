package com.huagu.more.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;

public class FrmSign extends AbstractForm {
	/**
	 *  @describe 签到说明后台展示
	 *  @author 王姣
	 *  @date   2018年4月4日上午9:46:15
	 *  @return
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "more/signExplainShow.jsp");
		LocalService svr = new LocalService(this, "SvrSignExplain");
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		jsp.add("explains", svr.getDataOut().getCurrent());
		return jsp;
	}

	/**
	 * 编辑签到说明
	 * @author 王姣
	 * @date 2018年4月4日上午9:40:21
	 * @return 
	 */
	public IPage editSignExplain() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up != null && up.equals("up")){
			LocalService svr = new LocalService(this, "SvrEditSignExplain");
			Record head = svr.getDataIn().getHead();
			head.setField("remark_", this.getRequest().getParameter("remark_"));
			if(!svr.exec())
				throw new  RuntimeException(svr.getMessage());
			return  new RedirectPage(this, "FrmSign");
		}else{
			JspPage jsp = new JspPage(this, "more/editSignExplain.jsp");
			LocalService svr = new LocalService(this, "SvrSignDetail");
			Record head = svr.getDataIn().getHead();
			head.setField("UID_", this.getRequest().getParameter("UID_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			jsp.add("sign", svr.getDataOut().getCurrent());
			return jsp;
		}
	}
	
	@Override
	public boolean logon() {
		return true;
	}
}
