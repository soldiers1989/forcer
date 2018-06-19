package com.huagu.maintain.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 *  查询要转赔付的订单
 * @author wj  
 * @date 2018年6月6日 
 *
 */
public class SvrGetRemrOrder extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select  o.createDate_,o.orderId_, u.name_, u.mobile_,p.proName_ ,beginTime_,returnTime_,sumRentMoney_,orderRentMoney_");
		sql.add("from %s  o join %s u  on o.userId_ = u.code_", appdb.T_ORDER ,appdb.S_Userinfo);
		sql.add("join  %s p on p.proId_ = o.proId_ " ,appdb.T_Products);
		sql.add("where o.orderState_ = '4'" );
		sql.add("and o.orderId_ = '%s'" ,head.getString("orderId_"));
		sql.add("order by createDate_ desc ");
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);
		}
		return this.success();
	}

}
