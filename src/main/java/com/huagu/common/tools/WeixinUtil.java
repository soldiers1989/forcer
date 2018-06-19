package com.huagu.common.tools;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.URL;
import java.util.List;
import java.util.SortedMap;
import java.util.TreeMap;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.huagu.common.constant.WxConfigConstant;
import com.huagu.common.global.appdb;
import com.huagu.other.beans.AccessTokenVo;
import com.huagu.common.util.MyX509TrustManager;
import com.huagu.common.util.StringUtils;

import cn.cerc.jbean.core.AbstractHandle;
import cn.cerc.jbean.core.AppHandle;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.oss.OssSession;
import cn.cerc.pay.wxpay.Sha1Util;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import sun.net.www.protocol.http.HttpURLConnection;

/**
 * 公众平台通用接口工具类
 * 
 * @author chenyeen
 * @date 2016-11-09
 */
@SuppressWarnings("restriction")
public class WeixinUtil {
	private static Logger log = LoggerFactory.getLogger(WeixinUtil.class);

	/**
	 * 根据城市编号，返回对应城市公众号toKen
	 * 
	 * @param corpNo_
	 * @return
	 */
	public static String getWxToken(String corpNo_) {
		// 获取token令牌，多城市公众号，改查询数据库配置
		String token = "";
		try (MemoryBuffer buff = new MemoryBuffer(BufferType.getTicket, corpNo_, "wx_token")) {
			if (buff.isNull()) {
				Record record = queryAppId(corpNo_);
				token = getAccessToken(record.getString("appID_"), record.getString("appSecret_")).getToken();
				buff.setExpires(7000 * 1000);
				buff.setField("token", token);
			}
			token = buff.getString("token");
		}
		return token;
	}

	/**
	 * 根据城市编号，生产对应公众号模板消息回调路径
	 * 
	 * @param corpNo_
	 * @return
	 */
	public static String getMessageUrl(String corpNo_) {
		// String url =
		// "https://open.weixin.qq.com/connect/oauth2/authorize?appid=APPID&redirect_uri=http://ehealth.lucland.com/forms/FrmWeixin.template?redirectUrl=REDIRECT_URL&response_type=code&scope=snsapi_base&state=CORPNO#wechat_redirect";
		String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=APPID&redirect_uri=http://testehealth.zhongyinginfo.com/forms/FrmWeixin.template?redirectUrl=REDIRECT_URL&response_type=code&scope=snsapi_base&state=CORPNO#wechat_redirect";
		// 获取微信appId，多城市公众号
		String appId = "";
		try (MemoryBuffer buff = new MemoryBuffer(BufferType.getTicket, corpNo_, "wx_appId")) {
			if (buff.isNull()) {
				Record record = queryAppId(corpNo_);
				if (StringUtils.isEmpty(record.getString("appID_"))) {
					return "#";
				}
				appId = record.getString("appID_");
				buff.setField("appId", appId);
			}
			appId = buff.getString("appId");
		}
		url = url.replace("CORPNO", corpNo_);
		url = url.replace("APPID", appId);
		return url;
	}

	/**
	 * 获取access_token
	 * 
	 * @param appid
	 *            凭证
	 * @param appsecret
	 *            密钥
	 * @return
	 */
	public static AccessTokenVo getAccessToken(String appid, String appsecret) {
		AccessTokenVo accessToken = null;
		String requestUrl = WxConfigConstant.GET_TOKEN_URL.replace("APPID", appid).replace("APPSECRET", appsecret);
		String resultStr = httpRequest(requestUrl, "GET", null);
		// 如果请求成功
		if (StringUtils.notEmpty(resultStr)) {
			try {
				JSONObject jsonObject = JSONObject.fromObject(resultStr);
				accessToken = new AccessTokenVo();
				accessToken.setToken(jsonObject.getString("access_token"));
				accessToken.setExpiresIn(jsonObject.getInt("expires_in"));
				String ticketUrl = WxConfigConstant.GET_TICKET_URL.replace("ACCESS_TOKEN", accessToken.getToken());
				resultStr = httpRequest(ticketUrl, "GET", null);
				// 如果请求成功
				if (StringUtils.notEmpty(resultStr)) {
					try {
						JSONObject ticketObject = JSONObject.fromObject(resultStr);
						accessToken.setTicket(ticketObject.getString("ticket"));
						log.error("---------------------------\n----ticket:", ticketObject.getString("ticket"));
					} catch (JSONException e) {
						// 获取ticket失败
						log.error("获取ticket失败，错误信息：", resultStr);
					}
				}
			} catch (JSONException e) {
				e.printStackTrace();
				// 获取token失败
				log.error("获取token失败 ,错误信息：", resultStr);
			}
		}

		return accessToken;
	}

