package com.huagu.myWallet.services;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 财务平台所有押金
 *  @author lxf
 *  @date   2018年4月26日下午2:56:32
 *  @return
 */
public class SvrGetYaJin extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		sql.add("select sum(p.cashPledge_ - o.reliefDeposit_) cashPledge_,DATE_FORMAT(o.beginTime_,'%Y-%m-%d %H:%i') beginTime_,p.proName_,p.proZsImges_ from t_order");
		sql.add(" o LEFT JOIN t_products p on o.proId_=p.proId_");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
