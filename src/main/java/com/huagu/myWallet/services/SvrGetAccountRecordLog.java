package com.huagu.myWallet.services;

import com.huagu.common.global.appdb;
import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 查询商户平台记录流水
 *  @author lxf
 *  @date   2018年4月26日下午2:56:32
 *  @return
 */
public class SvrGetAccountRecordLog extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("SELECT UID_,createTime_,number_,amount_,type_,qamount_,hamount_,recordId_,accountId_,desc_ FROM %s", appdb.RECORDACCOUNT);
		sql.add(" where 1 = 1");
		sql.add(" and accountId_ = '%s'", head.getSafeString("accountId_"));
		if(head.hasValue("unlockDate_"))
			sql.add(" and createTime_ > '%s'", head.getSafeString("unlockDate_"));
		if(head.hasValue("endDate_"))
			sql.add(" and createTime_ < '%s'", head.getSafeString("endDate_"));
		if(head.hasValue("desc_"))
			sql.add(" and desc_ LIKE '%s'", head.getSafeString("desc_"));
		sql.add(" ORDER BY createTime_ desc");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
			
		return this.success();
	}

}
