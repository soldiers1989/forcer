package com.huagu.donation.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 修改捐赠说明
 *  @author 王姣
 *  @date   2018年3月14日下午6:55:32
 *  @return
 */
public class SvrExceplainUpdate extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_ ,updateDate_ ,explain_  from %s" ,appdb.Donation);
		sql.open();
		sql.edit();
		sql.setField("updateDate_", TDateTime.Now());
		sql.setField("explain_", head.getString("explain_"));
		sql.post();
		return this.success();
	}

}
