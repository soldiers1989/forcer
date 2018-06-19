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

/**
 *  发送消息
 * @author wj  
 * @date 2018年6月1日 
 *
 */
public class SvrSendMessage extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select  o.orderId_,o.returnMethod_,o.createDate_,oe.OpenBoxTime_,o.returnType_,o.fixType_, o.orderId_ ,o.userId_ , o.setBoxId_ ,o.repairType_ ,");
		sql.add("o.settleState_ ,u.mobile_,p.homeAgency_  , p.zhuCode_, oe.operateId_ ,oe.createDate_ ,tp.proName_,de.ciCode_");
		sql.add("from %s o " ,appdb.T_ORDER);
		sql.add("join %s u  on o.userId_ = u.code_ " ,appdb.S_Userinfo);
		sql.add("join %s p on p.proId_ = o.proId_ " ,appdb.T_ProNode);
		sql.add("join %s oe on oe.orderId_ = o.orderId_" ,appdb.t_Operate);
		sql.add("join %s tp on tp.proId_ = o.proId_" ,appdb.T_Products);
		sql.add("join %s  de on de.zhuCode_ = p.zhuCode_" ,appdb.T_CiNode);
		sql.add("where o.returnMethod_ = '0'");
		sql.add(" and o.orderId_ = '%s'" ,head.getString("orderId_"));
		sql.open();
		
		String guid = new SimpleDateFormat("yyyyMMddhhmmssSSS").format(new Date()); 
		SqlQuery sqlMes = new SqlQuery(this);
		sqlMes.add("select  UID_ , createDate_ , createUser_ ,title_,content_,sendTime_,sendOb_,status_,type_,id_,sender_,userCode_ ");
		sqlMes.add("from t_newslist");
		sqlMes.open();
		sqlMes.append();
		sqlMes.setField("createDate_", TDateTime.Now());
		sqlMes.setField("sendTime_", TDateTime.Now());
		sqlMes.setField("createUser_", this.getUserCode());
		sqlMes.setField("title_", "运维");
		sqlMes.setField("type_", 3);
		sqlMes.setField("content_", "运维");
		sqlMes.setField("sendOb_", "运维");
		sqlMes.setField("id_", guid);
		sqlMes.setField("status_", 0);
		sqlMes.setField("sender_", this.getUserCode());
		sqlMes.setField("userCode_", sql.getField("userId_"));
		sqlMes.post();
		return this.success();
	}

}
