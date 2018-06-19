package com.huagu.more.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 *  @describe 查询我的总积分
 *  @author 王姣
 *  @date   2018年4月4日上午11:09:23
 *  @return
 */
public class SvrMySignNum extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select sum(integral_) signNum  , grade_ from %s" ,appdb.Integral);
		sql.add(" where userCode_  = '%s'" , head.getString("userCode_"));
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);
		}
		return this.success();
	}

}
