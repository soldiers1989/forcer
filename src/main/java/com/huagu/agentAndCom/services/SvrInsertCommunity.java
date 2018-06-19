package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.mysql.Transaction;
import cn.cerc.jdb.other.utils;

/**
 *  @describe  添加社区信息
 *  @author 王姣
 *  @date   2018年3月26日下午3:29:31
 *  @return
 */
public class SvrInsertCommunity extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record head = dataIn.getHead();
		
		//拿到区域id
		SqlQuery sql1 = new SqlQuery(this);
		sql1.add("select UID_ ,areaid_,province_,city_,area_,areaNum_,areaType_,remark_ from %s" ,appdb.Area);
		sql1.add("where area_ = '%s'" ,head.getString("area_"));
		sql1.open();
		
		try (Transaction tx = new Transaction(this)) {
		SqlQuery sql = new SqlQuery(this);
		String createUser_;
		if(getUserCode() != null){
			createUser_ = this.getUserCode();
		}else{
			createUser_ = "17620458925";
		}
		String guid = utils.newGuid();
	      guid = guid.substring(1, guid.length() - 1);
	      guid = guid.replaceAll("-", "");
		sql.add("select UID_,areaid_,createDate_,createUser_,updateDate_,updateUser_,communityName_,communityId_,communityNo_,headquarters_,provinceAgent_,");
		sql.add("communityJname_,wuYeJname_,wuYeName_,wuYePhone_,communityArea_,doorPlate_,address_,cityAgent_,areaAgent_  from %s" ,appdb.Community);
		sql.add("order by communityNo_ desc");
		sql.open();
		int lastComNo = 0;
		if(sql.eof()){
			lastComNo ++;
		}else{
			lastComNo = sql.getCurrent().getInt("communityNo_")+1;
		}
		sql.append();
		sql.setField("createDate_", TDateTime.Now());
		sql.setField("communityId_", guid);
		sql.setField("createUser_", createUser_);
		sql.setField("communityNo_", lastComNo);
		sql.setField("areaid_", sql1.getField("areaid_"));
		sql.setField("communityName_", head.getString("communityName_"));
		sql.setField("communityJname_", head.getString("communityJname_"));
		sql.setField("wuYeJname_", head.getString("wuYeJname_"));
		sql.setField("wuYeName_", head.getString("wuYeName_"));
		sql.setField("wuYePhone_", head.getString("wuYePhone_"));
		sql.setField("communityArea_", head.getString("communityArea_"));
		sql.setField("doorPlate_", head.getString("doorPlate_"));
		sql.setField("address_",  head.getString("address_"));
		sql.post();
		 tx.commit();
		}
		return this.success();
	}

}
