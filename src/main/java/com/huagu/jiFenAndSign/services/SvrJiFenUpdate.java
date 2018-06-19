package com.huagu.jiFenAndSign.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 后台积分修改
 *  @author 王姣
 *  @date   2018年3月16日下午2:15:49
 *  @return
 */
public class SvrJiFenUpdate extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_ ,updateTime_ ,num_ ,remark_ ,grade_ from %s " ,appdb.IngetralLevel);
		sql.add("where UID_ = '%s'" ,head.getString("UID_"));
		sql.open();
		sql.edit();
		sql.setField("updateTime_", TDateTime.Now());
		sql.setField("num_", head.getString("num_"));
		sql.setField("remark_", head.getString("remark_"));
		sql.setField("grade_", head.getString("grade_"));
		sql.post();
		return this.success();
	}

}
