package com.huagu.jiFenAndSign.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 后台积分类型查询展示
 *  @author 王姣
 *  @date   2018年3月20日上午9:53:22
 *  @return
 */
public class SvrJiFenTypeQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String type_ = head.getString("type_");
		if(type_.equals("2"))
			type_ = "";
		sql.add("select UID_ ,type_ ,integral_ ,createTime_  from %s" ,appdb.IngetralType);
		sql.add("where 1 = 1");
		if(type_ != null && type_ != ""){
			sql.add("and type_ like '%s'" ,new String("%"+type_+"%"));
		}
		sql.add("order by createTime_ desc");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
