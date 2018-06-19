package com.huagu.order.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/***
 *  租赁柜归还订单
 * @author wj  
 * @date 2018年5月23日 
 *
 */
public class SvrCabinetOrdersQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String proName_ = head.getString("proName_");
		String homeAgency_ = head.getString("homeAgency_");
		String createDate_ = head.getString("createDate_");
		String orderId_ = head.getString("orderId_");
		String OpenBoxTime_ = head.getString("OpenBoxTime_");
		String mobile_ = head.getString("mobile_");
		String returnType_ = head.getString("returnType_");
		if(returnType_.equals("-2")){
			returnType_= "";
		}
		sql.add("select  o.orderId_,c.name_ boxName_,c.communityName_ boxCommunityName_,o.returnMethod_,DATE_FORMAT(o.createDate_,'%s') as createDate_ ,DATE_FORMAT(oe.OpenBoxTime_,'%s') as OpenBoxTime_ ,o.returnType_,o.fixType_, o.orderId_ ,o.userId_ , o.setBoxId_ ,o.repairType_ ,","%Y-%m-%d %H:%m:%s","%Y-%m-%d %H:%m:%s");
		sql.add("o.settleState_ ,u.mobile_,p.homeAgency_  , p.zhuCode_, oe.operateId_ ,oe.createDate_ ,tp.proName_,de.ciCode_");
		sql.add("from %s o " ,appdb.T_ORDER);
		sql.add("join %s u  on o.userId_ = u.code_ " ,appdb.S_Userinfo);
		sql.add("join %s p on p.proId_ = o.proId_ " ,appdb.T_ProNode);
		sql.add("join %s oe on oe.orderId_ = o.orderId_" ,appdb.t_Operate);
		sql.add("join %s tp on tp.proId_ = o.proId_" ,appdb.T_Products);
		sql.add("join %s  de on de.zhuCode_ = p.zhuCode_" ,appdb.T_CiNode);
		sql.add("join %s tpb on p.zhuCode_  = tpb.zhuCode_" ,appdb.PRONODEBOX);
		sql.add("join %s c  on c.id_=tpb.cabId_" ,appdb.Cabinet);
		sql.add("where o.returnMethod_ = '0'");
		if(proName_ != null && proName_ != ""){
			sql.add("and tp.proName_ like '%s'" ,new String("%"+proName_+"%"));	
		}
		if(homeAgency_ != null && homeAgency_ != ""){
			sql.add("and p.homeAgency_ like '%s'" ,new String("%"+homeAgency_+"%"));	
		}
		if(createDate_ != null && createDate_ != ""){
			sql.add("and o.createDate_ like '%s'" ,new String("%"+createDate_+"%"));	
		}
		if(orderId_ != null && orderId_ != ""){
			sql.add("and o.orderId_ like '%s'" ,new String("%"+orderId_+"%"));	
		}
		if(mobile_ != null && mobile_ != ""){
			sql.add("and u.mobile_ like '%s'" ,new String("%"+mobile_+"%"));	
		}
		if(OpenBoxTime_ != null && OpenBoxTime_ != ""){
			sql.add("and oe.OpenBoxTime_ like '%s'" ,new String("%"+OpenBoxTime_+"%"));	
		}if(returnType_ != null &&  returnType_  != ""){
			sql.add("and o.returnType_ = '%s'" ,returnType_);
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
