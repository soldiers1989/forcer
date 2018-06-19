package com.huagu.creditManagement.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import org.apache.log4j.Logger;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.antgroup.zmxy.openplatform.api.DefaultZhimaClient;
import com.antgroup.zmxy.openplatform.api.ZhimaApiException;
import com.antgroup.zmxy.openplatform.api.request.ZhimaAuthInfoAuthorizeRequest;
import com.antgroup.zmxy.openplatform.api.request.ZhimaAuthInfoAuthqueryRequest;
import com.antgroup.zmxy.openplatform.api.request.ZhimaCreditScoreGetRequest;
import com.antgroup.zmxy.openplatform.api.response.ZhimaAuthInfoAuthqueryResponse;
import com.antgroup.zmxy.openplatform.api.response.ZhimaCreditScoreGetResponse;

public class SesameCredit {
	private static final Logger LOGGER = Logger.getLogger(SesameCredit.class);

	// 芝麻开放平台地址
	private static String gatewayUrl = "https://zmopenapi.zmxy.com.cn/openapi.do";
	// 商户应用 Id
	private static String appId = "300002620";
	// 商户 RSA 私钥
	private static String privateKey = "MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAKyT1WdI4JKZlRph6FC0o9608RgOwapknhyL0wvU6JEOq9/J55ibWHNHIQwBz1HKq0J+h/kxf24DcUjiYYm2UHSCtWDtwTGmqnhnFNPKLTmHSlh1lFFpNkrx6OPSWVsQcFbw1U5PEitOst8tFlu/m+HcrZ8S+C8qdndLkVvIFFRJAgMBAAECgYBrjG2vwkEB22iKWn223fxJrCWbwoZ6s929GH5bn0GYNLZz7pXACv+iR6+WlgInjNARzlzatTgezVJqA3qZod6c12TJlw99HbGgkV6VjtYd+IvXCWTAZUeQ9XUAIGgMDAKaDRNHtNuxD099Zae1DKDfejkwnoNHRctfN7Qpqe6uIQJBANL3Pe/vO3U7zGZmTGzx/9ZZmXoUNa/OWtU1p4qDYcRhKlrUUwPL424JLiCN6VO6B7ydbYTgw9tnafeZ7vcuTSUCQQDRasPuWzsll/OgtegfHe+ZPF3R3otO2WnRnyFRs18NaYi6eb/o23YHfw1FHTVn8kYRHbPFABQJx7pOnhJUaatVAkBTvxI3TSCtSS+69qEgHnERBkCG1b76K1CjkskPk1gcPPYzWFYcC7Qc2kgVZEBbnF214ki3lwIo9sR6JgFW3mqBAkB/EK4DsV1pCRLtH5LRVqOrscIndkXGuQqJA2n/Hbv98lvg8cCs9IRgNgoCNp/SC2HSPth2Hv8JlCOKUkVC7L7lAkBSDP22d4QK0YZudMwpvub2DxOUAJJpC06JTv7RhqMJv4PkCngxuMdilPmxC0FrLX5Sw8D65lZjX16ko9fcF03/";
	// 芝麻 RSA 公钥
	private static String zhimaPublicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCFqIjwqvlJLi2wC6c8QDYBtKBt5IPvde2tKvfj1QeizUPzavBGsIVSI8mAXYXJWdvBigzaw9t9PyY38YXOn+farCL5oELmIq/3rcAod+tbrj5CIKiD3TN52U7ZIR+y49IF7PwWrk3n13kw4UmPvB8cav7nRU7iEH/KWgI9l9WuQQIDAQAB";

	private static String charset = "UTF-8";

