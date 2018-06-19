package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.other.utils;
/**
 *  @describe 添加区域信息
 *  @author 王姣
 *  @date   2018年3月31日下午3:39:55
 *  @return
 */
public class SvrAreaInsert extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String createUser_ ;
		if(getUserCode() != null){
			createUser_ = this.getUserCode();
		}else{
			createUser_ = "17620458925";
		}
		String guid = utils.newGuid();
	      guid = guid.substring(1, guid.length() - 1);
	      guid = guid.replaceAll("-", "");
		sql.add("select UID_ ,areaid_,province_,country_,city_,area_,areaNum_,areaType_,remark_ from %s" ,appdb.Area);
		sql.add("where UID_ = '%s'" ,head.getString("UID_"));
		sql.open();
		sql.append();
		sql.setField("createDate_", TDateTime.Now());
		sql.setField("createUser_", createUser_);
		sql.setField("areaid_", guid);
		sql.setField("country_", "中国");
		sql.setField("province_", head.getString("province_"));
		sql.setField("city_", head.getString("city_"));
		sql.setField("area_", head.getString("area_"));
		sql.setField("areaNum_", head.getString("areaNum_"));
		sql.setField("areaType_", head.getString("areaType_"));
		sql.setField("remark_", head.getString("remark_"));
		sql.post();
		return this.success();
	}

}
