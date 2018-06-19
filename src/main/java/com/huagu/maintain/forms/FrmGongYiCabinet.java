package com.huagu.maintain.forms;

import org.springframework.web.bind.annotation.ResponseStatus;

import com.aliyun.mns.common.http.ServiceClient.Request;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

public class FrmGongYiCabinet  extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "cabinet/gongyiCabinet.jsp");
		LocalService communityJname_ = new LocalService(this, "SvrCommunityName");
		if(!communityJname_.exec())
			throw new RuntimeException(communityJname_.getMessage());
		page.add("communityJnames", communityJname_.getDataOut().getRecords());
		LocalService getGongYiCabinet = new LocalService(this, "SvrGongYiCabinet");
		if(!getGongYiCabinet.exec())
			throw new RuntimeException(getGongYiCabinet.getMessage());
		
		page.add("cabinet", getGongYiCabinet.getDataOut().getRecords());
		return page;
	}
	
	/**
	 * 柜组物品
	 * @return
	 * @throws Exception
	 */
	public IPage GYCabinetRes() throws Exception {
		JspPage page = new JspPage(this, "cabinet/gongyiCabinetRes.jsp");
		String id = this.getRequest().getParameter("id");
		
		// 查询该柜子下有多少箱子
		LocalService getBox = new LocalService(this, "SvrgetGYCabinet");
		if(!getBox.exec("id_", id))
			throw new RuntimeException(getBox.getMessage());
		page.add("boxCount", getBox.getDataOut().getRecords());
		return page;
	}
	
	public IPage changeqq() throws Exception {
		JspPage jsp = new JspPage(this, "cabinet/gongyiCabinet.jsp");
		LocalService communityJname_ = new LocalService(this, "SvrCommunityName");
		if(!communityJname_.exec())
			throw new RuntimeException(communityJname_.getMessage());
		jsp.add("communityJnames", communityJname_.getDataOut().getRecords());
		
		String Jname=this.getRequest().getParameter("communityJname_");
		String isShouhuo=this.getRequest().getParameter("shouhuo");
		jsp.add("Jname", Jname);
		jsp.add("isShouhuo", isShouhuo);
		
		LocalService getCabinet = new LocalService(this, "SvrChangeAdress");
		if(!getCabinet.exec("Jname",Jname,"isShouhuo", isShouhuo))
			throw new RuntimeException(getCabinet.getMessage());
		jsp.add("cabinet", getCabinet.getDataOut().getRecords());
		return jsp;
	}
	
	//跳转到柜子详情界面
	public IPage gotocabinetDetail() throws Exception {
		JspPage jsp = new JspPage(this, "cabinet/cabinetDetail.jsp");
		String cabinetId_=this.getRequest().getParameter("id_");
		LocalService con = new LocalService(this, "SvrCabinetDetail");
		if(!con.exec("cabinetId_",cabinetId_))
			throw new RuntimeException(con.getMessage());
		jsp.add("cons", con.getDataOut().getRecords());
		LocalService counts = new LocalService(this, "SvrConuntDetail");
		if(!counts.exec("cabinetId_",cabinetId_))
			throw new RuntimeException(counts.getMessage());
		jsp.add("counts", counts.getDataOut().getRecords());
		jsp.add("cabinetId_", cabinetId_);
		return jsp;
		
	}
	
	//跳转到捐赠详情界面
	public IPage gotoJZDetail() throws Exception {
		JspPage jsp = new JspPage(this, "cabinet/JZDetail.jsp");
		String orderId_=this.getRequest().getParameter("orderId_");
		String cabinetId_=this.getRequest().getParameter("cabinetId_");
		LocalService Detail = new LocalService(this, "SvrJZDetail");
		if(!Detail.exec("cabinetId_",cabinetId_,"orderId_",orderId_))
			throw new RuntimeException(Detail.getMessage());
		jsp.add("Detail", Detail.getDataOut().getCurrent());
		return jsp;
		}
	
	//跳转到收货历史页面
	public IPage Historys() throws Exception {
		JspPage jsp = new JspPage(this, "cabinet/history.jsp");
		LocalService HistoryList = new LocalService(this ,"SvrHistoryList");
		if(!HistoryList.exec())
			throw new  RuntimeException(HistoryList.getMessage());
		jsp.add("HistoryList", HistoryList.getDataOut().getRecords());
		return jsp;
	}
	//跳转到历史详情界面
	public IPage HistoryDetail() throws Exception {
		JspPage jsp = new JspPage(this, "cabinet/historyDetail.jsp");
		String orderId_=this.getRequest().getParameter("orderId_");
		String cabinetId_=this.getRequest().getParameter("cabinetId_");
		LocalService Detail = new LocalService(this, "SvrJZDetail");
		if(!Detail.exec("cabinetId_",cabinetId_,"orderId_",orderId_))
			throw new RuntimeException(Detail.getMessage());
		jsp.add("historyDetail", Detail.getDataOut().getCurrent());
		LocalService historyDetail = new LocalService(this ,"SvrConuntDetail");
		if(!historyDetail.exec("cabinetId_",cabinetId_))
			throw new RuntimeException(historyDetail.getMessage());
		jsp.add("counts", historyDetail.getDataOut().getRecords());
		return jsp;
		
	}
	
	public boolean logon() {
		return true;
	}
}
