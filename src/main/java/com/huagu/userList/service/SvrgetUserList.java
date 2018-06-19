package com.huagu.userList.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrgetUserList extends AbstractService {
    @Override
    public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
        Record headIn = dataIn.getHead();
        SqlQuery ds = new SqlQuery(this);
        String startDate = headIn.getString("unlockDate_");
        String endDate = headIn.getString("endDate_");
        String enabled_ = headIn.getString("enabled_");
        if("zs".equals(headIn.getString("type_"))){
        	ds.add("SELECT su.UID_,su.code_,DATE_FORMAT(su.createTime_,'%Y-%m-%d %H:%m:%s')AS createTime_,");
        	ds.add(" su.name_,su.enabled_,su.mobile_,su.overMoney_,su.userJifen_,su.id_,su.roleCode_,");
        	ds.add(" su.corpNo_,th.status_ as HTStatus,tb.status_ as BankStatus,ts.sesameFen_");
        	ds.add(" FROM %s su",appdb.S_Userinfo);
        	ds.add(" LEFT JOIN %s th on th.userCode_= su.code_",appdb.HTCERTIFIED);
        	ds.add(" LEFT JOIN %s tb on su.code_ = tb.userCode_",appdb.BankCard);
        	ds.add(" LEFT JOIN %s ts on su.idCard_  = ts.idCard_",appdb.SESAMELOG);
        	ds.add("WHERE isManager_ = '0'");
            if (headIn.hasValue("mobile_")) {
                ds.add("and su.mobile_ like '%s'", '%' + headIn.getString("mobile_") + '%');
            }
            if (headIn.hasValue("smoney_")) {
                ds.add("and su.overMoney_ >= '%s'", headIn.getString("smoney_"));
            }
            if (headIn.hasValue("money_")) {
                ds.add("and su.overMoney_ <= '%s'", headIn.getString("money_"));
            }
            ds.add(" GROUP BY su.code_");
        	ds.open();
        	if(!ds.eof())
                dataOut.appendDataSet(ds);
        		
        }else{
            if(enabled_.equals("2")){
            	enabled_ = "";
            }
            ds.add("SELECT UID_,code_,  DATE_FORMAT(createTime_,'%s') as createTime_ ,name_,enabled_,mobile_,overMoney_,userJifen_,id_ FROM %s WHERE isManager_ = '0'",
            		"%Y-%m-%d %H:%m:%s",appdb.S_Userinfo);

            if (headIn.hasValue("mobile_")) {
                ds.add("and mobile_ like '%s'", '%' + headIn.getString("mobile_") + '%');
            }
            /* if (headIn.hasValue("startTime_") && headIn.hasValue("endTime_")) {
                ds.add("and createTime_  between '%s' and '%s'", headIn.getDateTime("startTime_"),
                        headIn.getDateTime("endTime_"));
            }*//* else if (headIn.hasValue("startTime_")) {
                ds.add("and createTime_  >= '%s'", headIn.getDateTime("startTime_"));
            } else if (headIn.hasValue("endTime_")) {
                ds.add("and createTime_  <= '%s'", headIn.getDateTime("endTime_"));
            }*/
            if(enabled_ != null && enabled_ != ""){
            	ds.add("and enabled_  = '%s'" ,enabled_);
            }
            if (startDate != null && startDate != ""){
                ds.add("and unix_timestamp(createTime_) between unix_timestamp( '%s') and unix_timestamp('%s')",
                    startDate, endDate);
            }
            /* if (headIn.hasValue("enabled_")) {
                if ("1".equals(headIn.getString("enabled_")))
                    ds.add("and enabled_ = '1'");
                if ("0".equals(headIn.getString("enabled_")))
                    ds.add("and enabled_ = '0'");
            }*/
            ds.open();
            if (!ds.eof()) {
                dataOut.appendDataSet(ds);
            }
        }
        return success();
    }

}
