package com.huagu.admin.services;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jbean.other.SystemTable;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrRoleDataDel extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		String uid_ = headIn.getSafeString("UID_");
		SqlQuery ds = new SqlQuery(this);
		ds.add("select isLive_,UID_,UpdateDate_,UpdateUser_ from %s", SystemTable.get(SystemTable.getUserRoles));
		ds.add("where CorpType_='%s'",this.getCorpNo());
		ds.add("and UID_=%s",uid_);
		ds.open();
		DataValidateException.stopRun("要删除的数据不存在！", ds.eof());
		ds.edit();
		ds.setField("isLive_", "false");
		ds.setField("UpdateDate_", TDateTime.Now());
		ds.setField("UpdateUser_", this.getUserCode());
		ds.post();
		return success();
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}
}
