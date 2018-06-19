package com.huagu.jiFenAndSign.forms;

import java.util.ArrayList;
import java.util.List;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
import cn.cerc.jpage.grid.MutiPage;

/**
 *  @describe 积分等级管理
 *  @author 王姣 
 *  @date   2018年3月16日上午9:45:52
 *  @return      
 */
public class FrmJifenSign extends AbstractForm {

	/**
	 *  @describe 积分等级后台查询展示
	 *  @author 王姣
	 *  @date   2018年3月16日上午9:46:08
	 *  @return
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "jiFenSign/jifen.jsp");
		LocalService svr = new LocalService(this, "SvrJiFenQuery");
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("jifens", this.setPage(jsp, svr.getDataOut()));
		return jsp;
	}
	
	// 设置分页
	private List<Record> setPage(AbstractJspPage page, DataSet dataSet) {
		List<Record> records = null;
		MutiPage pages = new MutiPage();
		pages.setRequest(getRequest());
		pages.setDataSet(dataSet);
		pages.setPageSize(20);
		page.add("pages", pages);
		if (dataSet.size() > 0) {
			records = new ArrayList<>();
			for (int i = pages.getBegin(); i <= pages.getEnd(); i++) {
				dataSet.setRecNo(i + 1);
				Record record = dataSet.getCurrent();
				records.add(record);
			}
		}
		return records;
	}
	
	/**
	 * 后台查看积分等级详情
	 * @author 王姣
	 * @date 2018年3月16日上午11:19:02
	 * @return
	 */
	public IPage jiFenDetail() throws Exception{
		JspPage jsp = new JspPage(this, "jiFenSign/jiFenDetail.jsp");
		LocalService svr = new LocalService(this, "SvrGetJifenById");
		Record head = svr.getDataIn().getHead();
		head.setField("UID_", this.getRequest().getParameter("UID_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("jifen", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	/**
	 * 后台修改积分等级
	 * @author 王姣
	 * @date 2018年3月16日上午11:47:29
	 * @return  
	 */
	public IPage jiFenUpdate() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up != null && up.equals("up")){
			LocalService svr = new LocalService(this, "SvrJiFenUpdate");
			Record head = svr.getDataIn().getHead();
			head.setField("UID_", this.getRequest().getParameter("UID_"));
			head.setField("grade_", this.getRequest().getParameter("grade_"));
			head.setField("num_", this.getRequest().getParameter("num_"));
			head.setField("remark_", this.getRequest().getParameter("remark_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmJifenSign");
		}else{
			JspPage jsp = new JspPage(this, "jiFenSign/jiFenUpdate.jsp");
			LocalService svr = new LocalService(this, "SvrGetJifenById");
			Record head = svr.getDataIn().getHead();
			head.setField("UID_", this.getRequest().getParameter("UID_"));	
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			jsp.add("jifen", svr.getDataOut().getCurrent());
			return jsp;
		}
	}
	
	/**
	 * 添加积分等级
	 * @author 王姣
	 * @date 2018年4月10日下午4:46:20
	 * @return
	 */ 
	public IPage levelInsert() throws Exception{
		String in = this.getRequest().getParameter("in");
		if(in != null && in.equals("in")){
			LocalService svr = new LocalService(this, "SvrLevelInsert");
			Record head = svr.getDataIn().getHead();
			head.setField("grade_", this.getRequest().getParameter("grade_"));
			head.setField("num_", this.getRequest().getParameter("num_"));
			head.setField("remark_", this.getRequest().getParameter("remark_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmJifenSign");
		}else{
			JspPage jsp = new JspPage(this, "jiFenSign/levelInsert.jsp");
			return jsp;
		}
	}
	
	/**
	 * 删除积分等级
	 * @author 王姣
	 * @date 2018年4月10日下午5:40:21
	 * @return 
	 */ 
	public IPage deleteLevel() throws Exception{
		LocalService svr = new LocalService(this, "SvrDeleteLevel");
		Record head = svr.getDataIn().getHead();
		head.setField("levelID_", this.getRequest().getParameter("levelID_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return new RedirectPage(this, "FrmJifenSign");
	}
	
	
	@Override
	public boolean logon() {
		return true;
	}

}
