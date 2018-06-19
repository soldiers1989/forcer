package com.huagu.map.forms;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.URL;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;

import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSONException;
import com.huagu.common.util.MyX509TrustManager;
import com.huagu.common.util.Sign;
import com.huagu.common.util.WxPayConstants;

import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import net.sf.json.JSONObject;

/**
 * 调用起微信扫一扫
 * 
 * @author 李直达
 * @date 2017年12月21日下午14:05:12
 */
@Component
public class FrmWeiXinSaoYiSao extends AbstractForm {
	// 微信JSSDK的AccessToken请求URL地址
	public final static String weixin_jssdk_acceToken_url = "https://api.weixin.qq.com/cgi-bin/token?"
			+ "grant_type=client_credential&appid=" + WxPayConstants.APPID + "&secret=" + WxPayConstants.APP_SECRET;
	// 微信JSSDK的ticket请求URL地址
	public final static String weixin_jssdk_ticket_url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=ACCESS_TOKEN&type=jsapi";

	@Override
	public IPage execute() throws Exception {
		String signature = "";
		String timestamp = "";
		String nonceStr = "";
		JsonPage page = new JsonPage(this);
		// 获取微信jssdk---access_token
		String js_accessToken = getJSSDKAccessToken();
		// 获取微信jssdk---ticket
		String jsapi_ticket = getJSSDKTicket(js_accessToken);
		System.out.println("jsapi_ticket===" + jsapi_ticket);

		// 获取完整的URL地址
		String fullPath1 = "http://" + this.getRequest().getServerName() // 服务器地址
				+ this.getRequest().getContextPath()// 项目名称
				+ this.getRequest().getServletPath();// 请求页面或其他地址
		Sign sign = new Sign();
		// 获取参数传到页面 注入config里面进行微信验证，并调用起微信扫一扫 进行扫码
		Map<String, String> ret = sign.sign(jsapi_ticket, fullPath1);
		for (Map.Entry entry : ret.entrySet()) {
			if (entry.getKey().equals("signature")) {
				signature = entry.getValue().toString();
			} else if (entry.getKey().equals("jsapi_ticket")) {
				jsapi_ticket = entry.getValue().toString();
			} else if (entry.getKey().equals("timestamp")) {
				timestamp = entry.getValue().toString();
			} else if (entry.getKey().equals("nonceStr")) {
				nonceStr = entry.getValue().toString();
			}
		}

		/*
		 * page.add("appId", WxPayConstants.APPID); page.add("timestamp",
		 * timestamp); page.add("nonceStr", nonceStr); page.add("signature",
		 * signature); page.add("jsapi_ticket", jsapi_ticket);
		 */

		ret.put("appId", WxPayConstants.APPID);
		ret.put("timestamp", timestamp);
		ret.put("nonceStr", nonceStr);
		ret.put("signature", signature);
		ret.put("jsapi_ticket", jsapi_ticket);
		page.setData(ret);
		System.out.println(ret);

		System.out.println("timestamp===" + timestamp);
		System.out.println("nonceStr===" + nonceStr);
		System.out.println("signature===" + signature);
		System.out.println("fullPath1===" + fullPath1);
		return page;
	}

	/**
	 * 发起https请求并获取结果
	 * 
	 * @param requestUrl
	 *            请求地址
	 * @param requestMethod
	 *            请求方式（GET、POST）
	 * @param outputStr
	 *            提交的数据
	 * @return
	 */
	public static String httpRequest(String requestUrl, String requestMethod, String outputStr) {
		StringBuffer buffer = new StringBuffer();
		try {
			// 创建SSLContext对象，并使用我们指定的信任管理器初始化
			TrustManager[] tm = { new MyX509TrustManager() };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new java.security.SecureRandom());
			// 从上述SSLContext对象中得到SSLSocketFactory对象
			SSLSocketFactory ssf = sslContext.getSocketFactory();

			URL url = new URL(requestUrl);
			HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();
			httpUrlConn.setSSLSocketFactory(ssf);

			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod(requestMethod);

			if ("GET".equalsIgnoreCase(requestMethod))
				httpUrlConn.connect();

			// 当有数据需要提交时
			if (null != outputStr) {
				OutputStream outputStream = httpUrlConn.getOutputStream();
				// 注意编码格式，防止中文乱码
				outputStream.write(outputStr.getBytes("UTF-8"));
				outputStream.close();
			}

			// 将返回的输入流转换成字符串
			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			return buffer.toString();
		} catch (ConnectException ce) {
			ce.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获取微信JSSDK的access_token
	 * 
	 * @author Benson
	 */
	public static String getJSSDKAccessToken() {
		String returnString = "";
		String requestUrl = weixin_jssdk_acceToken_url;
		JSONObject jsonObject = JSONObject.fromObject(httpRequest(requestUrl, "GET", null)); // Http
																								// GET请求
		// 如果请求成功
		if (null != jsonObject) {
			try {
				returnString = jsonObject.getString("access_token");
			} catch (JSONException e) {
				returnString = null;
			}
		}
		return returnString;
	}

	// @Scheduled(cron = "0 0/1 * * * ?")
	void wxtoken() {
		String wxtoken = getJSSDKAccessToken();
		this.getRequest().getSession().setAttribute("wxtoken", wxtoken);
	}

	/**
	 * 获取微信JSSDK的ticket
	 * 
	 * @author Benson
	 */
	public static String getJSSDKTicket(String access_token) {
		String returnString = "";
		String requestUrl = weixin_jssdk_ticket_url.replace("ACCESS_TOKEN", access_token);
		JSONObject jsonObject = JSONObject.fromObject(httpRequest(requestUrl, "GET", null));
		// 如果请求成功
		if (null != jsonObject) {
			try {
				returnString = jsonObject.getString("ticket");
			} catch (JSONException e) {
				returnString = null;
			}
		}
		return returnString;
	}

	public IPage goToTest() {
		return new JspPage(this, "weixin/test.jsp");
	}

	@Override
	public boolean logon() {
		return true;
	}
}
