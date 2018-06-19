package com.huagu.admin.services;

import com.huagu.common.global.appdb;
import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 消息类型查询
 * 
 * @author xiaofei-pc
 *
 */
public class SvrMsgType extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery ds = new SqlQuery(this);
		ds.add("select IF(type_=1,'系统公告',IF(type_= 2,'推荐消息',IF(type_= 3,'互动消息',IF(type_ = 4,'圈子消息',IF(type_=5,'派单消息',IF(type_=6,'客户消息','订单完成消息')))))) type_ from %s", appdb.T_MESSAGE);
		ds.add("GROUP BY type_");
		ds.open();
		dataOut.appendDataSet(ds);
		return success();
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}
}
