package com.huagu.my.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.other.utils;

public class SvrFeedBackYunWei extends CustomService {
    // 查询反馈内容（运维端）
    public boolean selectFeedBack() throws DataValidateException {
        SqlQuery sql = new SqlQuery(this);
        String userid_;
        if (getUserCode() != "") {
            userid_ = this.getUserCode();
        } else {
            userid_ = "13277031262";
        }
        sql.add("select UID_,id_,userid_,view_,submit_time from %s", appdb.Feedback);
        sql.add("where userid_='%s'", userid_);
        sql.open();
        if (!sql.eof())
            dataOut.appendDataSet(sql);
        return true;
    }

    // 增加反馈内容（运维端）
    public boolean addView() throws DataValidateException {
    	Record head = dataIn.getHead();
		String userid_ = this.getUserCode();
        SqlQuery sql = new SqlQuery(this);
        // 随机产生ID
        String id_ = utils.newGuid();
        id_ = id_.substring(1, id_.length() - 1);
        id_ = id_.replaceAll("-", "");

        sql.add("select UID_,id_,userid_,view_,submit_time from %s", appdb.Feedback);
        sql.open();
        sql.append();
        sql.setField("id_", id_);
    	sql.setField("userid_", userid_);
        sql.setField("view_", head.getString("view_"));
        sql.setField("submit_time", TDateTime.Now());
        sql.post();
        return true;
    }

}
