package com.huagu.myWallet.services;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.huagu.common.global.appdb;
import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 添加商户平台记录流水
 *  @author lxf
 *  @date   2018年4月26日下午2:56:32
 *  @return
 */
public class SvrRecordLog extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Date date = new Date();  
	    SimpleDateFormat formatter = new SimpleDateFormat("yyMMddHHmmss");  
	    String number = "101" + formatter.format(date);  
		Record head = dataIn.getHead();
		sql.add("SELECT UID_,createTime_,createUser_,number_,amount_,type_,qamount_,hamount_,recordId_,accountId_,desc_ FROM %s", appdb.RECORDACCOUNT);
		sql.add(" where 1 = 1");
		sql.setMaximum(0);
		sql.open();
		sql.append();
		sql.setField("createTime_",  TDateTime.Now());
		sql.setField("createUser_",  "admin");
		sql.setField("number_",  number);
		sql.setField("amount_",  head.getSafeString("amount_"));
		sql.setField("type_",  head.getSafeString("type_"));
		sql.setField("qamount_",  head.getSafeString("qamount_"));
		sql.setField("hamount_",  head.getSafeString("hamount_"));
		sql.setField("recordId_",  number);
		sql.setField("accountId_",  head.getSafeString("accountId_"));
		sql.setField("desc_",  head.getSafeString("desc_"));
		sql.post();
		sql.close();
		
		return this.success();
	}

}
