package com.huagu.creditManagement.forms;

import org.apache.log4j.Logger;

import com.huagu.common.util.ParamUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;

/**
 * 查询后台征信和订单关联
 * 
 * @author xiaofei-pc
 *
 */
public class FrmClientAndOrder extends AbstractForm {
	@SuppressWarnings("unused")
	private static final Logger LOGGER = Logger.getLogger(FrmClientAndOrder.class);

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "creditManageMent/clientandorder.jsp");
		String mobile_ = this.getRequest().getParameter("mobile_");
		String unlockDate_ = this.getRequest().getParameter("unlockDate_");
		String endDate_ = this.getRequest().getParameter("endDate_");
		String channel_ = this.getRequest().getParameter("channel_");
		String jigou_ = this.getRequest().getParameter("jigou_");
		String moneyq_ = this.getRequest().getParameter("moneyq_");
		String moneyh_ = this.getRequest().getParameter("moneyh_");
		
		LocalService getCreditDeploy = new LocalService(this, "SvrGetClientAndOrder");
		if (!getCreditDeploy.exec("mobile_", mobile_, "unlockDate_", unlockDate_, "endDate_", endDate_
				, "channel_", channel_, "jigou_", jigou_, "moneyq_", moneyq_, "moneyh_", moneyh_))
			throw new RuntimeException(getCreditDeploy.getMessage());

		ParamUtil.addLog(this, "查询", "查询后台征信和订单关联列表", "查询后台征信和订单关联列表");
		jsp.add("sesame", getCreditDeploy.getDataOut().getRecords());
		jsp.add("mobile_", mobile_);
		jsp.add("channel_", channel_);
		jsp.add("jigou_", jigou_);
		jsp.add("moneyq_", moneyq_);
		jsp.add("moneyh_", moneyh_);
		jsp.add("endDate_", endDate_);
		jsp.add("unlockDate_", unlockDate_);
		return jsp;
	}

	/**
	 * 修改客户认证的状态
	 * 
	 * @return
	 * @throws Exception 
	 */
	public JsonPage up() throws Exception {
		JsonPage json = new JsonPage(this);
		String id_ = this.getRequest().getParameter("id_");
		String status_ = this.getRequest().getParameter("status_");
		LocalService upCredit = new LocalService(this, "SvrGetClientLog");
		if (!upCredit.exec("type_", "up", "status_", status_, "id_", id_)) {
			json.setData(false);
		} else {
			json.setData(true);
		}
		ParamUtil.addLog(this, "修改", "修改后台客户认证资料列表", "修改后台客户认证资料列表"+ id_);
		return json;
	}
	
	/**
	 * 删除客户认证记录
	 * 
	 * @return
	 * @throws Exception 
	 */
	public JsonPage del() throws Exception {
		JsonPage json = new JsonPage(this);
		String id_ = this.getRequest().getParameter("id_");
		LocalService upCredit = new LocalService(this, "SvrGetClientLog");
		if (!upCredit.exec("type_", "del", "id_", id_)) {
			json.setData(false);
		} else {
			json.setData(true);
		}
		ParamUtil.addLog(this, "删除", "删除后台客户认证资料列表", "删除后台客户认证资料列表"+ id_);
		return json;
	}

	public boolean logon() {
		return true;
	}
}
