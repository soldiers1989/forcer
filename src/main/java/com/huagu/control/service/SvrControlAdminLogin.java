package com.huagu.control.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jbean.other.SystemTable;
import cn.cerc.jbean.tools.MD5;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 中控管理员登录Service
 * 
 * @author xiaofei-pc
 *
 */
public class SvrControlAdminLogin extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		String md5Password = MD5.get(headIn.getString("userName_") + headIn.getString("passWord_"));
		SqlQuery dsUser = new SqlQuery(this);
		dsUser.add("SELECT UID_,id_,code_,corpNo_,name_,password_,mobile_,roleCode_,enabled_,isCheckPwd_ FROM %s",
				SystemTable.get(SystemTable.getUserInfo));
		dsUser.add(" where code_ = '%s'", headIn.getString("userName_"));
		dsUser.open();
		if (dsUser.getInt("isBlack_") == 1) {
			throw new RuntimeException("账户禁用");
		}

		if (!dsUser.getBoolean("enabled_")) {
			throw new RuntimeException("用户尚未启用");
		}
		// 如果不是微信登录则验证密码
		if (!dsUser.getString("password_").equals(md5Password)) {
			throw new RuntimeException("密码错误");
		}
		
		return success();
	}

	public static void main(String[] args) {
		System.err.println(MD5.get("1507150630612345678"));
	}
}
