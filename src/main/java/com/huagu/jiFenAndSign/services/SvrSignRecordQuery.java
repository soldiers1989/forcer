package com.huagu.jiFenAndSign.services;


import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 后台签到记录查询展示
 *  @author 王姣
 *  @date   2018年3月19日下午4:24:40
 *  @return
 */
public class SvrSignRecordQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String grade_ = head.getString("grade_");
		sql.add("select * from (");
		sql.add("select *,DATE_FORMAT(s.createTime_,'%s') as createTime,(select name_  from %s u where u.code_ =  s.userCode_ )  userName," ,"%Y-%m-%d %H:%m:%s",appdb.S_Userinfo);
		sql.add("(select mobile_  from %s u where u.code_ =  s.userCode_ )  mobile," ,appdb.S_Userinfo);
		sql.add("(select sum(integral_)   from %s where userCode_ =  s.userCode_ )  sum ," ,appdb.Integral);
		sql.add("(select integral_ from %s where type_ = '0' ) integral_" ,appdb.IngetralType);
		sql.add("from %s	s" ,appdb.Sign);
		sql.add("where 1 = 1 and UID_ not in ('1')  ");
		sql.add("order by s.createTime_ desc");
		sql.add(") as r");
		if(grade_ != null && !"".equals(grade_)){
			sql.add(" where r.grade_='%s' " ,grade_);
		}
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
