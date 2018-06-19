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
 *  @describe 编辑积分说明
 *  @author 王姣
 *  @date   2018年4月4日下午2:45:43
 *  @return
 */
public class SvrEditIntExp extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String updateUser_ = this.getUserCode();
		if("".equals(updateUser_)){
			updateUser_ = "17620458925";
		}
		sql.add("select UID_  , explain_ ,updateTime_ ,updateUser_  from %s" ,appdb.Integral);
		sql.open();
		sql.edit();
		sql.setField("updateUser_", updateUser_);
		sql.setField("updateTime_", TDateTime.Now());
		sql.setField("explain_", head.getString("explain_"));
		sql.post();
		return this.success();
	}

}
