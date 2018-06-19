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
 *  @describe 修改签到说明数据
 *  @author 王姣
 *  @date   2018年4月4日上午10:10:33
 *  @return
 */
public class SvrEditSignExplain extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String updateUser_ ;
		if(getUserCode() != null){
			updateUser_ = this.getUserCode();
		}else{
			updateUser_ = "17620458925";
		}
		sql.add("select UID_ ,remark_ ,updateTime_ ,updateUser_  from %s " ,appdb.Sign);
		sql.open();
		sql.edit();
		sql.setField("updateUser_", updateUser_);
		sql.setField("updateTime_", TDateTime.Now());
		sql.setField("remark_", head.getString("remark_"));
		sql.post();   
		return this.success();
	}

}
