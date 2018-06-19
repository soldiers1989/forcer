package com.huagu.common.services.message;

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
 * @describe 消息添加
 * @author li
 * @date 2017年11月30日上午10:32:57
 * @return
 */
public class SvrMessage_Insert extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String guid = utils.newGuid();
		guid = guid.substring(1, guid.length() - 1);
		guid = guid.replaceAll("-", "");
		sql.add("SELECT UID_,createDate_,createUser_,title_,content_,type_,sendTime_,sendOb_,id_,sender_,status_,userCode_ FROM %s",
				appdb.Newslist);
		sql.open();
		sql.append();
		sql.setField("createDate_", TDateTime.Now());
		sql.setField("createUser_", this.getUserCode());
		sql.setField("title_", head.getString("title_"));
		sql.setField("content_", head.getString("content_"));
		sql.setField("type_", head.getString("type_"));
		sql.setField("sendTime_", head.getString("sendTime_"));
		sql.setField("sendOb_", head.getString("sendOb_"));
		sql.setField("id_",guid );
		sql.setField("sender_", head.getString("sender_"));
		sql.setField("status_", 0);
		sql.setField("userCode_", head.getString("userCode_"));
		sql.post();

		return this.success();
	}

}
