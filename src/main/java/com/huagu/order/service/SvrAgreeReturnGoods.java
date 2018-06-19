package com.huagu.order.service;

import java.text.SimpleDateFormat;
import java.util.Date;

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
 *  同意退货
 * @author wj  
 * @date 2018年5月30日 
 *
 */
public class SvrAgreeReturnGoods extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		//拿到退货订单
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select g.rgId_,g.orderId_,g.userId_,u.mobile_ ,g.createDate_,p.proName_,g.isAgree_,g.rgLogisticsName_,g.rgLogisticsId_,");
		sql.add("g.check_,g.rgStatus_,g.rgHand_,g.rgMoney_,s.saleHomeAgency_");
		sql.add("from %s  g join %s p  on g.proId_ = p.proId_" ,appdb.goodsRejected ,appdb.T_Products);
		sql.add("join %s u  on u.code_ = g.userId_" ,appdb.S_Userinfo);
		sql.add("join %s s on g.proId_ = s.proId_" ,appdb.T_Storage);
		sql.add("where  g.rgId_ = '%s'" ,  head.getString("rgId_"));
		sql.open();
		
		try (Transaction tx = new Transaction(this)) {
		//改变退货单状态
		SqlQuery changeStatus = new SqlQuery(this);
		changeStatus.add("select UID_ , updateDate_,updateUser_,rgStatus_ ,rgHand_ , check_ ,isAgree_  from %s" ,appdb.goodsRejected);
		changeStatus.add("where rgId_ = '%s'" ,sql.getField("rgId_"));
		changeStatus.open();
		changeStatus.edit();
		changeStatus.setField("updateDate_", TDateTime.Now());
		changeStatus.setField("updateUser_", this.getUserCode());
		changeStatus.setField("rgStatus_", 1);
		changeStatus.setField("rgHand_", 1);
		changeStatus.setField("check_", 1);
		changeStatus.setField("isAgree_", 1);
		changeStatus.post();
		
		//退款给用户
        SqlQuery sqlUser = new SqlQuery(this);
        sqlUser.add("select UID_,updateUser_,updateTime_, code_ ,overMoney_ from %s" ,appdb.S_Userinfo);
        sqlUser.add("where code_ = '%s'" ,sql.getField("userId_"));
        sqlUser.open();
        sqlUser.edit();
        sqlUser.setField("updateTime_", TDateTime.Now());
        sqlUser.setField("updateUser_", this.getUserCode());
        sqlUser.setField("overMoney_", sqlUser.getInt("overMoney_") + sql.getInt("rgMoney_"));
        sqlUser.post();
        
		//添加交易记录
		SqlQuery sqlRecord =  new SqlQuery(this);
		String guid = new SimpleDateFormat("yyyyMMddhhmmssSSS").format(new Date());  
		sqlRecord.add("select UID_ ,createTime_, createUser_,number_,platform_,userCode_,opeType_,status_,amount_,userNowMoney_  from %s" ,appdb.Record);
		sqlRecord.open();
		sqlRecord.append();
		sqlRecord.setField("createTime_", TDateTime.Now());
		sqlRecord.setField("createUser_", this.getUserCode());
		sqlRecord.setField("number_", guid);
		sqlRecord.setField("platform_", 1);
		sqlRecord.setField("userCode_", sql.getField("userId_"));
		sqlRecord.setField("opeType_", "D");
		sqlRecord.setField("status_", 1);
		sqlRecord.setField("amount_", sql.getInt("rgMoney_"));
		sqlRecord.setField("userNowMoney_", sqlUser.getInt("overMoney_") + sql.getInt("rgMoney_"));
		sqlRecord.post();
        
		 tx.commit();
		}
		return this.success();
	}

}
