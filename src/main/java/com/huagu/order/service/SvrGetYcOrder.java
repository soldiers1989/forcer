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
 * 异常单信息
 * @author xiaofei-pc
 *
 */
public class SvrGetYcOrder extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		//异常单号，异常描述，订单号，关联物品名称，关联物品机构，异常时间，异常单处理状态，处理结果，处理时间，标记状态，处理人
		//ycNo_,source_,orderId_,goodsName_,goodsAgency_,ycTime_,ycStatus_,ycResult,clTime_,markStatus_,dealer
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("SELECT UID_,createDate_,ycNo_,source_,orderId_,goodsName_,goodsAgency_,ycTime_,ycStatus_,ycResult,clTime_,markStatus_,dealer FROM %s", appdb.YCORDER);
		sql.add(" where 1 = 1");
		if("up".equals(head.getString("type_"))){
			sql.add(" and ycNo_ = '%s'", head.getSafeString("ycNo_"));
			sql.open();
			sql.edit();
			sql.setField("clTime_", TDateTime.Now());
			sql.setField("markStatus_", "1");
			sql.setField("dealer", this.getUserCode());
			sql.post();
		}else if("add".equals(head.getString("type_"))){
			sql.setMaximum(0);
			sql.open();
			sql.append();
			sql.setField("createDate_", TDateTime.Now());
			sql.setField("ycNo_", head.getSafeString("ycNo_"));
			sql.setField("source_", head.getSafeString("source_"));
			sql.setField("orderId_", head.getSafeString("orderId_"));
			sql.setField("ycStatus_", head.getSafeString("orderStatus"));
			sql.setField("ycResult", head.getSafeString("result"));
			sql.setField("ycTime_", TDateTime.Now());
			sql.setField("markStatus_", "0");
			sql.post();
		}else {
			if(head.hasValue("ycOrder_"))
				sql.add("and ycNo_ like '%s'", head.getString("ycOrder_"));
			if(head.hasValue("goodsAgency_"))
				sql.add("and goodsAgency_ like '%s'", head.getString("goodsAgency_"));
			if(head.hasValue("source_"))
				sql.add("and source_ like '%s'", head.getString("source_"));
			if(head.hasValue("ycTime_"))
				sql.add("and ycTime_ like '%s'", head.getString("ycTime_"));
			if(head.hasValue("ycStatus_"))
				sql.add("and ycStatus_ like '%s'", head.getString("ycStatus_"));
			sql.add(" ORDER BY ycTime_ DESC");
			if(head.hasValue("no_"))
				sql.setMaximum(1);
			sql.open();
			if(!sql.eof())
				dataOut.appendDataSet(sql);
		}
		return this.success();
	}

}
