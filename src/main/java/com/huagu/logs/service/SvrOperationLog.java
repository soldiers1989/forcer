package com.huagu.logs.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrOperationLog extends AbstractService {

    @Override
    public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
        Record headIn = dataIn.getHead();
        SqlQuery ds = new SqlQuery(this);
        String operateType_ = headIn.getString("operateType_");
        String startDate = headIn.getString("unlockDate_");
        String endDate = headIn.getString("endDate_");
        if(operateType_.equals("0")){
        	operateType_ = "";
        }
        ds.add("select DATE_FORMAT(operateData_,'%s') as operateData_   ,operateUser_,operateType_,operate_,operateAdress_,operateDetail_ from %s where 1=1",
        		"%Y-%m-%d %H:%m:%s",appdb.MANAGE_LOGS);
     
       /* if (headIn.hasValue("startTime_") && headIn.hasValue("endTime_")) {
            ds.add("and operateData_ between '%s' and '%s'", headIn.getDateTime("startTime_"), headIn.getDateTime("endTime_"));
        } else if (headIn.hasValue("startTime_")) {
            ds.add("and operateData_  >= '%s'", headIn.getDateTime("startTime_"));
        } else if (headIn.hasValue("endTime_")) {
            ds.add("and operateData_  <= '%s'", headIn.getDateTime("endTime_"));
        }*/if(operateType_ != null && operateType_ != ""){
        	ds.add("and operateType_  = '%s'", operateType_);
        }
        if (startDate != null && startDate != ""){
            ds.add("and unix_timestamp(operateData_) between unix_timestamp( '%s') and unix_timestamp('%s')",
                startDate, endDate);
      }
      /*  if (headIn.hasValue("operateType_")) {
            if ("删除".equals(headIn.getString("operateType_")))
                ds.add("and operateType_ = '删除'");
            if ("添加".equals(headIn.getString("operateType_")))
                ds.add("and operateType_ = '添加'");
            if ("查询".equals(headIn.getString("operateType_")))
                ds.add("and operateType_ = '查询'");
            if ("修改".equals(headIn.getString("operateType_")))
                ds.add("and operateType_ = '修改'");
        }*/
//        if (headIn.hasValue("startTime_"))
//            ds.add("and operateData_ >='%s'", headIn.getSafeString("startTime_") + " 00:00:00");
//        if (headIn.hasValue("endTime_"))
//            ds.add("and operateData_ <'%s'", headIn.getSafeString("endTime_") + " 23:59:59");
//        if (headIn.hasValue("operateType_") && !"#".equals(headIn.getSafeString("operateType_")))
//            ds.add("and operateType_ ='%s'", headIn.getSafeString("operateType_"));
        ds.add("order by operateData_ DESC");
        
       
        ds.open();
        if (!ds.eof()) {
            dataOut.appendDataSet(ds);
        }
        return success();
    }

}
