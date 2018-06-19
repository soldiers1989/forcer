package com.huagu.order.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrDeliveryorder extends CustomService {
	
	//查询订单列表
	public boolean findOrderList() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		String orderType_ = head.getString("orderType_");
		String orderState_ = head.getString("orderState_");
		String startDate = head.getString("unlockDate_");
	    String endDate = head.getString("endDate_");
	    String returnDate_ = head.getString("returnDate_");
	    String endReturnDate_ = head.getString("endReturnDate_");
	    String logisticsState_ = head.getString("logisticsState_");
	    String settleState_ = head.getString("settleState_");
	    String orderId_ = head.getString("orderId_");
	    String mobile_ = head.getString("mobile_");
	    if(logisticsState_.equals("5"))
	    	logisticsState_ = "";
		if(orderState_.equals("0"))
			orderState_ = "";
		if(settleState_.equals("-1")){
			settleState_ = "";
		}
		sql.add("select r.out_trade_no_,ci.ciCode_, r.userNowMoney_,r.amount_,u.mobile_,o.*,o.orderState_,p.cashPledge_,p.price_,o.settleState_,DATE_FORMAT(o.createDate_,'%s') as createDate,DATE_FORMAT(o.beginTime_,'%s') as beginTime,DATE_FORMAT(o.payTime_,'%s') as payTime,DATE_FORMAT(o.returnTime_,'%s') as returnTime,p.proName_,p.isDiscount_,p.dayRentMoney_,p.discountPrice_,b.name_ boxName_,b.address_ boxAddress_,b.communityName_ boxCommunityName_,b.boxId_ "+
				"from (SELECT ord.*,n.homeAgency_ from %s ord  LEFT JOIN %s n on ord.zhuCode_=n.zhuCode_) o "+
				"left join %s p on o.proId_=p.proId_ ","%Y-%m-%d %H:%m:%s","%Y-%m-%d %H:%m:%s","%Y-%m-%d %H:%m:%s","%Y-%m-%d %H:%m:%s",appdb.T_ORDER,appdb.T_ProNode,appdb.T_Products);
		sql.add("left join (select c.name_,c.address_ ,c.communityName_,tpb.zhuCode_ ,tpb.boxId_  from %s c left join %s tpb  on c.id_=tpb.cabId_) b on o.zhuCode_=b.zhuCode_",appdb.CABINET,appdb.t_pronode_box);
		sql.add("left join %s u on u. code_ = o.userId_" ,appdb.S_Userinfo);
		sql.add("left join %s r on r.orderId_ = o.orderId_" ,appdb.Record);
		sql.add("left join %s ci on b.zhuCode_ = ci.zhuCode_ " ,appdb.T_CiNode);
		sql.add("where o.orderType_=%s",orderType_);
		if(head.hasValue("createDate_")){
			sql.add("and o.createDate_ like '%s'", "%"+head.getString("createDate_")+"%");
		}
		if(head.hasValue("proName_")){
			sql.add("and p.proName_ like '%s'", "%"+head.getString("proName_")+"%");
		}
		if(head.hasValue("homeAgency_")){
			sql.add("and o.homeAgency_ like '%s'", "%"+head.getString("homeAgency_")+"%");
		}
		if(head.hasValue("zhuCode_")){
			sql.add("and o.zhuCode_ like '%s'", "%"+head.getString("zhuCode_")+"%");
		}
		if(orderState_ != null && orderState_ != ""){
			sql.add("and o.orderState_  = '%s'" ,orderState_);
		}
		if(logisticsState_ != null && logisticsState_ != ""){
			sql.add("and o.logisticsState_  like '%s'" ,new String("%"+logisticsState_+"%"));
		}	
		if (startDate != null && startDate != ""){
	          sql.add("and unix_timestamp(o.createDate_) between unix_timestamp( '%s') and unix_timestamp('%s')",
	              startDate, endDate);
	    }
		if (returnDate_ != null && returnDate_ != ""){
	          sql.add("and unix_timestamp(o.returnOverTime_) between unix_timestamp( '%s') and unix_timestamp('%s')",
	        		  returnDate_, endReturnDate_);
	    }
		if(settleState_ != null && settleState_ != ""){
			sql.add("and o.settleState_  = '%s'" ,settleState_);
		}
		if(orderId_ != null && orderId_ != ""){
			sql.add("and o.orderId_ like '%s'" ,"%"+orderId_+"%");
		}
		if(mobile_ != null && mobile_ != ""){
			sql.add("and u.mobile_  like '%s'" ,"%"+mobile_+"%");
		}
		sql.add("group by o.orderId_");
		DataSet ds =  sql.open();
		this.getDataOut().appendDataSet(ds);
		return true;
	}
	
	//查询订单信息
	public boolean findOrder() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("select o.*,p.proName_,n.homeAgency_,p.isDiscount_,p.dayRentMoney_,p.discountPrice_,"+
				"(select count(*) from %s where nodeState_=2 and zhuCode_=(select zhuCode_ from t_order where orderId_='"+head.getString("orderId_")+"')) leasesTot_, "+
				"(select count(*) from %s where nodeState_=5 and zhuCode_=(select zhuCode_ from t_order where orderId_='"+head.getString("orderId_")+"')) sellTot_,"+
				"(select twoName_ from t_protype where twoNameId_=(select proTypeId_ from t_products where proId_=(select proId_ from t_order where orderId_='"+head.getString("orderId_")+"' ))) twoName_,"+
				"(select fristName_ from t_protype where twoNameId_=(select proTypeId_ from t_products where proId_=(select proId_ from t_order where orderId_='"+head.getString("orderId_")+"' ))) fristName_ "+
				"from %s o "+
				"left join %s p on o.proId_=p.proId_ "+
				"left join %s n on o.zhuCode_=n.zhuCode_",appdb.T_ProState,appdb.T_ProState,appdb.T_ORDER,appdb.T_Products,appdb.T_ProNode);
		sql.add("where o.orderId_='%s'",head.getString("orderId_"));
		DataSet ds =  sql.open();
		this.getDataOut().appendDataSet(ds);
		return true;
	}
	
	//修改物流信息
	public boolean updateOrder() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_,orderId_,recLogisticsName_,recLogisticsId_,deliveryTime_,recUpTime_,logisticsState_,zhuCode_,orderState_ from %s",appdb.T_ORDER);
		sql.add("where orderId_ = '%s'",head.getString("orderId_"));
		sql.open();
		sql.edit();
		sql.setField("recLogisticsName_", head.getString("recLogisticsName_"));
		sql.setField("recLogisticsId_", head.getString("recLogisticsId_"));
		sql.setField("deliveryTime_", head.getString("deliveryTime_"));
		sql.setField("zhuCode_", head.getString("zhuCode_"));
		sql.setField("logisticsState_", 1);
		sql.setField("orderState_", 3);
		sql.post();
		return true;
	}
	
	//运维根据主电子条码，状态是6：已归还，获取订单 和 此商品信息信息
	public boolean findOrd() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("select o.*,n.*,(SELECT SUM(rentTime_)+SUM(overdueDay_) from %s where zhuCode_='%s') sumTime_, "
				+ "(select count(userId_) from %s  where zhuCode_='%s') manCount_,"
				+ "(select count(orderId_) from %s  where zhuCode_='%s') orderCount_ ,"
				+"(select count(OpenBoxTime_) from %s where zhuCode_='%s') openCount_ "
				+ "from %s o ",
				appdb.T_ORDER, head.getString("zhuCode_"), 
				appdb.T_ORDER,head.getString("zhuCode_"),
				appdb.T_ORDER,head.getString("zhuCode_"),
				appdb.t_Operate,head.getString("zhuCode_"), 
				appdb.T_ORDER);
		sql.add("left join %s n on o.zhuCode_=n.zhuCode_",appdb.T_ProNode);
		sql.add(" where o.zhuCode_='%s'", head.getString("zhuCode_"));
		sql.add(" and o.orderState_=6");
		sql.open();
		DataSet ds =  sql.open();
		this.getDataOut().appendDataSet(ds);
		return true;
	}
	
}
