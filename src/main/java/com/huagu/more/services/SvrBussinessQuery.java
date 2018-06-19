package com.huagu.more.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrBussinessQuery extends AbstractService {

	/**
	 *  @describe 商务合作查询展示（后台）
	 *  @author 王姣
	 *  @date   2018年3月21日上午9:21:00
	 *  @return
	 */
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_ ,content_  from %s" ,appdb.Busperation);
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