	/**
	 * 根据code获取 openID
	 * 
	 * @param appId
	 *            凭证
	 * @param appSecret
	 *            密钥
	 * @return
	 */
	public static String getOpenId(String corpNo, String code) {
		String openid = "o_QGQ0qQMZoEg9TGBBvOhsoOA2yk";
		Record record = queryAppId(corpNo);
		String url = WxConfigConstant.GET_OPENID_URL;
		url = url.replace("APPID", record.getString("appID_"));
		url = url.replace("SECRET", record.getString("appSecret_"));
		url = url.replace("CODE", code == null ? "" : code);
		String resultStr = httpRequest(url, "GET", null);
		System.out.println("访问微信接口，得到当前的openId返回结果是：" + resultStr);
		if (StringUtils.notEmpty(resultStr) && resultStr.contains("openid")) {
			JSONObject resultJson = JSONObject.fromObject(resultStr);
			openid = resultJson.getString("openid");
		}
		return openid;
	}

	/**
	 * 创建微信菜单
	 */
	public static boolean createMenu(String accessToken, String params) throws Exception {
		String url = WxConfigConstant.CREATE_MENU_URL;
		url = url.replace("ACCESS_TOKEN", accessToken);
		String resultStr = httpRequest(url, "POST", params);
		if (StringUtils.notEmpty(resultStr)) {
			JSONObject resultJson = JSONObject.fromObject(resultStr);
			String errcode = resultJson.getString("errcode");
			return "0".equals(errcode);
		}
		return false;
	}

	/**
	 * 创建微信标签
	 */
	public static Integer createTag(String accessToken, String tagName) throws Exception {
		String paramStr = "{\"tag\" : {\"name\" : \"" + tagName + "\"}}";
		String url = WxConfigConstant.CREATE_TAGS;
		url = url.replace("ACCESS_TOKEN", accessToken);
		String resultStr = httpRequest(url, "POST", paramStr);
		if (StringUtils.notEmpty(resultStr)) {
			JSONObject resultJson = JSONObject.fromObject(resultStr);
			if (resultStr.contains("tag")) {
				String tagJson = resultJson.getString("tag");
				String id = JSONObject.fromObject(tagJson).getString("id");
				return StringUtils.notEmpty(id) ? Integer.parseInt(id) : null;
			}
		}
		return null;
	}

	/**
	 * 编辑微信标签
	 */
	public static boolean updateTag(String accessToken, String tagId, String tagName) throws Exception {
		String paramStr = "{\"tag\" : {\"id\" : " + tagId + ",\"name\" : \"" + tagName + "\"}}";
		String url = WxConfigConstant.UPDATE_TAGS;
		url = url.replace("ACCESS_TOKEN", accessToken);
		String resultStr = httpRequest(url, "POST", paramStr);
		if (StringUtils.notEmpty(resultStr)) {
			JSONObject resultJson = JSONObject.fromObject(resultStr);
			String errcode = resultJson.getString("errcode");
			return "0".equals(errcode);
		}
		return false;
	}

