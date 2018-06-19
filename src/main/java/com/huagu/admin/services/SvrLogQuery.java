package com.huagu.admin.services;

import com.huagu.common.global.appdb;
import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.jiguang.common.utils.StringUtils;

/**
 * 后台操作日志查询 SvrLogQuery
 * 
 * @author xiaofei-pc
 *
 */
public class SvrLogQuery extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select operateData_,operateUser_,operateType_,operate_,operateAdress_,operateDetail_,UID_,corpNo_ from %s",
				appdb.MANAGE_LOGS);
		if(StringUtils.isNotEmpty(getCorpNo()))
			ds.add("where corpNo_='%s'", getCorpNo());
		else
			ds.add("where corpNo_='%s'", headIn.getSafeString("corpNo_"));
		if (headIn.hasValue("startDate"))
			ds.add("and operateData_ >='%s'", headIn.getSafeString("startDate") + " 00:00:00");
		if (headIn.hasValue("endDate"))
			ds.add("and operateData_ <'%s'", headIn.getSafeString("endDate") + " 23:59:59");
		if (headIn.hasValue("operateType_") && !"#".equals(headIn.getSafeString("operateType_")))
			ds.add("and operateType_ ='%s'", headIn.getSafeString("operateType_"));
		ds.add("order by operateData_ DESC");
		ds.open();
		dataOut.appendDataSet(ds);
		return success();
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}
}
