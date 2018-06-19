package com.huagu.jiFenAndSign.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 后台积分等级查询展示
 *  @author 王姣
 *  @date   2018年3月16日上午10:27:46
 *  @return
 */
public class SvrJiFenQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_ ,createTime_ ,updateTime_ ,levelID_ ,grade_ ,num_ ,remark_  from %s " ,appdb.IngetralLevel);
		sql.add("order by createTime_ desc ");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
