package com.huagu.order.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 * 
 * @author wj
 * 查询送货到柜详情
 */
public class SvrToBoxDetrails extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select o.*,DATE_FORMAT(o.createDate_,'%s') as createDate,DATE_FORMAT(o.beginTime_,'%s') as beginTime,","%Y-%m-%d %H:%m:%s","%Y-%m-%d %H:%m:%s");
		sql.add("DATE_FORMAT(o.payTime_,'%s') as payTime,DATE_FORMAT(o.returnTime_,'%s') as returnTime,p.proName_,p.isDiscount_,","%Y-%m-%d %H:%m:%s","%Y-%m-%d %H:%m:%s");
		sql.add("p.dayRentMoney_,p.discountPrice_,b.name_ boxName_,b.address_ boxAddress_,b.communityName_ boxCommunityName_,b.boxId_ ");
		sql.add("from (SELECT ord.*,n.homeAgency_ from %s ord  LEFT JOIN %s n on ord.zhuCode_=n.zhuCode_) o" ,appdb.T_ORDER,appdb.T_ProNode);
		sql.add("left join %s p on o.proId_=p.proId_ " ,appdb.T_Products);
		sql.add("left join (select c.name_,c.address_ ,c.communityName_,tpb.zhuCode_ ,tpb.boxId_ ");
		sql.add("from %s c left join %s tpb  on c.id_=tpb.cabId_) b on o.zhuCode_=b.zhuCode_" ,appdb.CABINET,appdb.t_pronode_box);
		sql.add("where o.orderType_=3   and  o.orderId_ = '%s'" ,head.getString("orderId_"));
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
