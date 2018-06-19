package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 删除代理商信息
 *  @author 王姣
 *  @date   2018年3月23日下午5:40:14
 *  @return
 */
public class SvrAgentDelete extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_ , createDate_,updateDate_ ,updateUser_ ,agentNum_ ,agentNo_ ,agentJname_ ,agentName_ ,agentLevel_ ,agentArea_  from %s" ,appdb.Agent);
		sql.add("where UID_ = '%s'" ,head.getString("UID_"));
		sql.open();
		sql.delete();
		return this.success();
	}

}
