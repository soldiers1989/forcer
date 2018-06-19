package com.huagu.userList.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 查询记录
 * 
 * @author xiaofei-pc
 *
 */
public class SvrGetUserRecord extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
        Record headIn = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("SELECT userCode_,SUM(amount_) amount_ FROM %s", appdb.Record);
		sql.add("where 1 = 1");
		sql.add(" and type_ = '%s'", headIn.getString("type_"));
		sql.add(" and userCode_ = '%s'", headIn.getString("code_"));
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return success();
	}

}
