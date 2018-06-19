package com.huagu.userList.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 获取绑定登录运维端
 * 
 * @author xiaofei-pc
 *
 */
public class SvrGetAdminUserList extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("SELECT u.UID_,u.code_,u.name_,u.mobile_,ur.Name_ uName_,u.binding,u.loginTime_ FROM %s u JOIN s_userroles ur ON u.roleCode_ = ur.UID_",
				appdb.S_Userinfo);
		ds.add("  WHERE 1=1");
		ds.add(" and u.isManager_ = 1");
		if(headIn.hasValue("mobile_"))
			ds.add(" and u.mobile_ like '%s'", '%' + headIn.getString("mobile_") + '%');
		ds.open();
		if (!ds.eof()) {
			dataOut.appendDataSet(ds);
		}
		return success();
	}

}
