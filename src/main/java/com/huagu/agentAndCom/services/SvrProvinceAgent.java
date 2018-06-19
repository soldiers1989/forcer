package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.other.utils;

/**
 *  @describe  添加省级代理
 *  @author 王姣
 *  @date   2018年3月31日上午10:29:38
 *  @return
 */
public class SvrProvinceAgent extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record head = dataIn.getHead();
		//查询当前社区
		SqlQuery sqlCom = new SqlQuery(this);
		sqlCom.add("select UID_ ,communityId_  from %s " ,appdb.Community);
		sqlCom.add("where communityId_ = '%s'" ,head.getString("communityId_"));
		sqlCom.open();
		
		
		SqlQuery sql = new SqlQuery(this);
		String guid = utils.newGuid();
	      guid = guid.substring(1, guid.length() - 1);
	      guid = guid.replaceAll("-", "");
	    String createUser_;
	    if(getUserCode() != null){
	    	createUser_ = this.getUserCode();
	    }else{
	    	createUser_ = "17620458925";
	    }
	    int agentNum_ = 0;
	    if(sql.eof()){
	    	agentNum_ ++;
	    }else{
	    	agentNum_ = sql.getCurrent().getInt("agentNum_")+1;
	    }
		sql.add("select UID_ ,agentId_ ,createDate_,createUser_,agentNum_,agentNo_ ,agentJname_ ,agentName_ ,agentLevel_ ,agentArea_  from %s " ,appdb.Agent);
		sql.open();
		sql.append();
		sql.setField("agentId_", guid);
		sql.setField("createUser_", createUser_);
		sql.setField("createDate_", TDateTime.Now());
		sql.setField("agentNum_", agentNum_);
		sql.setField("agentNo_", head.getString("agentNo_"));
		sql.setField("agentJname_", head.getString("agentJname_"));
		sql.setField("agentName_", head.getString("agentName_"));
		sql.setField("agentArea_", head.getString("agentArea_"));
		sql.post();
		return this.success();
	}

}
