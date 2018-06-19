package com.huagu.myWallet.forms;

import java.util.ArrayList;
import java.util.List;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jpage.grid.MutiPage;

/**
 * 查询平台所有资金账户详情
 * 
 * @author xiaofei-pc
 *
 */
public class FrmFundsAccountDeil extends AbstractForm {
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "wallet/hongbaolog.jsp");
		String accountId_ = this.getRequest().getParameter("accountId_");
		LocalService svr = new LocalService(this, "SvrGetAccountRecordLog");
		if (!svr.exec("accountId_", accountId_))
			throw new RuntimeException(svr.getMessage());

		jsp.add("values", this.setPage(jsp, svr.getDataOut()));
		jsp.add("accountId_", accountId_);
		// 加载标题
		switch (accountId_) {
		case "1010010020066":
			jsp.add("title_", "平台红包账户代码");
			break;
		case "2020010020066":
			jsp.add("title_", "平台租金收益账户");
			break;
		case "3030010020066":
			jsp.add("title_", "平台社区收益提现账户");
			break;
		case "4040010020066":
			jsp.add("title_", "平台机构收益提现账户");
			break;
		case "5050010020066":
			jsp.add("title_", "赔付单实赔付账户");
			break;
		case "6060010020066":
			jsp.add("title_", "平台用户充值账户");
			break;
		case "7070010020066":
			jsp.add("title_", "平台用户提现账户");
			break;
		case "8080010020066":
			jsp.add("title_", "平台用户押金账户");
			break;
		case "9010010020066":
			jsp.add("title_", "平台总账余额");
			break;
		case "9020010020066":
			jsp.add("title_", "平台用户可用余额");
			break;
		default:
			jsp.add("title_", "平台账户明细");
		}
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
