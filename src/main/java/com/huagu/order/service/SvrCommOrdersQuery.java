package com.huagu.order.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  按社区归属查询订单
 * @author wj  
 * @date 2018年5月24日 
 *
 */
public class SvrCommOrdersQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String  orderId_ = head.getString("orderId_");
		String proName_ = head.getString("proName_");
		String payTime = head.getString("payTime");
		sql.add("select o.orderId_, p.proName_,b.zhuCode_,o.pay_,o.sumRentMoney_,o.homeAgency_,o.sumOverMoney_, b.communityName_,");
		sql.add("DATE_FORMAT(o.payTime_,'%Y-%m-%d %H:%m:%s') as payTime");
		sql.add("from (SELECT ord.*,n.homeAgency_ from %s  ord  LEFT JOIN %s  n on ord.zhuCode_=n.zhuCode_) o " , appdb.T_ORDER,appdb.T_ProNode);
		sql.add("left join %s  p on o.proId_=p.proId_" ,appdb.T_Products);
		sql.add("left join (select c.name_,c.address_ ,c.communityName_,tpb.zhuCode_ ,tpb.boxId_  from  %s  c left join %s tpb  on c.id_=tpb.cabId_) b " ,appdb.Cabinet,appdb.PRONODEBOX);
		sql.add("on o.zhuCode_=b.zhuCode_ ");
		sql.add("where 1 = 1");
		if(orderId_ != null && orderId_ != ""){
			sql.add("and o.orderId_ like '%s'" , new String("%"+orderId_+"%"));
		}
		if(proName_ != null && proName_ != ""){
			sql.add("and p.proName_ like '%s'" , new String("%"+proName_+"%"));
		}
		if(payTime != null && payTime != ""){
			sql.add("and o.payTime_ like '%s'" , new String("%"+payTime+"%"));
		}
		sql.add("group by o.orderId_");
		sql.add("order by o.payTime_ desc");
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);
		}
		return this.success();
	}

}
