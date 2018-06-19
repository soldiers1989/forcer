package com.huagu.helpcenter.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.other.utils;

public class SvrHelpcenter extends CustomService{
	

	public boolean getArticle() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this); 
    	Record head=dataIn.getHead();
    	String startDate = head.getString("unlockDate_");
        String endDate = head.getString("endDate_");
		sql.add("select UID_ ,title_, DATE_FORMAT(addtime_,'%s') as addtime_ ,content_,id_ from %s", "%Y-%m-%d %H:%m:%s",appdb.Helpcenter);
		sql.add("where 1 = 1");
		/*sql.add("where id_='%s'",head.getString("id_"));*/
		String falg = head.getString("falg");
		if(falg.equals("1") && falg != null){
			sql.add("and id_='%s'",head.getString("id_"));
		}
		if (startDate != null && startDate != ""){
	          sql.add("and unix_timestamp(addtime_) between unix_timestamp( '%s') and unix_timestamp('%s')",
	              startDate, endDate);
	    }
		sql.add("order by addtime_ desc ");
		sql.open();
		if(!sql.eof())
		      dataOut.appendDataSet(sql);
		return true;
	}
	
	public boolean addArticle() throws DataValidateException {
		SqlQuery sql=new SqlQuery(this);
		Record head=dataIn.getHead();
			//随机产生ID
		String id_ = utils.newGuid();	
		id_ = id_.substring(1, id_.length() - 1);
		id_ = id_.replaceAll("-", "");
		sql.add("select UID_,title_,content_,addtime_,id_ from %s", appdb.Helpcenter);
		sql.open();
		sql.append();
		sql.setField("id_", id_);
		sql.setField("title_", head.getString("title_"));
		sql.setField("addtime_", TDateTime.Now());
		sql.setField("content_", head.getString("content_"));
		sql.post();
		return true;
	}
	
	
	public boolean delArticle() throws DataValidateException{
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select UID_,title_,content_,addtime_,id_ from %s", appdb.Helpcenter);
		ds.add("where id_='%s'", headIn.getSafeString("id_"));
		ds.open();
		ds.delete();
		return true;
}
	
	public boolean upArticle() throws DataValidateException{
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select UID_,content_,title_,addtime_ from %s", appdb.Helpcenter);
		ds.add("where id_='%s'", headIn.getString("id_"));
		ds.open();
		ds.edit();
		ds.setField("title_", headIn.getString("title_"));
		ds.setField("addtime_", TDateTime.Now());
		ds.setField("content_", headIn.getString("content_"));
		ds.post();
		return true;
		
		}	
	}