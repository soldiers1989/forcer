package com.huagu.addBank.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrAddBankCard extends AbstractService{
	//添加银行卡
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		   SqlQuery sql = new SqlQuery(this);
	       Record head = dataIn.getHead();
	       sql.add("select createTime_,userCode_,cardNum_,bankName_,userName_,cardType_ from %s",appdb.BankCardCount); 
	       sql.open();
	       sql.append();
	       sql.setField("userCode_",this.getUserCode());
	       sql.setField("cardNum_", head.getString("BanKCard"));
	       sql.setField("userName_", head.getString("userName"));
	       sql.setField("bankName_", head.getString("bankName"));
	       sql.setField("cardType_", head.getString("cardType"));
	       sql.setField("createTime_",  TDateTime.Now());
	       sql.post();
		return success();
	}

}
