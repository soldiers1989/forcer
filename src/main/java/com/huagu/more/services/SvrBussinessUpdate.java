package com.huagu.more.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 修改商务合作信息（后台）
 *  @author 王姣
 *  @date   2018年3月21日上午10:38:47
 *  @return
 */
public class SvrBussinessUpdate extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_ ,content_ ,updateTime_  from %s" ,appdb.Busperation);
		sql.open();
		sql.edit();
		sql.setField("updateTime_", TDateTime.Now());
		sql.setField("content_", head.getString("content_"));
		sql.post();
		return this.success();
	}

}
