package com.huagu.common.services.version;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * @describe 查询所有/添加版本号
 * @author li
 * @date 2017年11月30日上午10:32:57
 * @return
 */
public class SvrGetVersion extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		if("add".equals(head.getString("type_"))){

			sql.add("SELECT UID_,createDate_,createUser_,versionNum_,versionFile_,versionName_ FROM %s", appdb.VERSION);
			sql.open();
			sql.append();
			sql.setField("createDate_", TDateTime.Now());
			sql.setField("createUser_", "admin");
			sql.setField("versionNum_", head.getString("versionNum_"));
			sql.setField("versionFile_",  head.getString("versionFile_"));
			sql.setField("versionName_",  head.getString("versionName_"));
			sql.post();
			
		}else if("del".equals(head.getString("type_"))){
			sql.add("SELECT UID_,createDate_,createUser_,versionNum_,versionFile_,versionName_ FROM %s", appdb.VERSION);
			sql.add(" where 1=1");
			sql.add("AND UID_ = '%s' ", head.getString("id_"));
			sql.open();
			if(!sql.eof())
				sql.delete();
				
		}else {
			sql.add("SELECT UID_,createDate_,createUser_,versionNum_,versionFile_,versionName_ FROM %s", appdb.VERSION);
			sql.open();
			if(!sql.eof()){
				dataOut.appendDataSet(sql);
			}
		}
		sql.close();
		return this.success();
	}

}
