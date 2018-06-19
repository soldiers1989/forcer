package com.huagu.control.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;


/**
 * 获取柜子mac地址，并且添加箱子
 * @author xiaofei-pc
 *
 */
public class SvrAddControl extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select UID_,createDate_,createUser_,id_,name_,carouselId_,joinUpDate_,joinStatus_,communityName_,communityNum_,address_,desc_,status_ from %s",
				appdb.Cabinet);
		ds.setMaximum(1);
		ds.open();
		ds.append();
		ds.setField("createDate_", TDateTime.Now());
		ds.setField("createUser_", "admin");
		ds.setField("id_", headIn.getSafeString("cobId_"));
		ds.setField("name_", "未命名");
		ds.setField("joinUpDate_", TDateTime.Now());
		ds.setField("joinStatus_", '1');
		ds.setField("desc_", "暂无描述~");
		ds.setField("status_", "0");
		ds.post();
		
		for (int i = 1; i < 40; i++) {
			SqlQuery addBox = new SqlQuery(this);
			addBox.add("SELECT UID_,createDate_,createUser_,cabId_,boxId_,boxName_,boxVolume_,boxType_,emptyStatus_,boxDesc_,boxOrderLock_,boxStatus_ FROM %s", appdb.BOX);
			addBox.setMaximum(1);
			addBox.open();
			addBox.append();
			addBox.setField("createDate_", TDateTime.Now());
			addBox.setField("createUser_", "admin");
			addBox.setField("cabId_", headIn.getSafeString("cobId_"));
			addBox.setField("boxId_", "A" + i);
			addBox.setField("boxName_", "A" + i);
			addBox.setField("boxVolume_", "0");
			addBox.setField("boxType_", "0");
			addBox.setField("emptyStatus_", 0);
			addBox.setField("boxDesc_", "此箱暂无描述~");
			addBox.setField("boxOrderLock_", 0);
			addBox.setField("boxStatus_", 1);
			addBox.post();
		}
		
		return success();
	}

}
