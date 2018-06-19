package com.huagu.common.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;

import cn.cerc.jbean.core.ServerConfig;
import net.sf.json.JSONObject;

/**
 * 通过短信接口发送短信
 */
public class SmsUtil {

	static Logger logger = Logger.getLogger(SmsUtil.class);

	public static void main(String[] args) {
		//int returnStr = sendSmsByYunPian("18124565230", "您的验证码是31511");
		int a = sendSmsByMobsms("18124565230", "您的验证码是31511");
		logger.info(a);
	}

	/**
	 * 给一个人发送单条短信
	 * 
	 * @param mobile
	 *            手机号
	 * @param code
	 *            短信内容
	 */
	public static int sendSmsByYunPian(String mobile, String text) {
		ServerConfig config = new ServerConfig();
		// 修改为您要发送的手机号
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("apikey", config.getProperty("sms.yunpian.key"));
		paramMap.put("mobile", mobile);
		paramMap.put("text", text);
		String str = post(config.getProperty("sms.yunpian.url"), paramMap);
		logger.info("发送短信返回结果：" + str);
		if (str == null) {
			return -1;
		}
		JSONObject obj = JSONObject.fromObject(str);
		return obj.getInt("code");
	}

	public static int sendSmsByMobsms(String mobile, String content) {
		ServerConfig config = new ServerConfig();
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("dst", mobile);
		paramMap.put("name", config.getProperty("sms.mobsms.name"));
		paramMap.put("pwd", config.getProperty("sms.mobsms.pwd"));
		paramMap.put("msg", content);

		String str = post("http://yl.mobsms.net/send/gsend.aspx", paramMap);
		logger.info("发送短信返回结果：" + str);
		if (str == null || "".equals(str)) {
			logger.info("发送短信异常："+str);
			return -1;
		}
		return 0;
	}

	/**
	 * 基于HttpClient 4.3的通用POST方法
	 *
	 * @param url
	 *            提交的URL
	 * @param paramsMap
	 *            提交<参数，值>Map
	 * @return 提交响应
	 */

	public static String post(String url, Map<String, String> paramsMap) {
		CloseableHttpClient client = HttpClients.createDefault();
		String responseText = "";
		CloseableHttpResponse response = null;
		try {
			HttpPost method = new HttpPost(url);
			if (paramsMap != null) {
				List<NameValuePair> paramList = new ArrayList<NameValuePair>();
				for (Map.Entry<String, String> param : paramsMap.entrySet()) {
					NameValuePair pair = new BasicNameValuePair(param.getKey(), param.getValue());
					paramList.add(pair);
				}
				method.setEntity(new UrlEncodedFormEntity(paramList, "UTF-8"));
			}
			response = client.execute(method);
			HttpEntity entity = response.getEntity();
			if (entity != null) {
				responseText = EntityUtils.toString(entity);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				response.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return responseText;
	}
}