	/**
	 * 删除微信标签
	 */
	public static boolean deleteTag(String accessToken, String tagId) throws Exception {
		String paramStr = "{\"tag\" : {\"id\" : " + tagId + "}}";
		String url = WxConfigConstant.DELETE_TAGS;
		url = url.replace("ACCESS_TOKEN", accessToken);
		String resultStr = httpRequest(url, "POST", paramStr);
		if (StringUtils.notEmpty(resultStr)) {
			JSONObject resultJson = JSONObject.fromObject(resultStr);
			String errcode = resultJson.getString("errcode");
			return "0".equals(errcode);
		}
		return false;
	}

	/**
	 * 微信用户打标签（用户分组）
	 */
	public static boolean addTag(String accessToken, String openid, String tagId) throws Exception {
		String url = WxConfigConstant.BATCH_TAG;
		url = url.replace("ACCESS_TOKEN", accessToken);
		String paramStr = "{\"openid_list\" : [\"" + openid + "\"],\"tagid\" : " + tagId + "}";
		String resultStr = httpRequest(url, "POST", paramStr);
		if (StringUtils.notEmpty(resultStr)) {
			JSONObject resultJson = JSONObject.fromObject(resultStr);
			String errcode = resultJson.getString("errcode");
			return "0".equals(errcode);
		}
		return false;
	}

	/**
	 * 微信用户取消标签
	 */
	public static boolean cancelTag(String accessToken, String openid, String tagId) throws Exception {
		String url = WxConfigConstant.BATCHUN_TAG;
		url = url.replace("ACCESS_TOKEN", accessToken);
		String paramStr = "{\"openid_list\" : [\"" + openid + "\"],\"tagid\" : " + tagId + "}";
		String resultStr = httpRequest(url, "POST", paramStr);
		if (StringUtils.notEmpty(resultStr)) {
			JSONObject resultJson = JSONObject.fromObject(resultStr);
			String errcode = resultJson.getString("errcode");
			return "0".equals(errcode);
		}
		return false;
	}

