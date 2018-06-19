package com.huagu.troubleshooting.forms;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import org.springframework.scheduling.annotation.Scheduled;
import com.huagu.pay.enums.accountdb;
import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.core.AppHandle;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.mysql.SqlQuery;

public class billCearingTask {
	private org.apache.log4j.Logger log = org.apache.log4j.Logger.getLogger(this.getClass());

	/* 每天凌晨5点执行一次 */
	@Scheduled(cron="0 0 5 * * ?")
	// @Scheduled(cron = "0/5 * *  * * ? ")
	void scheduler() throws ServiceException {
		boolean result = execute();
		log.info("定时清算账单完成");
	}

	public boolean execute() throws ServiceException {
		AppHandle handle = new AppHandle();
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		Date time = cal.getTime();
		String date = new SimpleDateFormat("yyyy-MM-dd").format(time);
		
		// 今日充值汇总
		LocalService chongzhi = new LocalService(handle, "SvrGetFundsAccount");
		if(!chongzhi.exec("id_", accountdb.CHONGZHI))
			throw new RuntimeException(chongzhi.getMessage());
		String chongzhiAccount = chongzhi.getDataOut().getCurrent().getString("amount_");
		if(chongzhiAccount == "")
			log.info("今日充值账户：0.00");
		else
			log.info("今日充值账户："+ chongzhiAccount);
		
		// 今日提现汇总
		LocalService tixian = new LocalService(handle, "SvrGetFundsAccount");
		if(!tixian.exec("id_", accountdb.TIXIAN))
			throw new RuntimeException(tixian.getMessage());
		String tixianAccount = tixian.getDataOut().getCurrent().getString("amount_");
		if(tixianAccount == "")
			log.info("今日提现金额：0.00");
		else
			log.info("今日提现金额" + tixianAccount);
		
		// 租赁订单今日结算订单租金总金额
		// 租赁订单今日结算时扣除的租金金额
		// 微信账户总金额
		LocalService overMoney_ = new LocalService(handle, "SvrGetUserMoney");
		if(!overMoney_.exec())
			throw new RuntimeException(overMoney_.getMessage());
		String wxOverMoney = overMoney_.getDataOut().getCurrent().getString("overMoney_");
		if(wxOverMoney == "")
			log.info("今日微信账户总金额：0.00");
		else
			log.info("今日微信账户总金额" + wxOverMoney);
		
		// 用户总可用余额
		LocalService keyong = new LocalService(handle, "SvrGetFundsAccount");
		if(!keyong.exec("id_", accountdb.KEYONG))
			throw new RuntimeException(keyong.getMessage());
		String keyongAccount = keyong.getDataOut().getCurrent().getString("amount_");
		if(keyongAccount == "")
			log.info("今日用户总可用余额：0.00");
		else
			log.info("今日用户总可用余额" + keyongAccount);
		// 今日产生赔付单金额
		
		// 今日产生负数总金额
		// 今日用户充值填补负数总金额
		// 今日新建产生租赁单立收租金金额
		
		SqlQuery bill = new SqlQuery(handle);
		return true;
	}

	public static void main(String[] args) {
		billCearingTask b = new billCearingTask();
		try {
			b.scheduler();
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
