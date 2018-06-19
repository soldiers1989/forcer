package com.huagu.ywManage.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 查看运维图片
 * @author wj  
 * @date 2018年4月26日 
 *
 */
public class SvrYunWeiImgQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select i.UID_ ,i.imgPath_ ,o.operateId_  from %s o" ,appdb.t_Operate);
		sql.add("left join %s i  on o.ImageId_ = i.relevancelId_" ,appdb.T_IMAGE);
		sql.add("where i.imgDel_ = '0' and o.operateId_ = '%s'" ,head.getString("operateId_"));
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