	/**
	 * 发送微信群发消息
	 * 
	 * @throws Exception
	 */
	public static boolean pushMessage(AbstractHandle handle, String accessToken, List<Record> messList,
			List<String> openIdList) throws Exception {
		String url = null;
		String resultStr = null;
		// 调用上传图文消息素材
		url = WxConfigConstant.UPLOAD_NEWS.replace("ACCESS_TOKEN", accessToken);
		StringBuffer sb = new StringBuffer();
		for (Record record : messList) {
			// 上传图片获取thumb_media_id
			String thumb_media_id = null;
			resultStr = sendFile(handle, accessToken, "image", record.getString("imgUrl_"));
			log.info("=======微信群发消息，上传图文消息-图片返回结果：" + resultStr);
			if (StringUtils.notEmpty(resultStr)) {
				JSONObject resultJson = JSONObject.fromObject(resultStr);
				thumb_media_id = resultJson.getString("media_id");
			}
			JSONObject json = new JSONObject();
			json.accumulate("thumb_media_id", thumb_media_id);
			json.accumulate("author", "");
			json.accumulate("title", record.getString("messageTitle_"));
			String redirectUrl = "FrmHealthMessage";
			String urlStr = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx8302b6636974854e&redirect_uri=http://ehealth.lucland.com/forms/FrmWeixin.template?redirectUrl="
					+ redirectUrl + "&response_type=code&scope=snsapi_base&state=727000#wechat_redirect";
			json.accumulate("content_source_url", urlStr);
			json.accumulate("content", record.getString("messageContent_"));
			json.accumulate("digest", "");
			json.accumulate("show_cover_pic", "1");
			if (StringUtils.notEmpty(sb.toString())) {
				sb.append(",");
			}
			sb.append(json.toString());
		}
		String paramStr4 = "{\"articles\": [" + sb.toString() + "]}";
		resultStr = httpRequest(url, "POST", paramStr4);
		log.info("=======微信群发消息，上传图文消息返回结果：" + resultStr);
		String media_id = null;
		if (StringUtils.notEmpty(resultStr)) {
			JSONObject resultJson = JSONObject.fromObject(resultStr);
			media_id = resultJson.getString("media_id");
		}

		// 调用openid列表发送接口
		url = WxConfigConstant.SEND_MESSAGE.replace("ACCESS_TOKEN", accessToken);
		StringBuffer sb2 = new StringBuffer();
		for (String openid : openIdList) {
			if (StringUtils.notEmpty(sb2.toString())) {
				sb2.append(",");
			}
			sb2.append("\"" + openid + "\"");
		}
		String paramStr5 = "{\"touser\":[" + sb2.toString() + "],\"mpnews\":{\"media_id\":\"" + media_id
				+ "\"},\"msgtype\":\"mpnews\"}";
		resultStr = httpRequest(url, "POST", paramStr5);
		log.info("=======微信群发消息返回结果：" + resultStr);
		if (StringUtils.notEmpty(resultStr)) {
			JSONObject resultJson = JSONObject.fromObject(resultStr);
			String errcode = resultJson.getString("errcode");
			return "0".equals(errcode);
		}
		return false;
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
	 * 文件上传到微信服务器
	 * 
	 * @param fileType
	 *            文件类型
	 * @param filePath
	 *            文件路径
	 * @return JSONObject
	 * @throws Exception
	 */
	public static String sendFile(AbstractHandle handle, String accessToken, String fileType, String filePath)
			throws Exception {
		String result = null;
		// 创建临时存储文件夹
		String localFile = WeixinUtil.class.getClassLoader().getResource("").getPath().replace("/", "\\");
		localFile = localFile.substring(0, localFile.length() - 16) + "\\tmp\\";
		File file1 = new File(localFile);
		if (!file1.exists()) {
			file1.mkdirs();
		}
		// 创建临时文件名
		localFile += System.currentTimeMillis() + filePath.substring(filePath.lastIndexOf("."));
		;
		File file = new File(localFile);
		// 从OSS下载图片文件
		OssSession ossSession = (OssSession) handle.getProperty(OssSession.sessionId);
		filePath = filePath.substring(filePath.lastIndexOf(".com") + 5);
		;
		ossSession.download(filePath, localFile);

		String requestUrl = WxConfigConstant.MEDIA_UPLOAD.replace("ACCESS_TOKEN", accessToken).replace("TYPE",
				fileType);
		URL url = new URL(requestUrl);
		HttpURLConnection httpUrlConn = (HttpURLConnection) url.openConnection();
		httpUrlConn.setRequestMethod("POST");
		httpUrlConn.setDoInput(true);
		httpUrlConn.setDoOutput(true);
		httpUrlConn.setUseCaches(false);
		// 设置请求头信息
		httpUrlConn.setRequestProperty("Connection", "Keep-Alive");
		httpUrlConn.setRequestProperty("Charset", "UTF-8");
		// 设置边界
		String BOUNDARY = "----------" + System.currentTimeMillis();
		httpUrlConn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);
		// 第一部分：
		StringBuilder sb = new StringBuilder();
		sb.append("--"); // 必须多两道线
		sb.append(BOUNDARY);
		sb.append("\r\n");
		sb.append("Content-Disposition: form-data;name=\"file\";filename=\"" + file.getName() + "\"\r\n");
		sb.append("Content-Type:application/octet-stream\r\n\r\n");
		byte[] head = sb.toString().getBytes("utf-8");
		// 获得输出流
		OutputStream out = new DataOutputStream(httpUrlConn.getOutputStream());
		// 输出表头
		out.write(head);
		// 把文件已流文件的方式 推入到url中
		DataInputStream in = new DataInputStream(new FileInputStream(file));
		int bytes = 0;
		byte[] bufferOut = new byte[1024];
		while ((bytes = in.read(bufferOut)) != -1) {
			out.write(bufferOut, 0, bytes);
		}
		in.close();
		// 结尾部分
		byte[] foot = ("\r\n--" + BOUNDARY + "--\r\n").getBytes("utf-8");// 定义最后数据分隔线
		out.write(foot);
		out.flush();
		out.close();
		StringBuffer buffer = new StringBuffer();
		BufferedReader reader = null;
		try {
			// 定义BufferedReader输入流来读取URL的响应
			reader = new BufferedReader(new InputStreamReader(httpUrlConn.getInputStream()));
			String line = null;
			while ((line = reader.readLine()) != null) {
				buffer.append(line);
			}
			if (result == null) {
				result = buffer.toString();
			}
		} catch (IOException e) {
			log.info("发送POST请求出现异常！" + e);
			e.printStackTrace();
			throw new IOException("数据读取异常");
		} finally {
			if (reader != null) {
				reader.close();
			}
		}
		return result;
	}

