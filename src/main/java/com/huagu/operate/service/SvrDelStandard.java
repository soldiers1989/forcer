package com.huagu.operate.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrDelStandard  extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record head = dataIn.getHead();
		String nameId_ = head.getString("nameId_");
		SqlQuery sql=new SqlQuery(this);
		sql.add("select * from %s where 1=1",appdb.T_Feight);
		if(head.hasValue("nameId_")){
			sql.add("and nameId_ ='%s'",nameId_);
		}
		sql.open();
		if(!sql.eof()){
			sql.delete();
		}
		return this.success();
	}

}
