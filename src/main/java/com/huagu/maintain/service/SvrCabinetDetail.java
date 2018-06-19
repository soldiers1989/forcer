package com.huagu.maintain.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrCabinetDetail extends AbstractService{

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		//查询捐赠动态总数
		Record headIn = dataIn.getHead();
		String cabinetId_= headIn.getString("cabinetId_");
		SqlQuery sql = new SqlQuery(this);
		sql.add("SELECT count(a.UID_) count FROM %s a",appdb.ORDERDONATION);
		sql.add("JOIN  %s b on a.boxId_ =b.boxId_",appdb.BOX);
		sql.add("JOIN t_cabinet c on c.Id_ = b.cabId_",appdb.CABINET);
		sql.add("where c.Id_ = '%s'",cabinetId_);
		sql.open();
		if (!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
