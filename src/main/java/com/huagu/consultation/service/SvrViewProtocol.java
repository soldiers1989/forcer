package com.huagu.consultation.service;
import com.huagu.common.global.appdb;
import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

	/**
	*  @describe 查询协议内容
	*  @author   李佳炫
	*  @date     2018年3月14日
	*  @return
	*/

public class SvrViewProtocol extends CustomService {
	//查询协议内容
	public boolean Protocolcontent() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_,id_,type_,content_ from %s", appdb.T_Article);
		sql.add("where type_= '%s'", head.getString("type_"));
		DataSet ds = sql.open();
		dataOut.appendDataSet(ds);
		return true;
	
	}
}
