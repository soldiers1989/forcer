package com.huagu.indemnity.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  得到当前用户/赔付单号/租赁单号
 * @author wj  
 * @date 2018年5月10日 
 *
 */
public class SvrUserAndIndemnity extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select u.UID_,u.code_,u.mobile_ ,o.orderId_,o.payID_ ,o.successMoney_,o.suggestMoney_,o.payReason_,o.suggest_,o.payDesc_ ,o.payRemark_   " );
		sql.add("from %s u",appdb.S_Userinfo);
		sql.add("join %s o on u.code_ = o.userId_ " ,appdb.T_ORDER);
		sql.add("where o.orderId_ = '%s'" ,head.getString("orderId_"));
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);
		}
		return this.success();
	}

}
