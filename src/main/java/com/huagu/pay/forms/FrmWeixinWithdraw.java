package com.huagu.pay.forms;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import org.apache.log4j.Logger;

import com.huagu.common.util.WxPayConstants;
import com.huagu.pay.enums.CZTXEnum;
import com.huagu.pay.enums.PlatformEnum;
import com.huagu.pay.enums.StatusEnum;
import com.huagu.pay.util.CollectionUtil;
import com.huagu.pay.util.HttpUtils;
import com.huagu.pay.util.PayUtil;
import com.huagu.pay.util.XmlUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.Transaction;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;


public class FrmWeixinWithdraw extends AbstractForm {

	private static final Logger log = Logger.getLogger(FrmWeixinWithdraw.class);

	@Override
	public IPage execute() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	public IPage Withdraw() throws Exception {
		JsonPage page = new JsonPage(this);
		Map<String, Object> map = new HashMap<String, Object>();
		/*double money = Double.parseDouble(this.getRequest().getParameter("money"));*/
		String money = this.getRequest().getParameter("money");// 传入付款金额
		String orderNo = String.valueOf(System.currentTimeMillis());// 系统时间，精确到毫秒
		String openId = this.getRequest().getParameter("openid");
		/*String userCode = this.getUserCode();// 用户code
*/		String uuid = UUID.randomUUID().toString().trim().replaceAll("-", "");// 获取随机字符串
		String ip = this.getRequest().getLocalAddr();// 获取本机IP
		String interfaceAddr = "https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers";// 调用接口地址
		// 为充值提现表添加数据
		/*
		 * LocalService svr = new LocalService(this, "SvrOperateCZTX"); Record
		 * head = svr.getDataIn().getHead(); head.setField("userCode",
		 * userCode); head.setField("amount", money); head.setField("orderId",
		 * orderNo); head.setField("type", CZTXEnum.upOut.getValue());
		 * head.setField("platform", PlatformEnum.weixin.getValue());
		 * head.setField("status", StatusEnum.notPay.getValue());
		 * head.setField("openId", openId); if (!svr.exec()) {
		 * log.error("添加提现申请失败"); page.setData("申请添加失败"); return page; } else {
		 */
		/*
		 * 判断用户提现金额是否比余额少
		 */
		/*
		 * svr = new LocalService(this, "SvrOperateRMBAccount.getBalance"); if
		 * (!svr.exec("userCode", this.getUserCode())) throw new
		 * RuntimeException(svr.getMessage()); Double balance =
		 * svr.getDataOut().getHead().getDouble("RMBTechnician_"); if (balance <
		 * money) { page.setData("余额不足！"); return page; }
		 */
		// 添加日志记录
		/*
		 * LocalService svr1 = new LocalService(this, "SvrOperateTransLog");
		 * Record headIn2 = svr1.getDataIn().getHead();
		 * headIn2.setField("userCode", userCode); headIn2.setField("orderId",
		 * orderNo); headIn2.setField("status",
		 * StatusEnum.paySuccess.getValue()); headIn2.setField("type",
		 * CZTXEnum.upOut.getValue()); headIn2.setField("platform",
		 * PlatformEnum.weixin.getValue()); headIn2.setField("amountBefore",
		 * balance); headIn2.setField("amount", +money);
		 * headIn2.setField("amountAfter", (balance - money));
		 * headIn2.setField("payRemark", "提现中"); if (!svr1.exec()) { throw new
		 * Exception(svr1.getMessage()); }
		 */
		/*
		 * page.setData("success"); return page;
		 */
		// 调用企业付款接口，得到反馈后再往下走
		map.put("result", "error");
		map.put("msg", "提现成功！");
		log.info("[/transfer/pay]");
		// 业务判断 openid是否有收款资格
		Map<String, String> restmap = new HashMap<String, String>();
		try {
			Map<String, String> parm = new HashMap<String, String>();
			parm.put("mch_appid", WxPayConstants.APPID); // 公众账号appid
			parm.put("mchid", WxPayConstants.MCH_ID); // 商户号
			parm.put("nonce_str", uuid); // 随机字符串
			parm.put("partner_trade_no", orderNo); // 商户订单号
			parm.put("openid", openId); // 用户openid
			parm.put("check_name", "NO_CHECK"); // 校验用户姓名选项 OPTION_CHECK
			// parm.put("re_user_name", "安迪");
			// check_name设置为FORCE_CHECK或OPTION_CHECK，则必填
			/* parm.put("amount", money + ""); // 转账金额 */
			parm.put("amount", "100"); // 转账金额
			parm.put("desc", "转账到个人"); // 企业付款描述信息
			parm.put("spbill_create_ip", ip); // Ip地址
			parm.put("sign", PayUtil.getSign(parm, WxPayConstants.KEY));
			String restxml = HttpUtils.posts(interfaceAddr, XmlUtil.xmlFormat(parm, false));
			restmap = XmlUtil.xmlParse(restxml);
			restmap.put("result_code", "SUCCESS");
			restmap.put("text", "OK");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		// 如果返回结果成功，那么执行插入日志表功能
		if (CollectionUtil.isNotEmpty(restmap) && "SUCCESS".equals(restmap.get("result_code"))) {
			log.info("转账成功：" + restmap.get("err_code") + ":" + restmap.get("err_code_des"));
			try (Transaction tx = new Transaction(this)) {
				// 给平台提现账户减钱并追加提现记录
				LocalService addAccount = new LocalService(this, "SvrAddAccountMoney");
				if(!addAccount.exec("type_", "wi", "userCode", this.getUserCode(), "czong_", "7070010020066", "totalFee", money))
					throw new RuntimeException(addAccount.getMessage());
				
				tx.commit();
			}
			page.setData("true");
		} else {
			log.info("转账失败：" + restmap.get("return_msg") + ":" + restmap.get("return_msg"));
			page.setData("false");
		}
		/* } */

		return page;
	}

	public boolean Logon() {
		return true;
	}

}
