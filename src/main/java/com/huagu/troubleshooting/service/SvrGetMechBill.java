package com.huagu.troubleshooting.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.huagu.common.global.appdb;
import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 社区账单所有信息
 * 
 * @author xiaofei-pc
 *
 */
public class SvrGetMechBill extends AbstractService {
	static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		SqlQuery sql = new SqlQuery(this);
		if ("2".equals(headIn.getString("type_"))) {
			sql.add("SELECT UID_,createTime_,SUM(cMoney_) cMoney_,SUM(tMoney_) tMoney_,SUM(leaseTotalMoney_) leaseTotalMoney_,SUM(leaseKouchuMoney_) leaseKouchuMoney_,SUM(wxUserMoney_) wxUserMoney_,"
					+ "SUM(userAvailableMoney_) userAvailableMoney_,SUM(userzAvailableMoney_) userzAvailableMoney_,SUM(userfAvailableMoney_) userfAvailableMoney_,SUM(userPeifuMoney_) userPeifuMoney_,SUM(userFuMoney_) userFuMoney_,SUM(userTianbuMoney_) userTianbuMoney_,SUM(leaseLishouMoney_) leaseLishouMoney_ FROM %s",
					appdb.BILL);
			sql.add(" where 1 = 1");
			sql.add(" and type_ = '3'");
			if (headIn.hasValue("unlockDate_"))
				sql.add(" and createTime_ LIKE '%s'", "%" + headIn.getSafeString("unlockDate_") + "%");
			if (headIn.hasValue("endDate_"))
				sql.add(" and createTime_ LIKE '%s'", "%" + headIn.getSafeString("endDate_") + "%");
			sql.add(" group by WEEK(createTime_)");
			sql.open();
			if (!sql.eof()) {
				DataSet ds = new DataSet();
				try {
					for (int i = 0; i < sql.size(); i++) {
						ds.append();
						Date date = dateFormat.parse(sql.getRecords().get(i).getString("createTime_"));
						Date newDate = addDate(date, 6); // 指定日期加上20天
						ds.setField("createTime_",
								sql.getRecords().get(i).getDate("createTime_") + " ~ " + dateFormat.format(newDate));
						ds.setField("cMoney_", sql.getRecords().get(i).getString("cMoney_"));
						ds.setField("tMoney_", sql.getRecords().get(i).getString("tMoney_"));
						ds.setField("leaseTotalMoney_", sql.getRecords().get(i).getString("leaseTotalMoney_"));
						ds.setField("leaseKouchuMoney_", sql.getRecords().get(i).getString("leaseKouchuMoney_"));
						ds.setField("userPeifuMoney_", sql.getRecords().get(i).getString("userPeifuMoney_"));
						ds.setField("userTianbuMoney_", sql.getRecords().get(i).getString("userTianbuMoney_"));
						ds.setField("leaseLishouMoney_", sql.getRecords().get(i).getString("leaseLishouMoney_"));
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				dataOut.appendDataSet(ds);
			}
		} else if ("3".equals(headIn.getString("type_"))) {
			sql.add("SELECT UID_,createTime_,SUM(cMoney_) cMoney_,SUM(tMoney_) tMoney_,SUM(leaseTotalMoney_) leaseTotalMoney_,SUM(leaseKouchuMoney_) leaseKouchuMoney_,SUM(wxUserMoney_) wxUserMoney_,"
					+ "SUM(userAvailableMoney_) userAvailableMoney_,SUM(userzAvailableMoney_) userzAvailableMoney_,SUM(userfAvailableMoney_) userfAvailableMoney_,SUM(userPeifuMoney_) userPeifuMoney_,SUM(userFuMoney_) userFuMoney_,SUM(userTianbuMoney_) userTianbuMoney_,SUM(leaseLishouMoney_) leaseLishouMoney_ FROM %s",
					appdb.BILL);
			sql.add(" where 1 = 1");
			sql.add(" and type_ = '3'");
			if (headIn.hasValue("unlockDate_"))
				sql.add(" and createTime_ LIKE '%s'", "%" + headIn.getSafeString("unlockDate_") + "%");
			if (headIn.hasValue("endDate_"))
				sql.add(" and createTime_ LIKE '%s'", "%" + headIn.getSafeString("endDate_") + "%");
			sql.add(" group by MONTH(createTime_)");
			sql.open();
			if (!sql.eof()) {
				DataSet ds = new DataSet();
				try {
					for (int i = 0; i < sql.size(); i++) {
						ds.append();
						ds.setField("createTime_", getMinMonthDate(sql.getRecords().get(i).getString("createTime_"))
								+ " ~ " + getMaxMonthDate(sql.getRecords().get(i).getString("createTime_")));
						ds.setField("cMoney_", sql.getRecords().get(i).getString("cMoney_"));
						ds.setField("tMoney_", sql.getRecords().get(i).getString("tMoney_"));
						ds.setField("leaseTotalMoney_", sql.getRecords().get(i).getString("leaseTotalMoney_"));
						ds.setField("leaseKouchuMoney_", sql.getRecords().get(i).getString("leaseKouchuMoney_"));
						ds.setField("wxUserMoneyc_", sql.getRecords().get(i).getString("wxUserMoneyc_"));
						ds.setField("wxUserMoney_", sql.getRecords().get(i).getString("wxUserMoney_"));
						ds.setField("userAvailableMoneyc_", sql.getRecords().get(i).getString("userAvailableMoneyc_"));
						ds.setField("userAvailableMoney_", sql.getRecords().get(i).getString("userAvailableMoney_"));
						ds.setField("userzAvailableMoneyc_",
								sql.getRecords().get(i).getString("userzAvailableMoneyc_"));
						ds.setField("userzAvailableMoney_", sql.getRecords().get(i).getString("userzAvailableMoney_"));
						ds.setField("userfAvailableMoneyc_",
								sql.getRecords().get(i).getString("userfAvailableMoneyc_"));
						ds.setField("userfAvailableMoney_", sql.getRecords().get(i).getString("userfAvailableMoney_"));
						ds.setField("userPeifuMoney_", sql.getRecords().get(i).getString("userPeifuMoney_"));
						ds.setField("userFuMoney_", sql.getRecords().get(i).getString("userFuMoney_"));
						ds.setField("userTianbuMoney_", sql.getRecords().get(i).getString("userTianbuMoney_"));
						ds.setField("leaseLishouMoney_", sql.getRecords().get(i).getString("leaseLishouMoney_"));
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				dataOut.appendDataSet(ds);
			}
		} else if ("1".equals(headIn.getString("type_"))) {
			sql.add("SELECT UID_,createTime_,cMoney_,tMoney_,leaseTotalMoney_,leaseKouchuMoney_,wxUserMoney_,userAvailableMoney_,userzAvailableMoney_,userfAvailableMoney_,userPeifuMoney_,userFuMoney_,userTianbuMoney_,leaseLishouMoney_ FROM %s",
					appdb.BILL);
			sql.add(" where 1 = 1");
			sql.add(" and type_ = '3'");
			if (headIn.hasValue("unlockDate_"))
				sql.add(" and createTime_ LIKE '%s'", "%" + headIn.getSafeString("unlockDate_") + "%");
			if (headIn.hasValue("endDate_"))
				sql.add(" and createTime_ LIKE '%s'", "%" + headIn.getSafeString("endDate_") + "%");
			sql.open();
			if (!sql.eof()) {
				dataOut.appendDataSet(sql);
			}
		}

		return success();
	}

	/**
	 * 在当前时间后面追加时间
	 * 
	 * @param num
	 * @param newDate
	 * @return
	 * @throws Exception
	 */
	public static String plusDay(int num, String newDate) throws Exception {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date currdate = format.parse(newDate);
		System.out.println("现在的日期是：" + currdate);
		Calendar ca = Calendar.getInstance();
		ca.add(Calendar.DATE, num);// num为增加的天数，可以改变的
		currdate = ca.getTime();
		String enddate = format.format(currdate);
		System.out.println("增加天数以后的日期：" + enddate);
		return enddate;
	}

	/**
	 * 获取月份起始日期
	 * 
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static String getMinMonthDate(String date) throws Exception {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dateFormat.parse(date));
		calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
		return dateFormat.format(calendar.getTime());
	}

	/**
	 * 获取月份最后日期
	 * 
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static String getMaxMonthDate(String date) throws Exception {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dateFormat.parse(date));
		calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
		return dateFormat.format(calendar.getTime());
	}

	/**
	 * 给时间追加天数
	 * 
	 * @param date
	 * @param day
	 * @return
	 * @throws Exception
	 */
	public static Date addDate(Date date, long day) throws Exception {
		long time = date.getTime(); // 得到指定日期的毫秒数
		day = day * 24 * 60 * 60 * 1000; // 要加上的天数转换成毫秒数
		time += day; // 相加得到新的毫秒数
		return new Date(time); // 将毫秒数转换成日期
	}
}
