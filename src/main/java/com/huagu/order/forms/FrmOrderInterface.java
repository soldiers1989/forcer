package com.huagu.order.forms;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.google.gson.Gson;
import com.huagu.common.util.QrcodeUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jbean.tools.MD5;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import net.sf.json.JSONObject;

public class FrmOrderInterface extends AbstractForm{
	public Logger log = Logger.getLogger(this.getClass());
	
	private String userCode_; 
	private String boxId_;	// 箱子ID
	private String cabId_;	// 柜子ID	
	private String zhuCode_;	//订单ID
	private String openBox_;	//打开箱子ID
	private String type_;	//打开箱子ID类型
	private String hostAnt;	//rfid主天线ID
	private String childAnt;	//rfid子天线id
	
	
	@Override
	public IPage execute() throws Exception {
		
		return null;

	}

	//开箱获取箱子ID和柜子ID生成在页面上
	public IPage getEWM() throws Exception {
		JspPage jsp = new JspPage(this, "my/QRCode.jsp");
		jsp.add("zhuCode_", this.getRequest().getParameter("zhuCode_"));
		jsp.add("type_", this.getRequest().getParameter("type_"));
		jsp.add("orderId_", this.getRequest().getParameter("orderId_"));
		return jsp;
	}
	
	//生成二维码
	public IPage createQR() throws Exception {
		HttpServletResponse response = this.getResponse();
		response.setContentType("image/jpg");
		/*String zhuCode_ = this.getRequest().getParameter("zhuCode_");
		LocalService svr = new LocalService(this, "SvrOrder_My.getBox");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("zhuCode_", zhuCode_);//订单ID
		if (!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		Record r = svr.getDataOut().getCurrent();
		boxId_ = r.getString("boxId_");
		cabId_ = r.getString("cabId_");*/
		String type_ = this.getRequest().getParameter("type_");
		String orderId_ = this.getRequest().getParameter("orderId_");
		System.err.println(orderId_);
		zhuCode_ = "2322221111";//商品主电子条码
		boxId_ = "1";//箱子ID
		cabId_ = "ZNG180609100721";//柜子ID
		hostAnt = "1";//RFID主天线ID
		childAnt = "1";//RFID子天线ID
		openBox_ = MD5.get(zhuCode_ + boxId_ + cabId_ + "type_=A");
		
		userCode_ = this.getUserCode();
		if("".equals(userCode_)){
			userCode_ = "15071506306";
		}
		
		try (MemoryBuffer Buff = new MemoryBuffer(BufferType.getSessionInfo, openBox_, openBox_)) {
			Buff.setExpires(0);
			Buff.setField("zhuCode_", zhuCode_);
			Buff.setField("boxId_", boxId_);
			Buff.setField("cabId_", cabId_);
			Buff.setField("cabId_", cabId_);
			Buff.setField("hostAnt", hostAnt);
			Buff.setField("childAnt", childAnt);
			Buff.setField("type_", "A");
			Buff.setField("orderId_", orderId_);
			Buff.setField("types_", type_);
			log.info("生成开箱标签:" + openBox_+ ",标签未使用，标签有效。");
		}

		log.info("------------- 以下是生成二维码日志  -------------");
		log.info("取货用户:" + userCode_);
		log.info("取货类型：" + type_);
		log.info("订单ID：" + orderId_);
		log.info("物品主电子标签：" + zhuCode_);
		log.info("取货类型：" + type_);
		log.info("RFID主天线ID：" + hostAnt);
		log.info("RFID子天线ID：" + childAnt);
		log.info("-------------    --------     -------------");
		
		QrcodeUtil.createStreamQrcode(300, 300, openBox_, this.getResponse().getOutputStream());
		/*if(!svr.getDataOut().bof()){
			Map<String, String> returnJson = new HashMap<>();
			returnJson.put("boxId_", boxId_);
			returnJson.put("cabId_", cabId_);
			returnJson.put("zhuCode_", this.getRequest().getParameter("zhuCode_"));
			returnJson.put("type_", "A");//用户取件开锁
			String returnStr = returnJson.toString();
			String url = String.format("data:'%s'", returnStr);
			QrcodeUtil.createStreamQrcode(300, 300, url, this.getResponse().getOutputStream());
		}
		*/
		return null;
	}
	
