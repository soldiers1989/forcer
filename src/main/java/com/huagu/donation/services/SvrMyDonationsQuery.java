package com.huagu.donation.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 我的捐赠查询展示
 *  @author 王姣
 *  @date   2018年3月15日下午2:44:08
 *  @return
 */
public class SvrMyDonationsQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql=new SqlQuery(this);
		sql.add("select UID_ ,DATE_FORMAT(createDate_,'%s') as createDate_, gdStatus_,gdMobile_,updateDate_ ,donationId_ ,productNum_ ,proGuiGe_ ,proRemark_ ,status_ ,userCode_ from %s " ,"%Y-%m-%d",appdb.Donation);
		sql.add("where  userCode_ = '%s'" ,this.getUserCode());
		sql.add("order by createDate_ desc ");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
