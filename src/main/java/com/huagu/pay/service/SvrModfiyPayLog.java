package com.huagu.pay.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * @ClassName: SvrModfiyPayLogService
 * @Description: 
 * @author hyt
 * @date 2016年11月17日 9:44:22
 * 
 */
public class SvrModfiyPayLog extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery sq = new SqlQuery(this);
		sq.add("SELECT UID_,createTime_,createUser_,updateTime_,updateUser_,platform_,userCode_,type_,opeType_,amount_ FROM %s", appdb.Record);
		sq.open();
		if(sq.eof()){
			sq.append();
			sq.setField("createTime_", TDateTime.Now());
			sq.setField("createUser_", "");
			sq.setField("platform_", headIn.getSafeString("platform_"));
			sq.setField("userCode_", headIn.getSafeString("userCode_"));
			sq.setField("type_", headIn.getSafeString("type_"));
			sq.setField("opeType_", headIn.getSafeString("opeType_"));
			sq.setField("amount_", headIn.getSafeString("amount_"));
		}else{
			sq.edit();
			sq.setField("updateTime_", TDateTime.Now());
			sq.setField("mch_id_", headIn.getSafeString("mch_id_"));
		}
		sq.post();
		dataOut.appendDataSet(sq);
		return success();
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}

}
