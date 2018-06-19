package com.huagu.common.tools;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jexport.excel.ExportExcel;
import cn.cerc.jmis.form.AbstractForm;

/**
 * 后台数据导出公用Form
 */
public class FrmExcel extends AbstractForm {
    @Override
    public IPage execute() throws Exception {
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
        if (svr.exec()) {
            export.getTemplate().setDataSet(svr.getDataOut());
            export.export();
        } else {
            export.export(svr.getMessage());
        }
        return null;
    }

    public IPage getExcelByDataSet() throws Exception {
        ExportExcel export = new ExportExcel(getResponse());
        export.setHandle(this);
        export.setTemplateId(getRequest().getParameter("templateId"));
        String exportKey = getRequest().getParameter("exportKey");

        DataSet ds = new DataSet();
        try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, this.getUserCode(), exportKey)) {
            ds = new DataSet();
            ds.setJSON(buff.getString("data"));
        }
        export.getTemplate().setDataSet(ds);
        export.export();
        return null;
    }
}
