package com.huagu.personalInfo.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 * 个人客户邀请
 * @author wj  
 * @date 2018年5月17日 
 *
 */
public class SvrGetcustomerInvitation extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
	/*	SqlQuery sql1 = new SqlQuery(this);
		Record headIn = dataIn.getHead();
		sql1.add("select u.UID_ , u.code_, u.name_, u.imgUrl_,i.createTime_ ,i.integral_ ,i.userId_,u.createTime_");
		sql1.add("from  s_userinfo  u join  t_integral  i on i.userCode_ = u.code_ ");
		sql1.add("where i.type_= '1' and i.userCode_ = '%s'" ,headIn.getString("userCode_"));
		sql1.open();*/
		
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String  userId_ = head.getString("userId_");
		sql.add("select u.UID_ , u.code_, i.userCode_,u.name_, u.mobile_, u.imgUrl_, DATE_FORMAT(i.createTime_,'%s') as createTime_  ,i.integral_ ,i.userId_,u.createTime_," ,"%Y-%m-%d %H:%m:%s");
		sql.add("(select count(orderId_) from t_order where userId_ = '%s') countOrder ,",head.getString("userCode_"));
		sql.add("(select sum(sumRentMoney_) from t_order where userId_ = '%s') sumRentMoney_ ,",head.getString("userCode_"));
		sql.add("(select sum(sumMoney_) from t_order where userId_ = '%s') sumMoney_",head.getString("userCode_"));
		sql.add("from  %s  u join  %s  i" ,appdb.S_Userinfo,appdb.Integral);
		sql.add("on i.userCode_ = u.code_");
		sql.add("where i.type_= '1' and i.userCode_ = '%s'" ,head.getString("userCode_"));
		if(userId_ != null && userId_ != ""){
			sql.add("and i.userId_ like '%s'" ,new String("%"+userId_+"%"));
		}
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
