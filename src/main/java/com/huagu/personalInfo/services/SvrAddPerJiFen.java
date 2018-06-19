package com.huagu.personalInfo.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrAddPerJiFen extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql1 = new SqlQuery(this);
		Record headIn = dataIn.getHead();
		sql1.add("select u.UID_ , u.code_, u.name_, u.imgUrl_,i.createTime_ ,i.integral_ ,i.userId_,u.createTime_");
		sql1.add("from  s_userinfo  u join  t_integral  i on i.userCode_ = u.code_ ");
		sql1.add("where i.type_= '1' and i.userCode_ = '%s'" ,headIn.getString("userCode_"));
		sql1.open();
		
		
		SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_,updateUser_,updateTime_,integral_ from %s" ,appdb.Integral);
		sql.open();
		sql.edit();
		sql.setField("updateUser_", this.getUserCode());
		sql.setField("updateTime_", TDateTime.Now());
		sql.setField("integral_", sql1.getInt("integral_")+10);
		sql.post();
		return this.success();
	}

}
