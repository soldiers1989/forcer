package com.huagu.order.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.scheduling.annotation.Scheduled;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AppHandle;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataQuery;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.mysql.Transaction;

public class UserOrderTask {
	private org.apache.log4j.Logger log = org.apache.log4j.Logger.getLogger(this.getClass());

	/* 每天凌晨5点执行一次 */
	@Scheduled(cron="0 0 5 * * ?")
	//@Scheduled(cron="0 * * * * ?")//测每没分钟执行一次
	void scheduler() throws ServiceException {
		int result = execute();
		log.info(result+"个订单评价完成");
		
		
	}
	public int execute() throws ServiceException {
		AppHandle handle = new AppHandle();
		SqlQuery comm = new SqlQuery(handle);
		comm.add("select * from %s where orderState_=4",appdb.T_ORDER);
		comm.add(" and orderType_=1");
		comm.open();
		int mun = 0;
		if(!comm.eof()){
			List<Record> lists = comm.getRecords();
			for(Record l:lists){
				String returnTime = l.getSafeString("returnTime_");
				Date now = new Date();
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			    Date date = null;
			    try {
					date = format.parse(returnTime);
					Long sum = date.getTime()-now.getTime();
					if(sum < 0){
						SqlQuery sql = new SqlQuery(handle);
						sql.add("select UID_,orderId_,orderState_ from %s where 1=1 ",appdb.T_ORDER);
						sql.add("and orderId_='%s'",l.getSafeString("orderId_"));
						sql.open();
						sql.edit();
						sql.setField("orderState_",5);//待归还
						sql.post();
						mun += 1;
						
					}
				} catch (ParseException e) {
					
					e.printStackTrace();
				}
		       
			    return mun;
			}
		}
		return 0;
	}
}
