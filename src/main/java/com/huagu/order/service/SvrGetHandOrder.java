package com.huagu.order.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  得到要处理的退货单数据
 * @author wj  
 * @date 2018年6月1日 
 *
 */
public class SvrGetHandOrder extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select g.rgId_,g.orderId_,g.userId_,u.mobile_ ,s.salePrice_,s.saleCount_,g.createDate_,p.proName_,g.isAgree_,g.rgLogisticsName_,g.rgLogisticsId_,");
		sql.add("g.check_,g.rgStatus_,g.rgHand_,g.rgMoney_,s.saleHomeAgency_ ,");
		sql.add("(select twoName_ from %s where twoNameId_=(select proTypeId_ from %s where proId_=(select proId_ from %s where orderId_='%s' ))) twoName_," ,appdb.T_Protype,appdb.T_Products,appdb.T_ORDER,head.getString("orderId_"));
		sql.add("(select fristName_ from %s where twoNameId_=(select proTypeId_ from %s where proId_=(select proId_ from %s where orderId_='%s'))) fristName_ " ,appdb.T_Protype,appdb.T_Products,appdb.T_ORDER,head.getString("orderId_"));
		sql.add("from %s  g join %s p  on g.proId_ = p.proId_" ,appdb.goodsRejected ,appdb.T_Products);
		sql.add("join %s u  on u.code_ = g.userId_" ,appdb.S_Userinfo);
		sql.add("join %s s on g.proId_ = s.proId_" ,appdb.T_Storage);
		sql.add("where  g.rgId_ = '%s'" ,  head.getString("rgId_"));
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);
		}
		return this.success();
	}

}
