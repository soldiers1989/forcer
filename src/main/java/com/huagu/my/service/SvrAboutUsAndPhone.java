package com.huagu.my.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrAboutUsAndPhone extends CustomService {
    // 关于我们
    public boolean aboutUs() throws DataValidateException {
        SqlQuery sql = new SqlQuery(this);
        sql.add("select * from %s where UID_ = 4", appdb.T_Article);
        sql.open();
        if (!sql.eof())
            dataOut.appendDataSet(sql);
        return true;
    }

    // 客服电话
    public boolean Phone() throws DataValidateException {
        SqlQuery sql = new SqlQuery(this);
        sql.add("select * from %s where UID_ = 3", appdb.T_Article);
        sql.open();
        if (!sql.eof())
            dataOut.appendDataSet(sql);
        return true;
    }

}
