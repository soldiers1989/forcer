package com.huagu.newslist.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrGetMessage extends CustomService {
    // 查询系统消息（用户端）
    public boolean getSystem() throws DataValidateException {
        SqlQuery sql = new SqlQuery(this);
        Record head = dataIn.getHead();
        sql.add("select title_,content_,sendTime_,type_,sendOb_,id_ from %s", appdb.Newslist);
        sql.add("where type_ ='2'");
        sql.add("order by sendTime_ desc");
        String falg = head.getString("falg");
        if (falg.equals("1") && falg != null) {
            sql.add("where id_='%s'", head.getString("id_"));
        }
        sql.open();
        if (!sql.eof())
            dataOut.appendDataSet(sql);
        return true;
    }

    // 查询系统消息详情（用户端）
    public boolean getSystemDetails() throws DataValidateException {
        SqlQuery sql = new SqlQuery(this);
        Record head = dataIn.getHead();
        sql.add("select title_,content_,sendTime_,type_,sendOb_,id_ from %s", appdb.Newslist);
        sql.add("where type_ ='2'");
        sql.add("and id_='%s'", head.getString("id_"));
        sql.add("order by sendTime_ desc");
        sql.open();
        if (!sql.eof())
            dataOut.appendDataSet(sql);
        return true;
    }

    // 查询订单消息（用户端）
    public boolean getOrder() throws DataValidateException {
        SqlQuery sql = new SqlQuery(this);
        Record head = dataIn.getHead();
        sql.add("select title_,content_,sendTime_,type_,sendOb_,status_,id_ from %s", appdb.Newslist);
        sql.add("where type_ ='1'");
        sql.add("and userCode_='%s'", head.getString("userCode"));
        sql.add("order by sendTime_ desc");
        String falg = head.getString("falg");
        if (falg.equals("1") && falg != null) {
            sql.add("where id_='%s'", head.getString("id_"));
        }
        sql.open();
        if (!sql.eof())
            dataOut.appendDataSet(sql);
        return true;
    }

}
