package com.huagu.setUp.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrPersonalData extends CustomService {
    public boolean getData() throws DataValidateException {
        Record head = dataIn.getHead();
        SqlQuery sql = new SqlQuery(this);
        sql.add("select imgUrl_,mobile_,userVIP_ from s_userinfo", appdb.S_Userinfo);
        sql.add("where code_='%s'", head.getString("userCode"));
        sql.open();
        if (!sql.eof())
            dataOut.appendDataSet(sql);
        return true;
    }
}
