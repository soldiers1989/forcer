package com.huagu.userList.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 查询所有用户捐赠订单信息
 * 
 * @author xiaofei-pc
 *
 */
public class SvrGetUserDonationOrder extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		String orderId_ = headIn.getString("orderId_");
		String shStatus_ = headIn.getString("shStatus_");
		String status_ = headIn.getString("status_");
		if(shStatus_.equals("-1")){
			shStatus_ = "";
		}
		if(status_.equals("-1")){
			status_ = "";
		}
		ds.add("SELECT UID_, DATE_FORMAT(createTime_,'%s') as createTime_ ,createUser_,orderId_,userId_,orderDesc_,count_,","%Y-%m-%d %H:%m:%s");
		ds.add("adr_,status_,  DATE_FORMAT(statusTime_,'%s') as statusTime_ ,shStatus_,maintainPhone_,DATE_FORMAT(shouhuoTime_,'%s') as shouhuoTime_  FROM %s","%Y-%m-%d %H:%m:%s","%Y-%m-%d %H:%m:%s",appdb.ORDERDONATION);
		ds.add(" WHERE 1=1");
		if("up".equals(headIn.getString("type_"))){
			ds.add(" and orderId_ = '%s'", headIn.getString("orderId_"));
			ds.open();
			if (!ds.eof()) 
				ds.edit();
				ds.setField("status_", "1");
				ds.setField("statusTime_", TDateTime.Now());
				ds.post();
		}else{
			if(orderId_ != null && orderId_ != "")
				ds.add(" and orderId_ LIKE '%s'","%"+headIn.getString("orderId_")+"%");
			if(headIn.hasValue("code_"))
				ds.add(" and createUser_ like '%s'", headIn.getString("code_"));
			if(shStatus_ != null && shStatus_ != "")
				ds.add(" and shStatus_ = '%s'", headIn.getString("shStatus_"));
			if(headIn.hasValue("shouhuoTime_"))
				ds.add(" and shouhuoTime_ like '%s'", "%"+headIn.getString("shouhuoTime_")+"%");
			if(headIn.hasValue("maintainPhone_"))
				ds.add(" and maintainPhone_ like '%s'", "%"+headIn.getString("maintainPhone_")+"%");
			if(status_ != null && status_ != "")
				ds.add(" and status_ = '%s'", headIn.getString("status_"));
			if(headIn.hasValue("orderDesc_")){
				ds.add(" and orderDesc_ like '%s'" , "%"+headIn.getString("orderDesc_")+"%");
			}
			ds.open();
			if (!ds.eof()) 
				dataOut.appendDataSet(ds);
		}
		return success();
	}

}
