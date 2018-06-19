package com.huagu.operate.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 查询异常上报单
 * 
 * @author xiaofei-pc
 *
 */
public class SvrGetOperateReported extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("SELECT UID_,createDate_,createUser_,updateDate_,updateUser_,ywNo_,reportedRen_,reportedTime_,reportedClient_,reportedInstructions_,reportedSuggest_,dealer_,status_ FROM %s",
				appdb.OPERATELEVY);
		ds.add("  WHERE 1=1");
		if(headIn.hasValue("ywNo_"))
			ds.add(" and ywNo_ like '%s'", '%' + headIn.getString("ywNo_") + '%');
		if(headIn.hasValue("mobile_"))
			ds.add(" and reportedRen_ like '%s'", '%' + headIn.getString("mobile_") + '%');
		if(headIn.hasValue("khmobile_"))
			ds.add(" and reportedClient_ like '%s'", '%' + headIn.getString("khmobile_") + '%');
		if(headIn.hasValue("time_"))
			ds.add(" and reportedTime_ like '%s'", '%' + headIn.getString("time_") + '%');
		if(!"----请选择----".equals(headIn.getSafeString("status_"))){
			if(headIn.hasValue("status_"))
				ds.add(" and status_ like '%s'", '%' + headIn.getString("status_") + '%');
		}
		ds.open();
		if (!ds.eof()) {
			dataOut.appendDataSet(ds);
		}
		return success();
	}

}
