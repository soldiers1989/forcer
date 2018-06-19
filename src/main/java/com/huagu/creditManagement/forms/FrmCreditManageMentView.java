package com.huagu.creditManagement.forms;

import org.apache.log4j.Logger;

import com.huagu.common.util.ParamUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;

/**
 * 后台征信管理
 * 
 * @author xiaofei-pc
 *
 */
public class FrmCreditManageMentView extends AbstractForm {
	@SuppressWarnings("unused")
	private static final Logger LOGGER = Logger.getLogger(FrmCreditManageMentView.class);

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "creditManageMent/creditScan.jsp");
		
		
		ParamUtil.addLog(this, "查询", "查询后台征信管理", "查询后台征信管理");
		return jsp;
	}

	/**
	 * 更改后台征信配置 credit 芝麻分设置 credit1 芝麻分认证成功抵扣金额 credit2 活体映像认证成功抵扣金额 credit3
	 * 绑定银行卡认证成功抵扣金额 credit4 认证客户抵扣金额
	 * 
	 * @return
	 * @throws Exception 
	 */
	public JsonPage upCredit() throws Exception {
		JsonPage json = new JsonPage(this);
		String credit = this.getRequest().getParameter("credit");
		String credit1 = this.getRequest().getParameter("credit1");
		String credit2 = this.getRequest().getParameter("credit2");
		String credit3 = this.getRequest().getParameter("credit3");
		String credit4 = this.getRequest().getParameter("credit4");
		LocalService upCredit = new LocalService(this, "SvrGetCreditDeploy");
		if (!upCredit.exec("type_", "up", "credit", credit, "credit1", credit1, "credit2", credit2, "credit3", credit3,
				"credit4", credit4)) {
			json.setData(false);
		} else {
			json.setData(true);
		}
		
		if(credit != null || credit != "")
			ParamUtil.addLog(this, "修改", "修改后台征信配置", "修改后台征信配置芝麻分设置："+credit);

		if(credit1 != null || credit1 != "")
			ParamUtil.addLog(this, "修改", "修改后台征信配置", "修改后台芝麻分认证成功抵扣金额："+credit1);

		if(credit2 != null || credit2 != "")
			ParamUtil.addLog(this, "修改", "修改后台征信配置", "修改后台活体映像认证成功抵扣金额："+credit2);

		if(credit3 != null || credit3 != "")
			ParamUtil.addLog(this, "修改", "修改后台征信配置", "修改后台绑定银行卡认证成功抵扣金额："+credit3);

		if(credit4 != null || credit4 != "")
			ParamUtil.addLog(this, "修改", "修改后台征信配置", "修改后台认证客户抵扣金额："+credit4);
		
		return json;
	}

	public boolean logon() {
		return true;
	}
}
