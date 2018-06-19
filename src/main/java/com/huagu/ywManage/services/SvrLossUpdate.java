package com.huagu.ywManage.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 * 修改折损管理
 * @author 黄培嘉
 * 2018-4-28
 */
/**
 * @author wj  
 * @date 2018年5月4日 
 *
 */
public class SvrLossUpdate extends AbstractService{

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql =new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("SELECT UID_,status_, returnType_ ,DATE_FORMAT(createDate_,'%s') as createDate_, orderId_, getCabinetId_, setCabinetId_, getBoxId_," ,"%Y-%m-%d %H:%m:%s");
		sql.add("setBoxId_, proId_, userId_, DATE_FORMAT(beginTime_,'%s') as beginTime_, DATE_FORMAT(returnTime_,'%s') as returnTime_ ,returnMethod_, returnOverTime_, fixType_, ","%Y-%m-%d %H:%m:%s","%Y-%m-%d %H:%m:%s");
		sql.add("rentTime_, sumRentMoney_, payTime_, shippingCosts_, orderType_, orderState_, sumMoney_, proModelId_, counts_, remark_,");
		sql.add("overhaul_, returnReason_, returnMoney_,returnLogisticsName_, recLogisticsId_, payMethod_, userEva_, pay_, payDesc_, payImg_, ");
		sql.add("payState_, allowReturnMoney_, coupon_, reliefDeposit_, receiver_, recAdr_, recPhone_, logisticsState_, deliveryTime_, recTime_, ");
		sql.add("recLogisticsName_, recUpTime_, repairType_, zhuCode_, orderRentMoney_, sumOverMoney_, overdueDay_ ");
		sql.add("FROM %s   " ,appdb.T_ORDER);
		sql.add("where UID_ = '%s'" ,head.getString("UID_"));
		sql.open();
		sql.edit();
		sql.setField("status_", head.getString("status_"));
		sql.setField("pay_", head.getString("pay_"));
		sql.setField("payDesc_", head.getString("payDesc_"));
		sql.post();
		return this.success();
	}

}
