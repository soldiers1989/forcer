package com.huagu.donation.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 * 捐赠单查询
 * @author wj  
 * @date 2018年5月23日 
 *
 */
public class SvrDonationsQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql=new SqlQuery(this);
		Record head = dataIn.getHead();
		String proRemark_ = head.getString("proRemark_");
		sql.add("select UID_ ,DATE_FORMAT(createDate_,'%s') as createDate_,DATE_FORMAT(updateDate_,'%s') as updateDate_,  gdStatus_,gdMobile_ ,DATE_FORMAT(gbTime_,'%s') as gbTime_,donationId_ ,productNum_ ,proGuiGe_ ,proRemark_ ,status_ ,userCode_ from %s " ,"%Y-%m-%d %H:%m:%s","%Y-%m-%d %H:%m:%s","%Y-%m-%d %H:%m:%s",appdb.Donation);
		sql.add("where 1 = 1");
		if(proRemark_!= null && proRemark_ != ""){
			sql.add("and proRemark_ like '%s'" , new String("%"+proRemark_+"%"));
		}
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
