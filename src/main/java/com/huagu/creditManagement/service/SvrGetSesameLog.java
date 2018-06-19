package com.huagu.creditManagement.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * @describe 查询芝麻信用认证历史记录
 * @date 2018年3月21日
 * @return
 */
public class SvrGetSesameLog extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		String userCode_ = this.getUserCode();
		if("".equals(userCode_))
			userCode_ = "15071506306";
		
		SqlQuery sql = new SqlQuery(this);
		if("in".equals(headIn.getSafeString("type_"))){
			sql.add("SELECT UID_,createDate_,createUser_,count_,name_,idCard_,sqStatus_,rzStatus_,sesameFen_ FROM %s", appdb.SESAMELOG);
			sql.add(" where 1=1 ");
			sql.add(" AND createUser_ = '%s'", userCode_);
			sql.setMaximum(1);
			sql.open();
			if(sql.eof()){
				sql.append();
				sql.setField("createDate_", TDateTime.Now());
				sql.setField("createUser_", userCode_);
				sql.setField("count_", 1);
				sql.setField("name_", headIn.getSafeString("name_"));
				sql.setField("idCard_", headIn.getSafeString("certNo_"));
				sql.setField("sqStatus_", headIn.getSafeString("sqStatus_"));
				sql.setField("rzStatus_", headIn.getSafeString("rzStatus_"));
				sql.post();
			}else{
				int counts = sql.getInt("count_") + 1;
				sql.edit();
				sql.setField("createDate_", TDateTime.Now());
				sql.setField("createUser_", userCode_);
				sql.setField("count_", counts);
				sql.setField("name_",  headIn.getSafeString("name_"));
				sql.setField("idCard_", headIn.getSafeString("certNo_"));
				sql.setField("sqStatus_", headIn.getSafeString("sqStatus_"));
				sql.setField("rzStatus_", headIn.getSafeString("rzStatus_"));
				sql.post();
			}
		}else if("up".equals(headIn.getSafeString("type_"))){
			// 认证成功 修改记录表
			sql.add("SELECT UID_,createDate_,createUser_,count_,name_,idCard_,sqStatus_,rzStatus_,sesameFen_ FROM %s", appdb.SESAMELOG);
			sql.add(" where 1=1 ");
			sql.add(" AND createUser_ = '%s'", userCode_);
			sql.setMaximum(1);
			sql.open();
			sql.edit();
			sql.setField("createDate_", TDateTime.Now());
			sql.setField("createUser_", userCode_);
			sql.setField("name_",  headIn.getSafeString("name_"));
			sql.setField("idCard_", headIn.getSafeString("certNo_"));
			sql.setField("sqStatus_", headIn.getSafeString("sqStatus_"));
			sql.setField("rzStatus_", headIn.getSafeString("rzStatus_"));
			sql.setField("sesameFen_", headIn.getSafeString("fraction"));
			sql.post();
		}else if("sel".equals(headIn.getSafeString("type_"))){
			// 查询单个用户
			sql.add("SELECT UID_,createDate_,createUser_,count_,name_,idCard_,sqStatus_,rzStatus_,sesameFen_ FROM %s", appdb.SESAMELOG);
			sql.add(" where 1=1 ");
			sql.add(" AND createUser_ = '%s'",  headIn.getString("code_"));
			sql.setMaximum(1);
			sql.open();
			if(!sql.eof())
				dataOut.appendDataSet(sql);
		}else{
			// 查询所有用户
			sql.add("SELECT UID_,createDate_,createUser_,count_,name_, ");
			sql.add("idCard_,case sqStatus_ when 1 then '已授权' when 0 then '未授权' end sqStatus_,");
			sql.add("case rzStatus_ when 1 then '已认证' when 0 then '未认证' end rzStatus_,sesameFen_ FROM %s", appdb.SESAMELOG);
			sql.add(" where 1=1 ");
			sql.open();
			if(!sql.eof())
				dataOut.appendDataSet(sql);
		}
		sql.close();
		return this.success();
	}

}
