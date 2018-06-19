package com.huagu.jiFenAndSign.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 积分记录详情查看
 *  @author 王姣
 *  @date   2018年3月19日上午11:06:56
 *  @return
 */
public class SvrjiFenRecordQueryDetails extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select  *, (select name_  from %s u where u.code_ =  t.userCode_) shareName , " ,appdb.S_Userinfo );
		sql.add("(select name_  from %s u where u.code_ =  t.userId_) regName ," ,appdb.S_Userinfo);
		sql.add("(select sum(integral_)   from %s where userCode_ =  t.userCode_ group by integral_ ) sum" ,appdb.Integral);
		sql.add("from %s t" ,appdb.Integral);
		sql.add("where userCode_ = '%s'" ,head.getString("userCode_"));
		sql.add("order by t.createTime_ desc");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
