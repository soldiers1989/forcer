package com.huagu.jiFenAndSign.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;


public class FrmJiFenType extends AbstractForm {

	/**
	 *  @describe 积分类型查询展示后台
	 *  @author 王姣
	 *  @date   2018年3月20日下午3:13:31
	 *  @return
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "jiFenSign/jiFenType.jsp");
		LocalService svr = new LocalService(this, "SvrJiFenTypeQuery");
		Record head = svr.getDataIn().getHead();
		head.setField("type_", this.getRequest().getParameter("type_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("types",  svr.getDataOut().getRecords());
		jsp.add("type_", this.getRequest().getParameter("type_"));
		return jsp;
	}
	
	/**
	 * 后台积分类型详情查看
	 * @author 王姣
	 * @date 2018年3月20日上午10:18:20
	 * @return  
	 */
	public IPage jfTypeDetails() throws Exception{
		JspPage jsp = new JspPage(this, "jiFenSign/jfTypeDetail.jsp");
		LocalService svr = new LocalService(this, "SvrJiFenTypeDetail");
		Record head = svr.getDataIn().getHead();
		head.setField("UID_", this.getRequest().getParameter("UID_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("detail", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	/**
	 * 后台修改积分类型
	 * @author 王姣
	 * @date 2018年3月20日上午10:26:34
	 * @return 
	 */
	public IPage typeUpdate() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up != null && up.equals("up")){
			LocalService svr = new LocalService(this, "SvrJiFenTypeUpdate");
			Record head = svr.getDataIn().getHead();
			head.setField("UID_", this.getRequest().getParameter("UID_"));
			head.setField("integral_", this.getRequest().getParameter("integral_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmJiFenType");
		}else{
			JspPage jsp = new JspPage(this, "jiFenSign/jfTypeUpdate.jsp");
			LocalService svr = new LocalService(this, "SvrJiFenTypeDetail");
			Record head = svr.getDataIn().getHead();
			head.setField("UID_", this.getRequest().getParameter("UID_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			jsp.add("detail", svr.getDataOut().getCurrent());
			return jsp;
		}
	}
	
	@Override
	public boolean logon() {
		return true;
	}
}
