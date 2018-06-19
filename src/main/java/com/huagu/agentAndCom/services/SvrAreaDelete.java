package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 删除区域信息
 *  @author 王姣
 *  @date   2018年3月31日下午3:29:11
 *  @return
 */
public class SvrAreaDelete extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String area = head.getString("area");
		sql.add("select UID_ ,country_,areaid_,province_,city_,area_,areaNum_,areaType_,remark_ from %s" ,appdb.Area);
		sql.add("where UID_ = '%s'" ,head.getString("UID_"));
		sql.open();
		sql.edit();
		if(area.equals("country")){
			sql.setField("country_", "");
			sql.setField("province_",  "");
			sql.setField("city_", "");
			sql.setField("area_", "");
			sql.setField("areaNum_", "");
			sql.setField("areaType_", "");
			sql.setField("remark_", "");
		}
		if(area.equals("province")){
			sql.setField("province_", "");
			sql.setField("city_", "");
			sql.setField("area_", "");
			sql.setField("areaNum_", "");
			sql.setField("areaType_", "");
			sql.setField("remark_", "");
		}
		if(area.equals("city")){
			sql.setField("city_", "");
			sql.setField("area_","");
			sql.setField("areaNum_", "");
			sql.setField("areaType_", "");
			sql.setField("remark_", "");
		}
		if(area.equals("area")){
			sql.setField("area_", "");
			sql.setField("areaNum_", "");
			sql.setField("areaType_", "");
			sql.setField("remark_", "");
		}
		sql.post();
		return this.success();
	}

}
