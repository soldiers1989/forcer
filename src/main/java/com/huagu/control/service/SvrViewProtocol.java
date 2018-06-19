package com.huagu.control.service;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jbean.other.SystemTable;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrViewProtocol extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select UID_,CorpType_,Code_,Name_,StandardRole_,Remark_,isLive_,System_,Default_,UpdateUser_,UpdateDate_,AppUser_,AppDate_,UpdateKey_ from %s",
				SystemTable.get(SystemTable.getUserRoles));
		ds.add("where Name_ = '%s'", headIn.getSafeString("roleName"));
		ds.open();
		if (!ds.eof()) {
			System.out.println(ds.getString("UID_"));
			if (ds.getString("UID_").equals(headIn.getSafeString("id"))) {
				return success();
			}
			return fail("error");
		}
		return success();
	}

}
