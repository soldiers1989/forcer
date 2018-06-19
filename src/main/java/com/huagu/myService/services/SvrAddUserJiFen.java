package com.huagu.myService.services;


import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.mysql.Transaction;

/**
 *  @describe 扫码后，用户得到10积分
 *  @author 王姣
 *  @date   2018年3月13日下午2:00:46
 *  @return
 */
public class SvrAddUserJiFen extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		try(Transaction tx = new Transaction(this)) {  
			//扫码后，用户获得10积分
			SqlQuery sql = new SqlQuery(this);
			Record head = dataIn.getHead();
			sql.add("select UID_ ,id_ ,code_ ,userJifen_ ,updateTime_ ,createTime_  from %s" ,appdb.S_Userinfo);
			sql.add("where id_ = '%s'" ,head.getString("id_"));
			sql.open();
			sql.edit();
			sql.setField("userJifen_", sql.getInt("userJifen_")+10);
			sql.post();
			
			//积分表添加记录
			SqlQuery sql1 = new SqlQuery(this);
			sql1.add("select UID_ ,createTime_ ,userCode_ ,integral_ ,remark_ from  %s" ,appdb.Integral);
			sql1.open();
			sql1.append();
			sql1.setField("createTime_", TDateTime.Now());
			sql1.setField("userCode_",sql.getField("code_"));
			sql1.setField("integral_", 10);
			sql1.setField("remark_", "扫码获得积分");
			sql1.setField("type_", 1);
			sql1.post();
			tx.commit();  
			}
		
		return this.success();
	}

}
