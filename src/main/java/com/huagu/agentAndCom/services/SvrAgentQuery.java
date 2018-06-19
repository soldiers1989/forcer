package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 代理商列表（后台）
 *  @author 王姣 
 *  @date   2018年3月23日上午9:02:38
 *  @return
 */
public class SvrAgentQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String agentJname_ = head.getString("agentJname_");
		sql.add("select UID_ , createDate_,updateDate_ ,updateUser_ ,agentId_,agentNum_ ,agentNo_ ,agentJname_ ,agentName_ ,agentLevel_ ,agentArea_  from %s" ,appdb.Agent);
		sql.add("where 1 = 1");
		if(agentJname_ != null && agentJname_ != ""){
			sql.add("and agentJname_ like '%s'" , new String("%"+agentJname_+"%"));
		}
		sql.add("order by createDate_ desc");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
