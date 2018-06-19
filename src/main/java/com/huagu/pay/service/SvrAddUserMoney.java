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
public class SvrAddUserMoney extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		String UserCode_ = headIn.getString("userCode");
		if("".equals(UserCode_)){
			UserCode_ = "15071506306";
		}
		SqlQuery addMoney = new SqlQuery(this);
		addMoney.add("SELECT UID_,updateTime_,updateUser_,code_,overMoney_ FROM %s WHERE code_ = '%s'", appdb.S_Userinfo, UserCode_);
		addMoney.open();
		if(!addMoney.eof()){
			String userMoney = addMoney.getRecords().get(0).getSafeString("overMoney_");
			if("".equals(userMoney)){
				userMoney = "0.00";
			}
			addMoney.edit();
			addMoney.setField("updateTime_", TDateTime.Now());
			addMoney.setField("updateUser_", UserCode_);
			addMoney.setField("overMoney_", Double.parseDouble(userMoney) + Double.parseDouble(headIn.getSafeString("totalFee_")));
			addMoney.post();
			dataOut.appendDataSet(addMoney);
		}
		return success();
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}

}
