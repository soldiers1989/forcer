package com.huagu.indemnity.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 *  赔付单详情查看
 * @author wj  
 * @date 2018年5月9日 
 *
 */
public class SvrIndemnityDetails extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select  oe.UID_,o.pay_,o.payID_,o.suggestMoney_,o.successMoney_,o.payReason_,o.suggest_,oe.createDate_ ,o.payState_, o.sumMoney_,o.proId_,o.orderType_ ,pn.zhuCode_  ,oe.operateId_,oe.type_,oe.orderId_,o.payDesc_,o.payImg_,o.pay_,pn.homeAgency_,pn.proCostPrice_,");
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
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
