package com.huagu.maintain.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * @describe 查询配置柜组信息柜组
 * @date 2018年3月21日
 * @return
 */
public class SvrGetCabinetBox extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		String id_= headIn.getString("id_");
		if(id_ == null || id_ == ""){
			id_ = "11111111111";
		}

		SqlQuery sql = new SqlQuery(this);
		sql.add("SELECT cabId_,boxId_,boxName_ FROM %s", appdb.BOX);
		sql.add(" WHERE cabId_ = '%s'", id_);
		sql.open();
		if (!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
