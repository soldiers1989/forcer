package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 
 *  @describe 拿到要修改的社区数据
 *  @author 王姣
 *  @date   2018年3月27日下午5:27:35
 *  @return
 */
public class SvrGetComById extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,communityName_,communityId_,communityNo_,headquarters_,provinceAgent_,");
		sql.add("communityJname_,wuYeJname_,wuYeName_,wuYePhone_,communityArea_,doorPlate_,address_,cityAgent_,areaAgent_  from %s" ,appdb.Community);
		sql.add("where communityId_ = '%s'" ,head.getString("communityId_"));
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
