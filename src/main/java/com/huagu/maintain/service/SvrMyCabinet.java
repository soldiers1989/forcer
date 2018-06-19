package com.huagu.maintain.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * @describe 我的柜组
 * @date 2018年3月21日
 * @return
 */
public class SvrMyCabinet extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		String userCode = this.getUserCode();
		if ("".equals(userCode)) {
			userCode = "15071506306";
		}

		SqlQuery sql = new SqlQuery(this);
		sql.add("SELECT c.id_ id_,c.createDate_ createDate_,c.name_ name_,c.address_ address_ FROM %s c", appdb.CABINET);
		sql.add(" JOIN %s cm ON c.communityNum_ = cm.communityNum_", appdb.CABINETMANAGER);
		sql.add(" JOIN %s ct ON ct.communityId_ = cm.communityNum_ WHERE cm.managerId_ = '%s'", appdb.Community, userCode);
		sql.open();
		if (!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
