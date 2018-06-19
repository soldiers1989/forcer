package com.huagu.other.services;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jbean.other.SystemTable;
import cn.cerc.jbean.tools.MD5;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 修改密码
 * 
 * @author Administrator
 *
 */
public class SvrLossPassword extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		DataValidateException.stopRun("参数错误", !headIn.hasValue("phoneNumber"));
		DataValidateException.stopRun("参数错误", !headIn.hasValue("password"));
		SqlQuery ds = new SqlQuery(this);
		ds.add("SELECT * FROM %s", SystemTable.get(SystemTable.getUserInfo));
		ds.add("WHERE code_ = '%s'", headIn.getSafeString("phoneNumber"));
		ds.open();

		DataValidateException.stopRun("该用户不存在", ds.bof());
		String md5Password = MD5.get(headIn.getSafeString("phoneNumber") + headIn.getSafeString("password"));
		ds.edit();
		ds.setField("password_", md5Password);
		ds.post();
		return success();
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}

}
