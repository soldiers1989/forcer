package com.huagu.order.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.http.util.EntityUtils;
import org.springframework.scheduling.annotation.Scheduled;

import com.huagu.common.aliyun.util.HttpUtils;
import com.huagu.common.forms.FrmMessage;
import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AppHandle;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

public class getLogisticsInfo {
	private org.apache.log4j.Logger log = org.apache.log4j.Logger.getLogger(this.getClass());

	/* 每天凌晨5点执行一次 */
	@Scheduled(cron="0 0 5 * * ?")
//	@Scheduled(cron="0 * * * * ?")//测每没分钟执行一次
	void scheduler() throws ServiceException {
		int result = execute();
		log.info(result+"条订单已签收");
		
		
	}
	
	//定时任务，自动查询物流信息，
	public int execute() throws ServiceException {
		String host = "https://wdexpress.market.alicloudapi.com";
	    String path = "/gxali";
	    String method = "GET";
	    String appcode = "4b3fa544f1c34b51b9be171f470accbc";
	    Map<String, String> headers = new HashMap<String, String>();
	    //最后在header中的格式(中间是英文空格)为Authorization:APPCODE 83359fd73fe94948385f570e3c139105
	    headers.put("Authorization", "APPCODE " + appcode);
	    Map<String, String> querys = new HashMap<String, String>();
		AppHandle handle = new AppHandle();
		SqlQuery sql = new SqlQuery(handle);
		sql.add("select * from %s where orderState_ in (2,3) and orderType_ in (2,3) ",appdb.T_ORDER);
		sql.open();
		int num = 0;
		if(!sql.eof()){
			List<Record> records = sql.getRecords();
			for(Record r:records){
				String n = r.getString("recLogisticsId_");
				String t = r.getString("recLogisticsName_");
				String userId_ = r.getString("userId_");
				t = getKDType(t);
			    querys.put("n", n);
			    querys.put("t", t);
			    try {
			    	//获取response的body
			    	String str = EntityUtils.toString((HttpUtils.doGet(host, path, method, headers, querys)).getEntity());
			    	
			    	JSONObject jsonObject = JSONObject.fromObject(str); 
			    	Boolean success = jsonObject.getBoolean("Success");
			    	if(success){
			    		String state = jsonObject.getString("State");
			    		if(state.equals("3")){
			    			String Traces = jsonObject.getString("Traces");
			    			int last = Traces.lastIndexOf("{");
			    			String lastStr = Traces.substring(last,Traces.length()-1);
			    			JSONObject lastObject = JSONObject.fromObject(lastStr);
			    			String beginTime_ = lastObject.getString("AcceptTime");//起租时间（签收时间）
			    			String rentTime_ = r.getString("rentTime_");//租期时长
			    			Integer rentTime = Integer.parseInt(rentTime_);
			    			SimpleDateFormat sdf =   new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			    			Date date = sdf.parse(beginTime_);
			    			Calendar ca=Calendar.getInstance();
			    			ca.setTime(date);
			    			ca.add(Calendar.DATE,+rentTime);//加上租赁天数
			    			Date returnTime = ca.getTime();
			    			String returnTime_ = sdf.format(returnTime);//应还时间
			    			SqlQuery sql2 = new SqlQuery(handle);
							sql2.add("select UID_,orderId_,beginTime_,returnTime_,orderState_ from  %s where orderId_='%s' ",appdb.T_ORDER,r.getString("orderId_"));
							sql2.open();
							sql2.edit();
							sql2.setField("beginTime_", beginTime_);
							sql2.setField("returnTime_", returnTime_);
							sql2.setField("orderState_", 4);//改为在租
							sql2.post();
							FrmMessage.addMsgInfo(handle, "订单签收", "订单："+r.getString("orderId_")+"已签收", "1", TDateTime.Now(), userId_, "system", userId_);
							num += 1;
							return num;
			    		}
			    	}
			    } catch (Exception e) {
			    	e.printStackTrace();
			    }
			}
		}

		return 0;
		
	}
	
	public String getKDType(String t){
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
