package com.huagu.admin.services;

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
 * 后台修改密码
 * 
 * @author xiaofei-pc
 *
 */
public class SvrEditPassWord extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record head = dataIn.getHead();
		DataValidateException.stopRun("无旧密码", !head.hasValue("oldpwd"));
		DataValidateException.stopRun("无旧密码", !head.hasValue("newpwd"));
		String oldPwd = MD5.get(getUserCode() + head.getString("oldpwd"));
		String newPwd = MD5.get(getUserCode() + head.getString("newpwd"));
		SqlQuery ds = new SqlQuery(this);
		ds.add("SELECT UID_,password_ FROM %s", SystemTable.get(SystemTable.getUserInfo));
		ds.add("WHERE code_ = '%s'", getUserCode());
		ds.open();
		DataValidateException.stopRun("该用户不存在", ds.bof());
		String userPwd = ds.getRecords().get(0).getItems().get("password_").toString();
		if (!oldPwd.equals(userPwd))
			return fail("密码错误");

		ds.edit();
		ds.setField("password_", newPwd);
		ds.post();
		return success("修改密码成功");
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}

}
