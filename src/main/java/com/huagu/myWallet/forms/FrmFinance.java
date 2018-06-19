package com.huagu.myWallet.forms;

import java.util.ArrayList;
import java.util.List;

import com.huagu.common.util.ParamUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jpage.grid.MutiPage;

/**
 * @describe 财务管理
 * @author 王姣
 * @date 2018年4月3日下午2:34:28
 * @return
 */
public class FrmFinance extends AbstractForm {

	/**
	 * @describe 财务列表查询(后台)
	 * @author 王姣
	 * @date 2018年4月3日下午2:34:39
	 * @return
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "finance/financeList.jsp");
		LocalService svr = new LocalService(this, "SvrFinanceQuery");
		Record head = svr.getDataIn().getHead();
		head.setField("name_", this.getRequest().getParameter("name_"));
		head.setField("status_", this.getRequest().getParameter("status_"));
		head.setField("platform_", this.getRequest().getParameter("platform_"));
		head.setField("opeType_", this.getRequest().getParameter("opeType_"));
		head.setField("type_", this.getRequest().getParameter("type_"));
		head.setField("orderId_", this.getRequest().getParameter("orderId_"));
		head.setField("createDate1", this.getRequest().getParameter("createDate1"));
		head.setField("createDate2", this.getRequest().getParameter("createDate2"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("finances", this.setPage(jsp, svr.getDataOut()));
		jsp.add("name_", this.getRequest().getParameter("name_"));
		jsp.add("status_", this.getRequest().getParameter("status_"));
		jsp.add("platform_", this.getRequest().getParameter("platform_"));
		jsp.add("type_", this.getRequest().getParameter("type_"));
		jsp.add("opeType_", this.getRequest().getParameter("opeType_"));
		jsp.add("orderId_", this.getRequest().getParameter("orderId_"));
		jsp.add("createDate1", this.getRequest().getParameter("createDate1"));
		jsp.add("createDate2", this.getRequest().getParameter("createDate2"));
		ParamUtil.addLog(this, "查询", "后台财务管理列表查询", "后台财务管理列表查询");
		return jsp;
	}
	
	public IPage FinanceScan() throws Exception{
		JspPage jsp = new JspPage(this, "finance/financeScan.jsp");
		// 当前一启享微信账户总余额
		LocalService getUserMoney = new LocalService(this, "SvrGetUserMoney");
		if(!getUserMoney.exec())
			throw new RuntimeException(getUserMoney.getMessage());
		jsp.add("userMoney", getUserMoney.getDataOut().getCurrent().getString("overMoney_"));

		// 上月累计充值金额
		LocalService rechargeMoney = new LocalService(this, "SvrGetRechargeMoney");
		if(!rechargeMoney.exec("type_", "1"))
			throw new RuntimeException(rechargeMoney.getMessage());
		jsp.add("rechargeMoney", rechargeMoney.getDataOut().getCurrent().getString("amount_"));
		
		// 用户当前押金合计
		LocalService getYaJin = new LocalService(this, "SvrGetYaJin");
		if(!getYaJin.exec())
			throw new RuntimeException(getYaJin.getMessage());
		jsp.add("yajin", getYaJin.getDataOut().getCurrent().getString("cashPledge_"));
		
		// 上月用户累计提现金额
		LocalService withdrawMoney = new LocalService(this, "SvrGetRechargeMoney");
		if(!withdrawMoney.exec("type_", "0"))
			throw new RuntimeException(withdrawMoney.getMessage());
		jsp.add("withdrawMoney", withdrawMoney.getDataOut().getCurrent().getString("amount_"));
		
		// 用户当前正数余额合计
		LocalService getUserZsMoney = new LocalService(this, "SvrGetUserMoney");
		if(!getUserZsMoney.exec("type_", "zs"))
			throw new RuntimeException(getUserZsMoney.getMessage());
		jsp.add("zs", getUserZsMoney.getDataOut().getCurrent().getString("overMoney_"));
		
		// 上月平台财务收益提现累计金额
		
		// 用户当前负数余额合计
		LocalService getUserFsMoney = new LocalService(this, "SvrGetUserMoney");
		if(!getUserFsMoney.exec("type_", "fs"))
			throw new RuntimeException(getUserFsMoney.getMessage());
		jsp.add("fs", getUserFsMoney.getDataOut().getCurrent().getString("overMoney_"));
		// 上月平台收益合计
		
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

	@Override
	public boolean logon() {
		return true;
	}

}
