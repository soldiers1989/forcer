package com.huagu.common.aliyun.send;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;
import com.huagu.common.aliyun.Constants;
import com.huagu.common.aliyun.HttpSchema;
import com.huagu.common.aliyun.enums.Method;
import com.huagu.common.aliyun.gateway.Client;
import com.huagu.common.aliyun.gateway.Request;
import com.huagu.common.aliyun.gateway.Response;

import cn.cerc.jdb.core.IConfig;

public class SingleSendSms {
	private Logger log = Logger.getLogger(SingleSendSms.class);
	
    private final static String APP_KEY = "dayu.appKey"; //AppKey从控制台获取
    private final static String APP_SECRET = "dayu.appSecret"; //AppSecret从控制台获取
    private final static String SIGN_NAME = "dayu.singName"; // 签名名称从控制台获取，必须是审核通过的
    //private final static String TEMPLATE_CODE = "SMS_63800793"; //模板CODE从控制台获取，必须是审核通过的
    private final static String HOST = "dayu.serverUrl"; //API域名从控制台获取
    // 简讯模版编号
    // 各类设置
 	private String serverUrl;
 	private String appKey;
 	private String appSecret;
 	private String signName;
 	private String TEMPLATE_CODE;
    private final static String ERRORKEY = "errorMessage";  //返回错误的key
	public SingleSendSms(IConfig conf) {
		this.serverUrl = conf.getProperty(HOST, "sms.market.alicloudapi.com");
		this.appKey = conf.getProperty(APP_KEY);
		this.appSecret = conf.getProperty(APP_SECRET);
		this.signName = conf.getProperty(SIGN_NAME, "一启享");
	}
    public SingleSendSms() {
		// TODO Auto-generated constructor stub
	}
	// @phoneNum: 目标手机号，多个手机号可以逗号分隔;
    // @params: 短信模板中的变量，数字必须转换为字符串，如短信模板中变量为${no}",则参数params的值为{"no":"123456"}
    // 老版本阿里大于发送验证码
    public boolean sendMsg(String phoneNum, String params) throws Exception{
        String path = "/singleSendSms";
    	   
        Request request =  new Request(Method.GET, HttpSchema.HTTP + serverUrl, path, appKey, appSecret, Constants.DEFAULT_TIMEOUT);

        //请求的query
        Map<String, String> querys = new HashMap<String, String>();
        querys.put("SignName", signName);
        querys.put("TemplateCode", TEMPLATE_CODE);
        querys.put("RecNum", phoneNum);
        querys.put("ParamString", params);
        request.setQuerys(querys);

        try {
            Map<String, String> bodymap = new HashMap<String, String>();
            Response response = Client.execute(request);
            //根据实际业务需要，调整对response的处理
            if (null == response) {
                System.out.println("no response");
            } else if (200 != response.getStatusCode()) {
                System.out.println("StatusCode:" + response.getStatusCode());
                System.out.println("ErrorMessage:"+response.getErrorMessage());
                System.out.println("RequestId:"+response.getRequestId());
            } else {
                bodymap = ReadResponseBodyContent(response.getBody());
                if (null != bodymap.get(ERRORKEY)) {
                    //当传入的参数不合法时，返回有错误说明
                    System.out.println(bodymap.get(ERRORKEY));
                } else {
                    //成功返回map，对应的key分别为：message、success等
                    System.out.println(JSON.toJSONString(bodymap));
                    return true;
                }
                
            }
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
		return false;
    }

    private Map<String, String> ReadResponseBodyContent(String body) {
        Map<String, String> map = new HashMap<String, String>();    
        try {
            JSONObject jsonObject = JSON.parseObject(body);
            if (null != jsonObject) {               
                for(Entry<String, Object> entry : jsonObject.entrySet()){
                    map.put(entry.getKey(), entry.getValue().toString());
                }               
            }
            if ("false".equals(map.get("success"))) {
                map.put(ERRORKEY, map.get("message"));
            }
        } catch (Exception e) {
            map.put(ERRORKEY, body);
        }
        return map;
    }
	public String getTEMPLATE_CODE() {
		return TEMPLATE_CODE;
	}

	public void setTEMPLATE_CODE(String TEMPLATE_CODE) {
		this.TEMPLATE_CODE = TEMPLATE_CODE;
	}
	
	// 新版本阿里云发送验证码
	public boolean sendMsgs(String phoneNum, String params, String templateCode) throws Exception{
		//设置超时时间-可自行调整
        System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
        System.setProperty("sun.net.client.defaultReadTimeout", "10000");
        final String product = "Dysmsapi";//短信API产品名称（短信产品名固定，无需修改）
		final String domain = "dysmsapi.aliyuncs.com";//短信API产品域名（接口地址固定，无需修改）
        //你的accessKeyId
        final String accessKeyId = appKey;
        //你的accessKeySecret
        final String accessKeySecret = appSecret;
        IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId, accessKeySecret);
        DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", product, domain);
        IAcsClient acsClient = new DefaultAcsClient(profile);
        
        //组装请求对象
        SendSmsRequest request = new SendSmsRequest();
        //使用post提交
        request.setMethod(MethodType.POST);
        //必填:待发送手机号。支持以逗号分隔的形式进行批量调用，批量上限为1000个手机号码,批量调用相对于单条调用及时性稍有延迟,验证码类型的短信推荐使用单条调用的方式
        request.setPhoneNumbers(phoneNum);
        //必填:短信签名-可在短信控制台中找到
        request.setSignName(signName);
        //必填:短信模板-可在短信控制台中找到
        request.setTemplateCode(templateCode);
        //可选:模板中的变量替换JSON串,如模板内容为"亲爱的${name},您的验证码为${code}"时,此处的值为
        //友情提示:如果JSON中需要带换行符,请参照标准的JSON协议对换行符的要求,比如短信内容中包含\r\n的情况在JSON中需要表示成\\r\\n,否则会导致JSON在服务端解析失败
        request.setTemplateParam(params);
        //可选-上行短信扩展码(无特殊需求用户请忽略此字段)
        //request.setSmsUpExtendCode("90997");
        //可选:outId为提供给业务方扩展字段,最终在短信回执消息中将此值带回给调用者
        request.setOutId("yourOutId");
        //请求失败这里会抛ClientException异常
        SendSmsResponse sendSmsResponse = acsClient.getAcsResponse(request);
        log.info(sendSmsResponse.getMessage());
        if(sendSmsResponse.getCode() != null && sendSmsResponse.getCode().equals("OK")) {
    		return true;
        }
        //请求成功
		return false;
	}
	
/*	public  static void main(String agrs[]){
        SingleSendSms app = new SingleSendSms();
        try {
			app.sendMsgs("15071506306","{'code':'1234'}");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }*/
}