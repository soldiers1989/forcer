package com.huagu.my.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 查看购买订单详情
 * @author wj  
 * @date 2018年5月21日 
 *
 */
public class SvrBuyOrdersDetails extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select o.orderId_,o.proId_, o.userId_,o.orderState_,o.recAdr_,o.receiver_,o.recPhone_ ,o.createDate_ ,o.sumRentMoney_,o.coupon_,o.sumMoney_,o.recLogisticsId_ ,");
		sql.add("o.recLogisticsName_ ,o.deliveryTime_ ,o.logisticsState_ , o.agree_  ,o.reGoodsId_ , o.orderState_ ,o.reGoodsMoney_  ,o.orderType_,p.proName_,");
		sql.add("s.saleProColor_,s.jinPrice_,s.ruKuCount_,s.saleHomeAgency_,s.offerPrice_,r.number_ , r.createTime_ , r. userNowMoney_");
		sql.add("from %s o join %s p" ,appdb.T_ORDER,appdb.T_Products);
		sql.add("on o.proId_ = p.proId_ ");
		sql.add("join %s s on s.proId_ = p.proId_ " ,appdb.T_Storage);
		sql.add("join %s	r  on r.userCode_ = o.userId_" ,appdb.Record);
		sql.add("where o.orderType_ = '4'");
		sql.add("and  o.orderId_ = '%s'" ,head.getString("orderId_"));
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);
		}
		return this.success();
	}

}
