package com.huagu.product.forms;

import java.util.ArrayList;
import java.util.List;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
import cn.cerc.jpage.grid.MutiPage;

public class FrmAdminSupply extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "products/FrmSupplyDetail.jsp");
		String supplyShortName_ = this.getRequest().getParameter("supplyShortName_");
		String tel_ = this.getRequest().getParameter("tel_");
		String businessModel_ = this.getRequest().getParameter("businessModel_");

		LocalService svr = new LocalService(this, "SvrAdminSupply.queryListSupply");
		Record head = svr.getDataIn().getHead();
		head.setField("tel_", tel_);
		head.setField("supplyShortName_", supplyShortName_);
		head.setField("businessModel_", businessModel_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("tel_", tel_);
		page.add("supplyShortName_", supplyShortName_);
		page.add("businessModel_", businessModel_);
		page.add("values", this.setPage(page, svr.getDataOut()));
		return page;

	}

	// 添加供应商信息
	public IPage toInsertSupply() throws Exception {
		JspPage page = new JspPage(this, "products/FrmSupplyInsert.jsp");
		return page;

	}

	// 添加供应商信息
	public IPage insertSupply() throws Exception {
		JsonPage jp = new JsonPage(this);
		String supplyId_ = this.getRequest().getParameter("supplyId_");
		String supplyShortName_ = this.getRequest().getParameter("supplyShortName_");
		String supplyFullName_ = this.getRequest().getParameter("supplyFullName_");
		String businessLicense_ = this.getRequest().getParameter("businessLicense_");
		String companyTel_ = this.getRequest().getParameter("companyTel_");
		String supplyGoodsRange_ = this.getRequest().getParameter("supplyGoodsRange_");
		String contact_ = this.getRequest().getParameter("contact_");
		String tel_ = this.getRequest().getParameter("tel_");
		String qq_ = this.getRequest().getParameter("qq_");
		String businessModel_ = this.getRequest().getParameter("businessModel_");
		String businessAdress_ = this.getRequest().getParameter("businessAdress_");
		String registerMoney_ = this.getRequest().getParameter("registerMoney_");
		String legalExpre_ = this.getRequest().getParameter("legalExpre_");
		LocalService svr = new LocalService(this, "SvrAdminSupply.insertSupply");
		Record head = svr.getDataIn().getHead();
		head.setField("supplyId_", supplyId_);
		head.setField("supplyShortName_", supplyShortName_);
		head.setField("supplyFullName_", supplyFullName_);
		head.setField("businessLicense_", businessLicense_);
		head.setField("companyTel_", companyTel_);
		head.setField("supplyGoodsRange_", supplyGoodsRange_);
		head.setField("contact_", contact_);
		head.setField("tel_", tel_);
		head.setField("qq_", qq_);
		head.setField("businessModel_", businessModel_);
		head.setField("businessAdress_", businessAdress_);
		head.setField("registerMoney_", registerMoney_);
		head.setField("legalExpre_", legalExpre_);
		if (!svr.exec()) {
			jp.setData("true");
		} else {
			jp.setData("false");
		}
		return jp;
	}

	// 修改供应商信息
	public IPage toUpdateSupply() throws Exception {
		JspPage page = new JspPage(this, "products/FrmSupplyUpdate.jsp");
		String supplyId_ = this.getRequest().getParameter("supplyId_");

		LocalService svr = new LocalService(this, "SvrAdminSupply.queryById");
		Record head = svr.getDataIn().getHead();
		head.setField("supplyId_", supplyId_);
		if (!svr.exec()) {
			throw new RuntimeException(svr.getMessage());
		}
		page.add("value", svr.getDataOut().getCurrent());
		return page;

	}

	// 修改供应商信息
	public IPage updateSupply() throws Exception {
		JsonPage jp = new JsonPage(this);
		String supplyId_ = this.getRequest().getParameter("supplyId_");
		String supplyShortName_ = this.getRequest().getParameter("supplyShortName_");
		String supplyFullName_ = this.getRequest().getParameter("supplyFullName_");
		String businessLicense_ = this.getRequest().getParameter("businessLicense_");
		String companyTel_ = this.getRequest().getParameter("companyTel_");
		String supplyGoodsRange_ = this.getRequest().getParameter("supplyGoodsRange_");
		String contact_ = this.getRequest().getParameter("contact_");
		String tel_ = this.getRequest().getParameter("tel_");
		String qq_ = this.getRequest().getParameter("qq_");
		String businessModel_ = this.getRequest().getParameter("businessModel_");
		String businessAdress_ = this.getRequest().getParameter("businessAdress_");
		String registerMoney_ = this.getRequest().getParameter("registerMoney_");
		String legalExpre_ = this.getRequest().getParameter("legalExpre_");
		LocalService svr = new LocalService(this, "SvrAdminSupply.updateSupply");
		Record head = svr.getDataIn().getHead();
		head.setField("supplyId_", supplyId_);
		head.setField("supplyShortName_", supplyShortName_);
		head.setField("supplyFullName_", supplyFullName_);
		head.setField("businessLicense_", businessLicense_);
		head.setField("companyTel_", companyTel_);
		head.setField("supplyGoodsRange_", supplyGoodsRange_);
		head.setField("contact_", contact_);
		head.setField("tel_", tel_);
		head.setField("qq_", qq_);
		head.setField("businessModel_", businessModel_);
		head.setField("businessAdress_", businessAdress_);
		head.setField("registerMoney_", registerMoney_);
		head.setField("legalExpre_", legalExpre_);
		if (!svr.exec()) {
			jp.setData("false");
			throw new RuntimeException(svr.getMessage());
		} else {
			jp.setData("true");
		}
		return jp;

	}

	// 删除供应商信息
	public IPage delSupply() throws Exception {
		String supplyId_ = this.getRequest().getParameter("supplyId_");
		LocalService svr = new LocalService(this, "SvrAdminSupply.delSupply");
		Record head = svr.getDataIn().getHead();
		head.setField("supplyId_", supplyId_);
		if (!svr.exec()) {
			throw new RuntimeException(svr.getMessage());
		}
		return new RedirectPage(this, "FrmAdminSupply");
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

	/*
	 * public boolean logon() { return true; }
	 */
}
