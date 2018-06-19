package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 变更的代理商的社区管辖信息
 *  @author 王姣
 *  @date   2018年3月29日上午11:09:42
 *  @return
 */
public class SvrChangeAgent extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		String updateUser_ ;
		if(getUserCode() != null ){
			updateUser_ = this.getUserCode();
		}else{
			updateUser_= "17620458925";
		}
		
		sql.add("select UID_ , createDate_,updateDate_ ,agentId_,updateUser_ ,agentNum_ ,agentNo_ ,agentJname_ ,agentName_ ,agentLevel_ ,agentArea_  from %s" ,appdb.Agent);
		sql.add("where agentId_ = '%s'" ,head.getString("agentId_"));
		sql.open();
		sql.edit();
		sql.setField("updateDate_", TDateTime.Now());
		sql.setField("updateUser_", updateUser_);
		sql.setField("agentNo_", head.getString("agentNo_"));
		sql.setField("agentJname_", head.getString("agentJname_"));
		sql.setField("agentName_", head.getString("agentName_"));
		sql.post();
		return this.success();
	}

}
