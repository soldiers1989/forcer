package com.huagu.userList.service;

import com.huagu.common.global.appdb;
import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 修改管理员管理用户
 * @author xiaofei-pc
 *
 */
public class SvrAdminUserUpdate extends AbstractService {
    @Override
    public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
        Record headIn = dataIn.getHead();
        String userList_ = headIn.getString("userList_"); // 需要变更的用户数组
        String adminCode_ = headIn.getString("adminCode_"); // 管理员code_
        SqlQuery ds = new SqlQuery(this);
        ds.add("SELECT UID_,createDate_,createUser_,updateDate_,updateUser_,adminCode_,userCode_ FROM %s", appdb.ADMINANDUSER);
        ds.add(" where 1 = 1 ");
        ds.add(" and adminCode_ = '%s'", adminCode_);
        ds.open();
		while (!ds.eof()) {
			ds.delete();
		}
    	String [] user = userList_.split("-");
    	for (int i = 0; i < user.length; i++) {
			ds.append();
			ds.setField("createDate_", TDateTime.Now());
			ds.setField("createUser_", "admin");
			ds.setField("updateDate_", TDateTime.Now());
			ds.setField("updateUser_", "admin");
			ds.setField("adminCode_", adminCode_);
			ds.setField("userCode_", user[i]);
	    	ds.post();
		}
    	ds.close();
    	
        return success();
    }

}
