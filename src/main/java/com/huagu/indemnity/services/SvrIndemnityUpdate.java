package com.huagu.indemnity.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 * 修改赔付单信息
 * @author wj  
 * @date 2018年5月10日 
 *
 */
public class SvrIndemnityUpdate extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this); 
		Record head = dataIn.getHead();
		sql.add("select UID_,updateDate_,updateUser_,orderId_,payID_,userId_,successMoney_,suggestMoney_,payReason_,suggest_,payDesc_ ,payRemark_ ");
		sql.add("from  %s where orderId_ = '%s'  " ,appdb.T_ORDER ,head.getString("orderId_"));
		sql.open();
		sql.edit();
		sql.setField("updateDate_", TDateTime.Now());
		sql.setField("updateUser_", this.getUserCode());
		sql.setField("payReason_", head.getString("payReason_"));
		sql.setField("successMoney_", head.getString("successMoney_"));
		sql.setField("suggestMoney_", head.getString("suggestMoney_"));
		sql.setField("suggest_", head.getString("suggest_"));
		sql.setField("payDesc_", head.getString("payDesc_"));
		sql.setField("payRemark_", head.getString("payRemark_"));
		sql.post();
		return this.success();
	}

}
