package com.huagu.admin.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jbean.other.SystemTable;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 根据用户编号获取用户菜单权限
 * 
 * @author rascal.guo
 * @time 2016-10-13 14:12
 */
public class SvrMenuQuery extends AbstractService {

	
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery ds = new SqlQuery(this);
		ds.add("SELECT p.* FROM %s p", SystemTable.get(SystemTable.getAppMenus));
		ds.add("INNER JOIN %s rp ON rp.powerId_ = p.Code_", appdb.getRoleAndPowerTable(this));
		ds.add("INNER JOIN %s r ON r.UID_ = rp.roleId_", SystemTable.get(SystemTable.getUserRoles));
		ds.add("INNER JOIN %s u ON u.roleCode_ = r.UID_ AND u.code_ = '%s'", SystemTable.get(SystemTable.getUserInfo), this.getUserCode());
		ds.add("group by p.It_");
		ds.add("order by p.It_ ASC");
		ds.open();
		dataOut.appendDataSet(ds);
		return success();
	}
	
	
	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}

}
