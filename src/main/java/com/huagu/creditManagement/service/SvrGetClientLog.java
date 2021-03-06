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
 * @describe 查询后台客户认证资料
 * @date 2018年3月21日
 * @return
 */
public class SvrGetClientLog extends AbstractService {

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
			// 查询所有用户
			sql.add("SELECT UID_,createDate_,userCode_,source_,attributes_,dataRen_,status_ FROM %s", appdb.CLIENTCERTIFIED);
			sql.add(" where 1=1 ");
			sql.add(" AND UID_ = '%s'", headIn.getString("id_"));
			sql.setMaximum(1);
			sql.open();
			sql.edit();
			if("有效".equals(headIn.getString("status_")))
				sql.setField("status_",  "2");
			if("失效".equals(headIn.getString("status_")))
				sql.setField("status_",  "1");
			sql.post();
		}else if("del".equals(headIn.getSafeString("type_"))){
			// 删除
			sql.add("SELECT UID_,createDate_,userCode_,source_,attributes_,dataRen_,case status_ when 1 then '有效' when 2 then '失效' end status_ FROM %s", appdb.CLIENTCERTIFIED);
			sql.add(" where 1=1 ");
			sql.add(" AND UID_ = '%s'", headIn.getString("id_"));
			sql.setMaximum(1);
			sql.open();
			if(!sql.eof()){
				sql.delete();
				sql.post();
			}
		}else{
			// 查询所有用户
			sql.add("SELECT UID_,createDate_,userCode_,source_,attributes_,dataRen_,case status_ when 1 then '有效' when 2 then '失效' end status_ FROM %s", appdb.CLIENTCERTIFIED);
			sql.add(" where 1=1 ");
			if(headIn.hasValue(""))
				sql.add(" AND userCode_ LIKE '%s'", '%' +headIn.getString("mobile_")+ '%');
			if(headIn.hasValue(""))
				sql.add(" AND status_ LIKE '%s'", '%' +headIn.getString("status_")+ '%');
			sql.open();
			if(!sql.eof())
				dataOut.appendDataSet(sql);
		}
		sql.close();
		return this.success();
	}

}
