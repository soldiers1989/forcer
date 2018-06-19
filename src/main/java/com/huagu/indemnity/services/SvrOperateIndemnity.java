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
 *  操作赔付单（生效/失效）
 * @author wj  
 * @date 2018年5月11日 
 *
 */
public class SvrOperateIndemnity extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select  oe.UID_,o.pay_,oe.createDate_ ,o.suggestMoney_,o.successMoney_,o.payReason_,o.suggest_,o.userId_,o.payState_, o.sumMoney_,o.proId_,o.orderType_ ,pn.zhuCode_  ,oe.operateId_,oe.type_,oe.orderId_,o.payDesc_,o.payImg_,o.pay_,pn.homeAgency_,pn.proCostPrice_,");
		sql.add("o.coupon_,o.reliefDeposit_,p.proName_ ,p.proZsImges_,p.dayRentMoney_,p.cashPledge_,c.name_,c.address_,c.communityName_,o.beginTime_,o.returnOverTime_,");
		sql.add("(select datediff(returnOverTime_,beginTime_)   from %s where orderId_ = '%s') as time " ,appdb.T_ORDER,head.getString("orderId_"));
		sql.add("from %s  o join   %s  p on o.proId_ = p.proId_" ,appdb.T_ORDER,appdb.T_Products);
		sql.add("join %s oe on  oe.orderId_ = o.orderId_" ,appdb.t_Operate);
		sql.add("join  %s  pn on o.proId_ = pn.proId_" ,appdb.T_ProNode);
		sql.add("join  %s   pb on pb.zhuCode_ = pn.zhuCode_" ,appdb.t_pronode_box);
		sql.add("join %s c on c.id_ = pb.cabId_ " ,appdb.CABINET);
		sql.add("where oe.type_ = '3'");
		sql.add("and oe.operateId_ = '%s'" ,head.getString("operateId_"));
		sql.open();
		
		SqlQuery sql1 = new SqlQuery(this);
		sql1.add("select UID_ ,orderId_, payState_ from %s" ,appdb.T_ORDER);
		sql1.add("where orderId_ = '%s'" ,sql.getField("orderId_"));
		sql1.open();
		sql1.edit();
		/*if("1".equals(payState_)){//订单失效
			sql1.setField("payState_", payState_);
		}else{*/
		
		//订单生效
		sql1.setField("payState_", 0);
		
		//扣除用户账户相对应的赔付金额
		SqlQuery sqlUser = new SqlQuery(this);
		sqlUser.add("select UID_,updateUser_,updateTime_,code_,overMoney_  from %s" ,appdb.S_Userinfo);
		sqlUser.add("where code_ = '%s'" ,sql.getField("userId_"));
		sqlUser.open();
		sqlUser.edit();
		sqlUser.setField("updateTime_",TDateTime.Now());
		sqlUser.setField("updateUser_", this.getUserCode());
		sqlUser.setField("overMoney_", sqlUser.getInt("overMoney_")-sql.getInt("successMoney_"));
		sqlUser.post();
		
		//往交易表里面添加交易记录
		SqlQuery sqlRecord = new SqlQuery(this);
		sqlRecord.add("select UID_,createTime_,createUser_,createUser_,platform_,status_,userCode_,opeType_,amount_,orderId_,userNowMoney_ from %s" ,appdb.Record);
		sqlRecord.add("where userCode_ = '%s'" ,sql.getField("userId_"));
		sqlRecord.open();
		sqlRecord.append();
		sqlRecord.setField("createTime_", TDateTime.Now());
		sqlRecord.setField("createUser_", this.getUserCode());
		sqlRecord.setField("amount_", sql.getInt("successMoney_"));
		sqlRecord.setField("userCode_", sql.getField("userId_"));
		sqlRecord.setField("orderId_", sql.getField("orderId_"));
		sqlRecord.setField("userNowMoney_", sqlUser.getInt("overMoney_"));
		sqlRecord.setField("platform_", 0);
		sqlRecord.setField("opeType_", "C");
		sqlRecord.setField("status_", 0 );
		sqlRecord.post();
	/*	}*/
	    sql1.post();
		return this.success();
	}

}
