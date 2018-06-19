package com.huagu.pay.forms;

import java.math.BigDecimal;
import java.util.Map;

import org.apache.log4j.Logger;

import com.huagu.common.util.WxPayConstants;
import com.huagu.myWallet.forms.FrmAdjust;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.pay.wxpay.ResponseHandler;

/**
 * 所有支付成功回调
 * 
 * @author Administrator
 *
 */
public class FrmRechargeNotify extends AbstractForm {
	private static Logger log = Logger.getLogger(FrmRechargeNotify.class);

	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this);
		return page;
	}

	public IPage notifyWechatpay() {
		JsonPage page = new JsonPage();
		try {
			ResponseHandler resHandler = new ResponseHandler(this.getRequest(), this.getResponse());
			resHandler.setKey(WxPayConstants.KEY);
			Map<String, String> postdata = resHandler.getSmap();
			log.info("---------postdata：" + postdata);
			if (resHandler.isWechatSign() == true) {
				String out_trade_no = (String) postdata.get("out_trade_no");
				String transaction_id = (String) postdata.get("transaction_id");
				Double totalFee = new BigDecimal(postdata.get("total_fee")).divide(new BigDecimal(100)).doubleValue();
				String time_end = (String) postdata.get("time_end");
				String openid = (String) postdata.get("openid");
				String trade_state = (String) postdata.get("result_code");
				String attach = (String) postdata.get("attach");
				if ("SUCCESS".equals(trade_state)) {
					String mchId = (String) postdata.get("mch_id");
					log.info("out_trade_no:" + out_trade_no + "-------openid:" + openid + "------transaction_id:"
							+ transaction_id + "--------time_end:" + time_end + "----------totalFee:"
							+ totalFee.toString() + "支付成功");
					
					String userCode;
					try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, openid, "code_")) {
						userCode = (String) buff.getField("userCode");
					}
					
					// 追加用户可用余额
					LocalService addUserAmount_ = new LocalService(this, "SvrAddUserMoney");
					if(!addUserAmount_.exec("totalFee_", totalFee.toString(),"userCode", userCode))
						throw new RuntimeException(addUserAmount_.getMessage());
					
					// 添加支付记录
					LocalService addPayLog = new LocalService(this, "SvrPayLog");
					if(!addPayLog.exec("userCode", userCode, "type_","1", "opeType_","B", "totalFee_", totalFee.toString(),"openid_",openid, "out_trade_no" ,out_trade_no, "status_", "0", "overMoney_", addUserAmount_.getDataOut().getString("overMoney_")))
						throw new RuntimeException(addPayLog.getMessage());
					
					// 给平台充值账户加钱
					LocalService addAccount = new LocalService(this, "SvrAddAccountMoney");
					if(!addAccount.exec("userCode", userCode, "czong_", "6060010020066", "totalFee", totalFee.toString()))
						throw new RuntimeException(addAccount.getMessage());
					
					log.info("这里执行支付完成的功能！-----------支付流水号： "+ mchId);
					resHandler.sendToCFT("<xml><return_code><![CDATA[SUCCESS]]></return_code></xml>");
				} else {
					LocalService addPayLog = new LocalService(this, "SvrPayLog");
					if(!addPayLog.exec("type_","1", "opeType_","B", "totalFee_", totalFee.toString(),"openid_",openid, "out_trade_no" ,out_trade_no, "status_", "1"))
						throw new RuntimeException(addPayLog.getMessage());
					
					log.info("fail -SHA1 failed   这里执行支付未完成的功能！-------"+ attach);
					resHandler.sendToCFT("<xml><return_code><![CDATA[FAIL]]></return_code></xml>");
				}
			} else {
				log.info("微信支付回调验证签名失败，fail -Md5 failed");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public IPage WXpay() {
		JsonPage page = new JsonPage();
		try {
			ResponseHandler resHandler = new ResponseHandler(this.getRequest(), this.getResponse());
			resHandler.setKey(WxPayConstants.KEY);
			Map<String, String> postdata = resHandler.getSmap();
			log.info("---------postdata：" + postdata);
			if (resHandler.isWechatSign() == true) {
				String out_trade_no = (String) postdata.get("out_trade_no");
				String transaction_id = (String) postdata.get("transaction_id");
				Double totalFee = new BigDecimal(postdata.get("total_fee")).divide(new BigDecimal(100)).doubleValue();
				String time_end = (String) postdata.get("time_end");
				String openid = (String) postdata.get("openid");
				String trade_state = (String) postdata.get("result_code");
				String attach = (String) postdata.get("attach");
				if ("SUCCESS".equals(trade_state)) {
					String mchId = (String) postdata.get("mch_id");
					log.info("out_trade_no:" + out_trade_no + "-------openid:" + openid + "------transaction_id:"
							+ transaction_id + "--------time_end:" + time_end + "----------totalFee:"
							+ totalFee.toString() + "支付成功");

					// 添加支付记录
					LocalService addPayLog = new LocalService(this, "SvrPayLog");
					if(!addPayLog.exec( "opeType_","C", "totalFee_", totalFee.toString(),"openid_",openid, "out_trade_no" ,out_trade_no, "status_", "0"))
						throw new RuntimeException(addPayLog.getMessage());
					
					log.info("这里执行支付完成的功能！-----------支付流水号： "+ mchId);
					resHandler.sendToCFT("<xml><return_code><![CDATA[SUCCESS]]></return_code></xml>");
				} else {
					LocalService addPayLog = new LocalService(this, "SvrPayLog");
					if(!addPayLog.exec( "opeType_","C", "totalFee_", totalFee.toString(),"openid_",openid, "out_trade_no" ,out_trade_no, "status_", "1"))
						throw new RuntimeException(addPayLog.getMessage());
					
					log.info("fail -SHA1 failed   这里执行支付未完成的功能！-------"+ attach);
					resHandler.sendToCFT("<xml><return_code><![CDATA[FAIL]]></return_code></xml>");
				}
			} else {
				log.info("微信支付回调验证签名失败，fail -Md5 failed");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public boolean logon() {
		return true;
	}
}
