package com.huagu.product.forms;

import java.util.ArrayList;
import java.util.List;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
import cn.cerc.jpage.grid.MutiPage;

public class FrmNode_queryUpdate extends AbstractForm{

	
	/**
	 * 按照物品（电子条码）查询
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "products/FrmNode_queryUpdate.jsp");
		String zhuCode_ = this.getRequest().getParameter("zhuCode_");//主电子条码
		String homeAgency_ = this.getRequest().getParameter("homeAgency_");//归属机构
		String nodeState_ = this.getRequest().getParameter("nodeState_");//柜组名称
		String updateDate_ = this.getRequest().getParameter("updateDate_");//变更时间
		LocalService ls=new LocalService(this,"SvrQueryPro_ByCabinet.nodeQueryUpdate");
		Record head = ls.getDataIn().getHead();
		head.setField("zhuCode_", zhuCode_);
		head.setField("homeAgency_", homeAgency_);
		if(nodeState_!="" && nodeState_!=null){
			if("初始录入".indexOf(nodeState_)!=-1){
				head.setField("nodeState_", "0");
			}
			if("在库".indexOf(nodeState_)!=-1){
				head.setField("nodeState_", "1");
			}
			if("在柜".indexOf(nodeState_)!=-1){
				head.setField("nodeState_", "2");
			}
			if("在租".indexOf(nodeState_)!=-1){
				head.setField("nodeState_", "3");
			}
			if("在途".indexOf(nodeState_)!=-1){
				head.setField("nodeState_", "4");
			}
			if("已售".indexOf(nodeState_)!=-1){
				head.setField("nodeState_", "5");
			}
		}
		head.setField("updateDate_", updateDate_);
		if(!ls.exec()){
			page.add("msg", ls.getMessage());
			return page;
		}
		// 缓存查询条件用做导出
        try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, this.getUserCode(), "SvrQueryPro_ByCabinet.nodeQueryUpdate")) {
            buff.setField("data", ls.getDataIn().getJSON());
        }
		page.add("zhuCode_", zhuCode_);
		page.add("homeAgency_", homeAgency_);
		page.add("nodeState_", nodeState_);
		page.add("updateDate_", updateDate_);
		page.add("value", this.setPage(page, ls.getDataOut()));
		return page;
	}
	
	//变更在库
	public IPage updateZaiKu() throws Exception{
		JspPage page = new JspPage(this, "products/FrmNode_queryUpdate.jsp");
		String zhuCode_ = this.getRequest().getParameter("zhuCode_");
		LocalService ls = new LocalService(this,"SvrQueryPro_ByCabinet.updateZaiKu");
		Record head = ls.getDataIn().getHead();
		head.setField("zhuCode_", zhuCode_);
		if(!ls.exec()){
			page.add("msg", ls.getMessage());
			return new RedirectPage(this, "FrmNode_queryUpdate");
		}
		return new RedirectPage(this, "FrmNode_queryUpdate");
	}
	
	/**
	 * 分页
	 * 
	 * @param page
	 * @param dataSet
	 * @return
	 */
	private List<Record> setPage(AbstractJspPage page, DataSet dataSet) {
		List<Record> records = null;
		MutiPage pages = new MutiPage();
		pages.setRequest(getRequest());
		pages.setDataSet(dataSet);
		pages.setPageSize(10);
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

	public boolean logon() {
		return true;
	}

}
