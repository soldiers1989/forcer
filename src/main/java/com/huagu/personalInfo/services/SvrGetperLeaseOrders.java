package com.huagu.personalInfo.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  个人租赁订单查询
 * @author wj  
 * @date 2018年5月17日 
 *
 */
public class SvrGetperLeaseOrders extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String orderId_ = head.getString("orderId_");
		String beginTime_ = head.getString("beginTime_");
		String proName_ = head.getString("proName_");
		String dayRentMoney_ = head.getString("dayRentMoney_");
		sql.add("select u.code_,o.orderId_,o.proId_,o.rentTime_,o.userId_,o.payID_,o.orderType_,o.coupon_,o.reliefDeposit_,o.sumOverMoney_,o.orderRentMoney_,");
		sql.add(" DATE_FORMAT(o.createDate_,'%s') as createDate_ , DATE_FORMAT(o.beginTime_,'%s') as beginTime_, DATE_FORMAT(o.returnOverTime_,'%s') as returnOverTime_ ,o.orderState_,o.repairType_,o.fixType_,o.status_ ,p.proName_,pn.zhuCode_," ,"%Y-%m-%d %H:%m:%s","%Y-%m-%d %H:%m:%s","%Y-%m-%d %H:%m:%s");
		sql.add("pn.proCostPrice_,p.dayRentMoney_,p.cashPledge_,pn.homeAgency_,u.mobile_,o.settleState_");
		sql.add("from %s o join %s p on  o.proId_ = p.proId_ " ,appdb.T_ORDER,appdb.T_Products);
		sql.add("join %s pn on o.proId_ = pn.proId_" ,appdb.T_ProNode);
		sql.add("join %s oe on oe.orderId_ = o.orderId_" ,appdb.t_Operate);
		sql.add("join %s u on u.code_ = o.userId_" ,appdb.S_Userinfo);
		sql.add("where u.code_ = '%s'" ,head.getString("code_"));
		sql.add("and o.orderType_ != '4'");
		if(orderId_ != null && orderId_ != ""){
			sql.add("and o.orderId_ like '%s'" , new String("%"+orderId_+"%"));
		}if(beginTime_ != null && beginTime_ != ""){
			sql.add("and o.beginTime_  like  '%s'" , new String("%"+beginTime_+"%"));
		}if(proName_ != null && proName_ != ""){
			sql.add("and p.proName_ like '%s'" ,new String("%"+proName_+"%"));
		}if(dayRentMoney_ != null && dayRentMoney_ != ""){
			sql.add("and p.dayRentMoney_ = '%s'" ,dayRentMoney_);
		}
		sql.add("group by o.orderId_");
		sql.add("order by o.createDate_ desc");
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);
		}
		return this.success();
	}

}
