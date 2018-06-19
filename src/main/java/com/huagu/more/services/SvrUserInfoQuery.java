package com.huagu.more.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * @describe 个人中心我的信息展示
 * @author 王姣
 * @date 2018年3月9日上午11:50:58
 * @return
 */
public class SvrUserInfoQuery extends AbstractService {

    @Override
    public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
        SqlQuery sql = new SqlQuery(this);
  /*      String userCode;
        if(getUserCode() != null){
        	userCode = this.getUserCode();
        }else{
        	userCode = "17620458925";
        }*/
        Record head = dataIn.getHead();
        sql.add("select UID_ ,code_ ,id_ ,mobile_ ,name_ ,imgUrl_,overMoney_ from %s", appdb.S_Userinfo);
        sql.add("where code_ =  '%s'", head.getString("userCode"));
        sql.open();
        // 查询今天是否已经签到
        SqlQuery sql2 = new SqlQuery(this);
        sql2.add("select * from %s where CURRENT_DATE = DATE_FORMAT(createTime_,'%s')", appdb.Sign, "%Y%m%d");
        sql2.add("and  userCode_ =  '%s'", sql.getField("code_"));
        sql2.open();
        if (!sql2.eof()) {
            sql.setField("sign", 1); // 已签到
        } else {
            sql.setField("sign", 0); // 未签到
        }
        if (!sql.eof())
            dataOut.appendDataSet(sql);
        return this.success();

    }

}
