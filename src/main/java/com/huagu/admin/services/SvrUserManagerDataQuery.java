package com.huagu.admin.services;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jbean.other.SystemTable;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrUserManagerDataQuery extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select su.UID_,su.code_,su.mobile_,su.corpCode_ as agencyName_,su.name_,su.mobile_,su.remark_ as mark_, su.enabled_,su.roleCode_ ,tr.Name_ roleName,su.corpNo_,  DATE_FORMAT(su.loginTime_,'%s') as loginTime_  from %s as su","%Y-%m-%d %H:%m:%s",SystemTable.get(SystemTable.getUserInfo));
		ds.add("left join %s tr on su.roleCode_ = tr.UID_", SystemTable.get(SystemTable.getUserRoles));
		ds.add("where 1 = 1 ");
		ds.add("and su.isManager_ = 1");//1表示后台用户
		if(headIn.hasValue("UID_"))
			ds.add("and su.UID_ = '%s'",dataIn.getHead().getSafeString("UID_"));
		if(headIn.hasValue("enabled_"))
			ds.add("and su.enabled_ = '%s'",dataIn.getHead().getSafeString("enabled_"));
		if(headIn.hasValue("roleId_") && !headIn.getSafeString("roleId_").equals("#"))
			ds.add("and su.roleCode_ like %s", headIn.getSafeString("roleId_"));
		if(headIn.hasValue("cityCode_") && !headIn.getSafeString("cityCode_").equals("#"))
			ds.add("and su.corpNo_ like %s","'%"+headIn.getSafeString("cityCode_")+"%'");
		ds.add("order by su.createTime_ desc");
		ds.open();
		dataOut.appendDataSet(ds);
		return success();
	}
}