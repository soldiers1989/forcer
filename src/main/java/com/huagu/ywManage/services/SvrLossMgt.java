package com.huagu.ywManage.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 * 查询所有折损数据
 * @author 黄培嘉
 * 2018-4-28
 */
public class SvrLossMgt extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql =new SqlQuery(this);
		sql.add("SELECT UID_,status_, returnType_ ,DATE_FORMAT(createDate_,'%s') as createDate_, orderId_, getCabinetId_, setCabinetId_, getBoxId_," ,"%Y-%m-%d %H:%m:%s");
		sql.add("setBoxId_, proId_, userId_, DATE_FORMAT(beginTime_,'%s') as beginTime_, DATE_FORMAT(returnTime_,'%s') as returnTime_ ,returnMethod_, DATE_FORMAT(returnOverTime_,'%s') as returnOverTime_ , fixType_, ","%Y-%m-%d %H:%m:%s","%Y-%m-%d %H:%m:%s","%Y-%m-%d %H:%m:%s");
		sql.add("DATE_FORMAT(rentTime_,'%s') as rentTime_ , sumRentMoney_,  DATE_FORMAT(payTime_,'%s') as payTime_, shippingCosts_, orderType_, orderState_, sumMoney_, proModelId_, counts_, remark_,","%Y-%m-%d %H:%m:%s","%Y-%m-%d %H:%m:%s");
		sql.add("overhaul_, returnReason_, returnMoney_,returnLogisticsName_, recLogisticsId_, payMethod_, userEva_, pay_, payDesc_, payImg_, ");
		sql.add("payState_, allowReturnMoney_, coupon_, reliefDeposit_, receiver_, recAdr_, recPhone_, logisticsState_, deliveryTime_, recTime_, ");
		sql.add("recLogisticsName_,  DATE_FORMAT(recUpTime_,'%s') as recUpTime_, repairType_, zhuCode_, orderRentMoney_, sumOverMoney_, overdueDay_ ","%Y-%m-%d %H:%m:%s");
		sql.add("FROM %s   " ,appdb.T_ORDER);	
		sql.add("where  returnType_ = '1' or returnOverTime_ > returnTime_ or overdueDay_ > 1");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
		
	}
} 