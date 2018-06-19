package com.huagu.creditManagement.forms;

import org.apache.log4j.Logger;

import com.huagu.common.util.ParamUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jexport.excel.ExportExcel;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;

/**
 * 查询后台单独配置征信列表
 * 
 * @author xiaofei-pc
 *
 */
public class FrmUserPersonalCredit extends AbstractForm {
	@SuppressWarnings("unused")
	private static final Logger LOGGER = Logger.getLogger(FrmUserPersonalCredit.class);

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "creditManageMent/userPersonalLog.jsp");
        // 查询后台单独配置征信列表
		String name_ = this.getRequest().getParameter("name_");
		String date_ = this.getRequest().getParameter("date_");
		String fangfa_ = this.getRequest().getParameter("fangfa_");
		String statu_ = this.getRequest().getParameter("statu_");
        LocalService personal = new LocalService(this, "SvrGetUserPersonalCredit");
        if (!personal.exec("type_", "sel", "name_", name_, "date_", date_, "fangfa_", fangfa_, "statu_", statu_))
            throw new RuntimeException(personal.getMessage());
        
        jsp.add("personal", personal.getDataOut().getRecords());
        jsp.add("name_", name_);
        jsp.add("date_", date_);
        jsp.add("fangfa_", fangfa_);
        jsp.add("statu_", statu_);
		ParamUtil.addLog(this, "查询", "查询后台单独配置征信列表", "查询后台单独配置征信列表");
		return jsp;
	}

	/**
	 * 修改状态
	 * @return
	 * @throws Exception
	 */
	public JsonPage upCredit() throws Exception {
		JsonPage json = new JsonPage(this);
		String id_ = this.getRequest().getParameter("id_");
		String status_ = this.getRequest().getParameter("status_");
		LocalService upCredit = new LocalService(this, "SvrGetUserPersonalCredit");
		if (!upCredit.exec("type_", "up", "status_", status_, "id_", id_)) {
			json.setData(false);
		} else {
			json.setData(true);
		}
		return json;
	}

    /**
     * 导出excel表格
     */
    public IPage excel() throws Exception {
        ExportExcel export = new ExportExcel(getResponse());
        export.setHandle(this);
        export.setTemplateId(getRequest().getParameter("templateId"));
        String service = getRequest().getParameter("service");
        String exportKey = getRequest().getParameter("exportKey");
        LocalService svr = new LocalService(this);
		ParamUtil.addLog(this, "导出", "导出后台单独配置征信列表", "导出后台单独配置征信列表");
        svr.setService(service);
        try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, this.getUserCode(), exportKey)) {
            svr.getDataIn().close();
            svr.getDataIn().setJSON(buff.getString("data"));
        }
        if (svr.exec("type_", "sel")) {
            export.getTemplate().setDataSet(svr.getDataOut());
            export.export();
        } else {
            export.export(svr.getMessage());
        }
        return null;
    }
	
	public boolean logon() {
		return true;
	}
}
