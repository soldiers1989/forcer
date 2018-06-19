package com.huagu.order.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 *  对退货单进行退货处理
 * @author wj  
 * @date 2018年6月1日 
 *
 */
public class SvrHandOrder extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select g.updateDate_,g.updateUser_,g.rgId_,g.orderId_,g.userId_,u.mobile_ ,g.createDate_,p.proName_,g.isAgree_,g.rgLogisticsName_,g.rgLogisticsId_,");
		sql.add("g.check_,g.rgStatus_,g.rgHand_,g.rgMoney_,s.saleHomeAgency_");
		sql.add("from %s  g join %s p  on g.proId_ = p.proId_" ,appdb.goodsRejected ,appdb.T_Products);
		sql.add("join %s u  on u.code_ = g.userId_" ,appdb.S_Userinfo);
		sql.add("join %s s on g.proId_ = s.proId_" ,appdb.T_Storage);
		sql.add("where  g.rgId_ = '%s'" ,  head.getString("rgId_"));
		sql.open();
		
		
		SqlQuery sqlHand = new SqlQuery(this);
		sqlHand.add("select UID_,updateDate_,updateUser_,rgId_,rgLogisticsName_,rgLogisticsId_,check_,rgStatus_,rgHand_,rgMoney_ ");
		sqlHand.add("from  %s  where   rgId_ = '%s'" ,appdb.goodsRejected,sql.getField("rgId_"));
		sqlHand.open();   
		sqlHand.edit();
		sqlHand.setField("updateDate_", TDateTime.Now());
		sqlHand.setField("updateUser_", this.getUserCode());
		sqlHand.setField("rgLogisticsName_", head.getString("rgLogisticsName_"));
		sqlHand.setField("rgLogisticsId_", head.getString("rgLogisticsId_"));
		sqlHand.setField("check_", head.getString("check_"));
		sqlHand.setField("rgStatus_", head.getString("rgStatus_"));	
		sqlHand.setField("rgHand_", head.getString("rgHand_"));
		sqlHand.setField("rgMoney_", head.getString("rgMoney_"));
		sqlHand.post();
		return this.success();
	}

}
