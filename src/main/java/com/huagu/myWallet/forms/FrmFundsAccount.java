package com.huagu.myWallet.forms;

import java.util.ArrayList;
import java.util.List;
import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jexport.excel.ExportExcel;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jpage.grid.MutiPage;

/**
 * 查询平台所有资金账户
 * 
 * @author xiaofei-pc
 *
 */
public class FrmFundsAccount extends AbstractForm {
	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "wallet/FrmFundsAccount.jsp");
		// 查询平台咨询账户列表
		LocalService svr = new LocalService(this, "SvrGetFinanceOvervicw");
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());

		page.add("values", this.setPage(page, svr.getDataOut()));
		return page;
	}

	/**
	 * 查询平台红包明细
	 * 
	 * @return
	 * @throws Exception
	 */
	public IPage hongbao() throws Exception {
		JspPage jsp = new JspPage(this, "wallet/hongbaolog.jsp");
		String accountId_ = this.getRequest().getParameter("accountId_");
		String unlockDate_ = this.getRequest().getParameter("unlockDate_");
		String endDate_ = this.getRequest().getParameter("endDate_");
		String desc_ = this.getRequest().getParameter("desc_");
		LocalService svr = new LocalService(this, "SvrGetAccountRecordLog");
		if (!svr.exec("accountId_", accountId_, "unlockDate_", unlockDate_, "endDate_", endDate_, "desc_", desc_))
			throw new RuntimeException(svr.getMessage());

		jsp.add("values", this.setPage(jsp, svr.getDataOut()));
		jsp.add("accountId_", accountId_);
		jsp.add("unlockDate_", unlockDate_);
		jsp.add("endDate_", endDate_);
		jsp.add("desc_", desc_);
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

	/**
	 * 导出excel表格
	 * 
	 * @return
	 * @throws Exception
	 */
	public IPage excel() throws Exception {
		ExportExcel export = new ExportExcel(getResponse());
		export.setHandle(this);
		export.setTemplateId(getRequest().getParameter("templateId"));
		String service = getRequest().getParameter("service");
		String exportKey = getRequest().getParameter("exportKey");
		String accountId_ = getRequest().getParameter("accountId_");
		LocalService svr = new LocalService(this);
		svr.setService(service);
		try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, this.getUserCode(), exportKey)) {
			svr.getDataIn().close();
			svr.getDataIn().setJSON(buff.getString("data"));
		}
		if (svr.exec("accountId_", accountId_)) {
			export.getTemplate().setDataSet(svr.getDataOut());
			export.export();
		} else {
			export.export(svr.getMessage());
		}
		return null;
	}

	/**
	 * 查询平台租金收益账户明细
	 * 
	 * @return
	 * @throws Exception
	 */
	public IPage zujin() throws Exception {
		JspPage jsp = new JspPage(this, "wallet/zujinlog.jsp");

		return jsp;
	}

	/**
	 * 查询平台社区收益提现账户明细
	 * 
	 * @return
	 * @throws Exception
	 */
	public IPage sequ() throws Exception {
		JspPage jsp = new JspPage(this, "wallet/sequlog.jsp");

		return jsp;
	}

	/**
	 * 查询平台机构收益提现账户明细
	 * 
	 * @return
	 * @throws Exception
	 */
	public IPage jigou() throws Exception {
		JspPage jsp = new JspPage(this, "wallet/jigoulog.jsp");

		return jsp;
	}

	/**
	 * 查询赔付单实赔付账户明细
	 * 
	 * @return
	 * @throws Exception
	 */
	public IPage peifu() throws Exception {
		JspPage jsp = new JspPage(this, "wallet/peifulog.jsp");

		return jsp;
	}

	/**
	 * 查询用户充值账户明细
	 * 
	 * @return
	 * @throws Exception
	 */
	public IPage chongzhi() throws Exception {
		JspPage jsp = new JspPage(this, "wallet/chongzhilog.jsp");

		return jsp;
	}

	/**
	 * 查询用户提现账户明细
	 * 
	 * @return
	 * @throws Exception
	 */
	public IPage tixian() throws Exception {
		JspPage jsp = new JspPage(this, "wallet/tixianlog.jsp");

		return jsp;
	}

	/**
	 * 查询用户提现账户明细
	 * 
	 * @return
	 * @throws Exception
	 */
	public IPage yajin() throws Exception {
		JspPage jsp = new JspPage(this, "wallet/yajinlog.jsp");

		return jsp;
	}

	/**
	 * 查询用户提现账户明细
	 * 
	 * @return
	 * @throws Exception
	 */
	public IPage zongzhang() throws Exception {
		JspPage jsp = new JspPage(this, "wallet/yajinlog.jsp");

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
