package com.huagu.myWallet.forms;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;

import com.huagu.common.constant.WxConfigConstant;
import com.huagu.common.util.MyX509TrustManager;
import com.huagu.common.util.StringUtils;
import com.huagu.common.util.WxPayConstants;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import net.sf.json.JSONObject;

public class FrmMyWallet extends AbstractForm {

	/**
	 * @describe 我的钱包
	 * @author 王姣
	 * @date 2018年3月13日下午4:08:51
	 * @return
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "wallet/myWallet.jsp");
		LocalService svr = new LocalService(this, "SvrMyMoeryQuery");
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("money", svr.getDataOut().getCurrent());
		return jsp;
	}

	/**
	 * 交易明细
	 * 
	 * @author 王姣
	 * @date 2018年3月13日下午4:58:57
	 * @return
	 */
	public IPage transactionDetails() throws Exception {
		JspPage jsp = new JspPage(this, "wallet/transactionDetail.jsp");
		LocalService svr = new LocalService(this, "SvrTransactionDetails");
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("details", svr.getDataOut().getRecords());
		return jsp;
	}

	/**
	 * 跳转去充值 页面
	 * 
	 * @author 李晓飞
	 * @date 2018年3月13日下午4:58:57
	 * @return
	 */
	public IPage recharge() throws Exception {
		JspPage jsp = new JspPage(this, "wallet/recharge.jsp");
		String code = this.getRequest().getParameter("code");// 这个请求用户的openid返回的code

		if (null != code && !"".equals(code)) {
			String url = WxConfigConstant.GET_OPENID_URL;
			String openid = "";
			url = url.replace("APPID", WxPayConstants.APPID);
			url = url.replace("SECRET", WxPayConstants.APP_SECRET);
			url = url.replace("CODE", code);
			String resultStr = httpRequest(url, "GET", null);
			System.out.println("访问微信接口，得到当前的openId返回结果是：" + resultStr);
			if (StringUtils.notEmpty(resultStr) && resultStr.contains("openid")) {
				JSONObject resultJson = JSONObject.fromObject(resultStr);
				openid = resultJson.getString("openid");
				String userCode = this.getUserCode();
				this.getRequest().getSession().setAttribute(userCode, openid);
			}
			jsp.add("openid", openid);
		}
		return jsp;
	}

	// 获取微信授权返回的code参数
	public IPage weixinCode() throws Exception {
		return new JspPage(this, "wallet/openID.jsp");
	}

	// 获取微信授权返回的code参数
	public IPage weixinCodeT() throws Exception {
		JspPage JspPage = new JspPage(this, "wallet/openIDs.jsp");
		return JspPage;
	}

	/**
	 * 跳转去提现 页面
	 * 
	 * @author 李晓飞
	 * @date 2018年3月13日下午4:58:57
	 * @return
	 */
	public IPage withdraw() throws Exception {
		JspPage jsp = new JspPage(this, "wallet/withdraw.jsp");
		String code = this.getRequest().getParameter("code");// 这个请求用户的openid返回的code

		if (null != code && !"".equals(code)) {
			String url = WxConfigConstant.GET_OPENID_URL;
			String openid = "";
			url = url.replace("APPID", WxPayConstants.APPID);
			url = url.replace("SECRET", WxPayConstants.APP_SECRET);
			url = url.replace("CODE", code);
			String resultStr = httpRequest(url, "GET", null);
			System.out.println("访问微信接口，得到当前的openId返回结果是：" + resultStr);
			if (StringUtils.notEmpty(resultStr) && resultStr.contains("openid")) {
				JSONObject resultJson = JSONObject.fromObject(resultStr);
				openid = resultJson.getString("openid");
				String userCode = this.getUserCode();
				this.getRequest().getSession().setAttribute(userCode, openid);
			}
			jsp.add("openid", openid);
		}
		// 查询个人余额
		LocalService getUserM = new LocalService(this, "SvrMyMoeryQuery");
		if (!getUserM.exec())
			throw new RuntimeException(getUserM.getMessage());
		jsp.add("money",  getUserM.getDataOut().getCurrent());
		
		return jsp;
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

	@Override
	public boolean logon() {
		return true;
	}

}
