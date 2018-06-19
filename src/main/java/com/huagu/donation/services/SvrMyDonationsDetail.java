package com.huagu.donation.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe  我的捐赠详情查看
 *  @author 王姣
 *  @date   2018年3月15日下午3:19:50
 *  @return
 */
public class SvrMyDonationsDetail extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select d.UID_ ,d.createDate_ ,d.updateDate_ ,d.donationId_ ,d.productNum_ ,");
		sql.add("d.proGuiGe_ ,d.proRemark_ ,d.status_ ,d.userCode_,u.name_ ,");
		sql.add("c.name_ ,c.address_,t.boxId_");
		sql.add("from %s  d join %s u" ,appdb.Donation,appdb.S_Userinfo);
		sql.add("on d.userCode_ = u.code_ ");
		sql.add("join %s t  on t.cabId_ = d.cabId_" ,appdb.BOX);
		sql.add("join %s c on c.id_ = t.cabId_ " ,appdb.Cabinet);
		sql.add("where d.donationId_ = '%s'" ,head.getString("donationId_"));
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
