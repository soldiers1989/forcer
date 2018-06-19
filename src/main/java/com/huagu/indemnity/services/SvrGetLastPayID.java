package com.huagu.indemnity.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  拿到最近一次的赔付单号
 * @author wj  
 * @date 2018年5月15日 
 *
 */
public class SvrGetLastPayID extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_ ,createDate_,payID_ from %s" ,appdb.T_ORDER);
		sql.add("  order by   createDate_ desc");
		sql.open();
		sql.setMaximum(1);
		String payID_ = sql.getString("payID_");
		if(!sql.eof())
			dataOut.getHead().setField("payID_", payID_);
		return this.success();
	}

}
