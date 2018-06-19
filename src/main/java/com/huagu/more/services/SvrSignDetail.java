package com.huagu.more.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 *  @describe 拿到要编辑的签到说明数据
 *  @author 王姣
 *  @date   2018年4月4日上午9:59:40
 *  @return
 */
public class SvrSignDetail extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_ ,remark_  from %s where UID_ = '%s'" ,appdb.Sign,head.getString("UID_"));
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
