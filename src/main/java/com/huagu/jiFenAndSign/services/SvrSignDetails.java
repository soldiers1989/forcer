package com.huagu.jiFenAndSign.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 后台签到记录详情查看
 *  @author 王姣
 *  @date   2018年3月19日下午6:42:13
 *  @return
 */
public class SvrSignDetails extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select *,(select name_  from %s u where u.code_ =  s.userCode_ )  userName," ,appdb.S_Userinfo);
		sql.add("(select mobile_  from %s u where u.code_ =  s.userCode_ )  mobile," ,appdb.S_Userinfo);
		sql.add("(select sum(integral_)   from %s where userCode_ =  s.userCode_ group by integral_)  sum," ,appdb.Integral);
		/*sql.add("(select integral_  from t_integral where userCode_ =  s.userCode_ )  integral_,");
		sql.add("(select grade_  from %s where userCode_ =  s.userCode_ )  grade_," ,appdb.Integral);*/
		sql.add("(select integral_ from %s where type_ = '0' ) integral_" ,appdb.IngetralType);
		sql.add("from %s	s" ,appdb.Sign);
		sql.add("where s.userCode_ = '%s'" ,head.getString("userCode_"));
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
