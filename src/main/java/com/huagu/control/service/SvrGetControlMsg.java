package com.huagu.control.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 查询系统消息Service
 * 
 * @author xiaofei-pc
 *
 */
public class SvrGetControlMsg extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {

		SqlQuery cabinetMsgList = new SqlQuery(this);
		cabinetMsgList.add("SELECT UID_,title_,content_ FROM %s",appdb.T_Article);
		cabinetMsgList.add(" WHERE 1=1");
		cabinetMsgList.add(" and type_ = '18'");
		cabinetMsgList.open();
		if (!cabinetMsgList.eof()) {
			dataOut.appendDataSet(cabinetMsgList);
		}

		return success();
	}

}
