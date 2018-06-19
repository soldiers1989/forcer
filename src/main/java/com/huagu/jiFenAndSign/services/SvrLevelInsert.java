package com.huagu.jiFenAndSign.services;

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
 *  @describe 添加积分等级
 *  @author 王姣
 *  @date   2018年4月10日下午4:51:16
 *  @return
 */
public class SvrLevelInsert extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String guid = utils.newGuid();
	      guid = guid.substring(1, guid.length() - 1);
	      guid = guid.replaceAll("-", "");
		String createUser_ ;
		if(getUserCode() != null){
			createUser_ = this.getUserCode();
		}else{
			createUser_ = "17620458925";
		}
		sql.add("select UID_ ,createTime_ ,createUser_ ,levelID_ ,grade_,num_ ,remark_ from %s" ,appdb.IngetralLevel);
		sql.open();
		sql.append();
		sql.setField("levelID_", guid);
		sql.setField("createUser_", createUser_);
		sql.setField("createTime_", TDateTime.Now());
		sql.setField("grade_", head.getString("grade_"));
		sql.setField("num_", head.getString("num_"));
		sql.setField("remark_", head.getString("remark_"));
		sql.post();
		return this.success();
	}

}
