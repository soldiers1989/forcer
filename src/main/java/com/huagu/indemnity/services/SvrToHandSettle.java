package com.huagu.indemnity.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  转手工结算
 * @author wj  
 * @date 2018年5月14日 
 *
 */
public class SvrToHandSettle extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		/*SqlQuery sql = new SqlQuery(this);*/
		Record  head = dataIn.getHead();
		/*sql.add("select o.orderId_,o.proId_,o.rentTime_,o.userId_,o.payID_,o.orderType_,o.coupon_,o.reliefDeposit_,o.sumOverMoney_,o.orderRentMoney_,");
		sql.add("o.createDate_,o.beginTime_,o.returnOverTime_,o.orderState_,o.repairType_,o.fixType_,o.status_ ,p.proName_,pn.zhuCode_,");
		sql.add("pn.proCostPrice_,p.dayRentMoney_,p.cashPledge_,pn.homeAgency_,u.mobile_");
		sql.add("from %s o join %s p on  o.proId_ = p.proId_ " ,appdb.T_ORDER,appdb.T_Products);
		sql.add("join %s pn on o.proId_ = pn.proId_" ,appdb.T_ProNode);
		sql.add("join %s oe on oe.orderId_ = o.orderId_" ,appdb.t_Operate);
		sql.add("join %s u on u.code_ = o.userId_" ,appdb.S_Userinfo);
		sql.add("where o.orderId_ = '%s' " ,head.getString("orderId_"));
		sql.open();*/
		
		SqlQuery sql1 = new SqlQuery(this);
		sql1.add("select UID_ , orderId_ ,settleState_ from %s" ,appdb.T_ORDER);
		sql1.add("where  orderId_ = '%s'" ,head.getString("orderId_"));
		sql1.open();
		sql1.edit();
		sql1.setField("settleState_", 1);
		sql1.post();
		return this.success();
	}

}
