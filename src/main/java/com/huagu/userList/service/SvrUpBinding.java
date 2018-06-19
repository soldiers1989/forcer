package com.huagu.userList.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 修改绑定运维帐号
 * 
 * @author xiaofei-pc
 *
 */
public class SvrUpBinding extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("SELECT UID_,code_,binding FROM %s", appdb.S_Userinfo);
		ds.add(" WHERE 1=1");
		ds.add(" AND code_ = '%s'", headIn.getSafeString("code_"));
		ds.open();
		if (!ds.eof()) {
			ds.edit();
			if("bd".equals(headIn.getSafeString("type_")))
				ds.setField("binding", 2);
			if("qxbd".equals(headIn.getSafeString("type_")))
				ds.setField("binding", 1);
			ds.post();
		}
		return success();
	}

}
