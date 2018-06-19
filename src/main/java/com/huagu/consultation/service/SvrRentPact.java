package com.huagu.consultation.service;
import com.huagu.common.global.appdb;
import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.other.utils;

/**
*  @describe 查询修改用户凭租协议
*  @author   李佳炫
*  @date     2018年3月14日
*  @return
 */

public class SvrRentPact extends CustomService{
    
	//查询协议
	public boolean selpact() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_,id_,title_,content_,DATE_FORMAT(date_,'%s') as date_,type_ from %s", "%Y-%m-%d %H:%m:%s" ,appdb.T_Article);
		sql.add("where type_= '%s'", head.getString("type_"));
		DataSet ds = sql.open();
		dataOut.appendDataSet(ds);
		return true;
	
	}

    //修改协议
	public boolean editpact() throws DataValidateException {
		String id_ = utils.newGuid();
		id_ = id_.substring(1, id_.length() - 1);
		id_ = id_.replaceAll("-", "");
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_,id_,title_,content_,date_ from %s", appdb.T_Article);
		sql.add("where id_= '%s'", head.getString("id_"));
		sql.open();
		sql.edit();
		sql.setField("id_", head.getString("id_"));
		sql.setField("title_", head.getString("title_"));
		sql.setField("content_", head.getString("content_"));
		sql.setField("date_", TDateTime.Now());
		sql.post();
		return true;
	}

	
}
