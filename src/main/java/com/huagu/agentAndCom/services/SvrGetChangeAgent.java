package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 拿到要变更的代理商的社区管辖信息
 *  @author 王姣
 *  @date   2018年3月29日上午11:01:20
 *  @return
 */
public class SvrGetChangeAgent extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_ , createDate_,updateDate_ ,agentId_,updateUser_ ,agentNum_ ,agentNo_ ,agentJname_ ,agentName_ ,agentLevel_ ,agentArea_  from %s" ,appdb.Agent);
		sql.add("where agentId_ = '%s'" ,head.getString("agentId_"));
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
