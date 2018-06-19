package com.huagu.myService.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 *  @describe 得到分享人
 *  @author 王姣
 *  @date   2018年4月8日下午4:37:35
 *  @return
 */
public class SvrMyShareQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		String  userCode_ ;
		if(getUserCode() != null){
			userCode_ = this.getUserCode();
		}else{
			userCode_ = "18827529536";
		}
		
		sql.add("select u.UID_ , u.code_, u.name_, u.imgUrl_,i.createTime_ ,i.integral_");
		sql.add("from %s  u join %s i" ,appdb.S_Userinfo,appdb.Integral);
		sql.add("on i.userId_ = u.code_");
		sql.add("where  i.userCode_ = '%s'" ,userCode_);
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
