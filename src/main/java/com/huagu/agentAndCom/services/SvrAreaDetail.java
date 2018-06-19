package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 查看区域详情
 *  @author 王姣
 *  @date   2018年3月31日下午2:10:59
 *  @return
 */
public class SvrAreaDetail extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_ ,province_,city_,area_,areaNum_,areaType_,remark_ from %s" ,appdb.Area);
		sql.add("where UID_ = '%s'" ,head.getString("UID_"));
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
