package com.huagu.pay.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.KeyStore;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;

import javax.net.ssl.SSLContext;

import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.ssl.SSLContexts;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import com.mchange.v2.util.PropertiesUtils;

import junit.framework.Test;

/**
 * 创建时间：2016年11月9日 下午4:16:32
 * 
 * @author andy
 * @version 2.2
 */
public class HttpUtils {

	private static final String DEFAULT_CHARSET = "UTF-8";

	private static final int CONNECT_TIME_OUT = 5000; // 链接超时时间3秒

	private static final RequestConfig REQUEST_CONFIG = RequestConfig.custom().setConnectTimeout(CONNECT_TIME_OUT)
			.build();

	private static SSLContext wx_ssl_context = null; // 微信支付ssl证书

	static {
		Resource resource = new ClassPathResource("apiclient_cert.p12");
		/*String path = "/home/zs/apiclient_cert.p12";
		File file = new File(path);
		FileInputStream instream = null;
		try {
			System.out.println("==="+ path);
			instream = new FileInputStream(file);
		} catch (FileNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}*/
		/*
		 * Resource resource = new ClassPathResource("wx_apiclient_cert.p12");
		 */
		try {
			KeyStore keystore = KeyStore.getInstance("PKCS12");
			// char[] keyPassword =
			// ConfigUtil.getProperty("wx.MchId").toCharArray(); //证书密码
			char[] keyPassword = "1499372782".toCharArray(); // 证书密码
			//keystore.load(instream, keyPassword);
			keystore.load(resource.getInputStream(), keyPassword);
			/* keystore.load(resource.getInputStream(), keyPassword); */
			wx_ssl_context = SSLContexts.custom().loadKeyMaterial(keystore, keyPassword).build();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * @description 功能描述: get 请求
	 * @param url
	 *            请求地址
	 * @param params
	 *            参数
	 * @param headers
	 *            headers参数
	 * @return 请求失败返回null
	 */
	public static String get(String url, Map<String, String> params, Map<String, String> headers) {

		CloseableHttpClient httpClient = null;
		if (params != null && !params.isEmpty()) {
			StringBuffer param = new StringBuffer();
			boolean flag = true; // 是否开始
			for (Entry<String, String> entry : params.entrySet()) {
				if (flag) {
					param.append("?");
					flag = false;
				} else {
					param.append("&");
				}
				param.append(entry.getKey()).append("=");

				try {
					param.append(URLEncoder.encode(entry.getValue(), DEFAULT_CHARSET));
				} catch (UnsupportedEncodingException e) {
					// 编码失败
				}
			}
			url += param.toString();
		}

		String body = null;
		CloseableHttpResponse response = null;
		try {
			httpClient = HttpClients.custom().setDefaultRequestConfig(REQUEST_CONFIG).build();
			HttpGet httpGet = new HttpGet(url);
			response = httpClient.execute(httpGet);
			body = EntityUtils.toString(response.getEntity(), DEFAULT_CHARSET);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (response != null) {
				try {
					response.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			if (httpClient != null) {
				try {
					httpClient.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return body;
	}

	/**
	 * @description 功能描述: get 请求
	 * @param url
	 *            请求地址
	 * @return 请求失败返回null
	 */
	public static String get(String url) {
		return get(url, null);
	}

	/**
	 * @description 功能描述: get 请求
	 * @param url
	 *            请求地址
	 * @param params
	 *            参数
	 * @return 请求失败返回null
	 */
	public static String get(String url, Map<String, String> params) {
		return get(url, params, null);
	}

	/**
	 * @description 功能描述: post 请求
	 * @param url
	 *            请求地址
	 * @param params
	 *            参数
	 * @return 请求失败返回null
	 */
	public static String post(String url, Map<String, String> params) {
		CloseableHttpClient httpClient = null;
		HttpPost httpPost = new HttpPost(url);
		List<NameValuePair> nameValuePairs = new ArrayList<>();
		if (params != null && !params.isEmpty()) {
			for (Entry<String, String> entry : params.entrySet()) {
				nameValuePairs.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
			}
		}

		String body = null;
		CloseableHttpResponse response = null;
		try {
			httpClient = HttpClients.custom().setDefaultRequestConfig(REQUEST_CONFIG).build();
			httpPost.setEntity(new UrlEncodedFormEntity(nameValuePairs, DEFAULT_CHARSET));
			response = httpClient.execute(httpPost);
			body = EntityUtils.toString(response.getEntity(), DEFAULT_CHARSET);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (response != null) {
				try {
					response.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			if (httpClient != null) {
				try {
					httpClient.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return body;
	}

	/**
	 * @description 功能描述: post 请求
	 * @param url
	 *            请求地址
	 * @param s
	 *            参数xml
	 * @return 请求失败返回null
	 */
	public static String post(String url, String s) {
		CloseableHttpClient httpClient = null;
		HttpPost httpPost = new HttpPost(url);
		String body = null;
		CloseableHttpResponse response = null;
		try {
			httpClient = HttpClients.custom().setDefaultRequestConfig(REQUEST_CONFIG).build();
			httpPost.setEntity(new StringEntity(s, DEFAULT_CHARSET));
			response = httpClient.execute(httpPost);
			body = EntityUtils.toString(response.getEntity(), DEFAULT_CHARSET);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (response != null) {
				try {
					response.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			if (httpClient != null) {
				try {
					httpClient.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return body;
	}

	/**
	 * @description 功能描述: post https请求，服务器双向证书验证
	 * @param url
	 *            请求地址
	 * @param params
	 *            参数
	 * @return 请求失败返回null
	 */
	public static String posts(String url, Map<String, String> params) {
		CloseableHttpClient httpClient = null;
		HttpPost httpPost = new HttpPost(url);
		List<NameValuePair> nameValuePairs = new ArrayList<>();
		if (params != null && !params.isEmpty()) {
			for (Entry<String, String> entry : params.entrySet()) {
				nameValuePairs.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
			}
		}

		String body = null;
		CloseableHttpResponse response = null;
		try {
			httpClient = HttpClients.custom().setDefaultRequestConfig(REQUEST_CONFIG)
					.setSSLSocketFactory(getSSLConnectionSocket()).build();
			httpPost.setEntity(new UrlEncodedFormEntity(nameValuePairs, DEFAULT_CHARSET));
			response = httpClient.execute(httpPost);
			body = EntityUtils.toString(response.getEntity(), DEFAULT_CHARSET);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (response != null) {
				try {
					response.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			if (httpClient != null) {
				try {
					httpClient.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return body;
	}

	private static final Logger log = Logger.getLogger(HttpUtils.class);

	/**
	 * @description 功能描述: post https请求，服务器双向证书验证
	 * @param url
	 *            请求地址
	 * @param s
	 *            参数xml
	 * @return 请求失败返回null
	 */
	public static String posts(String url, String s) {
		CloseableHttpClient httpClient = null;
		HttpPost httpPost = new HttpPost(url);
		String body = null;
		CloseableHttpResponse response = null;
		try {
			httpClient = HttpClients.custom().setDefaultRequestConfig(REQUEST_CONFIG)
					.setSSLSocketFactory(getSSLConnectionSocket()).build();
			httpPost.setEntity(new StringEntity(s, DEFAULT_CHARSET));
			response = httpClient.execute(httpPost);
			body = EntityUtils.toString(response.getEntity(), DEFAULT_CHARSET);
			log.info(body);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (response != null) {
				try {
					response.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

			if (httpClient != null) {
				try {
					httpClient.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return body;
	}

	// 获取ssl connection链接
	private static SSLConnectionSocketFactory getSSLConnectionSocket() {
		return new SSLConnectionSocketFactory(wx_ssl_context, new String[] { "TLSv1", "TLSv1.1", "TLSv1.2" }, null,
				SSLConnectionSocketFactory.getDefaultHostnameVerifier());
	}
	
    public static String file2String(File f, String charset) { 
        String result = null; 
        try { 
                result = stream2String(new FileInputStream(f), charset); 
        } catch (FileNotFoundException e) { 
                e.printStackTrace(); 
        } 
        return result; 
    } 
    
    /** 
     * 文件转换为字符串 
     * 
     * @param in            字节流 
     * @param charset 文件的字符集 
     * @return 文件内容 
     */ 
    public static String stream2String(InputStream in, String charset) { 
            StringBuffer sb = new StringBuffer(); 
            try { 
                    Reader r = new InputStreamReader(in, charset); 
                    int length = 0; 
                    for (char[] c = new char[1024]; (length = r.read(c)) != -1;) { 
                            sb.append(c, 0, length); 
                    } 
                    r.close(); 
            } catch (UnsupportedEncodingException e) { 
                    e.printStackTrace(); 
            } catch (FileNotFoundException e) { 
                    e.printStackTrace(); 
            } catch (IOException e) { 
                    e.printStackTrace(); 
            } 
            return sb.toString(); 
    } 
    
    //获取项目的根路径  
    public static String classPath = HttpUtils.class.getClassLoader().getResource("/").getPath();  
    //对项目的根路径进行解析，拿到项目路径  
      
    public static String getRootPath() {  
        String rootPath = "/WebContent/MP_verify_GfzrqKdIBiPgvGGf.txt";  
        //windows下  
        if("\\".equals(File.separator)){  
            System.out.println("windows");  
        rootPath = classPath.substring(1,classPath.indexOf("/WEB-INF/classes"));  
        rootPath = rootPath.replace("/", "\\");  
        }  
        //linux下  
        if("/".equals(File.separator)){  
            System.out.println("linux");  
        rootPath = classPath.substring(0,classPath.indexOf("/WEB-INF/classes"));  
        rootPath = rootPath.replace("\\", "/");  
        }  
        return rootPath;  
    }  
    
	public static void main(String[] args) throws UnsupportedEncodingException, FileNotFoundException {
        HttpUtils hu = new HttpUtils();
        System.out.println(hu.getRootPath());
        		
		/*File f = new File("WebContent/MP_verify_GfzrqKdIBiPgvGGf.txt"); 
        String b = file2String(f, "GBK"); 
        System.out.println(b); 
        //当前类的绝对路径 
        String cp = "/WebContent/MP_verify_GfzrqKdIBiPgvGGf.txt"; 
        File fs = new File(Test.class.getResource(cp).getFile()); 
        System.out.println(fs.getPath()); */
	}
}