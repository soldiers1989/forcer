package com.huagu.indemnity.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  根据用户名，订单号查询对应的订单信息
 * @author wj  
 * @date 2018年5月14日 
 *
 */
public class SvrGetOrderInfos extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String orderId_ = head.getString("orderId_");
		String mobile_ = head.getString("mobile_");
		sql.add("select o.orderId_,o.proId_,o.rentTime_,o.userId_,o.payID_,o.orderType_,o.coupon_,o.reliefDeposit_,o.sumOverMoney_,o.orderRentMoney_,");
		sql.add("o.createDate_,o.beginTime_,o.returnOverTime_,o.orderState_,o.repairType_,o.fixType_,o.status_ ,p.proName_,pn.zhuCode_,");
		sql.add("pn.proCostPrice_,p.dayRentMoney_,p.cashPledge_,pn.homeAgency_,u.mobile_");
		sql.add("from %s o join %s p on  o.proId_ = p.proId_ " ,appdb.T_ORDER,appdb.T_Products);
		sql.add("join %s pn on o.proId_ = pn.proId_" ,appdb.T_ProNode);
		sql.add("join %s oe on oe.orderId_ = o.orderId_" ,appdb.t_Operate);
		sql.add("join %s u on u.code_ = o.userId_" ,appdb.S_Userinfo);
		sql.add("where o.orderId_ = '%s' " ,head.getString("orderId_"));
		sql.add("and u.mobile_ = '%s'" ,head.getString("mobile_"));
		if(orderId_ != null && orderId_ != ""){
			sql.add("and o.orderId_ like '%s'" , new String("%"+orderId_+"%"));
		}
		if(mobile_ != null && mobile_ != ""){
			sql.add("and u.mobile_ like '%s'" ,new String("%"+mobile_+"%"));
		}
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);
		}
		return this.success();
	}

}
