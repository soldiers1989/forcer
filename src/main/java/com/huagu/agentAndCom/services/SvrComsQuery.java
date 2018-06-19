package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 查询代理商管辖社区
 *  @author 王姣
 *  @date   2018年3月30日下午4:30:49
 *  @return
 */
public class SvrComsQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select a.UID_ ,a.createDate_,a.agentJname_ ,a.agentArea_ , a.agentId_,a.agentLevel_,");
		sql.add("c.communityNo_ ,c.communityJname_ ,c.wuYeJname_ ,c.address_ ,c.wuYeName_ ,c.wuYePhone_ ,c.communityArea_ ,c.doorPlate_");
		sql.add("from %s a join %s ac " ,appdb.Agent,appdb.AgentCom);
		sql.add("on a.agentId_ = ac.agentId_");
		sql.add("join %s c" ,appdb.Community);
		sql.add("on ac.communityId_ = c.communityId_");
		sql.add("where  ac.agentId_  = '%s' " ,head.getString("agentId_"));
		sql.add("order by a.createDate_ desc");
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);
		}
		return this.success();
	}

}
