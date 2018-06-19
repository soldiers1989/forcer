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
 *  手工结算订单
 * @author wj  
 * @date 2018年5月14日 
 *
 */
public class SvrHandSettle extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql1 = new SqlQuery(this);
		Record head = dataIn.getHead();
		//修改结算状态
		sql1.add("select UID_ ,orderId_,payID_ ,settleState_,sumMoney_,sumRentMoney_, successMoney_,suggestMoney_,payReason_,suggest_,payDesc_ ,payRemark_ from %s" ,appdb.T_ORDER);
		sql1.add("where  orderId_ = '%s'" ,head.getString("orderId_"));
		sql1.open();
		sql1.edit();
		sql1.setField("settleState_", 2);
		sql1.post();
		
		
		//扣除订单租金，归还押金
		SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_ , overMoney_ ,code_ from %s" ,appdb.S_Userinfo);
		sql.add("");
		sql.open();
		sql.edit();
		sql.setField("overMoney_", sql1.getInt("sumRentMoney_") - sql1.getInt("sumMoney_"));
		sql.post();
		
		//往交易表里面添加交易记录
		SqlQuery sqlRecord = new SqlQuery(this);
		sqlRecord.add("select UID_,createTime_,createUser_,createUser_,platform_,status_,userCode_,opeType_,amount_,orderId_,userNowMoney_ from %s" ,appdb.Record);
		sqlRecord.add("where userCode_ = '%s'" ,sql.getField("userId_"));
		sqlRecord.open();
		sqlRecord.append();
		sqlRecord.setField("createTime_", TDateTime.Now());
		sqlRecord.setField("createUser_", this.getUserCode());
		sqlRecord.setField("amount_", sql1.getInt("sumRentMoney_") - sql1.getInt("sumMoney_"));
		sqlRecord.setField("userCode_", sql.getField("userId_"));
		sqlRecord.setField("orderId_", sql1.getField("orderId_"));
		sqlRecord.setField("userNowMoney_", sql.getInt("overMoney_"));
		sqlRecord.setField("platform_", 0);
		sqlRecord.setField("opeType_", "C");
		sqlRecord.setField("status_", 0 );
		sqlRecord.post();
		return this.success();
	}

}
