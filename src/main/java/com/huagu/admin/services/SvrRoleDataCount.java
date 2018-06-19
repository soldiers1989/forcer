package com.huagu.admin.services;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jbean.other.SystemTable;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrRoleDataCount extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select COUNT(S.roleCode_)roles_ FROM s_userinfo  S ");
		ds.add(" RIGHT join %s u on S.roleCode_=u.UID_ ", SystemTable.get(SystemTable.getUserRoles));
		ds.add(" where u.UID_=%s", headIn.getInt("UID_"));
		ds.open();
		dataOut.appendDataSet(ds);
		return success();
	}

}
