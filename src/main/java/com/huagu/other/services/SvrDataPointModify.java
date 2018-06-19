package com.huagu.other.services;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

import com.huagu.common.global.appdb;
import com.huagu.common.util.StringUtils;

public class SvrDataPointModify extends AbstractService {

	/**
	 * 数据埋点
	 */
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut)
			throws ServiceException {
		Record headIn = dataIn.getHead();
		DataValidateException.stopRun("参数错误", !dataIn.getHead().hasValue("DataPointUrl"));
		DataValidateException.stopRun("参数错误", !dataIn.getHead().hasValue("corpNo"));
		DataValidateException.stopRun("参数错误", !dataIn.getHead().hasValue("DataPointName"));
		
		if (StringUtils.isEmpty(headIn.getSafeString("TickCount"))
				&& StringUtils.isEmpty(headIn.getSafeString("Amount"))) {
			return fail("参数错误：TickCount_、Amount_至少传一个参数");
		}
		
		SqlQuery sq = new SqlQuery(this);
		sq.add("select UID_,CorpNo_,CreateTime_,UpdateTime_,DataPointUrl_,DataPointName_,TickCount_,Amount_ from %s", appdb.getDataPoint(this));
		sq.add("where DataPointUrl_ = '%s'", headIn.getSafeString("DataPointUrl"));
		sq.add("and CorpNo_ = '%s'", headIn.getSafeString("corpNo"));
		sq.open();
		if (sq.eof()) {
			sq.append();
			sq.setField("CorpNo_", headIn.getSafeString("corpNo"));
			sq.setField("createTime_", TDateTime.Now());
			sq.setField("DataPointUrl_", headIn.getSafeString("DataPointUrl"));
			sq.setField("DataPointName_", headIn.getSafeString("DataPointName"));
		} else {
			sq.edit();
		}
		sq.setField("TickCount_", sq.getDouble("TickCount_") + headIn.getDouble("TickCount"));
		sq.setField("Amount_", sq.getDouble("Amount_") + headIn.getDouble("Amount"));
		sq.post();
		return success();
	}

}
