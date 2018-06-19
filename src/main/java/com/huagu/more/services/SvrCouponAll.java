package com.huagu.more.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 查询用户可用优惠卷
 * @author xiaofei-pc
 *
 */
public class SvrCouponAll extends CustomService {
	public boolean getCouponAll() throws DataValidateException {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("select count(*) as couponAll, use_ from %s", appdb.t_couponanduser);
		sql.add("where userCode_ = '%s'", head.getString("userCode"));
		sql.add("and use_='0'");
		sql.open();
		if (!sql.eof())
			dataOut.appendDataSet(sql);
		return true;
	}

}
