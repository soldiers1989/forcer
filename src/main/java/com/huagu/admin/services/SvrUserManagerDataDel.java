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

/**
 * 删除后台管理员
 * @author xiaofei-pc
 *
 */
public class SvrUserManagerDataDel extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		String uid_ = headIn.getSafeString("UID_");
		SqlQuery ds = new SqlQuery(this);
		ds.add("select * from %s", SystemTable.get(SystemTable.getUserInfo));
		ds.add("where 1=1");
		ds.add("and UID_= '%s'", uid_);
		ds.open();
		DataValidateException.stopRun("要删除的数据不存在！", ds.eof());
		ds.delete();
		return success();
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}
}
