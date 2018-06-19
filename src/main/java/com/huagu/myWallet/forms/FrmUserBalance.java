package com.huagu.myWallet.forms;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.huagu.common.util.ParamUtil;

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
import net.sf.json.JSONArray;

/**
 * @describe 后台用户余额金额查询
 * @author lxf
 * @date 2018年4月27日下午2:34:28
 * @return
 */
public class FrmUserBalance extends AbstractForm {

	/**
	 * @describe 后台用户余额金额查询
	 * @author lxf
	 * @date 2018年4月27日下午2:34:39
	 * @return
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "finance/financeUserScan.jsp");
		LocalService getUserMoney = new LocalService(this, "SvrGetUserMoney");
		// 当前一启享用户账户总余额
		if (!getUserMoney.exec("type_", "user_"))
			throw new RuntimeException(getUserMoney.getMessage());

		jsp.add("userMoney", this.setPage(jsp, getUserMoney.getDataOut()));
		ParamUtil.addLog(this, "查询", "后台用户余额金额查询", "后台用户余额金额查询");
		return jsp;
	}
	
    // 查询用户
    public IPage getUser() throws Exception {
        JspPage page = new JspPage(this, "finance/financeUserScan.jsp");
        LocalService svr = new LocalService(this, "SvrGetUserMoney");
        Record record = svr.getDataIn().getHead();
        
        record.setField("overMoneyd_", this.getRequest().getParameter("yed_"));
        record.setField("overMoneyx_", this.getRequest().getParameter("yex_"));
        record.setField("cashPledge_", this.getRequest().getParameter("yjd_"));
        record.setField("amount_1", this.getRequest().getParameter("czd_"));
        record.setField("amount_2", this.getRequest().getParameter("txd_"));
        record.setField("sumRentMoney_", this.getRequest().getParameter("zod_"));
        if (!svr.exec("type_", "user_"))
            throw new RuntimeException(svr.getMessage());
        page.add("userMoney", this.setPage(page, svr.getDataOut()));
        page.add("yed_", this.getRequest().getParameter("yed_"));
        page.add("yex_", this.getRequest().getParameter("yex_"));
        page.add("yjd_", this.getRequest().getParameter("yjd_"));
        page.add("czd_", this.getRequest().getParameter("czd_"));
        page.add("txd_", this.getRequest().getParameter("txd_"));
        page.add("zod_", this.getRequest().getParameter("zod_"));
        return page;
    }

    // 分页
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
    
    public IPage ExcelUser() throws Exception {
        ExportExcel export = new ExportExcel(getResponse());
        export.setHandle(this);
        export.setTemplateId(getRequest().getParameter("templateId"));
        String service = getRequest().getParameter("service");
        String exportKey = getRequest().getParameter("exportKey");
        LocalService svr = new LocalService(this);
        svr.setService(service);
        try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, this.getUserCode(), exportKey)) {
            svr.getDataIn().close();
            svr.getDataIn().setJSON(buff.getString("data"));
        }
        if (svr.exec("type_", "user_")) {
            export.getTemplate().setDataSet(svr.getDataOut());
            export.export();
        } else {
            export.export(svr.getMessage());
        }
        return null;
    }
    
	/**
	 * String转list
	 * @param strs
	 * @return
	 */
	private List<String> stringToList(String strs) {
		String str[] = strs.split(",");
		return Arrays.asList(str);
	}

	/**
	 * 根据List获取到对应的JSONArray
	 * 
	 * @param list
	 * @return
	 */
	public static JSONArray getJSONArrayByList(List<?> list) {
		JSONArray jsonArray = new JSONArray();
		if (list == null || list.isEmpty()) {
			return jsonArray;// nerver return null
		}

		for (Object object : list) {
			jsonArray.add(object);
		}
		return jsonArray;
	}

	/**
	 * list转String
	 * @param users
	 * @return
	 */
	public static String listToString(List<Record> users) {
		if (users == null) {
			return null;
		}
		StringBuilder result = new StringBuilder();
		boolean first = true;
		// 第一个前面不拼接","
		for (Record string : users) {
			if (first) {
				first = false;
			} else {
				result.append(",");
			}
			result.append(string);
		}
		return result.toString();
	}

	@Override
	public boolean logon() {
		return true;
	}

}
