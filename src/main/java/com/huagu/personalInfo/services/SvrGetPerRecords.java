package com.huagu.personalInfo.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  个人交易记录
 * @author wj  
 * @date 2018年5月17日 
 *
 */
public class SvrGetPerRecords extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select r.UID_ ,r.createTime_ ,r.platform_ ,r.userNowMoney_,r.userCode_ ,r.amount_, r.type_, r.opeType_ ,u.overMoney_");
		sql.add("from  %s r  join  %s u" ,appdb.Record, appdb.S_Userinfo);
		sql.add("on u.code_ = r.userCode_");
		sql.add("where r.userCode_ = '%s'" ,head.getString("userCode_"));
		sql.add("group by r.createTime_ desc ");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
