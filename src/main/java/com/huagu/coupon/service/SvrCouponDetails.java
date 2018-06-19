package com.huagu.coupon.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrCouponDetails extends CustomService{
	
	/**
	 * 
	 *  @describe 优惠券发布详情
	 *  @author 李佳炫
	 *  @date   2018年3月19日
	 *  @return
	 */
	
	//优惠券查询
	public boolean details() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String startDate = head.getString("unlockDate_");
	    String endDate = head.getString("endDate_");
	    String type_ = head.getString("type_");
	    if(type_.equals("0")){
	    	type_ = "";
	    }
		sql.add("select UID_,couponname_,type_,use_,kind_,receive_,total_,imgUrl_,couponId_,Denomination_,range_,enddate_,enddate1_, DATE_FORMAT(releasedate_,'%s') as releasedate_  from %s", "%Y-%m-%d %H:%m:%s",appdb.t_coupon);
		sql.add("where 1 = 1 ");
		if (startDate != null && startDate != ""){
	          sql.add("and unix_timestamp(releasedate_) between unix_timestamp( '%s') and unix_timestamp('%s')",
	              startDate, endDate);
	    }if(type_ != null && type_ != ""){
	    	sql.add("and type_ = '%s'" ,type_);
	    }	
		sql.add("order by releasedate_ desc ");
		DataSet ds = sql.open();
		dataOut.appendDataSet(ds);
		return true;
	}
	
	//删除优惠券
	public boolean delcoupon() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_,couponname_,type_,receive_,total_,imgUrl_,couponId_,releasedate_ from %s", appdb.t_coupon);
		sql.add("where couponId_ = '%s'", head.getString("couponId_"));
		sql.open();
		sql.delete();
		return true;

	}
}
