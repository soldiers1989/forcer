package com.huagu.agentAndCom.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 修改区域信息
 *  @author 王姣
 *  @date   2018年3月31日下午3:09:10
 *  @return
 */
public class SvrAreaModify extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String updateUser_ ;
		if(getUserCode() != null){
			updateUser_ = this.getUserCode();
		}else{
			updateUser_ = "17620458925";
		}
		String province_ = head.getString("province_");
		String area_ = head.getString("area_");
		String city_ = head.getString("city_");
		sql.add("select UID_ ,updateDate_,updateUser_,province_,city_,area_,areaNum_,areaType_,remark_ from %s" ,appdb.Area);
		sql.add("where UID_ = '%s'" ,head.getString("UID_"));
		sql.open();
		sql.edit();
		sql.setField("updateDate_", TDateTime.Now());
		sql.setField("updateUser_", updateUser_);
		if(province_ != null && province_ != ""){
			sql.setField("province_", province_);
		}
		if(area_ != null && area_ !=""){
			
			sql.setField("area_", area_);
		}
		if(city_ != null && city_ != ""){
			sql.setField("city_", city_);
		}
		sql.setField("areaNum_", head.getString("areaNum_"));
		sql.setField("areaType_", head.getString("areaType_"));
		sql.setField("remark_", head.getString("remark_"));
		sql.post();
		return this.success();
	}

}
