package com.huagu.operate.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 修改上报运维征信单标记状态
 * 
 * @author xiaofei-pc
 *
 */
public class SvrUpOperateStatus extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("SELECT UID_,ywNo_,dealer_,status_ FROM %s", appdb.OPERATELEVY);
		ds.add(" WHERE 1=1");
		ds.add(" AND ywNo_ = '%s'", headIn.getSafeString("ywNo_"));
		ds.open();
		if (!ds.eof()) {
			ds.edit();
			ds.setField("dealer_", this.getUserCode());
			ds.setField("status_", 2);
			ds.post();
		}
		return success();
	}

}
