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
 *  @describe 变更社区代理挂靠
 *  @author 王姣
 *  @date   2018年3月28日上午10:58:38
 *  @return
 */
public class SvrChangeCom extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		String updateUser_;
		if(getUserCode() != null){
			updateUser_ = this.getUserCode();
		}else{
			updateUser_ = "17620458925";
		}
		Record head = dataIn.getHead();
		sql.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,communityName_,communityId_,communityNo_,headquarters_,provinceAgent_,");
		sql.add("communityJname_,wuYeJname_,wuYeName_,wuYePhone_,communityArea_,doorPlate_,address_,cityAgent_,areaAgent_  from %s" ,appdb.Community);
		sql.add("where communityId_ = '%s'" ,head.getString("communityId_"));
		sql.open();
		sql.edit();
		sql.setField("updateDate_", TDateTime.Now());
		sql.setField("updateUser_", updateUser_);
		sql.setField("communityJname_", head.getString("communityJname_"));
		sql.setField("wuYeJname_", head.getString("wuYeJname_"));
		sql.setField("address_", head.getString("address_"));
		sql.post();
		return this.success();
	}

}
