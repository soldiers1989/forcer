package com.huagu.my.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrMyCenter extends CustomService {
    public boolean getMyData() throws DataValidateException {
    	 String userid_;
         if (getUserCode() != "") {
             userid_ = this.getUserCode();
         } else {
             userid_ = "13277031262";
         }

        SqlQuery sql = new SqlQuery(this);
        sql.add("select imgUrl_,mobile_,name_ from s_userinfo", appdb.S_Userinfo);
        sql.add("where mobile_='%s'", userid_);
        sql.open();
        if (!sql.eof())
            dataOut.appendDataSet(sql);
        return true;
    }
}
