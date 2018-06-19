package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
import groovy.sql.Sql;

/**
 *  得到代理商所属区域
 * @author wj  
 * @date 2018年5月16日 
 *
 */
public class SvrGetAgentArea extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record head = dataIn.getHead();
		//通过agentId_拿到communityId_
		SqlQuery sql1 = new SqlQuery(this);
		sql1.add("select a.UID_  ,adc.UID_ , adc.communityId_ , a.agentId_  from %s a" ,appdb.Agent);
		sql1.add("left join %s  adc on a.agentId_ = adc.agentId_ " ,appdb.AgentCom);
		sql1.add("where a.agentId_ = '%s'" ,head.getString("agentId_"));
		sql1.open();
		
	/*	//通过communityId_拿到areaid_
		SqlQuery sql = new SqlQuery(this);
		sql.add("select ct.UID_ ,ct.communityId_ ,ct.areaid_ from t_community  ct");
		sql.add("join t_agentcom c  on  ct.communityId_ = c.communityId_");
		sql.add("where c.communityId_ = '%s'" ,sql1.getField("communityId_"));
		sql.open();*/
		
		//通过communityId_拿到areaid_
		SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_ ,communityId_ ,areaid_ from %s " ,appdb.Community);
		sql.add("where communityId_ = '%s'", sql1.getField("communityId_"));
		sql.open();
		
		//通过areaid_拿到省市区
		SqlQuery  sql2 = new SqlQuery(this);
		sql2.add("select UID_, areaid_,province_,city_,area_  from t_area" ,appdb.Area);
		sql2.add("where areaid_ = '%s'" ,sql.getField("areaid_"));
		sql2.open();
		
		if(!sql2.eof())
			dataOut.appendDataSet(sql2);
		return this.success();
	}

}
