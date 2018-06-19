package com.huagu.common.services.message;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jbean.other.SystemTable;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrGetUserMobileByUserCode extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {

		SqlQuery ds = new SqlQuery(this);
		ds.add("select mobile_ from %s",SystemTable.get(SystemTable.getUserInfo));
		ds.add("where code_='%s'",dataIn.getHead().getSafeString("userName"));
		ds.open();
		dataOut.appendDataSet(ds);
		return success();
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}
}
