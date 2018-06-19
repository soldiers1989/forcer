package com.huagu.myWallet.services;



import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 财务平台所有用户余额
 *  @author lxf
 *  @date   2018年4月26日下午2:56:32
 *  @return
 */
public class SvrGetUserMoney extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		if("user_".equals(head.getString("type_"))){
			sql.add("SELECT UID_, code_, name_,mobile_,userJifen_,overMoney_ FROM s_userinfo WHERE isManager_ = '0'");
			if(head.hasValue("overMoneyd_"))
				sql.add(" and overMoney_ > '%s'", head.getDouble("overMoneyd_"));
			if(head.hasValue("overMoneyx_"))
				sql.add(" and overMoney_ < '%s'", head.getDouble("overMoneyx_s"));
			sql.open();
			sql.setMaximum(20);
			DataSet user = new DataSet();
			for (int i = 0; i < sql.size(); i++) {
		        // 累计提现金额
		        LocalService getUserMT = new LocalService(this, "SvrGetUserRecord");
		        if(!getUserMT.exec("type_", "0", "code_", sql.getRecords().get(i).getString("code_")))
		        	throw new RuntimeException(getUserMT.getMessage());
		        
		        // 累计充值金额
		        LocalService getUserMC = new LocalService(this, "SvrGetUserRecord");
		        if(!getUserMC.exec("type_", "1", "code_",  sql.getRecords().get(i).getString("code_")))
		        	throw new RuntimeException(getUserMC.getMessage());

		        // 订单商品原价总和
		        LocalService dayRentMoney_ = new LocalService(this, "SvrGetUserOrderMoney");
		        if(!dayRentMoney_.exec("type_", "dayRentMoney_", "code_",  sql.getRecords().get(i).getString("code_")))
		        	throw new RuntimeException(dayRentMoney_.getMessage());
		        
		        // 用户商品押金总和
		        LocalService cashPledge_ = new LocalService(this, "SvrGetUserOrderMoney");
		        if(!cashPledge_.exec("type_", "cashPledge_", "code_",  sql.getRecords().get(i).getString("code_")))
		        	throw new RuntimeException(cashPledge_.getMessage());
		        
		        // 用户在租订单总额
		        LocalService sumRentMoney_ = new LocalService(this, "SvrGetUserOrderMoney");
		        if(!sumRentMoney_.exec("type_", "sumRentMoney_", "code_",  sql.getRecords().get(i).getString("code_")))
		        	throw new RuntimeException(sumRentMoney_.getMessage());
		        
		        user.append();
		        user.setField("name_", sql.getRecords().get(i).getString("name_"));
		        // 当查询的值大于并且小于的时候
		        user.setField("overMoney_", sql.getRecords().get(i).getString("overMoney_"));
				        
			    if(head.hasValue("cashPledge_")){
			    	if(sql.getRecords().get(i).getDouble("cashPledge_") > head.getDouble("cashPledge_"))
				        user.setField("cashPledge_", cashPledge_.getDataOut().getCurrent().getString("cashPledge_"));
			    }else{
			    	user.setField("cashPledge_", cashPledge_.getDataOut().getCurrent().getString("cashPledge_"));
			    }
					        
			    if(head.hasValue("amount_1")){
			    	if(getUserMT.getDataOut().getCurrent().getDouble("amount_") > head.getDouble("amount_1"))
			    		user.setField("amount_1", getUserMT.getDataOut().getCurrent().getString("amount_"));
			    }else{
			    	user.setField("amount_1", getUserMT.getDataOut().getCurrent().getString("amount_"));
			    }
			    
			    if(head.hasValue("amount_2")){
			    	if(getUserMC.getDataOut().getCurrent().getDouble("amount_") > head.getDouble("amount_2"))
			    		user.setField("amount_2", getUserMC.getDataOut().getCurrent().getString("amount_"));
			    }else{
			    	user.setField("amount_2", getUserMC.getDataOut().getCurrent().getString("amount_"));
			    }

			    if(head.hasValue("sumRentMoney_")){
			    	if(dayRentMoney_.getDataOut().getCurrent().getDouble("sumRentMoney_") > head.getDouble("sumRentMoney_"))
			    		user.setField("sumRentMoney_", dayRentMoney_.getDataOut().getCurrent().getString("sumRentMoney_"));
			    }else{
			        user.setField("sumRentMoney_", dayRentMoney_.getDataOut().getCurrent().getString("sumRentMoney_"));
			    }
			    	
		        /*user.setField("overMoney_", sql.getRecords().get(i).getString("overMoney_"));
		        user.setField("amount_1", getUserMT.getDataOut().getCurrent().getString("amount_"));
		        user.setField("amount_2", getUserMC.getDataOut().getCurrent().getString("amount_"));
		        user.setField("dayRentMoney_", dayRentMoney_.getDataOut().getCurrent().getString("dayRentMoney_"));
		        user.setField("cashPledge_", cashPledge_.getDataOut().getCurrent().getString("cashPledge_"));
		        user.setField("sumRentMoney_", sumRentMoney_.getDataOut().getCurrent().getString("sumRentMoney_"));*/
		        user.post();
			}
			if(!sql.eof())
				dataOut.appendDataSet(user);
		}else{
			sql.add("SELECT UID_,sum(overMoney_) overMoney_ FROM s_userinfo WHERE isManager_ = '0'");
			// 查询账户余额正数总额
			if("zs".equals(head.getString("type_")))
				sql.add(" AND overMoney_ > 0");
			// 查询账户余额负数总额
			if("fs".equals(head.getString("type_")))
				sql.add(" AND overMoney_ < 0");
			sql.open();
			if(!sql.eof())
				dataOut.appendDataSet(sql);
		}
		return this.success();
	}

}
