package com.huagu.ywManage.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 * 前台运维单详情查看
 * @author wj  
 * @date 2018年4月27日 
 *
 */
public class SvrYDetailsQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select t.UID_ ,t.operateId_,p.proZsImges_,t.hisOpeCount,o.recPhone_,o.returnOverTime_,t.hisLoss_,t.lastState_,t.createDate_,t.operateManId_,t.orderId_,t.boxId_, DATE_FORMAT(t.CloseBoxTime_,'%s') as CloseBoxTime_ ,c.name_  cabinetName, p.proName_,","%Y-%m-%d %H:%m:%s");
		sql.add("t.zhuCode_, i.imgPath_ ,t.OpenBoxTime_,t.leaveMess_ ,t.operateManName_,( select count(OpenBoxTime_) from %s  ) as openTime,t.nowLoss_," ,appdb.t_Operate);
		sql.add("(SELECT SUM(rentTime_)+SUM(overdueDay_) from t_order  where zhuCode_='123456') sumTime_ ");
		sql.add("from %s t " ,appdb.t_Operate);
		sql.add("left join %s  i on t.ImageId_ = i.relevancelId_" ,appdb.T_IMAGE);
		sql.add("left join %s o on t.orderId_ = o.orderId_" ,appdb.T_ORDER);
		sql.add("left join %s p on p.proId_ = t.proId_" ,appdb.T_Products);
		sql.add("left join %s b on t.boxId_ = b.boxId_" ,appdb.t_pronode_box);
		sql.add("left join %s c  on c.id_ = b.cabId_" ,appdb.Cabinet);
		sql.add("where t.type_ = '0' and i.imgDel_ = '0'");
		sql.add("and t.operateId_ = '%s'" ,head.getString("operateId_"));
		sql.add("group by  t.operateId_");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
