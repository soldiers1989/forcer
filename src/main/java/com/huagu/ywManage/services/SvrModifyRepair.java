package com.huagu.ywManage.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 * 手工变更物品位置状态为仓库手工变更物品为报修状态
 * @author wj  
 * @date 2018年4月26日 
 *
 */
public class SvrModifyRepair extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		String  updateUser_ = this.getUserCode();
		if("".equals(updateUser_))
			updateUser_ = "17620458925";
		Record head = dataIn.getHead();
		sql.add("select UID_,nowLoss_ ,updateDate_,updateUser_, operateId_ ,repairStatus_   from %s" ,appdb.t_Operate);
		sql.add("where operateId_ = '%s'" ,head.getString("operateId_"));
		sql.open();
		sql.edit();
		sql.setField("updateUser_", updateUser_);
		sql.setField("updateDate_", TDateTime.Now());
		sql.setField("repairStatus_", head.getString("repairStatus_"));
		sql.post();
		return this.success();
	}

}
