package com.huagu.consultation.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
*  @describe 资讯管理列表
*  @author   李佳炫
*  @date     2018年3月14日
*  @return 
 */

public class SvrInformationList extends CustomService{
    
	//查询文章列表
	public boolean ArticleListSel() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String startDate = head.getString("unlockDate_");
	    String endDate = head.getString("endDate_");
	    String type_ = head.getString("type_");
	    if(type_.equals("0"))
	    	type_ = "";
		sql.add("select UID_ ,DATE_FORMAT(date_,'%s') as date_ ,type_ ,title_ from %s" ,"%Y-%m-%d %H:%m:%s",appdb.T_Article);
		sql.add("where 1 = 1");
		if (startDate != null && startDate != ""){
	          sql.add("and unix_timestamp(date_) between unix_timestamp( '%s') and unix_timestamp('%s')",
	              startDate, endDate);
	    }if(type_ != null && type_ != ""){
	    	sql.add("and type_  = '%s'" ,type_);
	    }
		sql.add("order by date_ desc");  
		DataSet ds = sql.open();
		dataOut.appendDataSet(ds);
		return true;
	}
	
	

	/**
	 * 文章详情查看
	 * @author 王姣
	 * @date 2018年3月21日下午4:18:46
	 * @return
	 */
	public boolean infoDetail() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_ ,DATE_FORMAT(date_,'%s') as date_ ,type_ ,title_ ,content_ from %s" ,"%Y-%m-%d %H:%m:%s",appdb.T_Article);
		sql.add("where type_ = '%s'" ,head.getString("type_"));
		DataSet ds = sql.open();
		dataOut.appendDataSet(ds);
		return true;
	}

   

	
}
