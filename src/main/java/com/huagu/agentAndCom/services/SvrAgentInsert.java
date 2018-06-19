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
 *  @describe  添加省级代理
 *  @author 王姣
 *  @date   2018年3月23日下午5:15:07
 *  @return
 */
public class SvrAgentInsert extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		try(Transaction tx = new Transaction(this)) {  
		Record head = dataIn.getHead();
		//通过区域拿到区域ID
		SqlQuery sql3 = new SqlQuery(this);
		sql3.add("select UID_ ,areaid_,province_,city_,area_,areaNum_,areaType_,remark_ from %s" ,appdb.Area);
		sql3.add("where area_ = '%s'" ,head.getString("area_"));
		sql3.open();
		
		
		//通过区域ID拿到社区ID
		SqlQuery sql1 = new SqlQuery(this);
		sql1.add("select UID_ ,communityId_ ,areaid_ from %s" ,appdb.Community);
		sql1.add("where areaid_ = '%s'" ,sql3.getField("areaid_"));
		sql1.open();
		
	 
		SqlQuery sql = new SqlQuery(this);
		String createUser_;
		String province_ = head.getString("province_");
		String city_ = head.getString("city_");
		String area_ = head.getString("area_");
		if(getUserCode() != null){
			createUser_ = this.getUserCode();
		}else{
			createUser_ = "17620458925";
		}
		String guid = utils.newGuid();
	      guid = guid.substring(1, guid.length() - 1);
	      guid = guid.replaceAll("-", "");
		sql.add("select UID_ , createDate_,agentId_,createUser_,agentNum_ ,agentNo_ ,agentJname_ ,agentName_ ,agentLevel_ ,agentArea_  from %s order by agentNum_ desc" ,appdb.Agent);
		sql.open();
		int lastAgentNum = 0;
		if (sql.eof()) {
			lastAgentNum ++;
		} else {
			lastAgentNum = sql.getCurrent().getInt("agentNum_") + 1;
		}
		sql.append();
		sql.setField("createDate_", TDateTime.Now());
		sql.setField("createUser_", createUser_);
		sql.setField("agentNum_", lastAgentNum);
		sql.setField("agentId_",guid);
		sql.setField("agentNo_", head.getString("agentNo_"));
		sql.setField("agentJname_", head.getString("agentJname_"));
		sql.setField("agentName_", head.getString("agentName_"));
		sql.setField("agentLevel_", head.getString("agentLevel_"));
		sql.setField("agentArea_", province_ +"-"+ city_+"-" + area_);
		sql.post();
		
		//往中间表添加数据
		SqlQuery sql2 = new SqlQuery(this);
		sql2.add("select UID_ ,createDate_ ,createUser_ ,agentId_ ,communityId_ from %s" ,appdb.AgentCom);
		sql2.open();
		sql2.append();
		sql2.setField("createDate_", TDateTime.Now());
		sql2.setField("createUser_", createUser_);
		sql2.setField("agentId_", guid);
		sql2.setField("communityId_", sql1.getField("communityId_"));
		sql2.post();
		
		tx.commit();  
		}
		return this.success();
	}

}
