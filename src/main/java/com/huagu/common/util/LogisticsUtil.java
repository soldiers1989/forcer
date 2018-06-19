package com.huagu.common.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;

import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;

import com.huagu.common.aliyun.util.HttpUtils;

public class LogisticsUtil {
	
	public static String getLogistics(String id, String adr) {//物流单号，物流公司名
		String t = getKDType(adr);
		String host = "https://wdexpress.market.alicloudapi.com";
	    String path = "/gxali";
	    String method = "GET";
	    String appcode = "4b3fa544f1c34b51b9be171f470accbc";
	    Map<String, String> headers = new HashMap<String, String>();
	    //最后在header中的格式(中间是英文空格)为Authorization:APPCODE 83359fd73fe94948385f570e3c139105
	    headers.put("Authorization", "APPCODE " + appcode);
	    Map<String, String> querys = new HashMap<String, String>();
	    querys.put("n", id);
	    querys.put("t", t);
	    String str = "";
	    try {
	    	//获取response的body
	    	str = EntityUtils.toString((HttpUtils.doGet(host, path, method, headers, querys)).getEntity());
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
		return str;
	}

	public static String getKDType(String t){
		switch (t) {
		case "顺丰":
			t = "SF";
			break;
		case "申通":
			t = "STO";
			break;
		case "中通":
			t = "ZTO";
			break;
		case "百世快递":
			t = "HTKY";
			break;
		case "圆通":
			t = "YTO";
			break;
		case "韵达":
			t = "YD";
			break;
		case "邮政平邮":
			t = "YZPY";
			break;
		case "EMS":
			t = "EMS";
			break;
		case "天天":
			t = "HHTT";
			break;
		case "京东":
			t = "JD";
			break;
		case "全峰":
			t = "QFKD";
			break;
		case "国通":
			t = "GTO";
			break;
		case "广通":
			t = "GTONG";
			break;
		case "优速":
			t = "UC";
			break;
		case "德邦":
			t = "DBL";
			break;
		case "八达通":
			t = "BDT";
			break;
		case "快捷":
			t = "FAST";
			break;
		case "亚马逊":
			t = "AMAZON";
			break;
		case "宅急送":
			t = "ZJS";
			break;
		case "安捷快递":
			t = "AJ";
			break;
		case "百世快运":
			t = "BTWL";
			break;
		case "广东邮政":
			t = "GDEMS";
			break;
		case "汇丰物流":
			t = "HFWL";
			break;
		case "速尔快递":
			t = "SURE";
			break;
		case "运通快递":
			t = "YTKD";
			break;
		default:
			break;
		}
		return t;
		
	}
	

}
