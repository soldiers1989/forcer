package com.huagu.maintain.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrHistoryList extends AbstractService{
	//查询历史收货信息
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		String userCode = this.getUserCode();
		if ("".equals(userCode)) {
			userCode = "13277031262";
		}
		SqlQuery sql = new SqlQuery(this);
		sql.add("select userId_,maintainPhone_,shouhuoTime_,a.boxId_,d.name_,c.id_,c.address_,a.orderId_ from t_orderdonation a ",appdb.ORDERDONATION);
		sql.add("join %s b on a.boxId_=b.boxId_",appdb.BOX);
		sql.add("join %s c on b.cabId_ = c.id_",appdb.CABINET);
		sql.add("join %s d on a.maintainPhone_= d.code_",appdb.S_Userinfo);
		sql.add("where a.shStatus_= '0' and a.maintainPhone_ = '%s'",userCode);
		sql.open();
		if (!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
