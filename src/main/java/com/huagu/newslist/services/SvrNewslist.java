package com.huagu.newslist.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.other.utils;

public class SvrNewslist extends CustomService {
    // 后台查询消息列表
    public boolean getNews() throws DataValidateException {
        SqlQuery sql = new SqlQuery(this);
        Record head = dataIn.getHead();
        String startDate = head.getString("unlockDate_");
        String endDate = head.getString("endDate_");
        String sender_ = head.getString("sender_");
        sql.add("select UID_ , id_,sender_ ,sendOb_ ,content_, DATE_FORMAT(sendTime_,'%s') as sendTime_   from %s", "%Y-%m-%d %H:%m:%s",appdb.Newslist);
        sql.add("where 1 = 1");
        String falg = head.getString("falg");
        if (falg.equals("1") && falg != null) {
            sql.add("and id_='%s'", head.getString("id_"));
        }
        if(sender_ != null && sender_ != ""){
        	sql.add("and sender_ like '%s'" ,new String("%"+sender_+"%"));
        }
        if (startDate != null && startDate != ""){
            sql.add("and unix_timestamp(sendTime_) between unix_timestamp( '%s') and unix_timestamp('%s')",
                startDate, endDate);
      }
        sql.open();
        if (!sql.eof())
            dataOut.appendDataSet(sql);
        return true;                                                     
    }
    
    // 后台查询消息详情
    public boolean getNewsDetails() throws DataValidateException {
        SqlQuery sql = new SqlQuery(this);
        Record head = dataIn.getHead();
        sql.add("select * from %s", appdb.Newslist);
        sql.add("where 1 = 1");
        String falg = head.getString("falg");
        if (falg.equals("1") && falg != null) {
            sql.add("and  id_='%s'", head.getString("id_"));
        }

        sql.add("and  id_='%s'", head.getString("id_"));
/*
        if (head.hasValue("mobile_")) {
        	sql.add("and userCode_ like '%s'", '%' + head.getString("mobile_") + '%');
        }
        if (head.hasValue("unlockDate_")) {
        	sql.add("and sendTime_ >= '%s'", head.getString("unlockDate_"));
        }
        if (head.hasValue("endDate_")) {
        	sql.add("and sendTime_ <= '%s'", head.getString("endDate_"));
        }
*/
        sql.open();
        if (!sql.eof())
            dataOut.appendDataSet(sql);
        return true;                                                     
    }
    

    // 查询消息详情（运维端）
    public boolean getNew() throws DataValidateException {
        SqlQuery sql = new SqlQuery(this);
        Record head = dataIn.getHead();
        sql.add("select * from %s", appdb.Newslist);
        sql.add("where id_='%s'", head.getString("id_"));
        sql.add(" and sendOb_='%s'", "运维");
        sql.open();
        if (!sql.eof())
            dataOut.appendDataSet(sql);
        return true;
    }

    // 查询消息（运维端）
    public boolean getNewList() throws DataValidateException {
        SqlQuery sql = new SqlQuery(this);
        sql.add("select * from %s", appdb.Newslist);
        sql.add("where sendOb_='%s'", "运维");
        sql.open();
        if (!sql.eof())
            dataOut.appendDataSet(sql);
        return true;
    }
    
    // 后台增加消息
    public boolean addNews() throws DataValidateException {
        SqlQuery sql = new SqlQuery(this);
        Record head = dataIn.getHead();
        // 随机产生ID
        String id_ = utils.newGuid();
        id_ = id_.substring(1, id_.length() - 1);
        id_ = id_.replaceAll("-", "");

        sql.add("select UID_,title_,content_,type_,sendTime_,sendOb_,id_ from %s", appdb.Newslist);
        sql.open();
        sql.append();
        sql.setField("id_", id_);
        sql.setField("type_", "2");
        sql.setField("content_", head.getString("content_"));
        sql.setField("sendTime_", TDateTime.Now());
        sql.setField("sendOb_", head.getString("sendOb_"));
        sql.post();
        return true;
    }

    // 后台删除消息
    public boolean delNews() throws DataValidateException {
        Record headIn = dataIn.getHead();
        SqlQuery ds = new SqlQuery(this);
        ds.add("select UID_,title_,content_,type_,sendTime_,sendOb_,id_ from %s", appdb.Newslist);
        ds.add("where id_='%s'", headIn.getSafeString("id_"));
        ds.open();
        ds.delete();
        return true;
    }

    // 后台修改消息
    public boolean upNews() throws DataValidateException {
        Record headIn = dataIn.getHead();
        SqlQuery ds = new SqlQuery(this);
        ds.add("select UID_,content_ from %s", appdb.Newslist);
        ds.add("where id_='%s'", headIn.getString("id_"));
        ds.open();
        ds.edit();
        ds.setField("content_", headIn.getString("content_"));
        ds.post();
        return true;

    }
}