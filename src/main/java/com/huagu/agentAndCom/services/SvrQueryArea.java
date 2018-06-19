package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/** 
 *  @describe 查询区
 *  @author 王姣
 *  @date   2018年4月2日下午6:02:38
 *  @return
 */
public class SvrQueryArea extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_ ,areaid_,province_,city_,area_,areaNum_,areaType_,remark_ from %s" ,appdb.Area);
		sql.add("where city_ = '%s'" ,head.getString("city_"));
		sql.add("and  area_  <>  '' and area_ is not null");
		sql.add("group by area_");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
