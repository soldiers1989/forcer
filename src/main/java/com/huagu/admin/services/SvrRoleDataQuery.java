package com.huagu.admin.services;

import org.apache.commons.lang3.StringUtils;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jbean.other.SystemTable;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 角色查询
 * @author xiaofei-pc
 *
 */
public class SvrRoleDataQuery extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select tr.UID_,tr.Name_,tr.Remark_,tr.isLive_,group_concat(tp.name_) as menuName_ from %s tr ", SystemTable.get(SystemTable.getUserRoles));
		ds.add("LEFT JOIN %s trap on tr.UID_ = trap.roleId_ LEFT JOIN %s tp on tp.code_ = trap.powerId_", appdb.getRoleAndPowerTable(this), SystemTable.get(SystemTable.getAppMenus));
		ds.add("WHERE tr.Hide_ != 1 and tr.CorpType_ = %s",  this.getCorpNo());
		/*if(headIn.getBoolean("isLive_"))
			ds.add("and tr.isLive_ = 'true'");*/
		if(!headIn.hasValue(headIn.getSafeString("enabled_"))){
			if("1".equals(headIn.getSafeString("enabled_")))
				ds.add("and tr.isLive_ = 'true'");
			if("0".equals(headIn.getSafeString("enabled_")))
				ds.add("and tr.isLive_ = 'false'");
		}
		if(StringUtils.isNotBlank(headIn.getSafeString("UID_"))){
			ds.add("AND tr.UID_ = %s", headIn.getSafeString("UID_"));
		}else{
			ds.add("group by tr.UID_,tr.Name_,tr.Remark_");
		}
		ds.open();
		dataOut.appendDataSet(ds);
		return success();
	}
}
