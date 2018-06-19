package com.huagu.maintain.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * @describe 添加箱子持久层
 * @date 2018年3月21日
 * @return
 */
public class SvrAddDepolyCabinetBox extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		//"id_", id_, "num_", num_, "type_", type_, "size_", size_, "managerId_", managerId_
		Record headIn = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("SELECT UID_,createDate_,createUser_,cabId_,boxId_,boxName_,boxVolume_,boxType_,emptyStatus_,boxDesc_,lockDate_,boxOrderLock_,boxLockUD_,boxStatus_,boxOpen_ FROM %s", appdb.BOX);
		sql.add(" where 1=1 ");
		sql.open();
		if("insert".equals(dataIn.getString("types_"))){
			sql.append();
			sql.setField("createDate_", TDateTime.Now());
			sql.setField("createUser_", "15071506306");
			sql.setField("cabId_", "11111111111");  //柜子ID
			sql.setField("boxId_", "11111111111111"); //箱子编号
			sql.setField("boxName_", "A");  //箱子别名
			sql.setField("boxVolume_", "1");  //箱子体型（0大，1中，2小）
			sql.setField("boxType_", 0);  //箱子类型（0租赁箱，1公益箱）
			sql.setField("emptyStatus_", 0); //箱子内空箱状态（0空箱，1有物品） bit
			sql.setField("boxDesc_", "初次导入箱子"); //箱子描述
			sql.setField("lockDate_", TDateTime.Now()); //最近关锁时间
			sql.setField("boxOrderLock_", 1);//箱子订单锁定状态（0自由，1锁定） bit
			sql.setField("boxLockUD_", "11111111111111");//箱锁UD
			sql.setField("boxStatus_", 1);//锁箱启闭状态0未启用，1启用   bit
			sql.setField("boxOpen_", 1);//箱子是否开启 （0、开启  1、未开启）  bit
		}else{
			sql.append();
			sql.setField("createDate_", TDateTime.Now());
			sql.setField("createUser_", headIn.getString("managerId_"));
			sql.setField("cabId_", headIn.getString("id_"));  //柜子ID
			sql.setField("boxId_", "11111111111111"); //箱子编号
			sql.setField("boxName_", headIn.getString("num_"));  //箱子别名
			sql.setField("boxVolume_", headIn.getString("size_"));  //箱子体型（0大，1中，2小）
			if("租赁柜组".equals(headIn.getString("type_")))
				sql.setField("boxType_", 0);  //箱子类型（0租赁箱，1公益箱）
			else
				sql.setField("boxType_", 1);  //箱子类型（0租赁箱，1公益箱）
			sql.setField("emptyStatus_", 0); //箱子内空箱状态（0空箱，1有物品） bit
			sql.setField("boxDesc_", headIn.getString("type_")); //箱子描述
			sql.setField("lockDate_", TDateTime.Now()); //最近关锁时间
			sql.setField("boxOrderLock_", 1);//箱子订单锁定状态（0自由，1锁定） bit
			sql.setField("boxLockUD_", "11111111111111");//箱锁UD
			sql.setField("boxStatus_", 1);//锁箱启闭状态0未启用，1启用   bit
			sql.setField("boxOpen_", 1);//箱子是否开启 （0、开启  1、未开启）  bit
		}
		
		return this.success();
	}

}
