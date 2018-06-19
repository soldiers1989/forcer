package com.huagu.pay.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * @ClassName: SvrPayLog
 * @Description: 
 * @author lxf
 * @date 2018年4月2日 9:44:22
 * 
 */
public class SvrPayLog extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		String UserCode_ = headIn.getSafeString("userCode");
		if("".equals(UserCode_)){
			UserCode_ = headIn.getSafeString("openid_");
		}
		SqlQuery addPayLog = new SqlQuery(this);
		addPayLog.add("SELECT UID_,createTime_,createUser_,platform_,userCode_,type_,opeType_,amount_,openid_,out_trade_no_,status_,userNowMoney_ FROM %s", appdb.Record);
		addPayLog.open();
		addPayLog.append();
		addPayLog.setField("createTime_", TDateTime.Now());
		addPayLog.setField("createUser_", UserCode_);
		addPayLog.setField("platform_", "weixin");
		addPayLog.setField("userCode_", UserCode_);
		addPayLog.setField("type_", headIn.getSafeString("type_"));
		addPayLog.setField("opeType_", headIn.getSafeString("opeType_"));
		addPayLog.setField("amount_", headIn.getSafeString("totalFee_"));
		addPayLog.setField("openid_", headIn.getSafeString("openid_"));
		addPayLog.setField("out_trade_no_", headIn.getSafeString("out_trade_no_"));
		addPayLog.setField("status_", headIn.getSafeString("status_"));
		addPayLog.setField("userNowMoney_", headIn.getDouble("overMoney_") + headIn.getDouble("totalFee_"));
		addPayLog.post();
		
		return success();
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}

}
