package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 删除挂靠代理
 *  @author 王姣 
 *  @date   2018年3月28日下午2:35:02
 *  @return
 */
public class SvrDeleteComAgent extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record head = dataIn.getHead();
		/*SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,communityName_,communityId_,communityNo_,headquarters_,provinceAgent_,");
		sql.add("communityJname_,wuYeJname_,wuYeName_,wuYePhone_,communityArea_,doorPlate_,address_,cityAgent_,areaAgent_  from %s" ,appdb.Community);
		sql.add("where communityId_ = '%s'" ,head.getString("communityId_"));
		sql.open();*/
		
		
		SqlQuery sql1 = new SqlQuery(this);
		sql1.add("select UID_ ,communityId_ ,agentId_  from %s " ,appdb.AgentCom);
		sql1.add("where agentId_ = '%s'" ,head.getString("agentId_"));
		sql1.open();
		sql1.delete();
		return this.success();
	}

}
