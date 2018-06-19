package com.huagu.my.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONObject;

import com.huagu.common.forms.FrmMessage;
import com.huagu.common.forms.FrmMoneyRecord;
import com.huagu.common.global.appdb;
import com.huagu.common.util.LogisticsUtil;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.mysql.Transaction;
import cn.cerc.jdb.other.utils;

public class SvrOrder_My extends CustomService {
	
	//查询订单列表
	public boolean findOrderList() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		String falg = head.getString("falg");
		sql.add("select o.*,"
				+ "p.proName_,p.dayRentMoney_,p.discountPrice_,p.isDiscount_,p.cashPledge_,p.twoImgUrl_"
				+ " from (select ord.* from t_order ord LEFT JOIN t_pronode n on ord.zhuCode_=n.zhuCode_) o "
				+"left join "
				+"(select pro.proId_,pro.proName_,pro.dayRentMoney_,pro.discountPrice_,pro.isDiscount_,pro.cashPledge_,t.twoImgUrl_ from t_products pro LEFT JOIN t_protype t on t.twoNameId_=pro.proTypeId_) p "
				+ " on o.proId_=p.proId_ "
				+ " where 1=1 ");
		sql.add("and userId_='%s' and orderType_ is not null", head.getString("userId_"));
		if(falg.equals("1")){//待发货/开箱
			sql.add("and o.orderState_ in (1,2) ");
		}
		if(falg.equals("2")){//待收货/取件
			sql.add("and o.orderState_=3");
		}
		if(falg.equals("3")){//租用中
			//用户查看租用中页面时，获取订单物流信息，并订单修改状态为在租（由于定时器查看物流只在凌晨5点触发）
			SqlQuery sql2 = new SqlQuery(this);
			sql2.add("select UID_,recLogisticsId_,recLogisticsName_,orderId_,userId_ from %s where 1=1 ",appdb.T_ORDER);
			sql2.add(" and orderState_=3 and orderType_ in (2,3) and logisticsState_=1 ");
			sql2.open();
			if(!sql2.eof()){
				List<Record> records = sql2.getRecords();
				for(Record r:records){
					String n = r.getString("recLogisticsId_");
					String t = r.getString("recLogisticsName_");
					if(n != null && t != null && n != "" && t !=""){
						String str = LogisticsUtil.getLogistics(n, t);
						JSONObject jsonObject = JSONObject.fromObject(str); 
				    	Boolean success = jsonObject.getBoolean("Success");
				    	if(success){
				    		String state = jsonObject.getString("State");
				    		if(state.equals("3")){
				    			String Traces = jsonObject.getString("Traces");
				    			System.out.println(Traces);
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
				    			SqlQuery sql3 = new SqlQuery(handle);
								sql3.add("select UID_,orderId_,beginTime_,returnTime_,orderState_ from  %s where orderId_='%s' ",appdb.T_ORDER,r.getString("orderId_"));
								sql3.open();
								sql3.edit();
								sql3.setField("beginTime_", beginTime_);
								sql3.setField("returnTime_", returnTime_);
								sql3.setField("orderState_", 4);//改为在租
								sql3.post();
								FrmMessage.addMsgInfo(handle, "订单签收", "订单："+r.getString("orderId_")+"已签收", "1", TDateTime.Now(), r.getString("userId_"), "system",r.getString("userId_"));
								
				    		}
				    	}
						
					}
			    		
				}
			}
			sql.add("and o.orderState_ in (4,5)");
		}
		if(falg.equals("5")){//待评价
			sql.add("and o.orderState_=6");
		}
		if(falg.equals("6")){//退款
			sql.add("and o.orderState_=8");
		}
		if(falg.equals("mhss")){
			sql.add("and (o.orderId_ like '%s'", "%" + head.getString("data").trim() + "%");
			sql.add(" || p.proName_ like '%s')", "%" + head.getString("data").trim() + "%");
		}
		sql.add(" ORDER BY o.createDate_ desc ");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return true;
	}
	
	//查询订单详情
	public boolean findOrder() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("select o.userId_,o.orderId_,o.orderType_,o.orderState_,DATE_FORMAT(o.beginTime_,'%s-%s-%s %s:%s:%s') beginTime_,DATE_FORMAT(o.returnTime_,'%s-%s-%s %s:%s:%s') returnTime_,o.rentTime_,o.sumRentMoney_,o.coupon_,o.shippingCosts_,o.reliefDeposit_,o.sumMoney_,o.orderId_,DATE_FORMAT(o.createDate_,'%s-%s-%s %s:%s:%s') createDate_,DATE_FORMAT(o.payTime_,'%s-%s-%s %s:%s:%s') payTime_,o.remark_,o.receiver_,o.recPhone_,o.recAdr_,o.recLogisticsId_,o.recLogisticsName_,returnOverTime_,allowReturnMoney_,zhuCode_ "
				+ ",p.proName_,p.dayRentMoney_,p.discountPrice_,p.isDiscount_,p.cashPledge_,p.twoImgUrl_ "
				+ "from %s o "
				+" left join "
				+"(select pro.proId_,pro.proName_,pro.dayRentMoney_,pro.discountPrice_,pro.isDiscount_,pro.cashPledge_,t.twoImgUrl_ from t_products pro LEFT JOIN t_protype t on t.twoNameId_=pro.proTypeId_) p "
				+ " on o.proId_=p.proId_ "
				+ "where 1=1","%Y", "%m", "%d", "%H", "%i", "%S","%Y", "%m", "%d", "%H", "%i", "%S","%Y", "%m", "%d", "%H", "%i", "%S","%Y", "%m", "%d", "%H", "%i", "%S",appdb.T_ORDER);
		sql.add("and o.orderId_='%s'", head.getString("orderId_"));
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return true;
	}
	
	//修改订单状态
	public boolean updateOrder() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		String orderId_ = head.getString("orderId_");
		String orderState_ = head.getString("orderState_");
		sql.add("select UID_,orderState_,orderId_ from %s where 1=1 ",appdb.T_ORDER);
		sql.add(" and orderId_='%s'",orderId_);
		sql.open();
		sql.edit();
		sql.setField("orderState_",orderState_);
		sql.post();
		return true;
	}
	
	//归还时，修改物流信息
	public boolean seaExpReturn() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		String orderId_ = head.getString("orderId_");
		sql.add("select UID_,returnLogisticsName_,orderId_,retuenLogisticsId_ from %s where 1=1 ",appdb.T_ORDER);
		sql.add(" and orderId_='%s'",orderId_);
		sql.open();
		sql.edit();
		sql.setField("returnLogisticsName_",head.getString("returnLogisticsName_"));
		sql.setField("retuenLogisticsId_",head.getString("retuenLogisticsId_"));
		sql.post();
		return true;
	}
	
	//物流归还修改类型
	public boolean upOrderRepair() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		String orderId_ = head.getString("orderId_");
		sql.add("select UID_,orderId_,rentTime_,returnType_,repairType_,returnMethod_,orderState_,returnLogisticsName_,retuenLogisticsId_,overdueDay_,sumOverMoney_,orderRentMoney_,sumRentMoney_,returnOverTime_ "
				+ "from %s where 1=1 ",appdb.T_ORDER);
		sql.add(" and orderId_='%s'",orderId_);
		sql.open();
		if(!sql.eof()){
			Record r = sql.getCurrent();
			String sumRentMoney_ = r.getString("sumRentMoney_").trim();
			
			if(sumRentMoney_ == null || sumRentMoney_.equals("")){
				sumRentMoney_ = "0";
			}
			String rentTime_ = r.getString("rentTime_");
			sql.edit();
			sql.setField("returnOverTime_",TDateTime.Now());
			sql.setField("returnType_",head.getString("returnType_"));
			sql.setField("returnMethod_",head.getString("returnMethod_"));
			if(head.getString("returnMethod_").equals("1")){
				sql.setField("returnLogisticsName_",head.getString("returnLogisticsName_"));
				sql.setField("retuenLogisticsId_",head.getString("retuenLogisticsId_"));
			}
			if(head.getString("returnType_").equals("1")){
				sql.setField("repairType_",head.getString("repairType_"));
			}
			if(head.hasValue("overdueDay_")){
				sql.setField("overdueDay_",head.getString("overdueDay_"));
			}
			if(head.hasValue("sumOverMoney_")){
				sql.setField("sumOverMoney_",head.getString("sumOverMoney_"));
				System.out.println("sumRentMoney_:"+sumRentMoney_);
				System.out.println("sumOverMoney_:"+head.getString("sumOverMoney_"));
				Double tot = Double.parseDouble(sumRentMoney_)+Double.parseDouble(head.getString("sumOverMoney_"));
				sql.setField("orderRentMoney_",tot);
			}
			sql.setField("orderState_",5);
			sql.post();
		}
		
		return true;
	}
	
	//添加订单评价
	public boolean addEvaluate() throws Exception {
		Record head = dataIn.getHead();
		String evaId_ = utils.newGuid();
		evaId_ = evaId_.substring(1, evaId_.length() - 1);
		evaId_ = evaId_.replaceAll("-", "");
		String evaImgId_ = utils.newGuid();
		evaImgId_ = evaImgId_.substring(1, evaImgId_.length() - 1);
		evaImgId_ = evaImgId_.replaceAll("-", "");
		try (Transaction tx = new Transaction(this)) {
			System.out.println("file:"+head.getString("file"));
			SqlQuery sql3 = new SqlQuery(this);
			sql3.add("select UID_,proId_,orderState_ from %s",appdb.T_ORDER);
			sql3.add("where orderId_='%s'",head.getString("orderId_"));
			sql3.open();
			if(!sql3.eof()){
				Record r = sql3.getCurrent();
				String proId_ = r.getString("proId_");
				
				SqlQuery sql = new SqlQuery(this);
				sql.add("select UID_,evaId_,createDate_,orderId_,evaLevel_,	evaContent_,evaImgId_,evaState_,UserId_,proId_,orderType_ from %s ",appdb.T_EVALUATE);
				sql.open();
				sql.append();
				sql.setField("evaId_",evaId_);
				sql.setField("createDate_",TDateTime.Now());
				sql.setField("orderId_",head.getString("orderId_"));
				sql.setField("evaLevel_",head.getString("evaLevel_"));
				sql.setField("evaContent_",head.getString("evaContent_"));
				sql.setField("evaImgId_",evaImgId_);
				sql.setField("evaState_",head.getString("evaState_"));
				sql.setField("proId_",proId_);
				sql.setField("UserId_",head.getString("userId_"));
				if(head.getString("orderType_").equals("4")){
					sql.setField("orderType_",1);
				}else{
					sql.setField("orderType_",0);
				}
				sql.post();
				SqlQuery sql2 = new SqlQuery(this);
				sql2.add("select UID_,createDate_,relevancelId_,imgPath_ from %s ",appdb.T_IMAGE);
				sql2.open();
				sql2.append();
				sql2.setField("relevancelId_",evaImgId_);
				sql2.setField("imgPath_",head.getString("file"));
				sql2.setField("createDate_",TDateTime.Now());
				sql2.post();

				
				//修改订单状态
				SqlQuery sqlStatus = new SqlQuery(this);
				sqlStatus.add("select UID_ ,orderState_ ,userId_ ,orderId_ from %s ", appdb.T_ORDER);
				sqlStatus.add("where userId_ = '%s'  and orderId_ = '%s' " ,sql.getField("UserId_"),sql.getField("orderId_"));
				sqlStatus.open();
				sqlStatus.edit();
				sqlStatus.setField("orderState_", 7);
				sqlStatus.post();
			}
			tx.commit();
		}
		return true;
	}
	
	//获取柜子和箱子id
	public boolean getBox() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		String zhuCode_ = head.getString("zhuCode_");
		sql.add("select * from %s  ",appdb.t_pronode_box);
		sql.add(" where zhuCode_='%s' and status_ = 1", zhuCode_);
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return true;
	}
	
	//根据用户Id 获取用户总押金
	public boolean getTotCashPledge() throws Exception {
		Record head = dataIn.getHead();
		String userId_ = head.getString("userId_");
		SqlQuery sql = new SqlQuery(this);
		sql.add("select SUM(p.cashPledge_ )-SUM(o.reliefDeposit_) totCashPledge_ from %s o",appdb.T_ORDER);
		sql.add("LEFT JOIN t_products p on o.proId_=p.proId_ ");
		sql.add(" where  o.userId_='%s' and o.orderState_ not in(7,8) and o.beginTime_ is not null",userId_);
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return true;
	}
	
	//根据用户ID获取用户租金明细
	public boolean getCashPledge() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		String userId_ = head.getString("userId_");
		sql.add("select p.cashPledge_-o.reliefDeposit_ CashPledge_,DATE_FORMAT(o.beginTime_,'%s-%s-%s %s:%s') beginTime_,p.proName_,p.proZsImges_ from %s o","%Y", "%m", "%d", "%H", "%i",appdb.T_ORDER);
		sql.add("LEFT JOIN t_products p on o.proId_=p.proId_ ");
		sql.add(" where  o.userId_='%s' and o.orderState_ not in(7,8) and o.beginTime_ is not null",userId_);
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return true;
	}
	
	//用户退款
	public boolean refund() throws Exception {
		
		Record head = dataIn.getHead();
		//修改订单情况
		try (Transaction tx = new Transaction(this)) {
			SqlQuery sql = new SqlQuery(this);
			sql.add("select UID_,orderId_,updateDate_,returnReason_,returnMoney_,orderState_,zhuCode_,logisticsState_,recLogisticsId_,recLogisticsName_ from %s ",appdb.T_ORDER);
			sql.add(" where orderId_='%s'",head.getString("orderId_"));
			sql.open();
			Record r = sql.getCurrent();
			String logisticsState_ = r.getString("logisticsState_");
			String recLogisticsId_ = r.getString("recLogisticsId_");
			String recLogisticsName_ = r.getString("recLogisticsName_");
			sql.edit();
			sql.setField("returnReason_", head.getString("returnReason_"));
			sql.setField("returnMoney_", head.getString("returnMoney_"));
			sql.setField("orderState_", 8);//退款
			
			String userId_ = this.getUserCode();
			if(userId_ == "" || userId_ == null){
				userId_ = "17620458925";
			}
			//增加订单消息
		/*	if(!addMsg.exec("title_",title_,"content_",content_,"type_",type_,"sendTime_",sendTime_,"sendOb_",sendOb_,"sender_",sender_,"userCode_",userCode_)){
			*/	
			FrmMessage.addMsgInfo(handle, "订单退款", "订单："+r.getString("orderId_")+"退款", "1",TDateTime.Now(), userId_, "system", userId_);
			
			//修改商品状态
			SqlQuery sql2 = new SqlQuery(this);
			sql2.add("select UID_,nodeState_ from %s where 1=1 ",appdb.T_ProState);
			sql2.add(" and zhuCode_='%s'", head.getString("zhuCode_"));
			sql2.open();
			if(logisticsState_.equals("0")  && logisticsState_ != null){//寄送上门未发货，物品直接改为在仓库的状态
				sql2.edit();
				sql2.setField("nodeState_", 0);
				sql2.post();
			}
//			if(logisticsState_.equals("1")  && logisticsState_ != null){//寄送发货未签收，物品直接改为在柜的状态
//				sql2.edit();
//				sql2.setField("nodeState_", 2);
//				sql2.post();
//			}
			if(recLogisticsId_ != null && recLogisticsName_ != null){
				String n = recLogisticsId_;
				String t = recLogisticsName_;
				if(n != null && n != "" && t != null && t != ""){
				String str = LogisticsUtil.getLogistics(n, t);
				JSONObject jsonObject = JSONObject.fromObject(str); 
		    	Boolean success = jsonObject.getBoolean("Success");
		    	if(success){
		    		String state = jsonObject.getString("State");
		    		if(state.equals("1") || state.equals("2")){ //1:快递收件，2：在途中
		    			sql2.edit();
		    			sql2.setField("nodeState_", 4);//改为在途
		    			sql2.post();
		    		}
		    		if(state.equals("3")){
		    			head.setField("err", "快递已签收暂无法执行退款操作,若想退租物品，请到‘租用中归还物品’");
		    			return true;
		    		}
		    		
		    	}	
			}
			}
			FrmMoneyRecord.addMoneyRecord(handle, userId_, head.getString("returnMoney_"), null, "D", null, head.getString("orderId_"), null);
//			//修改用户余额
//			SqlQuery sql3 = new SqlQuery(this);
//			sql3.add("select UID_,code_,overMoney_ from %s",appdb.S_Userinfo);
//			sql3.add(" where code_='%s'",userId_);
//			sql3.open();
//			if(!sql3.eof()){
//				Record user = sql3.getCurrent();
//				String overMoney_ = user.getString("overMoney_");
//				Double tot = Double.parseDouble(overMoney_)+Double.parseDouble(head.getString("returnMoney_"));
//				sql3.edit();
//				sql3.setField("overMoney_", tot);
//				sql3.post();
//			}
//			
//			//增加交易记录
//			SqlQuery sql4 = new SqlQuery(this);
//			sql4.add("select UID_,userCode_,opeType_,amount_,status_,orderId_,createTime_ from %s ", appdb.Record);
//			sql4.add(" where userCode_='%s'",userId_);
//			sql4.open();
//			sql4.append();
//			sql4.setField("userCode_", userId_);
//			sql4.setField("opeType_", "D");
//			sql4.setField("amount_", head.getString("returnMoney_"));
//			sql4.setField("status_", "0");
//			sql4.setField("orderId_", head.getString("orderId_"));
//			sql4.setField("createTime_", TDateTime.Now());
//			sql4.post();
			sql.post();
			tx.commit();
			return true;
		}
		
	}
		
}
