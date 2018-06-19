package com.huagu.ywManage.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 * 查询单行折损数据
 * @author 黄培嘉
 * 2018-4-28
 */
public class SvrLossQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		// TODO Auto-generated method stub
		SqlQuery sql =new SqlQuery(this);
		Record head =dataIn.getHead(); 
		sql.add("SELECT UID_, status_,createDate_, createUser_, updateDate_, updateUser_, orderId_, getCabinetId_, "
				+ "setCabinetId_, getBoxId_, setBoxId_, proId_, userId_, beginTime_, returnTime_, returnType_,"
				+ "returnMethod_, returnOverTime_, fixType_, rentTime_, sumRentMoney_, payTime_, shippingCosts_, "
				+ "orderType_, orderState_, sumMoney_, proModelId_, counts_, remark_, overhaul_, returnReason_, "
				+ "returnMoney_,returnLogisticsName_, recLogisticsId_, payMethod_, userEva_, pay_, payDesc_, payImg_,"
				+ " payState_, allowReturnMoney_, coupon_, reliefDeposit_, receiver_, recAdr_, recPhone_, logisticsState_, "
				+ "deliveryTime_, recTime_, recLogisticsName_, recUpTime_, repairType_, returnLogisticsName_, zhuCode_, "
				+ "orderRentMoney_, sumOverMoney_, overdueDay_");
		sql.add("FROM %s",appdb.T_ORDER);
		sql.add("where UID_= '%s'",head.getString("UID_"));
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success(); 
	}

}
