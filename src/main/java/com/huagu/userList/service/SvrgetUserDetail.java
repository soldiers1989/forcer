package com.huagu.userList.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrgetUserDetail extends CustomService {
    // 后台查看用户详情
    public boolean detail() throws DataValidateException {
        Record headIn = dataIn.getHead();
        SqlQuery ds1 = new SqlQuery(this);
        if("login".equals(headIn.getString("type_"))){
            ds1.add("SELECT UID_,Account_ code_,LoginTime_,UserID_ FROM s_currentuser");
            ds1.add(" WHERE UserID_ = '%s' ORDER BY LoginTime_ DESC", headIn.getString("id_"));
            ds1.setMaximum(1);
            ds1.open();
            if (!ds1.eof()) {
                dataOut.appendDataSet(ds1);
            }else{
                SqlQuery ds2 = new SqlQuery(this);
                ds2.add("SELECT UID_,code_,createTime_,name_,mobile_,enabled_,overMoney_,userJifen_,id_ FROM %s WHERE isManager_ = '0'",
                        appdb.S_Userinfo);
                ds2.add("and id_='%s'", headIn.getString("id_"));
                ds2.open();
                if (!ds2.eof()) {
                    dataOut.appendDataSet(ds2);
                }
            }
        }else{
            ds1.add("SELECT UID_,code_,createTime_,name_,mobile_,enabled_,overMoney_,userJifen_,id_ FROM %s WHERE isManager_ = '0'",
                    appdb.S_Userinfo);
            ds1.add("and id_='%s'", headIn.getString("id_"));
            ds1.open();
            if (!ds1.eof()) {
                dataOut.appendDataSet(ds1);
            }
        }
        return true;
    }

    // 后台删除用户
    public boolean delUser(DataSet dataIn, DataSet dataOut) throws ServiceException {
        Record headIn = dataIn.getHead();
        SqlQuery ds = new SqlQuery(this);
        ds.add("SELECT UID_,code_,createTime_,name_,enabled_,mobile_,overMoney_,userJifen_,id_ FROM %s WHERE isManager_ = '0'",
                appdb.S_Userinfo);
        ds.add("where code_='%s'", headIn.getSafeString("id_"));
        ds.open();
        ds.delete();
        dataOut.appendDataSet(ds);
        return true;
    }
    
    // 查询用户充值 提现记录
    public boolean getUserTransaction(DataSet dataIn, DataSet dataOut) throws ServiceException {
        Record headIn = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("SELECT userCode_,SUM(amount_) amount_ FROM %s", appdb.Record);
		sql.add("where 1 = 1");
		sql.add(" and type_ = '%s'", headIn.getString("type_"));
		sql.add(" and userCode_ = '%s'", headIn.getString("code_"));
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
        return true;
    }
}
