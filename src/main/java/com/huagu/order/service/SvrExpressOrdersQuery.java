package com.huagu.order.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 *  快递归还订单
 * @author wj  
 * @date 2018年5月23日 
 *
 */
public class SvrExpressOrdersQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String proName_ = head.getString("proName_");
		String homeAgency_ = head.getString("homeAgency_");
		String orderId_ = head.getString("orderId_");
		String mobile_ = head.getString("mobile_");
		String settleState_ = head.getString("settleState_");
		if(settleState_.equals("-2")){
			settleState_= "";
		}
		sql.add("select  o.orderId_,o.returnMethod_,u.mobile_,p.homeAgency_, DATE_FORMAT(o.deliveryTime_,'%s') as deliveryTime_ ,tp.proName_ ,o.recLogisticsId_,o.logisticsState_,","%Y-%m-%d %H:%m:%s");
		sql.add("o.recLogisticsName_,o.returnOverTime_, p.zhuCode_,de.ciCode_, oe.operateId_,o.settleState_");
		sql.add("from %s o" ,appdb.T_ORDER);
		sql.add("join %s u  on o.userId_ = u.code_" ,appdb.S_Userinfo);
		sql.add("join %s p on p.proId_ = o.proId_" ,appdb.T_ProNode);
		sql.add("join %s oe on oe.orderId_ = o.orderId_" ,appdb.t_Operate);
		sql.add("join %s tp on tp.proId_ = o.proId_" ,appdb.T_Products);
		sql.add("join %s  de on de.zhuCode_ = p.zhuCode_" ,appdb.T_CiNode);
		sql.add("where o.returnMethod_ = '1'");
		if(proName_ != null && proName_ != ""){
			sql.add("and tp.proName_ like '%s'" ,new String("%"+proName_+"%"));	
		}
		if(homeAgency_ != null && homeAgency_ != ""){
			sql.add("and p.homeAgency_ like '%s'" ,new String("%"+homeAgency_+"%"));	
		}
		if(orderId_ != null && orderId_ != ""){
			sql.add("and o.orderId_ like '%s'" ,new String("%"+orderId_+"%"));	
		}
		if(mobile_ != null && mobile_ != ""){
			sql.add("and u.mobile_ like '%s'" ,new String("%"+mobile_+"%"));	
		}
		if(settleState_ != null &&  settleState_  != ""){
			sql.add("and o.settleState_ = '%s'" ,settleState_);
		}
		sql.add("group by  o.orderId_");
		sql.add("order by  o.createDate_ desc");
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);
		}
		return this.success();
	}

}
