package com.huagu.ywManage.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 得到要变更报修状态的调货单
 * 
 * @author wj
 * @date 2018年4月26日
 *
 */
public class SvrGetRepairInfo extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select t.UID_ ,t.operateId_,t.operateManId_,t.orderId_,t.boxId_,c.name_  cabinetName,p.proName_ ,t.repairStatus_,");
		sql.add("t.zhuCode_,t.leaveMess_ ,( select count(OpenBoxTime_) from %s  ) as openTime,t.nowLoss_,t.CloseBoxTime_", appdb.t_Operate);
		sql.add("from %s t ", appdb.t_Operate);
		sql.add("left join %s p on p.proId_ = t.proId_", appdb.T_Products);
		sql.add("left join %s b on t.boxId_ = b.boxId_", appdb.t_pronode_box);
		sql.add("left join %s c  on c.id_ = b.cabId_", appdb.Cabinet);
		sql.add("where t.type_ = '2' and t.operateId_ = '%s'", head.getString("operateId_"));
		sql.open();
		if (!sql.eof()) {
			dataOut.appendDataSet(sql);
		}
		return this.success();
	}

}
