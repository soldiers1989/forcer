package com.huagu.admin.services;

import com.huagu.common.global.appdb;
import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 日志分类查询
 * 
 * @author xiaofei-pc
 *
 */
public class SvrLogType extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery ds = new SqlQuery(this);
		ds.add("select operateType_ from %s", appdb.MANAGE_LOGS);
		ds.add("GROUP BY operateType_");
		ds.open();
		dataOut.appendDataSet(ds);
		return success();
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}
}
