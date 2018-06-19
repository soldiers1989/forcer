package com.huagu.pay.forms;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.huagu.common.util.WxPayUtil;

import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.pay.wxpay.WxpayJs;

public class FrmWeixinPay extends AbstractForm {

	private static final Logger log = Logger.getLogger(FrmWeixinPay.class);

	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this);
		return page;
	}

	/**
	 * 微信支付
	 */
	public IPage recharge() {
		JsonPage page = new JsonPage(this);
		Map<String, Object> map = new HashMap<String, Object>();
		String body = this.getRequest().getParameter("body");
		String amount = this.getRequest().getParameter("amount");
		String notifyUrl = this.getRequest().getParameter("notifyUrl");
		String orderNo = String.valueOf(System.currentTimeMillis());

		/*
		 * LocalService svr = new LocalService(this, "SvrModfiyPayLog"); if
		 * (!svr.exec("payRemark_", body, "outTradeNo_", orderNo, "amount_",
		 * amount)) { map.put("result", "error"); map.put("msg",
		 * svr.getMessage()); } else {
		 */
		log.info(this.getClient().getDevice());
		/*
		 * if (ClientDevice.device_weixin.equals(this.getClient().getDevice()))
		 * {
		 */
		WxpayJs pay = new WxpayJs(this, new ServerConfig());
		pay.setAmount(amount);
		pay.setOrderNo(orderNo);
		pay.setNotifyUrl(notifyUrl);
		String prepaid = pay.requestPay(body);
		map.put("result", "success");
		map.put("prepaid", prepaid);
		log.info("pay:" + pay);
		log.info("prepaid:" + prepaid);
		/*
		 * } else { map.put("result", "error"); map.put("msg", "请使用客户端支付"); }
		 */
		/* } */
		page.setData(map);
		return page;
	}

	// 统一支付
	public IPage tyzf() throws IOException {
		JsonPage page = new JsonPage(this);
		Map<String, Object> map = new HashMap<String, Object>();

		String body = this.getRequest().getParameter("body");
		String amount = this.getRequest().getParameter("amount");
		String openid = this.getRequest().getParameter("openid");
		String orderNo = String.valueOf(System.currentTimeMillis());
		
		BigDecimal money = new BigDecimal(amount);
		System.out.println(this.getRequest().getSession().getAttribute(this.getUserCode()).toString());
		// 统一下单，返回xml，用return_code判断统一下单结果,获取prepay_id等预支付成功信息
		String prePayInfoXml = WxPayUtil.unifiedOrder(body, orderNo, (money.multiply(new BigDecimal(100))).intValue(),
				WxPayUtil.getIpAddr(getRequest()),
				this.getRequest().getSession().getAttribute(this.getUserCode()).toString());

		// 生成包含prepay_id的map，map传入前端
		map = WxPayUtil.getPayMap(prePayInfoXml);
		// 将订单号放入map，用以支付后处理
		map.put("orderNo", orderNo);
		page.setData(map);
		System.out.println(map);
		try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, openid, "code_")) {
			buff.setField("amount", amount);
			buff.setField("userCode", this.getUserCode());
		}

		try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, openid, "code_")) {
			String amount1 = (String) buff.getField("amount");
			System.out.println("用户：" + this.getUserCode() + "充值了：" + amount1 + "元");
		}
		return page;
	}

	@Override
	public boolean logon() {
		return true;
	}
}
