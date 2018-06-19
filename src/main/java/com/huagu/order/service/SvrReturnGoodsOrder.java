package com.huagu.order.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  退货单列表查询
 * @author wj  
 * @date 2018年5月22日 
 *
 */
public class SvrReturnGoodsOrder extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String proName_ = head.getString("proName_");
		String saleHomeAgency_ = head.getString("saleHomeAgency_");
		String rgStatus_ = head.getString("rgStatus_");
		String reGoodsTime_ = head.getString("reGoodsTime_");
		String mobile_ = head.getString("mobile_");
		String isAgree_ = head.getString("isAgree_");
		String rgHand_ = head.getString("rgHand_");
		if(rgStatus_.equals("-1")){
			rgStatus_ = "";
		}
		if(isAgree_.equals("-1")){
			isAgree_ = "";
		}
		if(rgHand_.equals("-1")){
			rgHand_ = "";
		}
		
		sql.add("select g.rgId_,g.orderId_,u.mobile_ , DATE_FORMAT(g.createDate_,'%s') as createDate_ ,p.proName_,g.isAgree_,g.rgLogisticsName_,g.rgLogisticsId_," ,"%Y-%m-%d %H:%m:%s");
		sql.add("g.check_,g.rgStatus_,g.rgHand_,g.rgMoney_,s.saleHomeAgency_");
		sql.add("from %s  g join %s  p  on g.proId_ = p.proId_" ,appdb.goodsRejected,appdb.T_Products);
		sql.add("join %s u  on u.code_ = g.userId_	" ,appdb.S_Userinfo);
		sql.add("join %s s on g.proId_ = s.proId_" ,appdb.T_Storage);
		if(proName_ != null && proName_ != ""){
			sql.add("and p.proName_ like '%s'" ,new String("%"+proName_+"%"));
		}
		if(saleHomeAgency_ != null && saleHomeAgency_ != ""){
			sql.add("and s.saleHomeAgency_ like '%s'" ,new String("%"+saleHomeAgency_+"%"));
		}
		if(mobile_ != null && mobile_ != ""){
			sql.add("and u.mobile_ like '%s'" ,new String("%"+mobile_+"%"));
		}
	    if(reGoodsTime_ != null && reGoodsTime_ != ""){
			sql.add("and g.createDate_  like '%s'" ,new String("%"+reGoodsTime_+"%"));
		}
		if(rgStatus_ != null && rgStatus_ != ""){
			sql.add("and g.rgStatus_ = '%s'" ,rgStatus_);
		}		
		if(isAgree_ != null && isAgree_ != ""){
			sql.add("and g.isAgree_ = '%s'" ,isAgree_);
		}
		if(rgHand_ != null && rgHand_ != ""){
			sql.add("and g.rgHand_ = '%s'" ,rgHand_);
		}
		sql.add("group by g.orderId_ ");
		sql.add("order by  g.createDate_  desc");
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);
		}
		return this.success();
	}

}
