package com.huagu.admin.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 查询用户权限
 * 
 * @author xiaofei-pc
 *
 */
public class SvrRoleAddPower extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select UID_,roleId_,powerId_ from %s", appdb.getRoleAndPowerTable(this));

		if (headIn.getBoolean("query")) { // 用于查询用户权限
			ds.add("where roleId_ = '%s'", headIn.getSafeString("roleId_"));
			ds.open();
			dataOut.appendDataSet(ds);
			return success();
		} else {
			ds.setMaximum(0);
		}
		ds.open();
		ds.append();
		ds.setField("roleId_", headIn.getSafeString("roleId_"));
		ds.setField("powerId_", headIn.getSafeString("powerId_"));
		ds.post();
		return success();
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}
}
