package com.huagu.donation.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.other.utils;

/**
 *  @describe 前台我要捐赠
 *  @author 王姣
 *  @date   2018年3月15日上午9:59:22
 *  @return
 */
public class SvrMyDonationInsert extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery  sql1 = new SqlQuery(this);
		sql1.add("select UID_ ,id_   from %s " ,appdb.Cabinet);
		sql1.open();	
		
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String guid = utils.newGuid();
	      guid = guid.substring(1, guid.length() - 1);
	      guid = guid.replaceAll("-", "");
		sql.add("select UID_ ,createDate_ ,updateDate_ ,donationId_ ,productNum_ ,proGuiGe_ ,proRemark_ ,status_ ,userCode_ ,cabId_  from %s " ,appdb.Donation);
		sql.open();
		sql.append();
		sql.setField("userCode_", this.getUserCode());
		sql.setField("createDate_", TDateTime.Now());
		sql.setField("donationId_", guid);
		sql.setField("productNum_", head.getString("productNum_"));
		sql.setField("proGuiGe_", head.getString("proGuiGe_"));
		sql.setField("proRemark_", head.getString("proRemark_"));
		sql.setField("cabId_", sql1.getField("id_"));
		sql.setField("status_", 0);
		sql.post();
		return this.success();
	}

}
