package com.huagu.indemnity.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.mysql.Transaction;

/**
 * 添加赔付单信息
 * @author wj  
 * @date 2018年5月10日 
 *
 */
public class SvrIndemnityInsert extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql1 = new SqlQuery(this); 
		Record head = dataIn.getHead();
		sql1.add("select u.mobile_,o.orderId_ ,p.type_ from %s u" ,appdb.S_Userinfo);
		sql1.add("join %s o on u.code_ = o.userId_" ,appdb.T_ORDER);
		sql1.add("join %s p on p.orderId_ = o.orderId_" ,appdb.t_Operate);
		sql1.add("where p.type_ != '3'");
		sql1.open();
		
		try (Transaction tx = new Transaction(this)) {
		
		SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_,createDate_,createUser_,settleState_,userId_,orderId_,payID_,successMoney_,suggestMoney_,payReason_,suggest_,payDesc_ ,payRemark_,payState_ ");
		sql.add("from  %s where orderId_ = '%s'  " ,appdb.T_ORDER ,sql1.getField("orderId_"));
		sql.open();
		sql.edit();
		sql.setField("createDate_", TDateTime.Now());
		sql.setField("createUser_", this.getUserCode());
		sql.setField("userId_", sql1.getField("mobile_"));
		sql.setField("orderId_", sql1.getField("orderId_"));
		sql.setField("payID_", head.getString("payID_"));
		sql.setField("payReason_", head.getString("payReason_"));
		sql.setField("successMoney_", head.getInt("successMoney_"));
		sql.setField("suggestMoney_", head.getInt("suggestMoney_"));
		sql.setField("suggest_", head.getString("suggest_"));
		sql.setField("payDesc_", head.getString("payDesc_"));
		sql.setField("payRemark_", head.getString("payRemark_"));
		sql.setField("payState_", 2);
		sql.setField("settleState_", 0);
		sql.post();
		
		SqlQuery sql2 = new SqlQuery(this);
		sql2.add("select UID_ , type_ ,orderId_ from %s " ,appdb.t_Operate);
		sql2.add("where orderId_ = '%s'" ,sql1.getField("orderId_"));
		sql2.open();
		sql2.edit();
		sql2.setField("type_", 3);
		sql2.post();
		
	    tx.commit();
        }
		return this.success();
	}

}
