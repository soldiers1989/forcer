package com.huagu.troubleshooting.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.other.utils;

public class SvrTroubleshooting extends CustomService {
    public boolean getTroubleshooting() throws DataValidateException {
        SqlQuery sql = new SqlQuery(this);
        Record head = dataIn.getHead();
        sql.add("select UID_,content_,title_,date_,id_ from %s", appdb.T_Article);
        sql.add("where type_='20'");
        String falg = head.getString("falg");
        if (falg.equals("1") && falg != null) {
            sql.add("and id_='%s'", head.getString("id_"));
        }
        sql.add("order by date_ desc");
        sql.open();
        if (!sql.eof())
            dataOut.appendDataSet(sql);
        return true;
    }

    // 后台增加社区服务
    public boolean addTroubleshooting() throws DataValidateException {
        SqlQuery sql = new SqlQuery(this);
        Record head = dataIn.getHead();
        // 随机产生ID
        String id_ = utils.newGuid();
        id_ = id_.substring(1, id_.length() - 1);
        id_ = id_.replaceAll("-", "");
        sql.add("select UID_,content_,title_,date_,id_ from %s", appdb.T_Article);
        sql.open();
        sql.append();
        sql.setField("id_", id_);
        sql.setField("title_", head.getString("title_"));
        sql.setField("content_", head.getString("content_"));
        sql.setField("type_", 20);
        sql.setField("date_", TDateTime.Now());
        sql.post();
        return true;
    }

    // 后台删除社区服务
    public boolean delTroubleshooting() throws DataValidateException {
        Record headIn = dataIn.getHead();
        SqlQuery ds = new SqlQuery(this);
        ds.add("select UID_,content_,title_,date_,id_ from %s", appdb.T_Article);
        ds.add("where id_='%s'", headIn.getSafeString("id_"));
        ds.open();
        ds.delete();
        return true;
    }

    // 后台修改社区服务
    public boolean upTroubleshooting() throws DataValidateException {
        Record headIn = dataIn.getHead();
        SqlQuery ds = new SqlQuery(this);
        ds.add("select UID_,content_,title_,date_,id_ from %s", appdb.T_Article);
        ds.add("where id_='%s'", headIn.getString("id_"));
        ds.open();
        ds.edit();
        ds.setField("title_", headIn.getString("title_"));
        ds.setField("content_", headIn.getString("content_"));
        ds.post();
        return true;

    }
}
