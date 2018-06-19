package com.huagu.myWallet.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;

/** 
 *  @describe 交易明细
 *  @author 王姣
 *  @date   2018年3月13日下午5:00:40
 *  @return
 */
public class SvrTransactionDetails extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		String userCode = this.getUserCode();
		if("".equals(userCode)){
			 userCode = "17620458925";
		}
		
		SqlQuery sql = new SqlQuery(this);
		sql.add("select r.UID_ ,r.createTime_ ,r.platform_ ,r.userNowMoney_,r.userCode_ ,r.amount_, r.type_, r.opeType_ ,u.overMoney_");
		sql.add("from  %s r  join  %s u" ,appdb.Record, appdb.S_Userinfo);
		sql.add("on u.code_ = r.userCode_");
		sql.add("where r.userCode_ = '%s'" ,userCode);
		sql.add("group by r.createTime_ desc ");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
