package com.huagu.maintain.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * @describe 查询配置柜组信息柜组
 * @date 2018年3月21日
 * @return
 */
public class SvrDepolyCabinet extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		String userCode;
		String id_= headIn.getString("id_");
		if (getUserCode() == null) {
			userCode = this.getUserCode();
		} else {
			userCode = "15071506306";
		}
		if(id_ == null || id_ == ""){
			id_ = "11111111111";
		}

		SqlQuery sql = new SqlQuery(this);
		sql.add("SELECT c.id_ id_,c.createDate_ createDate_,c.name_ name_,c.address_ address_,cm.managerId_ managerId_,ct.communityName_ ctName_  FROM %s c", appdb.CABINET);
		sql.add(" JOIN %s cm ON c.communityNum_ = cm.communityNum_", appdb.CABINETMANAGER);
		sql.add(" JOIN %s ct ON ct.communityId_ = cm.communityNum_ WHERE cm.managerId_ = '%s'", appdb.Community, userCode);
		sql.add(" AND c.id_ = '%s'", id_);
		sql.open();
		if (!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
