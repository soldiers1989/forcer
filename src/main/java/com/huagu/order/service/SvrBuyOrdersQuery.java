package com.huagu.order.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  购买订单查询展示
 * @author wj  
 * @date 2018年5月21日 
 *
 */
public class SvrBuyOrdersQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String proName_ = head.getString("proName_");
		String saleHomeAgency_ = head.getString("saleHomeAgency_");
		String orderState_ = head.getString("orderState_");
		String logisticsState_ = head.getString("logisticsState_");
		String createTime_ = head.getString("createTime_");
		String receiver_ = head.getString("receiver_");
		String recPhone_ = head.getString("recPhone_");
		if(orderState_.equals("-1")){
			orderState_ = "";
		}
		if(logisticsState_.equals("-2")){
			logisticsState_ = "";
		}
		sql.add("select o.orderId_,o.proId_, o.userId_,o.orderState_,o.recAdr_,o.receiver_,o.recPhone_ ,DATE_FORMAT(o.createDate_,'%s') as createDate_  ,o.sumRentMoney_,o.coupon_,o.sumMoney_,o.recLogisticsId_ ,","%Y-%m-%d %H:%m:%s");
		sql.add("o.recLogisticsName_  ,  DATE_FORMAT(o.deliveryTime_  ,'%s') as deliveryTime_   ,o.logisticsState_ , o.agree_  ,o.reGoodsId_ , o.orderState_ ,o.reGoodsMoney_  ,o.orderType_,p.proName_,","%Y-%m-%d %H:%m:%s");
		sql.add("s.saleProColor_,s.jinPrice_,s.ruKuCount_,s.saleHomeAgency_,s.offerPrice_,r.number_ ,  DATE_FORMAT(r.createTime_ ,'%s') as createTime_  , r. userNowMoney_","%Y-%m-%d %H:%m:%s");
		sql.add("from %s o join %s p" ,appdb.T_ORDER,appdb.T_Products);
		sql.add("on o.proId_ = p.proId_ ");
		sql.add("join %s s on s.proId_ = p.proId_ " ,appdb.T_Storage);
		sql.add("join %s	r  on r.userCode_ = o.userId_" ,appdb.Record);
		sql.add("where o.orderType_ = '4'");
		if(proName_ != null && proName_ != ""){
			sql.add("and p.proName_ like '%s'" ,new String("%"+proName_+"%"));
		}
		if(saleHomeAgency_ != null && saleHomeAgency_ != ""){
			sql.add("and s.saleHomeAgency_ like '%s'" ,new String("%"+saleHomeAgency_+"%"));
		}
		if(createTime_ != null && createTime_ != ""){
			sql.add("and r.createTime_ like '%s'" ,new String("%"+createTime_+"%"));
		}
		if(receiver_ != null && receiver_ != ""){
			sql.add("and o.receiver_ like '%s'" ,new String("%"+receiver_+"%"));
		}
		if(recPhone_ != null && recPhone_ != ""){
			sql.add("and o.recPhone_ like '%s'" ,new String("%"+recPhone_+"%"));
		}
		if(orderState_ != null && orderState_ != ""){
			sql.add("and o.orderState_ = '%s'" , orderState_);
		}
		if(logisticsState_ != null && logisticsState_ != ""){
			sql.add("and o.logisticsState_ = '%s'" , logisticsState_);
		}
		sql.add("group by o.orderId_ ");
		sql.add("order by  o.createDate_  desc");
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);
		}
		return this.success();
	}

}
