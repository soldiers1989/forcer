package com.huagu.common.services.moneyRecord;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.mysql.Transaction;
import cn.cerc.jdb.other.utils;

/**
 * @describe 消息添加
 * @author 
 * @date 
 * @return
 */
public class SvrMoneyRecord extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		
		Record head = dataIn.getHead();
		String guid = utils.newGuid();
		guid = guid.substring(1, guid.length() - 1);
		guid = guid.replaceAll("-", "");
		try (Transaction tx = new Transaction(this)) {
			SqlQuery sql2 = new SqlQuery(this);
			sql2.add("select UID_,code_,overMoney_ from %s",appdb.S_Userinfo);
			sql2.add("where code_='%s'",head.getString("userCode_"));
			sql2.open();
			Record r = sql2.getCurrent();
			String overMoney_ = r.getString("overMoney_");//用户余额
			if(overMoney_ == null || overMoney_ == ""){
				overMoney_ = "0";
			}
			
			String amount_ =  head.getString("amount_");//操作金额
			String platform_ = head.getString("platform_");//支付平台
			String opeType_ = head.getString("opeType_");//操作类型   A:转出 B：转入 C：付款 D：退款
			Double userNowMoney_ = Double.parseDouble(overMoney_);//用户当前余额
			if(platform_ == null || platform_ == ""){
				if(opeType_.equals("A") || opeType_.equals("C")){ //转出&付款：用户余额 - 操作金额
					userNowMoney_ = Double.parseDouble(overMoney_) - Double.parseDouble(amount_);
				}
				if(opeType_.equals("B") || opeType_.equals("D")){ //转入&退款：用户余额 + 操作金额
					userNowMoney_ = Double.parseDouble(overMoney_) + Double.parseDouble(amount_);
				}
				
			}
			sql2.edit();
			sql2.setField("overMoney_", userNowMoney_);
			sql2.post();
			
			SqlQuery sql = new SqlQuery(this);
			//                   用户code    支付平台       流水号                         操作金额    操作类型        创建时间             是否成功     用户ID    支付openid
			sql.add("select UID_,userCode_,platform_,out_trade_no_,amount_,opeType_,createTime_,status_,orderId_,openid_,userNowMoney_ "
					+ "from %s ", appdb.Record);
			sql.open();
			sql.append();
			sql.setField("userCode_", head.getString("userCode_"));
			sql.setField("platform_", head.getString("platform_"));
			if(head.hasValue("out_trade_no_")){
				sql.setField("out_trade_no_", head.getString("out_trade_no_"));
			}else{
				sql.setField("out_trade_no_",guid);
			}
			sql.setField("amount_", head.getString("amount_"));
			sql.setField("opeType_",head.getString("opeType_"));
			sql.setField("createTime_", TDateTime.Now());
			sql.setField("status_",0);
			if(head.hasValue("orderId_")){
				sql.setField("orderId_", head.getString("orderId_"));
			}
			if(head.hasValue("openid_")){
				sql.setField("openid_", head.getString("openid_"));
			}
			System.out.println("userNowMoney_:"+userNowMoney_);
			sql.setField("userNowMoney_",userNowMoney_);
			sql.post();
			tx.commit();
			return this.success();
			}
		
		}
		

}
