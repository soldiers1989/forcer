package com.huagu.control.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 更新版本接口查询
 * 
 * @author xiaofei-pc 
 */
public class SvrVersionUpdate extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery getVersion = new SqlQuery(this);
		getVersion.add("SELECT UID_,versionFile_,versionNum_ FROM %s", appdb.VERSION);
		getVersion.add("  WHERE 1 = 1 ORDER BY UID_ DESC");
		getVersion.setMaximum(1);
		getVersion.open();
		if(!getVersion.eof())
			dataOut.appendDataSet(getVersion);
		return success();
	}

}
