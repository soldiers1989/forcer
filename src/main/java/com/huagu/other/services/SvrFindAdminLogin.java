package com.huagu.other.services;

import com.huagu.common.global.appdb;
import com.huagu.common.util.DateUtil;
import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 查找后台用户权限
 * @author xiaofei-pc
 *
 */
public class SvrFindAdminLogin extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		String startDay = DateUtil.getDay();
		String endDay = DateUtil.getDay();
		SqlQuery ds1 = new SqlQuery(this);
		ds1.add("SELECT * FROM %s ", appdb.getDataPoint(this));
		ds1.add("tdp where tdp.DataPointName_ ='%s' ", headIn.getSafeString("name"));
		ds1.add(" AND (tdp.createTime_ between '%s' and '%s')", startDay, endDay + " 23:59:59");
		ds1.open();
		dataOut.appendDataSet(ds1);
		return success();
	}

}
