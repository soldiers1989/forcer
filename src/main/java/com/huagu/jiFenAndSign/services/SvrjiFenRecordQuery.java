package com.huagu.jiFenAndSign.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 积分记录后台查询展示
 *  @author 王姣
 *  @date   2018年3月16日下午5:34:25
 *  @return
 */
public class SvrjiFenRecordQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String type_ = head.getString("type_");
		String shareName = head.getString("shareName");
		if(type_.equals("2"))
			type_ = "";
		sql.add("select  *, (select u.name_  from %s u where u.code_ =  t.userCode_) shareName , " ,appdb.S_Userinfo );
		sql.add("(select name_  from %s u where u.code_ =  t.userId_) regName ," ,appdb.S_Userinfo);
		sql.add("(select sum(integral_)   from %s where userCode_ =  t.userCode_ ) sum" ,appdb.Integral);
		sql.add("from %s t" ,appdb.Integral);
		sql.add("where 1 = 1  and t.UID_ not in ('1') " );
		if(type_ != null && type_ != ""){
			sql.add("and type_ like '%s'" ,new String("%"+type_+"%"));
		}
		if(shareName != null && shareName != ""){
			sql.add("and t.userCode_ in(select code_ from %s where name_ LIKE '%s')" ,appdb.S_Userinfo,new String("%"+shareName+"%"));
		}
		sql.add("order by t.createTime_ desc");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
