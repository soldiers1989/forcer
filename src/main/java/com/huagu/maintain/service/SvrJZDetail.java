package com.huagu.maintain.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrJZDetail extends AbstractService{

	//公益捐赠详情
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		String orderId_= headIn.getString("orderId_");
		String cabinetId_=headIn.getString("cabinetId_");
		SqlQuery sql = new SqlQuery(this);
		sql.add("SELECT a.orderDesc_,a.count_,d.name_,a.createTime_,a.shStatus_ ,b.boxId_,c.name_,c.address_,a.shouhuoTime_  FROM %s a ",appdb.ORDERDONATION);
		sql.add("left join %s b on a.boxId_ =b.boxId_",appdb.BOX);
		sql.add("left JOIN %s c on c.Id_ = b.cabId_ ",appdb.CABINET);
		sql.add("join %s d on d.code_ = a.userId_",appdb.S_Userinfo);
		sql.add("where c.Id_='%s'",cabinetId_);
		sql.add("and a.orderId_='%s'",orderId_);
		sql.open();
		if (!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
