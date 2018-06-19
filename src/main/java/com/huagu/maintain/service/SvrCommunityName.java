package com.huagu.maintain.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrCommunityName extends AbstractService{
		@Override
		public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
			String userCode = this.getUserCode();
			if ("".equals(userCode)) {
				userCode = "13277031262";
			}
			SqlQuery sql = new SqlQuery(this);
			sql.add("SELECT distinct ct.communityJname_ FROM %s c", appdb.CABINET);
			sql.add(" JOIN %s cm ON c.communityNum_ = cm.communityNum_", appdb.CABINETMANAGER);
			sql.add(" JOIN t_box cb on cb.cabId_=c.id_");
			sql.add(" JOIN %s ct ON ct.communityId_ = cm.communityNum_ WHERE cm.managerId_ = '%s'", appdb.Community, userCode);
			sql.add(" and c.cabinetType_='1'");
			sql.open();
			if (!sql.eof())
				dataOut.appendDataSet(sql);
			return this.success();
		}
}
