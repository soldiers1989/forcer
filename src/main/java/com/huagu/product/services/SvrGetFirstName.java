package com.huagu.product.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 * 得到一级分类名称
 * @author wj  
 * @date 2018年5月8日 
 *
 */
public class SvrGetFirstName extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_,updateDate_,updateUser_, fristName_,fristNameId_,fristState_,fristDel_ ");
		sql.add("from %s" ,appdb.T_Protype);
		sql.add(" where fristNameId_ = '%s' group by fristNameId_" ,head.getString("fristNameId_"));
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
