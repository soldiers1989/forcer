package com.huagu.my.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.mysql.Transaction;
import cn.cerc.jdb.other.utils;

public class SvrOrder_Lease extends CustomService {
	
	//查询用户信息
	public boolean findUser() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("select * from %s where 1=1", appdb.S_Userinfo);
		sql.add("and id_='%s' and adrState_=1 and userAdr_ is not null", head.getString("userId_"));
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return true;
	}
	
	//添加订单信息
	public boolean addOrderr_Lease() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		/*String guid = utils.newGuid();
		guid = guid.substring(1, guid.length() - 1);
		guid = guid.replaceAll("-", "");*/
		String orderType_ = head.getString("orderType_");
		try (Transaction tx = new Transaction(this)) {
		String guid = new SimpleDateFormat("yyyyMMddhhmmssSSS").format(new Date());
		sql.add("select UID_,orderId_,createDate_,createUser_,userId_,proId_,beginTime_,rentTime_,sumRentMoney_,coupon_,reliefDeposit_,sumMoney_,allowReturnMoney_,remark_,payTime_,orderType_,shippingCosts_,receiver_,recPhone_,recAdr_,orderState_,zhuCode_ from %s",appdb.T_ORDER);
		sql.open();
		sql.append();
		sql.setField("orderId_", guid);
		sql.setField("userId_",head.getString("userId_"));
		sql.setField("createDate_",TDateTime.Now());
		sql.setField("createUser_" ,this.getUserCode());
		sql.setField("proId_",head.getString("proId_"));
		sql.setField("rentTime_",head.getString("rentTime_"));
		sql.setField("sumRentMoney_",head.getString("sumRentMoney_"));
		sql.setField("coupon_",head.getString("coupon_"));
		sql.setField("reliefDeposit_",head.getString("reliefDeposit_"));
		sql.setField("sumMoney_",head.getString("sumMoney_"));
		sql.setField("allowReturnMoney_",head.getString("allowReturnMoney_"));
		sql.setField("remark_",head.getString("remark_"));
		sql.setField("payTime_",TDateTime.Now());
		sql.setField("orderType_",orderType_);
		sql.setField("zhuCode_",head.getString("zhuCode_"));
		if(orderType_.equals("1")){//自取租赁
			sql.setField("orderState_","3");//待取件
//			sql.setField("beginTime_",head.getString("beginTime_"));   
			sql.setField("returnTime_",head.getString("returnTime_"));
			
		}
		
		if(orderType_.equals("2") ){//送货上门，有物流
			sql.setField("orderState_","1");//用户下单待发货
			sql.setField("shippingCosts_",head.getString("shippingCosts_"));
			sql.setField("receiver_",head.getString("receiver_"));//收件人
			sql.setField("recPhone_",head.getString("recPhone_"));//收件人联系方式
			sql.setField("recAdr_",head.getString("recAdr_"));//收件人地址
			sql.setField("logisticsState_","0");//物流暂无轨迹
		}
		
		
		if( orderType_.equals("3")){//送货到柜，无物流
			sql.setField("orderState_","1");//用户下单待发货
			sql.setField("beginTime_", TDateTime.Now().addDay(3));//起租时间为下单时间24后+给工作人员2天的配送时间
			/*sql.setField("shippingCosts_",head.getString("shippingCosts_"));
			sql.setField("receiver_",head.getString("receiver_"));
			sql.setField("recPhone_",head.getString("recPhone_"));
			sql.setField("recAdr_",head.getString("recAdr_"));*/
		}  
		sql.post();
		
		//商品状态改为在租
		SqlQuery sql2 = new SqlQuery(this);
		sql2.add("select UID_,nodeState_ from %s where 1=1 ",appdb.T_ProState);
		sql2.add(" and zhuCode_='%s'", head.getString("zhuCode_"));
		sql2.open();
		sql2.edit();
		sql2.setField("nodeState_", 3);
		sql2.post();
		
		//增加交易记录
		if(head.hasValue("consumeId_")){
			SqlQuery sql3 = new SqlQuery(this);
			sql3.add("select UID_,orderId_,updateTime_ from %s ", appdb.Record);
			sql3.add("where out_trade_no_='%s'",head.getString("consumeId_"));
			sql3.open();
			sql3.edit();
			sql3.setField("orderId_", guid);
			sql3.setField("updateTime_", TDateTime.Now());
			sql3.post();
		}
		if(!head.hasValue("consumeId_")){
			SqlQuery sql3 = new SqlQuery(this);
			sql3.add("select UID_,orderId_,updateTime_ from %s ", appdb.Record);
			sql3.add(" where userCode_='%s'",head.getString("userId_"));
			sql3.add(" ORDER BY createTime_ DESC ");
			sql3.setMaximum(1);
			sql3.open();
			sql3.edit();
			sql3.setField("orderId_", guid);
			sql3.setField("updateTime_", TDateTime.Now());
			sql3.post();
		}
		
		//修改优惠卷中间表状态改为已使用
		/*SqlQuery sql4 = new SqlQuery(this);
		sql4.add("select UID_,couponId_,use_,userCode_ from %s where 1=1 ",appdb.t_couponanduser);
		sql4.add("and couponId_='%s'",head.getString("couponId_"));
		sql4.add("and userCode_='%s'",head.getString("userId_"));
		sql4.open();
		sql4.edit();
		sql4.setField("use_", "1");
		sql4.post();
		
		
		}*/
			if(!"".equals(head.getString("couponId_"))){
				//修改优惠卷中间表状态改为已使用
				SqlQuery sql4 = new SqlQuery(this);
				sql4.add("select UID_,couponId_,use_,userCode_ from %s where 1=1 ",appdb.t_couponanduser);
				sql4.add("and couponId_='%s'",head.getString("couponId_"));
				sql4.add("and userCode_='%s'",head.getString("userId_"));
				sql4.open();
				sql4.edit();
				sql4.setField("use_", "1");
				sql4.setField("Denomination_",head.getString("Denomination_"));
				sql4.post();
			}
			tx.commit();
		}
		return true;
	}
	
	//用户使用零钱支付
	public boolean payment() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("select * from %s where 1=1", appdb.S_Userinfo);
		sql.add("and code_='%s' ", head.getString("code_"));
		sql.open();
		if(!sql.eof()){
			Record r = sql.getCurrent();
			Double overMoney_ = r.getDouble("overMoney_");
			Double sumMoney = head.getDouble("sumMoney");
			Double balance = overMoney_ - sumMoney;
			if(balance >= 0){ 
				sql.edit();
				sql.setField("overMoney_", balance);
				sql.post();
				SqlQuery sql2 = new SqlQuery(this);
				String guid = utils.newGuid();
				guid = guid.substring(1, guid.length() - 1);
				guid = guid.replaceAll("-", "");
				head.setField("consumeId_", guid);
				sql2.add("select UID_,userCode_,platform_,userNowMoney_,out_trade_no_,amount_,opeType_,createTime_,status_,orderId_ from %s ", appdb.Record);
				sql2.open();
				sql2.append();
				sql2.setField("userCode_", head.getString("code_"));
				sql2.setField("platform_", head.getString("platform_"));
				sql2.setField("out_trade_no_",guid );
				sql2.setField("amount_", sumMoney);
				sql2.setField("opeType_","C" );
				sql2.setField("userNowMoney_", r.getDouble("overMoney_") - sql2.getInt("amount_"));
				sql2.setField("createTime_", TDateTime.Now());
				sql2.setField("status_",0);
				if(head.hasValue("orderId_")){  
					sql2.setField("orderId_", head.getString("orderId_"));
				}
				sql2.post();
				
			}
		}
		
		return true;
	}
	
	//微信增加交易记录
	public boolean WXpayment() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql2 = new SqlQuery(this);
		String guid = utils.newGuid();
		guid = guid.substring(1, guid.length() - 1);
		guid = guid.replaceAll("-", "");
		head.setField("consumeId_", guid);
		sql2.add("select UID_,userCode_,platform_,out_trade_no_,amount_,opeType_,createTime_,status_,orderId_ from %s ", appdb.Record);
		sql2.open();
		sql2.append();
		sql2.setField("userCode_", head.getString("code_"));
		sql2.setField("platform_", 0);
		sql2.setField("out_trade_no_",guid );
		sql2.setField("amount_", head.getString("sumMoney"));
		sql2.setField("opeType_","C" );
		sql2.setField("createTime_", TDateTime.Now());
		sql2.setField("status_",0);
		if(head.hasValue("orderId_")){
			sql2.setField("orderId_", head.getString("orderId_"));
		}
		sql2.post();
		return true;
	}
	//根据主电子条码获取箱子信息
	public boolean getBox() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("select * from %s where 1=1", appdb.PRONODEBOX);
		sql.add("and zhuCode_='%s' ", head.getString("zhuCode_"));
		sql.open();
		if(!sql.eof()){
			Record r = sql.getCurrent();
			String cabId_ = r.getString("cabId_");
			String boxId_ = r.getString("boxId_");
			SqlQuery sql2 = new SqlQuery(this);
			sql2.add("select boxName_ from %s where 1=1",appdb.BOX);
			sql2.add(" and cabId_='%s' and boxId_='%s' ",cabId_,boxId_);
			sql2.open();
			if(!sql2.eof())
				dataOut.appendDataSet(sql2);
		}
		return true;
	}
	
	//获取优惠卷
	public boolean getCoupon() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("select c.couponId_,c.couponname_,cd.use_,cd.range_ ,c.imgUrl_,c.Denomination_,c.enddate_,c.enddate1_ ");
		sql.add("FROM  %s c LEFT JOIN  %s cd   ON cd.couponId_=c.couponId_" ,appdb.t_coupon,appdb.t_couponanduser);
		sql.add("where cd.userCode_='%s' ",head.getString("userId_"));
		sql.add("and cd.use_='0' AND c.enddate_ < now() AND c.enddate1_ > now()");
		sql.add("group by c.couponId_ order by enddate_ desc");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return true;
	}
}
