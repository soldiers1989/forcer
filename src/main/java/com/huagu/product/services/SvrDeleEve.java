package com.huagu.product.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 * 删除评价
 * @author wj  
 * @date 2018年4月26日 
 *
 */
public class SvrDeleEve extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select e.UID_ UID_,e.proId_,e.createDate_ createDate_,e.orderId_ orderId_,");
		sql.add("evaLevel_,name_,evaContent_,evaState_,UserId_,orderType_,isShow_,proName_");
		sql.add("from %s e left join %s s" ,appdb.T_EVALUATE,appdb.S_Userinfo);
		sql.add("on e.UserId_=s.id_ left join %s p" ,appdb.T_Products);
		sql.add("on e.proId_=p.proId_ where 1=1 ");
		sql.add("and  e.proId_ = '%s' " ,head.getString("proId_"));
		sql.open();
		sql.delete();
		return this.success();
	}
}