	//中控屏 获取二维码信息后反馈信息，后台判断该主电子条码是否存在柜子中
	public void  getOpen() throws Exception {
		/*JsonPage page = new JsonPage(this);*/
		Map<String, String> map = new HashMap<String, String>();
		/*String date = "{'newData':'gz1','data':'{cabId_=gz1,zhuCode_=123456,boxId_=A02,type_=A}'}";//模拟数据
		JSONObject jsonObj = JSONObject.fromObject(date);
		String newData = jsonObj.getString("newData");
		String data = jsonObj.getString("data");
		Gson gson = new Gson();
        Map<String, Object> map = new HashMap<String, Object>();
        map = gson.fromJson(data, map.getClass());
        String cabId_ = (String) map.get("cabId_");
        String type_ = (String) map.get("type_");
        Double zhuCode = (Double) map.get("zhuCode_");
        int zhuCode_ = (new Double(zhuCode)).intValue();*/
		// openType_=A&openTime_=当前时间&intValue=
		openBox_ = this.getRequest().getParameter("openBox_");
		
		// 安卓加密后7位+s 传给我，我再判断加密后是否匹配，
		String intValue_ = this.getRequest().getParameter("intValue_");
		// 后期7位加密
		String value_ = MD5.get(openBox_.substring(openBox_.length()-7, openBox_.length())+"s");

		// 用户userCode_
		userCode_ = this.getUserCode();
		if("".equals(userCode_)){
			userCode_ = "15071506306";
		}
		
		String orderId_ = null;
		String types_ = null;
		try (MemoryBuffer Buff = new MemoryBuffer(BufferType.getSessionInfo, openBox_, openBox_)) {
			zhuCode_ = (String) Buff.getField("zhuCode_");
			boxId_ = (String) Buff.getField("boxId_");
			cabId_ = (String) Buff.getField("cabId_");
			type_ = (String) Buff.getField("type_");
			hostAnt = (String) Buff.getField("hostAnt");
			childAnt = (String) Buff.getField("childAnt");
			orderId_ = (String) Buff.getField("orderId_");
			types_ = (String) Buff.getField("types_");
			log.info("拿到开箱标签:" + openBox_+ ",标签使用完毕，标签失效。");
			Buff.clear();	//清理缓存
			Buff.close();	//关闭缓存
		}
		log.info("------------- 以下是二维码取货日志  -------------");
		log.info("取货用户:" + userCode_);
		log.info("取货类型：" + type_);
		log.info("订单ID：" + orderId_);
		log.info("物品主电子标签：" + zhuCode_);
		log.info("取货类型：" + type_);
		log.info("RFID主天线ID：" + hostAnt);
		log.info("RFID子天线ID：" + childAnt);
		log.info("-------------    --------     -------------");
		
		if(value_.equals(intValue_)){
			log.info("二维码加密匹配成功！");
			if(type_ != null){
		        if("A".equals(type_)){
		        	/*LocalService svr = new LocalService(this, "SvrOrderInterface.getCab");
		        	Record headIn = svr.getDataIn().getHead();
		    		headIn.setField("cabId_", cabId_);//柜子Id
		    		headIn.setField("zhuCode_", zhuCode_);//柜子Id
		    		headIn.setField("userCode_", userCode_);//柜子Id
		    		if (!svr.exec())
		    			throw new RuntimeException(svr.getMessage());
		    		if(!svr.getDataOut().eof()){*/
		        	if("gx".equals(types_)){
		        		// 还货二维码
			        	LocalService updateOrderStrus_ = new LocalService(this, "SvrOrderInterface.upCab");
			        	if (!updateOrderStrus_.exec("orderId_", orderId_, "type_", types_))
			    			throw new RuntimeException(updateOrderStrus_.getMessage());
		        		
		        	}else{
		        		// 取货二维码
			        	// 开箱后修改订单状态
			        	LocalService updateOrderStrus_ = new LocalService(this, "SvrOrderInterface.upCab");
			        	if (!updateOrderStrus_.exec("orderId_", orderId_))
			    			throw new RuntimeException(updateOrderStrus_.getMessage());
		        	}
		        	
	    			map.put("cabId_", cabId_);
		    		map.put("boxId_", boxId_);
		    		map.put("status", "true");
		    		map.put("message", "开锁成功");
		    		/*}else{
		    			// 查询不到东西说明东西已经被取走，不打开箱子
		    			map.put("status", "false");
		    			map.put("message", "开锁失败，物品已被取走！");
		    		}*/
		        }else{
		        	//进来了如果type_不等于A不打开箱子
	    			map.put("status", "false");
	    			map.put("message", "开锁失败，二维码有误！");
		        }
			}else{
				// 如何type_等于空就不打开箱子;
				map.put("status", "false");
				map.put("message", "开锁失败，二维码失效！");
			}
		}else{
			// 加密比对不成功;
			map.put("status", "false");
			map.put("message", "开锁失败，二维码有误！");
		}
		log.info("扫码后柜子ID:"+cabId_ + "，返回柜子信息:" + new Gson().toJson(map));
		this.getResponse().getWriter().print(new Gson().toJson(map));
	}
	
	public IPage getDown() throws Exception {
		JsonPage page = new JsonPage(this);
		String date = "{'data':'{cabId_=gz1,boxId_=A02,type_=B}'}";//模拟数据(B=取货关门)
		JSONObject jsonObj = JSONObject.fromObject(date);
		String data = jsonObj.getString("data");
		Gson gson = new Gson();
        Map<String, Object> map = new HashMap<String, Object>();
        map = gson.fromJson(data, map.getClass());
        String cabId_ = (String) map.get("cabId_");
        String type_ = (String) map.get("type_");
        String boxId_ = (String) map.get("boxId_");
        if(type_.equals("B")){
        	LocalService svr = new LocalService(this, "SvrOrderInterface.upCab");
        	Record headIn = svr.getDataIn().getHead();
    		headIn.setField("cabId_",cabId_);//柜子Id
    		headIn.setField("boxId_",boxId_);//箱子Id
    		if (!svr.exec()){
    			throw new RuntimeException(svr.getMessage());
    		}
    		page.setData(true);
        }else{
        	page.setData(false);
        	
        }
		return page;
	}
	
	public static void main(String[] args) {
		System.err.println(MD5.get("07608d0s"));
	}
	
	@Override
	public boolean logon() {
		return true;
	}

}
