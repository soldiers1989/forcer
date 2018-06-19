package com.huagu.my.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.other.utils;

public class SvrGuideOrder extends CustomService {

	/**
	 * 指南标题查询
	 * 
	 * @return
	 * @throws DataValidateException
	 */

	public boolean querytitle() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select title_,id_ ,content_ from %s", appdb.T_Article);
		sql.add("where type_= '%s'", head.getString("type"));
		DataSet ds = sql.open();
		dataOut.appendDataSet(ds);
		return true;
	}

	/**
	 * 指南标题内容查询
	 * 
	 * @return
	 * @throws DataValidateException
	 */

	public boolean querycontent() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select id_,title_,content_ from %s", appdb.T_Article);
		sql.add("where id_='%s' ", head.getString("id"));
		DataSet ds = sql.open();
		dataOut.appendDataSet(ds);
		return true;
	}

	/**
	 * 指南添加
	 * 
	 * @return
	 * @throws DataValidateException
	 */

	public boolean addtitle() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String createUser_;
		if(getUserCode() != null){
			createUser_ = this.getUserCode();
		}else{
			createUser_  = "17620458925";
		}
		String id = utils.newGuid();
		id = id.substring(1, id.length() - 1);
		id = id.replaceAll("-", "");
		sql.add("select UID_,id_,createDate_,createUser_,title_,content_,type_ from %s", appdb.T_Article);
		sql.open();
		sql.append();
		sql.setField("id_", id);
		sql.setField("createUser_", createUser_);
		sql.setField("createDate_", TDateTime.Now());
		sql.setField("title_", head.getString("title"));
		sql.setField("content_", head.getString("content"));
		sql.setField("type_", 0);
		sql.post();
		return true;
	}

	/**
	 * 指南删除
	 * 
	 * @return
	 * @throws DataValidateException
	 */
	public boolean deletetitle() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select * from %s", appdb.T_Article);
		sql.add("where id_ = '%s'", head.getString("id"));
		sql.open();
		sql.delete();
		return true;

	}

	/**
	 * 指南修改
	 * 
	 * @return
	 * @throws DataValidateException
	 */
	public boolean modifytitle() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String updateUser_;
		if(getUserCode() != null){
			updateUser_ = this.getUserCode();
		}else{
			updateUser_  = "17620458925";
		}
		sql.add("select UID_,id_,updateDate_,updateUser_,title_,content_,type_ from %s", appdb.T_Article);
		sql.add("where  id_= '%s'", head.getString("id_"));
		sql.open();
		sql.edit();
		sql.setField("updateUser_", updateUser_);
		sql.setField("updateDate_", TDateTime.Now());
		sql.setField("title_", head.getString("title"));
		sql.setField("content_", head.getString("content"));
		sql.setField("type_",  0);
		sql.post();
		return true;
	}
}
