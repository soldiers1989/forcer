package com.huagu.admin.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 查询用户列表信息
 * @author xiaofei-pc
 *
 */
public class SvrUserList extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("SELECT UID_,code_,createTime_,name_,enabled_,mobile_,imgUrl_,isBlack_,enabled_ FROM %s WHERE isManager_ = '0'",
				appdb.S_Userinfo);
		
		if (headIn.getString("name_").length() == 11){
			ds.add("and code_ = '%s'", dataIn.getHead().getString("name_"));
		}else{
			if (headIn.hasValue("name_"))
				ds.add("and name_ = '%s'", dataIn.getHead().getString("name_"));
		}
		if(headIn.hasValue("startTime_") && headIn.hasValue("endTime_")){
			ds.add("and createTime_  between '%s' and '%s'", headIn.getDateTime("startTime_"), headIn.getDateTime("endTime_"));
		}else if (headIn.hasValue("startTime_")) {
			ds.add("and createTime_  >= '%s'", headIn.getDateTime("startTime_"));
		} else if (headIn.hasValue("endTime_")) {
			ds.add("and createTime_  <= '%s'", headIn.getDateTime("endTime_"));
		}
		if(headIn.hasValue("enabled_")){
			if("1".equals(headIn.getString("enabled_")))
				ds.add("and enabled_ = '1'");
			if("0".equals(headIn.getString("enabled_")))
				ds.add("and enabled_ = '0'");
		}
		ds.open();
		if (!ds.eof()) {
			dataOut.appendDataSet(ds);
		}
		return success();
	}

}
