package com.huagu.my.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/****
 * 
 * 订单优惠金额
 * @author wj  
 * @date 2018年6月11日 
 *
 */
public class SvrSesameQuery extends CustomService {
	
	/***
	 *  查询芝麻信用分
	 *  @author wj    
	 *  @date 2018年6月11日
	 */
	public boolean sesameQuery() throws Exception {
		SqlQuery sql = new SqlQuery(this);
		sql.add("select * from %s" ,appdb.S_Userinfo);
		sql.add("where code_ = '%s'" ,this.getUserCode());
		sql.open();
		
		SqlQuery sqlSesame = new SqlQuery(this);
		sqlSesame.add("SELECT UID_,createDate_,createUser_,count_,name_,  idCard_,case sqStatus_ when 1 then '已授权' when 0 then '未授权' end sqStatus_, case rzStatus_ when 1 then '已认证' when 0 then '未认证' end rzStatus_,sesameFen_ FROM %s  where 1=1" ,appdb.SESAMELOG);
		sqlSesame.add("and idCard_ = '%s'", sql.getField("cardId_"));
		sqlSesame.open();
		if(!sqlSesame.eof())
			dataOut.appendDataSet(sqlSesame);
		return true;
	}
	
	
}
