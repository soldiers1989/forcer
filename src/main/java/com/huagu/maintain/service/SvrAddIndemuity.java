package com.huagu.maintain.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.mysql.Transaction;
import groovy.sql.Sql;

/**
 *  转赔付
 * @author wj  
 * @date 2018年6月6日 
 *
 */
public class SvrAddIndemuity extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record head = dataIn.getHead();
		SqlQuery sql1 = new SqlQuery(this);
		try (Transaction tx = new Transaction(this)) {
			sql1.add("select UID_ , createUser_,createDate_,payDesc_,payImg_,orderId_ , payState_ from %s" ,appdb.Pay);
			sql1.open();
			sql1.append();
			sql1.setField("createUser_", this.getUserCode());
			sql1.setField("createDate_", TDateTime.Now());
			sql1.setField("payDesc_", head.getString("payDesc_"));
			sql1.setField("payImg_", head.getString("path"));
			sql1.setField("orderId_", head.getString("orderId_"));
			sql1.setField("payState_", 2);
			sql1.post();
			
			
			SqlQuery sql = new SqlQuery(this);
			sql.add("select  UID_, orderState_ , orderId_ from t_order" ,appdb.T_ORDER);
			sql.add("where orderId_ = '%s'" ,head.getString("orderId_") );
			sql.open();
			sql.edit();
			sql.setField("orderState_", 11);
			sql.post();
			
			tx.commit();
		 }
		return this.success();
	}

}
