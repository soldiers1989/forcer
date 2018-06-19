package com.huagu.order.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 拿到箱子Id
 * @author wj 
 *
 */
public class SvrGetBoxId extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select o.*,p.proName_,p.isDiscount_,p.dayRentMoney_,p.discountPrice_,b.name_ boxName_,b.address_ boxAddress_,b.communityName_ boxCommunityName_,b.boxId_");
		sql.add("from (SELECT ord.*,n.homeAgency_ from %s ord  LEFT JOIN %s n on ord.zhuCode_=n.zhuCode_) o" ,appdb.T_ORDER,appdb.T_ProNode);
		sql.add("left join %s p on o.proId_=p.proId_  " ,appdb.T_Products);
		sql.add("left join (select c.name_,c.address_ ,c.communityName_,tpb.zhuCode_,tpb.boxId_");
		sql.add("from %s c left join %s tpb  on c.id_=tpb.cabId_) b on o.zhuCode_=b.zhuCode_" ,appdb.Cabinet,appdb.t_pronode_box);
		sql.add("where  b.boxId_ = '%s'" ,head.getString("boxId_"));
		sql.add("and o.orderType_ = '3'");
		sql.add("group by o.orderId_");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
