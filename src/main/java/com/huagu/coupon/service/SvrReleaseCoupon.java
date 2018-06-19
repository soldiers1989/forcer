package com.huagu.coupon.service;
import org.apache.log4j.Logger;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.mysql.Transaction;
import cn.cerc.jdb.other.utils;

	/**
	 * 
	 *  @describe 优惠券发布
	 *  @author 李佳炫
	 *  @date   2018年3月16日
	 *  @return
	 */

public class SvrReleaseCoupon extends AbstractService{
	public Logger log = Logger.getLogger(this.getClass());
	
	@Override
	public IStatus execute(DataSet DataIn, DataSet DataOut) throws ServiceException {
		String userCode_ = this.getUserCode();
		if("".equals(userCode_)){
			userCode_ = "admin";
		}
		SqlQuery sql = new SqlQuery(this);
		Record head = DataIn.getHead();
		String couponId_ = utils.newGuid();
		couponId_ = couponId_.substring(1, couponId_.length() - 1);
		couponId_ = couponId_.replaceAll("-", "");
		sql.add("select UID_ , createUser_, createData_, couponId_, couponname_ ,userCode_,couponcontent_,imgUrl_,type_,receive_,total_,grantdate_,enddate_,enddate1_,Denomination_,range_ from %s",appdb.t_coupon);
		sql.open();
		sql.append();
		sql.setField("createUser_", userCode_);
		sql.setField("createData_", TDateTime.Now());
		sql.setField("releasedate_", TDateTime.Now());
		sql.setField("couponId_",couponId_ );
		sql.setField("userCode_", userCode_);
		sql.setField("couponname_", head.getString("couponname_"));
		sql.setField("couponcontent_", head.getString("couponcontent_"));
		sql.setField("imgUrl_", head.getString("imgUrl_"));
		sql.setField("type_", head.getString("type_"));
		sql.setField("receive_", head.getString("receive_"));
		sql.setField("total_", head.getString("total_"));
		sql.setField("grantdate_", head.getString("grantdate_"));
		sql.setField("grantdate1_", head.getString("grantdate1_"));
		sql.setField("enddate_",head.getString("enddate_"));
		sql.setField("enddate1_",head.getString("enddate1_"));
		sql.setField("Denomination_", head.getString("Denomination_"));
		sql.setField("range_", head.getString("range_"));
		sql.post();
		
		try (Transaction tx = new Transaction(this)) {
			SqlQuery getUser = new SqlQuery(this);
			getUser.add("select id_,code_ from %s", appdb.S_Userinfo);
			getUser.open();
			if(!getUser.eof()){
				log.info("查询到 "+ getUser.getRecords().size() +" 个用户");
				for (int i = 0; i < getUser.getRecords().size(); i++) {
					SqlQuery addCoupon = new SqlQuery(this);
					addCoupon.add("SELECT UID_,createDate_,createUser_,userCode_,couponId_,use_ FROM %s", appdb.t_couponanduser);
					addCoupon.open();
					addCoupon.setMaximum(0);
					addCoupon.append();
					addCoupon.setField("createDate_", TDateTime.Now());
					addCoupon.setField("createUser_", userCode_);
					addCoupon.setField("userCode_", getUser.getRecords().get(i).getSafeString("code_"));
					addCoupon.setField("couponId_", couponId_);
					addCoupon.setField("use_", "0");
					addCoupon.post();
				}
			}
			tx.commit();
		}
		
		return this.success();
	}
}
