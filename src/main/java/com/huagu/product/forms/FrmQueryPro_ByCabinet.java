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
import cn.cerc.jpage.grid.MutiPage;

public class FrmQueryPro_ByCabinet extends AbstractForm {
	
	/**
	 * 按照机柜组查询物品存放状态
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "products/FrmQueryPro_ByCabinet.jsp");
		String zhuCode_ = this.getRequest().getParameter("zhuCode_");//主电子条码
		String homeAgency_ = this.getRequest().getParameter("homeAgency_");//归属机构
		String name_ = this.getRequest().getParameter("name_");//柜组名称
		String communityName_ = this.getRequest().getParameter("communityName_");//社区简称
		LocalService ls=new LocalService(this,"SvrQueryPro_ByCabinet.queryProByCabinet");
		Record head = ls.getDataIn().getHead();
		head.setField("zhuCode_", zhuCode_);
		head.setField("homeAgency_", homeAgency_);
		head.setField("name_", name_);
		head.setField("communityName_", communityName_);
		if(!ls.exec()){
			page.add("msg", ls.getMessage());
			return page;
		}
		// 缓存查询条件用做导出
        try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, this.getUserCode(), "SvrQueryPro_ByCabinet.queryProByCabinet")) {
            buff.setField("data", ls.getDataIn().getJSON());
        }
		page.add("zhuCode_", zhuCode_);
		page.add("homeAgency_", homeAgency_);
		page.add("name_", name_);
		page.add("communityName_", communityName_);
		page.add("value", this.setPage(page, ls.getDataOut()));
		return page;
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
