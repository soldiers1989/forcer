package com.huagu.my.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.other.utils;

public class SvrCollect extends CustomService {
	private String userCode_;
	
    public IStatus search(DataSet dataIn, DataSet dataOut) {
    	userCode_ = this.getUserCode();
    	if("".equals(userCode_)){
    		userCode_ = "15071506306";
    	}
        SqlQuery dsTemp = new SqlQuery(this);
        dsTemp.add("select distinct c.colID_,c.userID_,c.proId_,c.status_,s.zhuCode_,");
        dsTemp.add("p.proName_,p.dayRentMoney_,p.discountPrice_,p.proId_,p.cashPledge_,p.isDiscount_,p.proZsImges_ proZsImges_,");
        dsTemp.add("t.fristName_,t.fristNameId_,t.twoImgUrl_,pb.boxId_,ca.communityName_,ca.communityNum_,ca.address_");
        dsTemp.add("from %s c", appdb.Collect);
        dsTemp.add("left join %s s on s.zhuCode_=c.proId_", appdb.T_ProState);
        dsTemp.add("left join %s p on p.proId_ = s.proId_",appdb.T_Products);
        dsTemp.add("left join %s t on t.twoNameId_ = p.proTypeId_",appdb.T_Protype);
        dsTemp.add("left join %s pb on pb.zhuCode_ = s.zhuCode_",appdb.t_pronode_box);
        dsTemp.add("left join %s ca on ca.id_ = pb.cabId_",appdb.CABINET);
        dsTemp.add("where (p.proState_=0 or p.proState_=2)");
        dsTemp.add("and p.isDel_=0 and t.fristState_=0 and t.fristDel_=0");
        dsTemp.add("and c.status_='0' and c.userID_='%s'", userCode_);
        dsTemp.add("order by c.createDate_ desc");
        dsTemp.open();
        dataOut.appendDataSet(dsTemp);
        return this.success();
    }
    
    public IStatus add(DataSet dataIn, DataSet dataOut) throws DataValidateException {
        Record headIn = dataIn.getHead();
        userCode_ = this.getUserCode();
    	if("".equals(userCode_)){
    		userCode_ = "15071506306";
    	}
        DataValidateException.stopRun("商品主电子条码不能为空", !headIn.hasValue("zhuCode_"));
        SqlQuery dsTemp = new SqlQuery(this);
        dsTemp.add("select * from %s", appdb.Collect);
        dsTemp.add("where proId_='%s'", headIn.getString("zhuCode_"));
        dsTemp.add("and userID_='%s'", userCode_);
        dsTemp.setMaximum(1);
        dsTemp.open();
        if(dsTemp.eof()) {
            dsTemp.append();
            dsTemp.setField("colID_", TDateTime.FormatDateTime("YYYYMMDDHHMMSSZZZ", TDateTime.Now())
                    + utils.intToStr(utils.random(900) + 100));
            dsTemp.setField("userID_", userCode_);
            dsTemp.setField("proId_", headIn.getString("zhuCode_"));
            dsTemp.setField("status_", 0);
            dsTemp.setField("createUser_", userCode_);
            dsTemp.setField("createDate_", TDateTime.Now());
            dsTemp.post();
        }else {
            dsTemp.edit();
            if("0".equals(dsTemp.getString("status_"))) {
                dsTemp.setField("status_", "1");
            }else {
                dsTemp.setField("status_", "0");
            }
            dsTemp.setField("updateUser_", userCode_);
            dsTemp.setField("updateDate_", TDateTime.Now());
            dsTemp.post();
        }
        dataOut.getHead().setField("status_", dsTemp.getString("status_"));
        return this.success();
    }
    
    public IStatus delete(DataSet dataIn, DataSet dataOut) throws DataValidateException {
        Record headIn = dataIn.getHead();
    	userCode_ = this.getUserCode();
    	if("".equals(userCode_)){
    		userCode_ = "15071506306";
    	}
        DataValidateException.stopRun("商品proId_不能为空", !headIn.hasValue("proIds"));
        String[]  proIds= headIn.getString("proIds").split(",");
        for (int i = 0; i < proIds.length; i++) {
            SqlQuery dsTemp = new SqlQuery(this);
            dsTemp.add("select * from %s", appdb.Collect);
            dsTemp.add("where proId_='%s'",proIds[i]);
            dsTemp.add("and status_='0' and userID_='%s'", userCode_);
            dsTemp.setMaximum(1);
            dsTemp.open();
            DataValidateException.stopRun("该商品未收藏或已删除", dsTemp.eof());
            dsTemp.edit();
            dsTemp.setField("status_", "1");//已删除
            dsTemp.setField("updateUser_", userCode_);
            dsTemp.setField("updateDate_", TDateTime.Now());
            dsTemp.post();
        }
        return this.success();
    }
    
    public IStatus getCollectByProid(DataSet dataIn, DataSet dataOut) throws DataValidateException {
        Record headIn = dataIn.getHead();
        DataValidateException.stopRun("商品主电子条码不能为空", !headIn.hasValue("zhuCode_"));
        userCode_ = this.getUserCode();
        if("".equals(userCode_)){
            userCode_ = "15071506306";
        }
        SqlQuery dsTemp = new SqlQuery(this);
        dsTemp.add("select * from %s", appdb.Collect);
        dsTemp.add("where proId_='%s'",headIn.getString("zhuCode_"));
        dsTemp.add("and userID_='%s'", userCode_);
        dsTemp.setMaximum(1);
        dsTemp.open();
        if(!dsTemp.eof()) {
            dataOut.getHead().copyValues(dsTemp.getCurrent());
        }
        return this.success();
    }
}
