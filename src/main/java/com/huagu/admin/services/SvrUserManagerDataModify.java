package com.huagu.admin.services;

import java.util.UUID;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jbean.other.SystemTable;
import cn.cerc.jbean.tools.MD5;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrUserManagerDataModify extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		// 新增管理员密码默认为6个8
		Record headIn = dataIn.getHead();

		SqlQuery ds = new SqlQuery(this);
		ds.add("select * from %s", SystemTable.get(SystemTable.getUserInfo));
		ds.add("where 1=1");
		ds.add("and name_ = '%s'", headIn.getSafeString("name_"));
		ds.open();
		if (ds.eof()) {
			ds.append();
			ds.setField("createTime_", TDateTime.Now());
			ds.setField("createUser_", this.getUserCode());
			ds.setField("id_", UUID.randomUUID().toString());
			ds.setField("password_", MD5.get(headIn.getSafeString("name_")+"888888"));
		} else {
			ds.edit();
			ds.setField("updateTime_", TDateTime.Now());
			ds.setField("updateUser_", this.getUserCode());
		}
		ds.setField("name_", headIn.getSafeString("userName_"));
		ds.setField("mobile_", headIn.getSafeString("mobile_"));
		ds.setField("remark_", headIn.getSafeString("mark_"));
		ds.setField("roleCode_", headIn.getSafeString("roleCode_"));
		ds.setField("idCard_", headIn.getSafeString("idCard_"));
		ds.setField("isManager_", 1);
		ds.setField("code_", headIn.getSafeString("name_"));
		ds.setField("enabled_", headIn.getBoolean("enabled_"));
		ds.setField("corpNo_", "727000");
		ds.post();
		dataOut.appendDataSet(ds);
		return success();
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}
	
	public static void main(String[] args) {
		System.out.println(MD5.get("李建春561611111111"));
	}
}
