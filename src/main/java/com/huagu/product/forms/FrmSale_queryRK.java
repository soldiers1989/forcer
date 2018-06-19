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

public class FrmSale_queryRK extends AbstractForm  {

	/**
	 * 入库单的查询列表
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage page =new JspPage(this,"products/FrmSale_queryRK.jsp");
		String proName_ = this.getRequest().getParameter("proName_");//物品名称
		String saleHomeAgency_ = this.getRequest().getParameter("saleHomeAgency_");//归属机构
		String saleSupply_ = this.getRequest().getParameter("saleSupply_");//供应商
		String saleRuKuTime_ = this.getRequest().getParameter("saleRuKuTime_");//入库时间 
		String fristNameId_ = this.getRequest().getParameter("fristNameId_");
		String twoNameId_ = this.getRequest().getParameter("twoNameId_");
		LocalService rk=new LocalService(this,"SvrSaleProManage.queryRKList");
		Record head = rk.getDataIn().getHead();
		head.setField("proName_", proName_);
		head.setField("saleHomeAgency_", saleHomeAgency_);
		head.setField("saleSupply_", saleSupply_);
		head.setField("saleRuKuTime_", saleRuKuTime_);
		head.setField("fristNameId_", fristNameId_);
		head.setField("twoNameId_", twoNameId_);
		if(!rk.exec()){
			page.add("msg", rk.getMessage());
			return page;
		}
		// 缓存查询条件用做导出
        try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, this.getUserCode(), "SvrSaleProManage.queryRKList")) {
            buff.setField("data", rk.getDataIn().getJSON());
        }
        page.add("proName_", proName_);
        page.add("saleHomeAgency_", saleHomeAgency_);
        page.add("saleSupply_", saleSupply_);
		page.add("value",  this.setPage(page, rk.getDataOut()));
		return page;
	}

	//入库数量冲红
	public IPage toCHong() throws Exception{
		JspPage page =new JspPage(this,"products/FrmSale_CHong.jsp");
		String ruKuId_ = this.getRequest().getParameter("ruKuId_");//物品入库单号
		LocalService rkCH=new LocalService(this,"SvrSaleProManage.queryRuKuByRKId");
		Record head = rkCH.getDataIn().getHead();
		head.setField("ruKuId_", ruKuId_);
		if(!rkCH.exec()){
			page.add("msg", rkCH.getMessage());
			return page;
		}
		page.add("value", rkCH.getDataOut().getCurrent());
		return page;
	
	}
	
	//入库数量冲红
	public IPage CHong() throws Exception{
		JspPage page =new JspPage(this,"products/FrmSale_CHong.jsp");
		String ruKuId_ = this.getRequest().getParameter("ruKuId_");//物品入库单号
		String chCountNew_ = this.getRequest().getParameter("chCountNew_");//物品入库单号
		LocalService rkCH=new LocalService(this,"SvrSaleProManage.toCHong");
		Record head = rkCH.getDataIn().getHead();
		head.setField("ruKuId_", ruKuId_);
		head.setField("chCount_", chCountNew_);
		if(!rkCH.exec()){
			page.add("msg", rkCH.getMessage());
			return new RedirectPage(this, "FrmSale_queryRK.toCHong?ruKuId_="+ruKuId_);
		}
		return new RedirectPage(this, "FrmSale_queryRK");
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
