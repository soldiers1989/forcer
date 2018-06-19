package com.huagu.admin.services;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jbean.other.SystemTable;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrRoleDataModify extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		
		SqlQuery ds = new SqlQuery(this);
		ds.add("select UID_,CorpType_,Code_,Name_,StandardRole_,Remark_,isLive_,System_,Default_,UpdateUser_,UpdateDate_,AppUser_,AppDate_,UpdateKey_ from %s", SystemTable.get(SystemTable.getUserRoles));
		ds.add("where CorpType_ ='%s'",this.getCorpNo());		
		ds.add("and UID_ ='%s'", headIn.getSafeString("UID_"));
		
		ds.open();
		if(ds.eof()){
			ds.append();
			ds.setField("AppDate_", TDateTime.Now());
			ds.setField("AppUser_", this.getUserCode());
		}else{
			ds.edit();
			ds.setField("UpdateDate_", TDateTime.Now());
			ds.setField("UpdateUser_", this.getUserCode());
		}
		ds.setField("Name_", headIn.getSafeString("Name_"));
		ds.setField("isLive_", headIn.getSafeString("isLive_"));
		ds.setField("CorpType_", this.getCorpNo());
		ds.setField("Remark_", headIn.getSafeString("Remark_"));
		
		ds.post();
		return success();

	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}
}