	/**
	 * 获取JSAPI签名
	 * 
	 * @throws NoSuchProviderException
	 * @throws NoSuchAlgorithmException
	 * @throws KeyManagementException
	 */
	public static String WxJsApiCheck(String corpNo_, String url) {
		Record record = queryAppId(corpNo_);
		String ticket = "";
		try (MemoryBuffer buff = new MemoryBuffer(BufferType.getTicket, corpNo_, "wx_ticket")) {
			if (buff.isNull()) {
				ticket = getAccessToken(record.getString("appID_"), record.getString("appSecret_")).getTicket();
				buff.setExpires(7000 * 1000);
				buff.setField("ticket", ticket);
			}
			ticket = buff.getString("ticket");
		}
		String nonce_str = Sha1Util.getNonceStr();// 随机字符串
		String timestamp = Sha1Util.getTimeStamp();// 时间戳
		String sign = null;
		try {
			SortedMap<String, String> packageParams = new TreeMap<String, String>();
			packageParams.put("jsapi_ticket", ticket);
			packageParams.put("noncestr", nonce_str);
			packageParams.put("timestamp", timestamp);
			packageParams.put("url", url);
			sign = Sha1Util.createSHA1Sign(packageParams);// 签名
		} catch (Exception e) {
			e.printStackTrace();
		}
		String res = "{\"appId\" : \"" + record.getString("appID_") + "\",\"timeStamp\" : \"" + timestamp
				+ "\", \"nonceStr\" : \"" + nonce_str + "\", \"signature\" : \"" + sign + "\"}";
		log.info(res);
		return res;
	}

	// 获取公招配置
	public static Record queryAppId(String corpNo) {
		AppHandle handle = new AppHandle();
		SqlQuery sqlQuery = new SqlQuery(handle);
		sqlQuery.add("select wxName_,appID_,appSecret_ from %s", appdb.WX_CONFIG);
		sqlQuery.add("where corpNo_ = '%s'", corpNo);
		sqlQuery.open();
		if (sqlQuery.eof()) {
			log.error("=========微信获取城市编号为：" + corpNo + " 的token失败，数据库未查询到公众号配置信息!");
			return new Record();
		}
		return sqlQuery.getRecords().get(0);
	}

	public static void setToKenAndTicket(IHandle handle) {
		AccessTokenVo vo = null;
		SqlQuery sqlQuery = new SqlQuery(handle);
		sqlQuery.add("select wxName_,appID_,appSecret_ from %s", appdb.WX_CONFIG);
		sqlQuery.add("where corpNo_ = '%s'", handle.getCorpNo());
		sqlQuery.open();
		if (!sqlQuery.eof()) {
			vo = WeixinUtil.getAccessToken(sqlQuery.getString("appID_"), sqlQuery.getString("appSecret_"));
			log.info("--------------------AccessTokenVo.token信息：" + vo.getToken());
			log.info("--------------------AccessTokenVo.Ticket信息：" + vo.getTicket());
			try (MemoryBuffer buff = new MemoryBuffer(BufferType.getTicket, handle.getCorpNo(), "wx_token")) {
				buff.setExpires(7000 * 1000);
				buff.setField("token", vo.getToken());
			}
			try (MemoryBuffer buff = new MemoryBuffer(BufferType.getTicket, handle.getCorpNo(), "wx_ticket")) {
				buff.setExpires(7000 * 1000);
				buff.setField("ticket", vo.getTicket());
			}
		}
	}
}