package com.huagu.myWallet.services;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 财务平台所有充值/提现金额
 *  @author lxf
 *  @date   2018年4月26日下午2:56:32
 *  @return
 */
public class SvrGetRechargeMoney extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("SELECT sum(amount_) amount_ FROM t_record");
		if("1".equals(head.getString("type_")))
			sql.add(" where type_ = '1' and status_ = '0'");
		else
			sql.add(" where type_ = '0' and status_ = '0'");
		
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
