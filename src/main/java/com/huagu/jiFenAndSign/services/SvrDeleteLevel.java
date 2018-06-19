package com.huagu.jiFenAndSign.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 删除积分等级
 *  @author 王姣
 *  @date   2018年4月10日下午5:42:54
 *  @return
 */
public class SvrDeleteLevel extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_ ,createTime_ ,updateTime_ ,levelID_ ,grade_ ,num_ ,remark_  from %s " ,appdb.IngetralLevel);
		sql.add("where levelID_ = '%s'" ,head.getString("levelID_"));
		sql.open();
		sql.delete();
		return this.success();
	}

}
