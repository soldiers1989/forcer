package com.huagu.control.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.mysql.Transaction;

/**
 * 中控屏同步箱子Service
 * 
 * @author xiaofei-pc 传入 柜子ID 添加柜子的对应的箱子ID
 */
public class SvrControlSyncBox extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		try (Transaction tx = new Transaction(this)) {
			SqlQuery sync = new SqlQuery(this);
			sync.add(
					"SELECT UID_,createDate_,createUser_,updateDate_,id_,name_,carouselId_,joinUpDate_,joinStatus_,combinationInfo_,address_,communityName_,communityNum_,x_,y_ FROM %s",
					appdb.Cabinet);
			sync.add(" WHERE id_ = '%s'", headIn.getString("cobId_"));
			// 增加柜子信息
			if (sync.eof()) {
				sync.append();
				sync.setField("createDate_", TDateTime.Now());
				sync.setField("createUser_", TDateTime.Now());
				sync.setField("id_", headIn.getSafeString("cobId_"));
				sync.post();
			}
			// 解析箱子的键值json，解析完json后for循环添加当前柜组下所有的箱子
			// 增加柜子下箱子信息
			SqlQuery addBox = new SqlQuery(this);
			addBox.add("select UID_,createDate_,createUser_,cabId_,boxId_,boxName_,boxVolume_,boxType_,emptyStatus_,boxDesc_,boxOrderLock_,boxLockUD_,boxStatus_ from %s",
					appdb.BOX);
			addBox.add(" where boxId_ = %s", headIn.getSafeString("boxId_"));
			if (addBox.eof()) {
				addBox.append();
				addBox.setField("createDate_", TDateTime.Now());
				addBox.setField("cabId_", headIn.getSafeString("cabId_"));
				addBox.setField("boxId_", headIn.getSafeString("boxId_"));
				addBox.setField("boxName_", headIn.getSafeString("cabId_") + "的箱子");
				addBox.setField("boxDesc_", headIn.getSafeString("cabId_") + "的箱子");
				addBox.setField("boxOrderLock_", "0");
				addBox.setField("boxLockUD_", headIn.getSafeString("boxId_"));
				addBox.setField("boxStatus_", "0");
				addBox.post();
			}
			tx.commit();
		} catch (Exception e) {
			return fail("同步失败");
		}
		return success();
	}

}
