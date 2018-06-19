package com.huagu.myService.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 *  @describe 我的邀请总人数
 *  @author 王姣
 *  @date   2018年4月8日下午4:21:41
 *  @return
 */
public class SvrMyShare extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		String userCode_ ;
		if(getUserCode() != null){
			userCode_ = this.getUserCode();
		}else{
			userCode_ = "18827529536";
		}
		sql.add("select count(userCode_ ) as shareNum from %s" ,appdb.Integral);
		sql.add("where userCode_ = '%s' and type_ = '1'" ,userCode_);
		sql.open();
		if(!sql.eof())
			dataOut.getHead().setField("shareNum" ,sql.getCurrent().getField("shareNum"));
		return this.success();
	}

}
