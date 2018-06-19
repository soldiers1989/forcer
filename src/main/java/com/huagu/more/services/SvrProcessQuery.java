package com.huagu.more.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 使用流程展示
 *  @author 王姣
 *  @date   2018年3月22日下午2:40:59
 *  @return
 */
public class SvrProcessQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_ ,updateDate_ ,updateUser_ ,content_  from %s" ,appdb.UseProcess);
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
