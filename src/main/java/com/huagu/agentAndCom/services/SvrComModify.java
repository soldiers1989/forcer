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
 *  @describe 修改社区信息
 *  @author 王姣
 *  @date   2018年3月27日下午5:30:59
 *  @return
 */
public class SvrComModify extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String updateUser_  = this.getUserCode();
		if("".equals(updateUser_)){
			updateUser_ = "17620458925";
		}
		sql.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,communityName_,communityId_,communityNo_,headquarters_,provinceAgent_,");
		sql.add("communityJname_,wuYeJname_,wuYeName_,wuYePhone_,communityArea_,doorPlate_,address_,cityAgent_,areaAgent_  from %s" ,appdb.Community);
		sql.open();
		sql.edit();
		sql.setField("updateDate_", TDateTime.Now());
		sql.setField("updateUser_", updateUser_);
		sql.setField("communityName_", head.getString("communityName_"));
		sql.setField("communityJname_", head.getString("communityJname_"));
		sql.setField("wuYeJname_", head.getString("wuYeJname_"));
		sql.setField("wuYeName_", head.getString("wuYeName_"));
		sql.setField("wuYePhone_", head.getString("wuYePhone_"));
		sql.setField("communityArea_", head.getString("communityArea_"));
		sql.setField("doorPlate_", head.getString("doorPlate_"));
		sql.setField("address_", head.getString("address_"));
		sql.post();
		return this.success();
	}

}
