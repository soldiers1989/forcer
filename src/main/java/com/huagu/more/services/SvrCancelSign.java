package com.huagu.more.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 取消签到
 *  @author 王姣
 *  @date   2018年3月9日下午3:50:45
 *  @return
 */
public class SvrCancelSign extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		String userCode = this.getUserCode();
		if("".equals(userCode)){
			 userCode = "17620458925";
		}
		
		//删除签到表数据
		SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_ ,createTime_ ,userCode_ from %s" ,appdb.Sign);
		sql.add("where userCode_ = '%s'" , userCode);
		sql.open();
		sql.delete();
		
		//删除积分表数据
		SqlQuery sql1 = new SqlQuery(this);
		sql1.add("select UID_ , integral_ ,grade_ ,userCode_  from  %s" ,appdb.Integral);
		sql1.add("where userCode_ = '%s'", userCode);
		sql1.open();
		sql1.delete();
		return this.success();
	}

}
