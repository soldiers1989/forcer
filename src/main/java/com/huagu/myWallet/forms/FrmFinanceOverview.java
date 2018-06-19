package com.huagu.myWallet.forms;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;

/**
 * @describe 财务总览
 * @author lxf
 * @date 2018年5月7日下午2:34:28
 * @return
 */
public class FrmFinanceOverview extends AbstractForm {

	/**
	 * @describe 财务总览
	 * @author lxf
	 * @date 2018年5月7日下午2:34:28
	 * @return
	 */
	@Override
	public IPage execute() throws Exception {
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

	@Override
	public boolean logon() {
		return true;
	}

}
