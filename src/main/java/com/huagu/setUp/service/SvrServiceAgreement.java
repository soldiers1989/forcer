package com.huagu.setUp.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrServiceAgreement extends CustomService {
    // 运维服务
    public boolean getAgreement() throws DataValidateException {
        SqlQuery sql = new SqlQuery(this);
        sql.add("select * from %s where UID_ = 6", appdb.T_Article);
        sql.open();
        if (!sql.eof())
            dataOut.appendDataSet(sql);
        return true;
    }
}