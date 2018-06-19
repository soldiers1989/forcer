package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 *  @describe 变更代理商信息
 *  @author 王姣
 *  @date   2018年3月23日下午4:16:22
 *  @return
 */
public class SvrAgentModify extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String province_ = head.getString("province_");
		String city_ = head.getString("city_");
		String area_ = head.getString("area_");
		String updateUser_ = this.getUserCode();
		if("".equals(updateUser_)){
			updateUser_ = "17620458925";
		}
		sql.add("select UID_ , createDate_,updateDate_ ,updateUser_ ,agentNum_ ,agentNo_ ,agentJname_ ,agentName_ ,agentLevel_ ,agentArea_  from %s" ,appdb.Agent);
		sql.add("where UID_ = '%s'" ,head.getString("UID_"));
		sql.open();
		sql.edit();
		sql.setField("updateDate_", TDateTime.Now());
		sql.setField("updateUser_", updateUser_);
		sql.setField("agentNo_", head.getString("agentNo_"));
		sql.setField("agentJname_", head.getString("agentJname_"));
		sql.setField("agentName_", head.getString("agentName_"));
		sql.setField("agentLevel_", head.getString("agentLevel_"));
		sql.setField("agentArea_", province_ +"-"+ city_+"-" + area_);
		sql.post();
		return this.success();
	}

}
