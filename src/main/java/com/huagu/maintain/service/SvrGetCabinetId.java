package com.huagu.maintain.service;

import com.huagu.common.global.appdb;
import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * @describe 查询所有智能柜的轮播图片
 * @date 2018年3月21日
 * @return
 */
public class SvrGetCabinetId extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		sql.add("SELECT c.UID_ UID_, id_, i.imgPath_ imgPath_ FROM t_cabinet c", appdb.Cabinet);
		sql.add(" LEFT JOIN %s i ON c.id_ = i.relevancelId_", appdb.T_IMAGE);
		sql.add(" where 1=1 ");
		sql.open();

		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
