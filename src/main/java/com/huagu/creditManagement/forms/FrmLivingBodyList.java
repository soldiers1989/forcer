package com.huagu.creditManagement.forms;

import org.apache.log4j.Logger;

import com.huagu.common.util.ParamUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;

/**
 * 查询后台活体映像列表
 * 
 * @author xiaofei-pc
 *
 */
public class FrmLivingBodyList extends AbstractForm {
	@SuppressWarnings("unused")
	private static final Logger LOGGER = Logger.getLogger(FrmLivingBodyList.class);

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "creditManageMent/livingBodyList.jsp");
		String mobile_ = this.getRequest().getParameter("mobile_");
		String status_ = this.getRequest().getParameter("status_");
		String sxDate_ = this.getRequest().getParameter("sxDate_");
		String date_ = this.getRequest().getParameter("date_");
		LocalService getCreditDeploy = new LocalService(this, "SvrGetLivingBody");
		if (!getCreditDeploy.exec("mobile_", mobile_, "status_", status_, "sxDate_", sxDate_, "date_", date_))
			throw new RuntimeException(getCreditDeploy.getMessage());

		ParamUtil.addLog(this, "查询", "查询后台活体映像列表", "查询后台活体映像列表");
		jsp.add("sesame", getCreditDeploy.getDataOut().getRecords());
		jsp.add("mobile_", mobile_);
		jsp.add("status_", status_);
		jsp.add("sxDate_", sxDate_);
		jsp.add("date_", date_);
		return jsp;
	}

	/**
	 * 更改活体状态
	 * 
	 * @return
	 * @throws Exception 
	 */
	public JsonPage up() throws Exception {
		JsonPage json = new JsonPage(this);
		String id_ = this.getRequest().getParameter("id_");
		String status_ = this.getRequest().getParameter("status_");
		LocalService upCredit = new LocalService(this, "SvrGetLivingBody");
		if (!upCredit.exec("type_", "up", "id_", id_, "status_", status_)) {
			json.setData(false);
		} else {
			json.setData(true);
		}
		ParamUtil.addLog(this, "修改", "修改后台活体映像列表", "修改后台活体映像列表id"+ id_);
		return json;
	}
	
	/**
	 * 延长活体时间
	 * 
	 * @return
	 * @throws Exception 
	 */
	public JsonPage ups() throws Exception {
		JsonPage json = new JsonPage(this);
		String id_ = this.getRequest().getParameter("id_");
		LocalService upCredit = new LocalService(this, "SvrGetLivingBody");
		if (!upCredit.exec("type_", "ups", "id_", id_)) {
			json.setData(false);
		} else {
			json.setData(true);
		}
		ParamUtil.addLog(this, "修改", "修改后台延长活体时间列表", "修改后台延长活体时间列表id"+ id_);
		return json;
	}

	public boolean logon() {
		return true;
	}
}
