package com.huagu.more.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 修改使用流程
 *  @author 王姣
 *  @date   2018年3月22日下午3:38:00
 *  @return
 */
public class SvrProcessModify extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		String updateUser_ = this.getUserCode();
	    if("".equals(updateUser_)){
	      updateUser_ = "17620458925";
	    }
		Record head = dataIn.getHead();
		sql.add("select UID_ ,updateDate_ ,updateUser_ ,content_  from %s" ,appdb.UseProcess);
		sql.open();
		sql.edit();
		sql.setField("updateDate_", TDateTime.Now());
		sql.setField("updateUser_", updateUser_);
		sql.setField("content_", head.getString("content_"));
		sql.post();
		return this.success();
	}

}
