package com.huagu.creditManagement.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 *  将excel导入的数据插入数据库
 * @author wj  
 * @date 2018年6月6日 
 *
 */
public class SvrAddExcelInfo extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("SELECT UID_,createDate_,createUser_,userCode_,source_,attributes_,dataRen_,status_ FROM %s", appdb.CLIENTCERTIFIED);
		sql.open();
		sql.append();
		sql.setField("createDate_", TDateTime.Now());
		sql.setField("createUser_", this.getUserCode());
		sql.setField("userCode_",  head.getString("userCode_"));
		sql.setField("source_", head.getString("source_"));
		sql.setField("attributes_", head.getString("attributes_"));
		sql.setField("dataRen_", head.getString("dataRen_"));
		if("有效".equals(head.getString("status_")))
		sql.setField("status_",  "2");
	    if("失效".equals(head.getString("status_")))
		sql.setField("status_",  "1");
	/*	sql.setField("status_", head.getString("status_"));*/
		sql.post();
		return this.success();
	}

}
