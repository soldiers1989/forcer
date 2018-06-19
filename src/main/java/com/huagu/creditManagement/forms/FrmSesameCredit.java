package com.huagu.creditManagement.forms;

import org.apache.log4j.Logger;
import com.huagu.creditManagement.util.SesameCredit;
import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
import net.sf.json.JSONObject;

public class FrmSesameCredit extends AbstractForm {
	@SuppressWarnings("unused")
	private static final Logger LOGGER = Logger.getLogger(FrmSesameCredit.class);

	@Override
	public IPage execute() throws Exception {
		return new JspPage(this, "wallet/sesameCredit.jsp");
	}

	/**
	 * 生成身份证对应的芝麻信用授权链接
	 * @return
	 */
	public JsonPage zhimaAuthInfoAuthorize() {
		JsonPage json = new JsonPage(this);
		String certNo_ = this.getRequest().getParameter("card_");
		String name_ = this.getRequest().getParameter("name_");
		// 更新当前登录用户的身份证信息
		LocalService getUserCard = new LocalService(this, "SvrUserCard");
		if(!getUserCard.exec("type_", "i", "certNo_", certNo_ , "name_", name_))
            throw new RuntimeException(getUserCard.getMessage());
		SesameCredit sesameCredit = new SesameCredit();
		String url = sesameCredit.zhimaAuthInfoAuthorize(certNo_, name_);
		
		// 生成授权链接同时生成认证记录信息
		LocalService getCreditDeploy = new LocalService(this, "SvrGetSesameLog");
		if (!getCreditDeploy.exec("type_", "in", "certNo_", certNo_ , "name_", name_, "sqStatus_", "0", "rzStatus_", "0"))
			throw new RuntimeException(getCreditDeploy.getMessage());
		
		json.setData(url);
		return json;
	}
	
	/**
	 * 更新用户认证后的信息
	 * @return
	 */
	public IPage sesameCredit(){
		// 取当前登录用户的身份证信息
		LocalService getUserCard = new LocalService(this, "SvrUserCard");
		if(!getUserCard.exec("type_", "s"))
            throw new RuntimeException(getUserCard.getMessage());

		String certNo_ = getUserCard.getDataOut().getString("cardId_");
		String name_ = getUserCard.getDataOut().getString("cardName_");
		LOGGER.info("取得用户"+ this.getUserCode() +"数据库身份信息："+ certNo_ +"，姓名："+name_);
		SesameCredit sesa = new SesameCredit();
		Object jsonReq = sesa.zhimaAuthInfoReq(certNo_, name_);
		JSONObject json = JSONObject.fromObject(jsonReq);
		String openId_ = json.get("openId").toString();
		
		String fraction = sesa.getScore(openId_);

		// 获取当芝麻分并写入数据库中
		LocalService upUserSesame = new LocalService(this, "SvrUserCard");
		if(!upUserSesame.exec("type_", "u" , "fraction", fraction))
            throw new RuntimeException(upUserSesame.getMessage());

		// 更改授权链接同时生成认证记录信息
		LocalService getCreditDeploy = new LocalService(this, "SvrGetSesameLog");
		if (!getCreditDeploy.exec("type_", "up", "certNo_", certNo_ , "name_", name_,"fraction", fraction, "sqStatus_", "1", "rzStatus_", "1"))
			throw new RuntimeException(getCreditDeploy.getMessage());
		
		LOGGER.info("系统已更新用户:"+ this.getUserCode() +"芝麻分为："+ fraction);
		return new RedirectPage(this, "FrmMore.reliefDeposit");
	}

	public boolean logon() {
		return true;
	}
}
