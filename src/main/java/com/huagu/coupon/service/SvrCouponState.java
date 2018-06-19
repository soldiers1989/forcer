package com.huagu.coupon.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 查询优惠卷列表信息
 * @author xiaofei-pc
 *
 */
public class SvrCouponState extends CustomService {
    public boolean coupon() throws DataValidateException {
        Record headIn = dataIn.getHead();
        String userCode = headIn.getSafeString("code_");
        if ("".equals(userCode)) 
            userCode = this.getUserCode();
        
        SqlQuery sql = new SqlQuery(this);
        sql.add("select a.Denomination_,a.enddate1_,a.enddate_,b.use_,a.type_,a.couponname_,a.couponcontent_ from %s a",
                appdb.t_coupon);
        sql.add("left join %s b on a.couponId_=b.couponId_", appdb.t_couponanduser);
        sql.add("where b.userCode_= '%s'", userCode);
        sql.open();
        if (!sql.eof())
            dataOut.appendDataSet(sql);
        return true;
    }
}
