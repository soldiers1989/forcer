package com.huagu.jiFenAndSign.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 后台查看积分等级详情
 *  @author 王姣
 *  @date   2018年3月16日上午11:34:19
 *  @return
 */
public class SvrGetJifenById extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record  head = dataIn.getHead();
		sql.add("select UID_ ,num_ ,remark_ ,grade_ from %s " ,appdb.IngetralLevel);
		sql.add("where UID_ = '%s'" ,head.getString("UID_"));
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
