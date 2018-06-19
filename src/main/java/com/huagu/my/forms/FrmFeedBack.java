package com.huagu.my.forms;

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
 * 
 * @ClassName: FrmGuideList
 * @Description: 意见反馈
 * @author 李佳炫
 * @date 2018年3月12日  
 *       
 */   
public class FrmFeedBack extends AbstractForm{
	/**
	 *  @describe 反馈意见后台查询展示
	 *  @author 王姣
	 *  @date   2018年3月20日下午3:45:55
	 *  @return
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "my/opinionfeedback.jsp");
		LocalService svr = new LocalService(this, "SvrFeedBack.queryopinion");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("view_", this.getRequest().getParameter("view_"));
		headIn.setField("username", this.getRequest().getParameter("username"));
		headIn.setField("userphone", this.getRequest().getParameter("userphone"));
		headIn.setField("unlockDate_", this.getRequest().getParameter("unlockDate_"));
	    headIn.setField("endDate_", this.getRequest().getParameter("endDate_"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", this.setPage(page, svr.getDataOut()));
		page.add("view_", this.getRequest().getParameter("view_"));
		page.add("username", this.getRequest().getParameter("username"));
		page.add("userphone", this.getRequest().getParameter("userphone"));
		page.add("unlockDate_", getRequest().getParameter("unlockDate_"));
	    page.add("endDate_", getRequest().getParameter("endDate_"));
		return page;
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
	 * 前台提交反馈意见
	 * @author 王姣
	 * @date 2018年3月20日下午6:09:12
	 * @return
	 */
	public IPage addFeedback() throws Exception {
		String in = this.getRequest().getParameter("in");
		if(in != null && in.equals(in)){
			LocalService svr = new LocalService(this, "SvrFeedBack.addopinion");
			Record headIn = svr.getDataIn().getHead();
			headIn.setField("view_", this.getRequest().getParameter("view_"));
			if (!svr.exec())
				throw new RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmFeedback.addFeedback");
		}else{
			JspPage page = new JspPage(this, "my/feedbackInsert.jsp");
			LocalService svr = new LocalService(this, "SvrFeedBack.opinionShow");
			if (!svr.exec())
				throw new RuntimeException(svr.getMessage());
			page.add("values", svr.getDataOut().getRecords());
			return page;
		}
		
	}
	
	//后台查询用户提交及回复(无用--王姣)
	public IPage selopinion() throws Exception {
		JspPage page = new JspPage(this, "my/opinionreply.jsp");
		LocalService svr = new LocalService(this, "SvrFeedBack.queryopinion");
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		
		page.add("values", svr.getDataOut().getRecords());
		return page;
		
	}
	
	//刪除用戶意見(无用--王姣)
	public void deleopinion() throws Exception {
		String id = this.getRequest().getParameter("id_");
		LocalService svr = new LocalService(this, "SvrFeedBack.deleteadr");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("id", id);
		headIn.setField("userid", 1234);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());

	}
	
	//回复前查询
	public IPage addreply() throws Exception {
		JspPage page = new JspPage(this, "my/replypage.jsp");
		String id = this.getRequest().getParameter("id_");
		LocalService svr = new LocalService(this, "SvrFeedBack.opinionDetail");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("id_", id);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", svr.getDataOut().getCurrent());
		return page;
	}
	
	//回复
	public IPage reply() throws Exception {
		LocalService svr = new LocalService(this, "SvrFeedBack.addreply");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("reply", this.getRequest().getParameter("reply_"));
		headIn.setField("id_", this.getRequest().getParameter("id_"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return new RedirectPage(this, "FrmFeedback");
	}
	
	
	/**
	 * 反馈详情查看（后台）
	 * @author 王姣
	 * @date 2018年3月20日下午4:48:47
	 * @return  
	 */ 
	public IPage details() throws Exception {
		JspPage page = new JspPage(this, "my/interlocution.jsp");
		String id = this.getRequest().getParameter("id_");
		LocalService svr = new LocalService(this, "SvrFeedBack.opinionDetail");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("id_", id);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("val", svr.getDataOut().getCurrent());
		return page;
	}
	
	/**
	 * 反馈详情查看（前台）
	 * @author 王姣
	 * @date 2018年3月20日下午4:48:47
	 * @return  
	 */ 
	public IPage feedBackDetail() throws Exception {
		JspPage page = new JspPage(this, "my/feedBackDetail.jsp");
		String id = this.getRequest().getParameter("id_");
		LocalService svr = new LocalService(this, "SvrFeedBack.opinionDetail");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("id_", id);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("val", svr.getDataOut().getCurrent());
		return page;
	}
	public boolean logon() {
		return true;
	}
}
