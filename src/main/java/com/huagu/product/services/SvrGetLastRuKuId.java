package com.huagu.product.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 * 查询最后一次的入库单号
 * @ClassName: SvrGetLastRuKuId 
 * @Description: TODO 
 * @author 乔晨光
 * @date 2018年5月15日 下午4:23:04 
 *
 */
public class SvrGetLastRuKuId extends AbstractService{

	  @Override
	  public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
	    SqlQuery sql = new SqlQuery(this);
	    sql.add("select UID_ ,createDate_,ruKuId_ from %s" ,appdb.T_Storage);
	    sql.add("  order by   createDate_ desc");
	    sql.open();
	    sql.setMaximum(1);
	    String ruKuId_ = sql.getString("ruKuId_");
	    if(!sql.eof())
	      dataOut.getHead().setField("ruKuId_", ruKuId_);
	    return this.success();
	  }
}