package com.huagu.admin.services;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jbean.other.SystemTable;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrRoleDel extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select UID_,CorpType_,Code_,Name_,StandardRole_,Remark_,isLive_,System_,Default_,UpdateUser_,UpdateDate_,AppUser_,AppDate_,UpdateKey_ from %s",
				SystemTable.get(SystemTable.getUserRoles));
		ds.add("where UID_ = '%s'", headIn.getSafeString("UID_"));
		ds.open();
		DataValidateException.stopRun("未找到该角色", ds.eof());
		ds.delete();
		return success();
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}
}
