package com.huagu.admin.services;

import com.huagu.common.global.appdb;
import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 修改用户状态
 * @author li
 *
 */
public class SvrUserStateUpdate extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record head = dataIn.getHead();
		DataValidateException.stopRun("state_ 参数错误 ",!head.hasValue("state_"));
	    SqlQuery sql=new SqlQuery(this);
	    sql.add("select UID_,code_,enabled_ from %s",appdb.S_Userinfo);
	    sql.add("where code_='%s'",head.getString("code_"));
	    sql.setMaximum(1);
	    sql.open();
	    if(head.hasValue("state_")){
	    	sql.edit();
	    	sql.setField("enabled_", head.getInt("state_"));
	    	sql.post();
	    }
	    dataOut.appendDataSet(sql);
		return success("成功");
	}
}