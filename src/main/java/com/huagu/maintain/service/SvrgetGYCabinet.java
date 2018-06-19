package com.huagu.maintain.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;


public class SvrgetGYCabinet extends AbstractService{
		@Override
		public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
			Record headIn = dataIn.getHead();
			String id_= headIn.getString("id_");
			if(id_ == null || id_ == ""){
				id_ = "123456789";
			}

			SqlQuery sql = new SqlQuery(this);
			sql.add("SELECT distinct a.boxId_,emptyStatus_,c.orderDesc_,c.orderId_,c.proImges_ from %s a", appdb.BOX);
			sql.add("left join %s b on b.Id_ = a.cabId_ ", appdb.CABINET);
			sql.add("left join %s c on c.boxId_ = a.boxId_",appdb.ORDERDONATION);
			sql.add("where a.cabId_='%s'",id_);
			sql.open();
			if (!sql.eof())
				dataOut.appendDataSet(sql);
			return this.success();
		}

}
