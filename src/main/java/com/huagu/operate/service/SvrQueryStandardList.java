package com.huagu.operate.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 * 查询运费模板列表
 */
public class SvrQueryStandardList  extends AbstractService{

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record head = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select * from %s where 1=1",appdb.T_Feight);
		if(head.hasValue("nameId_")){
			ds.add(" and nameId_='%s'",head.getString("nameId_"));
		}
		ds.open();
		if(!ds.eof()){
			dataOut.appendDataSet(ds);
		}
		return this.success();
	}

}
