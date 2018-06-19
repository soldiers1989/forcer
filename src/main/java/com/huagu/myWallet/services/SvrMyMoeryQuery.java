package com.huagu.myWallet.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 我的钱包
 *  @author 王姣
 *  @date   2018年3月13日下午4:17:05
 *  @return
 */
public class SvrMyMoeryQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		String userCode = this.getUserCode();
		if("".equals(userCode)){
			 userCode = "17620458925";
		}
		
		SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_ ,overMoney_ ,code_  from %s" ,appdb.S_Userinfo);
		sql.add("where code_ = '%s'" , userCode);
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
