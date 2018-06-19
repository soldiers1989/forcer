package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 *  @describe 查询国家
 *  @author 王姣
 *  @date   2018年3月31日上午11:25:23
 *  @return
 */
public class SvrAreaQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_ ,country_,areaid_,province_,city_,area_,areaNum_,areaType_,remark_ from %s" ,appdb.Area);
		sql.add("order by createDate_ desc");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
