package com.huagu.order.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 物流列表查询展示
 *  @author 王姣
 *  @date   2018年4月16日下午2:26:31
 *  @return
 */
public class SvrLogisticsQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record head = dataIn.getHead();
		String orderId_ = head.getString("orderId_");
		String content = head.getString("content");
		String orderState_ = head.getString("orderState_");
		String orderType_ = head.getString("orderType_");
		String shippingCosts_ = head.getString("shippingCosts_");
		String deliveryTimeBegin_ = head.getString("deliveryTimeBegin_");
		String deliveryTimeEnd_ = head.getString("deliveryTimeEnd_");
		String recTimeBegin_ = head.getString("recTimeBegin_");
		String recTimeEnd_ = head.getString("recTimeEnd_");
		SqlQuery sql = new SqlQuery(this);
		sql.add("select o.orderId_,o.proId_,p.proName_,o.orderType_,o.userId_,o.orderState_,o.shippingCosts_,o.receiver_,o.recAdr_,o.recPhone_,p.isDel_,"
				+ "o.deliveryTime_,o.recTime_,o.recLogisticsName_,o.retuenLogisticsId_,o.returnLogisticsName_,o.recLogisticsId_"
				+ " from %s o left join %s p on o.proId_=p.proId_ where 1=1 ",appdb.T_ORDER,appdb.T_Products);
		sql.add("and p.isDel_='0'");
		if(orderId_ != null && orderId_ != ""){
			sql.add("and o.orderId_='%s'",orderId_);
		}
		if(content != null && content != ""){
			sql.add("and (p.proName_ like '%s' or o.userId_ like '%s' or o.shippingCosts_ like '%s' or o.receiver_ like '%s' or recAdr_ like '%s'"
					+ " or o.recPhone_ like '%s' or o.shippingCosts_ like '%s' or o.returnLogisticsName_ like '%s' or o.recLogisticsName_ like '%s')",new String("%"+content+"%")
					,new String("%"+content+"%"),new String("%"+content+"%"),new String("%"+content+"%"),new String("%"+content+"%")
					,new String("%"+content+"%"),new String("%"+content+"%"),new String("%"+content+"%"),new String("%"+content+"%"));
		}
		if(orderState_ != null && orderState_ != ""){
			if(orderState_.equals("1")){
				sql.add("and o.orderState_='1'");
			}else if(orderState_.equals("2")){
				sql.add("and o.orderState_='2'");
			}else if(orderState_.equals("3")){
				sql.add("and o.orderState_='3'");
			}else if(orderState_.equals("4")){
				sql.add("and o.orderState_='4'");
			}else if(orderState_.equals("5")){
				sql.add("and o.orderState_='5'");
			}else if(orderState_.equals("6")){
				sql.add("and o.orderState_='6'");
			}else if(orderState_.equals("7")){
				sql.add("and o.orderState_='7'");
			}else if(orderState_.equals("8")){
				sql.add("and o.orderState_='8'");
			}
		}
		if(orderType_ != null && orderType_ != ""){
			if(orderType_.equals("1")){
				sql.add("and o.orderType_='1'");
			}else if(orderType_.equals("2")){
				sql.add("and o.orderType_='2'");
			}else if(orderType_.equals("3")){
				sql.add("and o.orderType_='3'");
			}else if(orderType_.equals("4")){
				sql.add("and o.orderType_='4'");
			}
			
		}
		if(shippingCosts_ != null && shippingCosts_ != ""){
			if(shippingCosts_.equals("1")){
				sql.add("and o.shippingCosts_='0'");
			}else if(shippingCosts_.equals("2")){
				sql.add("and o.shippingCosts_!='0'");
			}
			
		}
		if (deliveryTimeBegin_ != null && deliveryTimeBegin_ != ""){
	          sql.add("and unix_timestamp(o.createDate_) between unix_timestamp( '%s') and unix_timestamp('%s')",
	        		  deliveryTimeBegin_, deliveryTimeEnd_);
	    }
		if (recTimeBegin_ != null && recTimeBegin_ != ""){
	          sql.add("and unix_timestamp(o.createDate_) between unix_timestamp( '%s') and unix_timestamp('%s')",
	        		  recTimeBegin_, recTimeEnd_);
	    }
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
