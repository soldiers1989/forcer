package com.huagu.personalInfo.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 * 个人购买订单详情查看
 * @author wj  
 * @date 2018年5月18日 
 *
 */
public class SvrBuyOrderDetails extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select u.code_ , o.userId_ ,o.proId_,o.orderId_ ,o.receiver_,o.recPhone_,o.recAdr_,o.sumRentMoney_,o.sumMoney_,o.createDate_,");
		sql.add("o.recLogisticsName_,o.recLogisticsId_,o.logisticsState_,o.orderState_ ,p.proName_ ,pn.homeAgency_,o.orderType_");
		sql.add("from %s o " ,appdb.T_ORDER);
		sql.add("join %s p on o.proId_ = p.proId_" ,appdb.T_Products);
		sql.add("join  %s pn on pn.proId_ = o.proId_" ,appdb.T_ProNode);
		sql.add("join %s u on o.userId_ = u.code_ " ,appdb.S_Userinfo);
		sql.add("where o.orderType_ = '4'");
		sql.add("and o.orderId_ = '%s'" ,head.getString("orderId_"));
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);	
		}
		return this.success();
	}

}
