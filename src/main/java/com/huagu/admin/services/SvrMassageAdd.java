package com.huagu.admin.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.other.utils;

/**
 * 发送系统消息
 * 
 * @author xiaofei-pc
 *
 */
public class SvrMassageAdd extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		// 创建新的唯一id
		String guid = utils.newGuid();
		guid = guid.substring(1, guid.length() - 1);
		guid = guid.replaceAll("-", "");
		SqlQuery ds = new SqlQuery(this);
		ds.add("SELECT UID_,createDate_,createUser_,userCode_,title_,message_,type_,belong_,status_,msgUrl_,messageId_ FROM %s",
				appdb.T_MESSAGE);
		ds.open();
		ds.setMaximum(0);
		ds.append();
		ds.setField("createDate_", TDateTime.Now());
		ds.setField("createUser_", this.getUserCode());
		ds.setField("userCode_", this.getUserCode());
		ds.setField("title_", headIn.getString("title_"));
		ds.setField("message_", headIn.getString("message_"));
		ds.setField("type_", 1);
		ds.setField("belong_", headIn.getString("belong_"));
		ds.setField("status_", 0);
		ds.setField("msgUrl_", "");
		ds.setField("messageId_", guid);
		ds.post();
		return success();
	}

}
