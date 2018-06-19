package com.huagu.ywManage.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 得到要修改折损率的运维单信息
 * @author wj  
 * @date 2018年4月26日 
 *
 */
public class SvrGetYunWeiBill extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select p.UID_,p.nowLoss_ , p.operateId_ ,p.zhuCode_,d.proName_ from %s p" ,appdb.t_Operate);
		sql.add("left join  %s d on p.proId_ = d.proId_" ,appdb.T_Products);
		sql.add("where p.operateId_ = '%s'" ,head.getString("operateId_"));
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
