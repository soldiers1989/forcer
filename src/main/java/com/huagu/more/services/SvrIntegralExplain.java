package com.huagu.more.services;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 积分说明后台展示
 *  @author 王姣
 *  @date   2018年4月4日下午2:21:26
 *  @return
 */
public class SvrIntegralExplain extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_  , explain_ ,updateTime_ ,updateUser_  from t_integral");
		sql.add("where UID_ = '1'");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
