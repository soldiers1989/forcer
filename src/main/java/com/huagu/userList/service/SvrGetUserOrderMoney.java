package com.huagu.userList.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 查询记录
 * 
 * @author xiaofei-pc
 *
 */
public class SvrGetUserOrderMoney extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
        Record headIn = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		// 订单商品原价总和
		if("dayRentMoney_".equals(headIn.getString("type_"))){
			sql.add("SELECT SUM(dayRentMoney_) dayRentMoney_ FROM  %s", appdb.T_ORDER);
			sql.add("  o JOIN %s p ON o.zhuCode_ = p.zhuCode_ ", appdb.T_ProNode);
			sql.add(" JOIN t_products ps ON p.proId_ = ps.proId_", appdb.T_Products);
			sql.add(" WHERE o.userId_ = '%s' AND orderState_ NOT in (6,7,8)", headIn.getString("code_"));
		}
		// 用户商品押金总和
		if("cashPledge_".equals(headIn.getString("type_"))){
			sql.add("SELECT SUM(cashPledge_) cashPledge_ FROM  %s", appdb.T_ORDER);
			sql.add("  o JOIN %s p ON o.zhuCode_ = p.zhuCode_ ", appdb.T_ProNode);
			sql.add(" JOIN t_products ps ON p.proId_ = ps.proId_", appdb.T_Products);
			sql.add(" WHERE o.userId_ = '%s' AND orderState_ NOT in (6,7,8)", headIn.getString("code_"));
		}
		// 用户在租订单总额
		if("sumRentMoney_".equals(headIn.getString("type_"))){
			sql.add("SELECT SUM(o.sumRentMoney_) sumRentMoney_ FROM  %s", appdb.T_ORDER);
			sql.add("  o JOIN %s p ON o.zhuCode_ = p.zhuCode_ ", appdb.T_ProNode);
			sql.add(" JOIN %s ps ON p.proId_ = ps.proId_", appdb.T_Products);
			sql.add(" WHERE o.userId_ = '%s' AND orderState_ NOT in (6,7,8)", headIn.getString("code_"));
		}
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return success();
	}

}
