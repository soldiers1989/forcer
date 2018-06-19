package com.huagu.order.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 *  按租赁单查询关联单
 * @author wj  
 * @date 2018年5月24日 
 *
 */
public class SvrLeaseOrdersQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String  orderId_ = head.getString("orderId_");
		String  operateId_ = head.getString("operateId_");
		String  payID_ = head.getString("payID_");
		String  returnId_ = head.getString("returnId_");
		sql.add("select o.orderId_ ,o.createDate_,o.payTime_ ,qw.id_ ,qw.createTime_  qwdate_  ,rg.returnId_ ,rg.returnOverTime_ ,");
		sql.add("ate.operateId_ ,ate.OpenBoxTime_ ,yc.ycNo_ , yc.orderId_,yc.ycTime_,p.payID_ ,p.payDate_ ");
		sql.add(" from %s o join %s qw  on qw.orderId_ = o.orderId_" ,appdb.T_ORDER,appdb.qhorder);
		sql.add(" join %s  ate  on ate.orderId_ = o.orderId_" ,appdb.t_Operate);
		sql.add("join %s yc on yc.orderId_ = o.orderId_" ,appdb.YCORDER);
		sql.add("join %s  rg  on rg.orderId_ = o.orderId_" ,appdb.ReturnGoods);
		sql.add("join  %s  p on p.orderId_ = o.orderId_" ,appdb.Pay);
		sql.add("where 1=1");
		if(orderId_ != null && orderId_ != ""){
			sql.add("and o.orderId_ like '%s'" ,new String ("%"+orderId_+"%"));
		}
		if(operateId_ != null && operateId_ != ""){
			sql.add("and ate.operateId_ like '%s'" ,new String ("%"+operateId_+"%"));
		}
		if(payID_ != null && payID_ != ""){
			sql.add("and p.payID_ like '%s'" ,new String ("%"+payID_+"%"));
		}
		if(returnId_ != null && returnId_ != ""){
			sql.add("and rg.returnId_ like '%s'" ,new String ("%"+returnId_+"%"));
		}
		sql.add("order by o.createDate_ desc");
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);
		}
		return this.success();
	}

}