	/**
	 * 查询授权URL信息，返回浏览器，便可授权 如果该支付宝错误的情况会返回到项目的登录页面
	 * 
	 * @return
	 */
	public String zhimaAuthInfoAuthorize(String certNo_, String name_) {
		String url = null;
		ZhimaAuthInfoAuthorizeRequest req = new ZhimaAuthInfoAuthorizeRequest();
		req.setIdentityType("2");// 必要参数
		req.setChannel("apppc");
		req.setBizParams("{\"auth_code\":\"M_APPPC_CERT\",\"state\":\"100111211\"}");
		Map<String, String> identityParams = new HashMap<String, String>();
		identityParams.put("certNo", certNo_); // 证件号码
		identityParams.put("name", name_); // 姓名
		identityParams.put("certType", "IDENTITY_CARD"); // 证件类型
		// 必要参数 state: 用于给商户提供透传的参数，芝麻会将此参数透传给商户;
		req.setIdentityParam(JSONObject.toJSONString(identityParams));
		DefaultZhimaClient client = new DefaultZhimaClient(gatewayUrl, appId, privateKey, zhimaPublicKey);
		try {
			url = client.generatePageRedirectInvokeUrl(req);
			LOGGER.info(url); // url得跳到页面上才有显示授权信息，或者检验支付宝账号是否可用
		} catch (Exception e) {
			e.printStackTrace();
		}
		return url;
	}

	/**
	 * openId需要授权后才有值 获取目标用户的openId,没有openId,要跳授权页面 将openId拿出来，便可查询芝麻分
	 */

	public Object zhimaAuthInfoReq(String certNo_, String name_) {
		Object rep = null;
		ZhimaAuthInfoAuthqueryRequest req = new ZhimaAuthInfoAuthqueryRequest();
		// 0：芝麻信用开放账号ID 1：按照手机号进行授权 2:按照身份证+姓名进行授权 3通过公安网验证进行授权 4.通过人脸验证进行授权
		req.setIdentityType("2");
		
		Map<String, String> identityParams = new HashMap<String, String>();
		identityParams.put("certNo", certNo_); // 证件号码
		identityParams.put("name", name_); // 姓名
		identityParams.put("certType", "IDENTITY_CARD"); // 证件类型
		// 必要参数 state: 用于给商户提供透传的参数，芝麻会将此参数透传给商户;
		req.setIdentityParam(JSONObject.toJSONString(identityParams));
		
		//req.setIdentityParam("{\"certNo\":\"420607199411112821\",\"certType\":\"IDENTITY_CARD\",\"name\":\"王姣\"}");// 必要参数
		DefaultZhimaClient client = new DefaultZhimaClient(gatewayUrl, appId, charset, privateKey, zhimaPublicKey);
		try {
			// 如果正常返回,直接在对象里面获取结果值
			ZhimaAuthInfoAuthqueryResponse response = client.execute(req);
			LOGGER.info(JSON.toJSON(response));
			rep = JSON.toJSON(response);
		} catch (ZhimaApiException e) {
			e.printStackTrace();
		}
		return rep;
	}

	/**
	 * 返回芝麻信用评分
	 */
	public String getScore(String openId) {
		String smScore = null;
		ZhimaCreditScoreGetRequest req = new ZhimaCreditScoreGetRequest();
		String transactionId = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date())
				+ UUID.randomUUID().toString(); // 创建业务流水凭证，以当前时间作为前缀，uuid为后缀
		req.setTransactionId(transactionId); // 必要参数，业务流水凭证
		req.setProductCode("w1010100100000000001"); // 必要参数，这个值对于芝麻分产品是固定的，无需修改
		// req.setOpenId("268814372079262267514648989"); // 必要参数，授权获得的openid
		req.setOpenId(openId); // 必要参数，授权获得的openid
		DefaultZhimaClient client = new DefaultZhimaClient(gatewayUrl, appId, privateKey, zhimaPublicKey);
		try {
			ZhimaCreditScoreGetResponse response = client.execute(req); // TODO
																		// 将业务流水凭证与响应内容持久化到DB，便于后续对账
			LOGGER.info("transactionId=" + transactionId + ";请求完整响应=" + response.getBody());
			if (response.isSuccess()) { // 打印正常响应
				//LOGGER.info("用户芝麻信用评分=" + response.getZmScore());
				smScore = response.getZmScore();
			} else { // 打印异常原因
				LOGGER.info(response.getErrorCode());
				LOGGER.info(response.getErrorMessage());
			}
		} catch (ZhimaApiException e) {
			e.printStackTrace();
		}
		return smScore;
	}

	public boolean logon() {
		return true;
	}

}
