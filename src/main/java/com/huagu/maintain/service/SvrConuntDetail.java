package com.huagu.maintain.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrConuntDetail extends AbstractService{
	//查询公益捐赠信息
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		String cabinetId_= headIn.getString("cabinetId_");
		SqlQuery sql2 = new SqlQuery(this);
		sql2.add("SELECT  a.createTime_,d.name_,a.orderDesc_,a.orderId_,a.count_ FROM %s a",appdb.ORDERDONATION);
		sql2.add("JOIN  %s b on a.boxId_ =b.boxId_",appdb.BOX);
		sql2.add("JOIN t_cabinet c on c.Id_ = b.cabId_",appdb.CABINET);
		sql2.add("join %s d on d.code_ = a.userId_",appdb.S_Userinfo);
		sql2.add("where c.Id_ = '%s'",cabinetId_);
		sql2.open();
		if (!sql2.eof())
			dataOut.appendDataSet(sql2);
		return this.success();
	}

}
