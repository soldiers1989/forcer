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
 * 根据用户名和新密码去查询数据
 * @author YMF
 *
 */
public class SvrCheckPassword extends AbstractService{

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		// TODO Auto-generated method stub
		Record headIn = dataIn.getHead();
		DataValidateException.stopRun("参数错误", !headIn.hasValue("phoneNum"));
		DataValidateException.stopRun("参数错误", !headIn.hasValue("password"));
		String phoneNum = headIn.getSafeString("phoneNum");
		String password = headIn.getSafeString("password");
		String md5Password = MD5.get(phoneNum + password);
		SqlQuery ds = new SqlQuery(this);
		ds.add("SELECT * FROM %s", SystemTable.get(SystemTable.getUserInfo));
		ds.add(" where code_ = '%s' and password_ = '%s'", phoneNum, md5Password);
		ds.open();
		if (!ds.eof()) {
			dataOut.appendDataSet(ds);
		}
		return success();
	}
	
	public boolean checkSecurity(IHandle handle) {
		return true;
	}

}
