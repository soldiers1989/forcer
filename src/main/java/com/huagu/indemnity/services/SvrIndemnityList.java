package com.huagu.indemnity.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrIndemnityList extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String mobile_ = head.getString("mobile_");
		String homeAgency_ = head.getString("homeAgency_");
		String orderId_ = head.getString("orderId_");
		String proName_ = head.getString("proName_");
		String payReason_ = head.getString("payReason_");
		String operateId_ = head.getString("operateId_");
		String payStatus_ = head.getString("payStatus_");
		if(payStatus_.equals("-1")){
			payStatus_ = "";
		}
		sql.add("select  oe.UID_,o.payID_,o.payState_,o.pay_,o.payStatus_,oe.createDate_ , o.proId_,o.orderType_ ,pn.zhuCode_ ,oe.operateId_,oe.type_,oe.orderId_,pn.homeAgency_,pn.proCostPrice_,");
		sql.add("p.proName_ ,p.proZsImges_,c.name_,c.address_,c.communityName_,o.sumMoney_,o.reliefDeposit_,o.suggestMoney_,o.successMoney_,o.payReason_,o.suggest_,");
		sql.add("u.code_,u.mobile_");
		sql.add("from %s  o join   %s  p on o.proId_ = p.proId_" ,appdb.T_ORDER,appdb.T_Products);
		sql.add("join %s u on u.code_ = o.userId_ " ,appdb.S_Userinfo);
		sql.add("join %s oe on  oe.orderId_ = o.orderId_" ,appdb.t_Operate);
		sql.add("join  %s  pn on o.proId_ = pn.proId_" ,appdb.T_ProNode);
		sql.add("join  %s   pb on pb.zhuCode_ = pn.zhuCode_" ,appdb.t_pronode_box);
		sql.add("join %s c on c.id_ = pb.cabId_ " ,appdb.CABINET);
		sql.add("where oe.type_ = '3'");
		if(mobile_ != null && mobile_ != ""){
			sql.add("and u.mobile_ like '%s'" ,new String("%"+mobile_+"%"));
		}
		if(homeAgency_ != null && homeAgency_ != ""){
			sql.add("and pn.homeAgency_ like '%s'" ,new String("%"+homeAgency_+"%"));
		}
		if(orderId_ != null && orderId_ != ""){
			sql.add("and oe.orderId_ like '%s'" ,new String("%"+orderId_+"%"));
		}
		if(proName_ != null && proName_ != ""){
			sql.add("and p.proName_ like '%s'" ,new String("%"+proName_+"%"));
		}
		if(payReason_ != null && payReason_ != ""){
			sql.add("and o.payReason_ like '%s'" ,new String("%"+payReason_+"%"));
		}
		if(operateId_ != null && operateId_ != ""){
			sql.add("and oe.operateId_ like '%s'" ,new String("%"+operateId_+"%"));
		}
		if(payStatus_ != null && payStatus_ != ""){
			sql.add("and o.payStatus_  =  '%s'" ,payStatus_);
		}
		sql.add("group by oe.orderId_");
		sql.add("order by oe.createDate_ desc ");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
