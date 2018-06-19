package com.huagu.order.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AppHandle;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.IRecord;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.other.utils;

public class orderOneDayProcess {
	private org.apache.log4j.Logger log = org.apache.log4j.Logger.getLogger(this.getClass());

	/* 每天凌晨5点执行一次 */
	@Scheduled(cron="0 0 5 * * ?")
//	@Scheduled(cron="0 * * * * ?")//测每没分钟执行一次
	void scheduler() throws ServiceException {
		int result = execute();
		log.info(result+"条订单已签收");
		
		
	}
	
	//定时任务，下单后一天内未来取物品的处理
	public int execute() throws ServiceException {
		AppHandle handle = new AppHandle();
		SqlQuery sql = new SqlQuery(handle);
		sql.add("select UID_,payTime_,orderId_,orderType_,zhuCode_ from t_order where 1=1");
		sql.add(" and orderType_ in(1,3) and orderState_=3");
		sql.open();
		int num = 0;
		if(!sql.eof()){
			List<Record> records = sql.getRecords();
			for(Record r:records){
				String orderType_ = r.getString("orderType_");//订单类型
				if(orderType_.equals("1")){
					String payTime_ = r.getString("payTime_");//用户付款时间	
					Date now = new Date();
					SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				    Date date = null;
				    try {
						date = format.parse(payTime_);
	 					Long sum = now.getTime() - date.getTime();
						if((sum/1000/60/60/24) > 1){//如果大于一天改为系统自动取消
							SqlQuery sql2 = new SqlQuery(handle);
							sql2.add("select UID_,payTime_,orderId_,orderType_,o.zhuCode_,userId_,sumMoney_,returnMoney_,orderState_,"
									+ "p.discountPrice_,p.isDiscount_,p.dayRentMoney_ "
									+ "from t_order o  left join "
									+ "(select pe.proId_,pe.zhuCode_,ps.dayRentMoney_,ps.isDiscount_,ps.discountPrice_ from t_pronode pe left join  t_products ps on pe.proId_=ps.proId_ ) p "
									+ " on o.zhuCode_=p.zhuCode_ where 1=1");
							sql2.add(" and orderId_='%s'",r.getString("orderId_"));
							sql2.open();
							String sunMoney = updateOrder(sql2.getCurrent());
							sql2.edit();
							sql2.setField("orderState_", 9);//改为系统自动取消订单
							sql2.setField("returnMoney_",sunMoney);//退款的金额
							sql2.post();
							
							//物品改为可租在柜的状态
							SqlQuery sql3 = new SqlQuery(handle);
							sql3.add("select UID_,nodeState_ from %s where 1=1",appdb.T_ProState);
							sql3.add(" and zhuCode_='%s'",r.getString("zhuCode_"));
							sql3.open();
							sql3.edit();
							sql3.setField("nodeState_", 2);//改为系统自动取消订单
							sql3.post();
							num += 1;
						}
						
					} catch (ParseException e) {
						
						e.printStackTrace();
					}
				}
			}
		}
		
		return 0;
	}
	
	public String updateOrder(Record r){
		AppHandle handle = new AppHandle();
		String isDiscount_ = r.getString("isDiscount_");
		String money = "";
		if(isDiscount_.equals("0")){
			money = r.getString("dayRentMoney_");
		}
		if(isDiscount_.equals("1")){
			money = r.getString("discountPrice_");
		}
		String sumMoney_ = r.getString("sumMoney_");
		if(sumMoney_ != null && sumMoney_ != "" && money != null && money != ""){
			Double tot = Double.parseDouble(sumMoney_)-Double.parseDouble(money);
			SqlQuery sql = new SqlQuery(handle);
			//修改用户的余额，加上扣除一天的钱
			sql.add("select UID_,code_,overMoney_ from %s where 1=1 ",appdb.S_Userinfo);
			sql.add(" and code_='%s'",r.getString("userId_"));
			sql.open();
			Record str = sql.getCurrent();
			String overMoney_ = str.getString("overMoney_");
			if(overMoney_ != null && overMoney_ != ""){
				Double overMoney = Double.parseDouble(overMoney_)+tot;
				sql.edit();
				sql.setField("overMoney_", overMoney);
				sql.post();
				
				//修改用户消费记录表，往消费记录加信息
				String guid = utils.newGuid();
				guid = guid.substring(1, guid.length() - 1);
				guid = guid.replaceAll("-", "");
				SqlQuery sql2 = new SqlQuery(handle);
				sql2.add("select UID_,createTime_,userCode_,opeType_,amount_,openid_,out_trade_no_,status_,orderId_ from %s",appdb.Record);
				sql2.add(" where userCode_='%s'",r.getString("userId_"));
				sql2.open();
				sql2.append();
				sql2.setField("createTime_", TDateTime.Now() );
				sql2.setField("userCode_", r.getString("userId_") );
				sql2.setField("opeType_", "D" );
				sql2.setField("amount_", overMoney );
				sql2.setField("openid_", r.getString("userId_") );
				sql2.setField("out_trade_no_", guid );
				sql2.setField("status_", 0);
				sql2.setField("orderId_",r.getString("orderId_"));
				sql2.post();
			}
			
			return tot.toString();
		}
		return null;
		
	}
}
