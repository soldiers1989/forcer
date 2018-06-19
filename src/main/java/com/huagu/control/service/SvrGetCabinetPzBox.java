package com.huagu.control.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * @describe 查询柜组物品信息
 * @date 2018年3月21日
 * b.cabId_ cabId_,  柜子ID
 * b.boxId_ boxId_,		箱子ID
 * ps.proName_ proName_,  商品名称
 * pd.zhuCode_ zhuCode_,	商品主电子条码
 * boxName_,	箱子名
 * boxVolume_,	箱子体积（0大，1中，2小）
 * boxType_,	箱子类型（0租赁箱，1公益箱）
 * emptyStatus_,箱子内空箱状态（0空箱，1有物品）
 * lockDate_,	最近关锁时间
 * boxOrderLock_,箱子订单锁定状态（0自由，1锁定）
 * boxStatus_, 锁箱启闭状态0未启用，1启用
 * status_  箱子状态状态0物品已经取走，1物品存放中
 * @return
 */
public class SvrGetCabinetPzBox extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		String id_= headIn.getString("id_");
		if(id_ == null || id_ == ""){
			id_ = "11111111111";
		}

		SqlQuery sql = new SqlQuery(this);
		sql.add("SELECT b.cabId_ cabId_, b.boxId_ boxId_,pd.zhuCode_ zhuCode_,ps.proName_ proName_,proZsImges_ , boxName_, boxVolume_, boxType_, emptyStatus_,lockDate_,boxOrderLock_,boxStatus_,status_ FROM t_box b", appdb.BOX);
		sql.add(" LEFT JOIN %s pb ON b.boxId_ = pb.boxId_", appdb.t_pronode_box);
		sql.add(" AND b.cabId_ = pb.cabId_");
		sql.add(" LEFT JOIN %s pd ON pd.zhuCode_ = pb.zhuCode_", appdb.T_ProNode);
		sql.add(" LEFT JOIN %s ps ON ps.proId_ = pd.proId_", appdb.T_Products);
		sql.add(" WHERE b.cabId_ = '%s'", id_);
		sql.open();
		if (!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
