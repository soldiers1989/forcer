package com.huagu.troubleshooting.service;

import com.huagu.common.global.appdb;
import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 查询当天产生的充值金额
 * @author xiaofei-pc
 *
 */
public class SvrGetFundsAccount extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("select sum(amount_) amount_ from %s", appdb.RECORDACCOUNT);
		sql.add(" WHERE accountId_ = '%s' and createTime_ LIKE '%s'", headIn.getString("id_"), "%2018-05-20%");
		sql.open();
		if (!sql.eof()) {
			dataOut.appendDataSet(sql);
		}
		return success();
	}
}
