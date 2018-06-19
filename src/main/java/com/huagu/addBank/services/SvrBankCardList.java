package com.huagu.addBank.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrBankCardList extends CustomService{
	   // 查询绑定的银行卡列表
    public boolean getBankCardList() throws DataValidateException {
        SqlQuery sql = new SqlQuery(this);
        sql.add("select createTime_,userCode_,cardNum_,bankName_,userName_,cardType_ from %s",appdb.BankCardCount);
        sql.add("where userCode_='%s'",this.getUserCode());
        sql.open();
        if (!sql.eof())
            dataOut.appendDataSet(sql);
        return true;
    }
    // 删除银行卡
    public boolean delBankCard() throws DataValidateException {
        Record headIn = dataIn.getHead();
        SqlQuery ds = new SqlQuery(this);
        ds.add("select UID_,createTime_,userCode_,cardNum_,bankName_,userName_,cardType_ from %s",appdb.BankCardCount);
        ds.add("where cardNum_='%s'", headIn.getSafeString("cardNum_"));
        ds.open();
        ds.delete();
        return true;
    }
    
}
