package com.huagu.maintain.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * @describe 柜子相关操作（增删改查）
 * @date 2018年3月21日
 * @return
 */
public class SvrCabinetAd extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("SELECT UID_,createDate_,createUser_,cabId_,boxId_,boxName_,boxVolume_,boxType_,emptyStatus_,boxDesc_,lockDate_,boxOrderLock_,boxLockUD_,boxStatus_,boxOpen_ FROM %s", appdb.BOX);
		sql.add(" where 1=1 ");
		sql.open();
		if("b".equals(headIn.getString("type_"))){
			sql.append();
			sql.setField("createDate_", TDateTime.Now());
		}else{
			sql.append();
			sql.setField("createDate_", TDateTime.Now());
		}
		
		return this.success();
	}

}
