package com.huagu.troubleshooting.forms;

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
 * 月账单
 * 
 * @author xiaofei-pc
 *
 */
public class FrmMonthBill extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "troubleshooting/monthbill.jsp");
		LocalService getBill = new LocalService(this, "SvrGetDayBill");
        Record record = getBill.getDataIn().getHead();
        record.setField("type_", "month");
        record.setField("unlockDate_", this.getRequest().getParameter("unlockDate_"));
        record.setField("endDate_", this.getRequest().getParameter("endDate_"));
		if (!getBill.exec()) {
			throw new RuntimeException(getBill.getMessage());
		}

        page.add("values", this.setPage(page, getBill.getDataOut()));
        page.add("unlockDate_", this.getRequest().getParameter("unlockDate_"));
        page.add("endDate_", this.getRequest().getParameter("endDate_"));
		return page;
	}

	/**
	 * 导出周账单
	 * @return
	 * @throws Exception
	 */
    public IPage excel() throws Exception {
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
        if (svr.exec("type_", "month")) {
            export.getTemplate().setDataSet(svr.getDataOut());
            export.export();
        } else {
            export.export(svr.getMessage());
        }
        return null;
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
	
	@Override
	public boolean logon() {
		return true;
	}

}
