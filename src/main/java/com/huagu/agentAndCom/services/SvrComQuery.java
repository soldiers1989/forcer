package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/***
 *  @describe 社区列表查询
 *  @author 王姣
 *  @date   2018年3月26日上午11:49:08
 *  @return
 */
public class SvrComQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		/*sql.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,communityName_,communityId_,communityNo_,headquarters_,provinceAgent_,");
		sql.add("communityJname_,wuYeJname_,wuYeName_,wuYePhone_,communityArea_,doorPlate_,address_,cityAgent_,areaAgent_  from %s" ,appdb.Community);
		*/
		Record head = dataIn.getHead();
		String communityJname_ = head.getString("communityJname_");
		sql.add("select c.UID_ , a.agentId_,a.agentNum_ ,a.agentNo_ ,a.agentJname_ ,a.agentName_ ,a.agentLevel_ ,a.agentArea_  ,c.communityName_,c.communityId_,");
		sql.add("c.communityNo_,c.communityJname_,c.wuYeJname_,c.wuYeName_,c.wuYePhone_,c.communityArea_,c.doorPlate_,c.address_ ");
		sql.add("from  %s c left join %s ac on c.communityId_ = ac.communityId_" ,appdb.Community,appdb.AgentCom);
		sql.add("left join %s a on a.agentId_ = ac.agentId_ " ,appdb.Agent);
		if(communityJname_ != null && communityJname_ != ""){
			sql.add("where c.communityJname_ like '%s'" ,new String("%"+communityJname_+"%"));
		}
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
