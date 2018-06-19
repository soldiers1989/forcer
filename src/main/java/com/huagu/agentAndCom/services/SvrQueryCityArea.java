package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/** 
 *  @describe 查询市
 *  @author 王姣
 *  @date   2018年4月2日下午5:30:40
 *  @return
 */
public class SvrQueryCityArea extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_ ,areaid_,province_,city_,area_,areaNum_,areaType_,remark_ from %s" ,appdb.Area);
		sql.add("where province_ = '%s' " ,head.getString("province_"));
		sql.add("and  city_  <>  '' and city_ is not null");
		sql.add("group by city_");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
