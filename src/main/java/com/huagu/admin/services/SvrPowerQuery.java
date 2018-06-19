package com.huagu.admin.services;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jbean.other.SystemTable;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrPowerQuery extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery ds = new SqlQuery(this);
		ds.add("select Code_ UID_,name_,Parent_ parentId_ from %s", SystemTable.get(SystemTable.getAppMenus));
		ds.add("where Hide_ = 0");
		ds.add("order by It_ desc");
		ds.open();
		dataOut.appendDataSet(ds);
		return success();
	}
}