package com.huagu.ywManage.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 * 补货单查询展示
 * @author wj  
 * @date 2018年4月26日 
 *
 */
public class SvrAddGoodsQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		sql.add("select t.UID_ ,t.operateId_,p.proZsImges_,t.createDate_,u.name_ userName,ci.ciCode_,t.operateManId_,t.orderId_,t.boxId_, DATE_FORMAT(t.CloseBoxTime_,'%s') as CloseBoxTime_ ,c.name_  cabinetName, p.proName_,","%Y-%m-%d %H:%m:%s");
		sql.add("t.zhuCode_, i.imgPath_ ,t.leaveMess_ ,( select count(OpenBoxTime_) from %s  ) as openTime,t.nowLoss_" ,appdb.t_Operate);
		sql.add("from %s t " ,appdb.t_Operate);
		sql.add("left join %s  i on t.ImageId_ = i.relevancelId_" ,appdb.T_IMAGE);
		sql.add("left join %s p on p.proId_ = t.proId_" ,appdb.T_Products);
		sql.add("left join %s u on u.code_ = t.operateManId_" ,appdb.S_Userinfo);
		sql.add("left join %s b on t.boxId_ = b.boxId_" ,appdb.t_pronode_box);
		sql.add("left join %s c  on c.id_ = b.cabId_" ,appdb.Cabinet);
		sql.add("left join %s ci on b.zhuCode_ = ci.zhuCode_" ,appdb.T_CiNode);
		sql.add("where t.type_ = '1' and i.imgDel_ = '0'");
		sql.add("group by  t.operateId_");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
