package com.huagu.my.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.other.utils;

public class SvrFeedBack extends CustomService{
	

	public boolean addopinion() throws DataValidateException {
		
		Record head = dataIn.getHead();
		String userid_ = this.getUserCode();
		/*if(getUserCode() != ""){
			userid_ = this.getUserCode();
		}else{
			userid_ = "18827529536";
		}*/
		if("".equals(userid_)){
			userid_ = "17620458925";
		}
		SqlQuery sql1 = new SqlQuery(this);
		sql1.add("select UID_ , name_ ,code_ ,mobile_ from %s" ,appdb.S_Userinfo);
		sql1.add("where code_ = '%s'" ,userid_);
		sql1.open();
		
		SqlQuery sql = new SqlQuery(this);
		String id = utils.newGuid();
		id = id.substring(1, id.length() - 1);
		id = id.replaceAll("-", "");
		Date d = new Date();    
        String submit_time = null;  
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");    
		submit_time = sdf.format(d);    
		sql.add("select UID_,id_,userid_,view_,username,userphone from %s", appdb.Feedback);
		sql.open();
		sql.append();
		sql.setField("view_", head.getString("view_"));
		sql.setField("id_", id);
		sql.setField("submit_time", submit_time);
		sql.setField("userid_", userid_);
		sql.setField("username", sql1.getField("name_"));
		sql.setField("userphone", sql1.getField("mobile_"));
		sql.post();
		return true;
	}
	
	/**
	 * 反馈建议后台查询展示
	 * @author 王姣
	 * @date 2018年3月20日下午4:32:03
	 * @return
	 */
	public boolean queryopinion() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();

        String userCode_ = head.getSafeString("code_");
        if ("".equals(userCode_)) 
            userCode_ = this.getUserCode();
        
		String username = head.getString("username");
		String view_ = head.getString("view_");
		String startDate = head.getString("unlockDate_");
	    String endDate = head.getString("endDate_");
		String userphone = head.getString("userphone");
		sql.add("select UID_ ,id_,view_ ,DATE_FORMAT(submit_time,'%s') as submit_time ,userCode_,username ,userphone  from %s " ,"%Y-%m-%d %H:%m:%s",appdb.Feedback);
		sql.add("where 1 = 1");
		/*sql.add("and userid_ = '%s'" ,userCode_);*/
		if(username != null && username != "")
			sql.add("and username like '%s'" ,new String("%"+username+"%"));
		if(view_ != null && view_ != "")
			sql.add("and view_ like '%s'" ,new String("%"+view_+"%"));
		if(userphone != null && userphone != "")
			sql.add("and userphone like '%s'" ,new String("%"+userphone+"%"));
		if (startDate != null && startDate != ""){
	          sql.add("and unix_timestamp(submit_time) between unix_timestamp( '%s') and unix_timestamp('%s')",
	              startDate, endDate);
	    }
		sql.add("order by submit_time desc");
		DataSet ds = sql.open();
		dataOut.appendDataSet(ds);
		return true;
	}
	public boolean deleteadr() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select * from %s" , appdb.Feedback);
		sql.add("where id_ = '%s'", head.getString("id"));
		sql.open();
		sql.delete();
		return true;

	}
//回复
	public boolean addreply() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String userCode_;
		if(getUserCode() != null ){
			userCode_ = this.getUserCode();
		}else{
			userCode_ = "17620458925";
		}
		String replyid = utils.newGuid();
		replyid = replyid.substring(1, replyid.length() - 1);
		replyid = replyid.replaceAll("-", "");
		Date d = new Date();    
        String answer_time = null;  
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");    
		answer_time = sdf.format(d);
		sql.add("select UID_ ,view_ ,reply_,replyid_,answer_time ,username ,userphone ,userCode_  from %s " ,appdb.Feedback);
		sql.add("where id_ = '%s'", head.getString("id_"));
		sql.open();
		sql.edit();
		sql.setField("replyid_", replyid);
		sql.setField("reply_", head.getString("reply"));
/*		sql.setField("id_", head.getString("id"));*/
		sql.setField("userCode_", userCode_);
		sql.setField("answer_time", answer_time);
		sql.post();
		return true;
	}
	
	/**
	 * 查看反馈详情（后台）
	 * @author 王姣
	 * @date 2018年3月20日下午4:31:50
	 * @return
	 */
	public boolean opinionDetail() throws DataValidateException{
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_ ,id_,view_ ,DATE_FORMAT(submit_time,'%s') as submit_time,DATE_FORMAT(answer_time,'%s') as answer_time ,reply_,username ,userCode_ ,userphone  from %s " ,"%Y-%m-%d %H:%m:%s","%Y-%m-%d %H:%m:%s",appdb.Feedback);
		sql.add("where id_ = '%s'" ,head.getString("id_"));
		DataSet ds = sql.open();
		dataOut.appendDataSet(ds);
		return true;
	}
	

	/**
	 * 查看回复详情（后台）
	 * @author 王姣
	 * @date 2018年3月20日下午4:31:50
	 * @return
	 */
	public boolean replyDetail() throws DataValidateException{
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select UID_ ,view_ ,reply_,replyid_,answer_time,username ,userphone ,userCode_  from %s " ,appdb.Feedback);
		sql.add("where id_ = '%s'", head.getString("id_"));
		DataSet ds = sql.open();
		dataOut.appendDataSet(ds);
		return true;
	}
	
	/**
	 *   前台反馈意见记录查询
	 *  @author wj  
	 *  @date 2018年5月16日
	 */
	public boolean  opinionShow() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();

        String userCode_ = head.getSafeString("code_");
        if ("".equals(userCode_)) 
            userCode_ = this.getUserCode();
        
		String username = head.getString("username");
		String view_ = head.getString("view_");
		String startDate = head.getString("unlockDate_");
	    String endDate = head.getString("endDate_");
		String userphone = head.getString("userphone");
		sql.add("select UID_ ,id_,view_ ,DATE_FORMAT(submit_time,'%s') as submit_time ,userCode_,username ,userphone  from %s " ,"%Y-%m-%d %H:%m:%s",appdb.Feedback);
		sql.add("where 1 = 1");
		sql.add("and userid_ = '%s'" ,userCode_);
		if(username != null && username != "")
			sql.add("and username like '%s'" ,new String("%"+username+"%"));
		if(view_ != null && view_ != "")
			sql.add("and view_ like '%s'" ,new String("%"+view_+"%"));
		if(userphone != null && userphone != "")
			sql.add("and userphone like '%s'" ,new String("%"+userphone+"%"));
		if (startDate != null && startDate != ""){
	          sql.add("and unix_timestamp(submit_time) between unix_timestamp( '%s') and unix_timestamp('%s')",
	              startDate, endDate);
	    }
		sql.add("order by submit_time desc");
		DataSet ds = sql.open();
		dataOut.appendDataSet(ds);
		return true;
	}
	
}
