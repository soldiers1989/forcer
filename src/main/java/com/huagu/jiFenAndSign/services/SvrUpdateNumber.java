package com.huagu.jiFenAndSign.services;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 * 修改物流单号
 * @author wj  
 * @date 2018年5月18日 
 *
 */
public class SvrUpdateNumber extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_,orderId_ ,updateDate_,updateUser_, userId_,recLogisticsName_ ,recLogisticsId_ from t_order");
		sql.add("where orderId_ = '%s'" ,head.getString("orderId_"));
		sql.open();
		sql.edit();
		sql.setField("updateUser_", this.getUserCode());
		sql.setField("updateDate_", TDateTime.Now());
		sql.setField("recLogisticsId_", head.getString("recLogisticsId_"));
		sql.post();
		return this.success();
	}

}
