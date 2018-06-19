package com.huagu.indemnity.services;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  
 * @author wj  
 * @date 2018年5月12日 
 *
 */
public class SvrGetOrderInfo extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select u.mobile_,o.orderId_ ,p.type_ ,o.userId_ from s_userinfo u");
		sql.add("join t_order o on u.code_ = o.userId_");
		sql.add("join t_operate p on p.orderId_ = o.orderId_");
		sql.add("where p.type_ != '3' and u.mobile_ = '%s' " ,head.getString("mobile_"));
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);
		}
		return this.success();
	}

}
