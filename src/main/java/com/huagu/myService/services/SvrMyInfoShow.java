package com.huagu.myService.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 *  @describe 我的分享 得到我的信息
 *  @author 王姣
 *  @date   2018年4月8日下午4:07:35
 *  @return
 */
public class SvrMyInfoShow extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		String code_;
		if(getUserCode() != null){
			code_ = this.getUserCode();
		}else{
			code_ = "18827529536";
		}
		sql.add("select UID_ , code_,name_,imgUrl_ from %s" ,appdb.S_Userinfo);
		sql.add("where code_ = '%s'" ,code_);
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
