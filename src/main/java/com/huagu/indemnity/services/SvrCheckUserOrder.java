package com.huagu.indemnity.services;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 *  检查用户是否有订单
 * @author wj  
 * @date 2018年5月29日 
 *
 */
public class SvrCheckUserOrder extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record  head = dataIn.getHead();
		sql.add("select count(o.orderId_) as orderNum from s_userinfo u join t_order o on u.code_ = o.userId_");
		sql.add("join t_operate p on p.orderId_ = o.orderId_ where p.type_ != '3' and u.mobile_ = '%s'" ,head.getString("mobile_"));
		sql.open();
		int orderNum = 0;
		if(!sql.eof())
			orderNum = sql.getInt("orderNum");
			dataOut.getHead().setField("orderNum", orderNum);
		return this.success();
	}

}
