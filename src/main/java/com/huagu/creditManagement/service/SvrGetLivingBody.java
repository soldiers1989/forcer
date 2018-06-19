package com.huagu.creditManagement.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * @describe 查询后台客户认证资料
 * @date 2018年3月21日
 * @return
 */
public class SvrGetLivingBody extends AbstractService {
	static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		String userCode_ = this.getUserCode();
		if("".equals(userCode_))
			userCode_ = "15071506306";
		
		SqlQuery sql = new SqlQuery(this);
		if("ups".equals(headIn.getSafeString("type_"))){
			// 修改UID用户
			sql.add("SELECT UID_,createDate_,id_,userCode_,sxDate_,cabAdr_,cabNo_,case status_ when 1 then '正常' when 2 then '失效' end status_,imgUrl_ FROM %s", appdb.HTCERTIFIED);
			sql.add(" where 1=1 ");
			sql.add(" AND UID_ = '%s'", headIn.getString("id_"));
			sql.open();
			sql.edit();
			try {
				Date date = dateFormat.parse(sql.getString("sxDate_"));
				Date newDate = addDate(date, 30); // 指定日期加上20天 
				sql.setField("sxDate_", dateFormat.format(newDate));
				sql.post();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if("up".equals(headIn.getSafeString("type_"))){
			// 修改UID用户
			sql.add("SELECT UID_,createDate_,id_,userCode_,sxDate_,cabAdr_,cabNo_,status_,imgUrl_ FROM %s", appdb.HTCERTIFIED);
			sql.add(" where 1=1 ");
			sql.add(" AND UID_ = '%s'", headIn.getString("id_"));
			sql.open();
			sql.edit();
			if("正常".equals(headIn.getString("status_")))
				sql.setField("status_",  "2");
			if("失效".equals(headIn.getString("status_")))
				sql.setField("status_",  "1");
			sql.post();
		}else if("sel".equals(headIn.getSafeString("type_"))){
			// 查询单个用户
			sql.add("SELECT UID_,createDate_,createUser_,count_,name_,idCard_,sqStatus_,rzStatus_,sesameFen_ FROM %s", appdb.SESAMELOG);
			sql.add(" where 1=1 ");
			sql.add(" AND createUser_ = '%s'",  headIn.getString("code_"));
			sql.setMaximum(1);
			sql.open();
			if(!sql.eof())
				dataOut.appendDataSet(sql);
		}else{
			// 查询所有用户
			sql.add("SELECT UID_,createDate_,id_,userCode_,sxDate_,cabAdr_,cabNo_,case status_ when 1 then '正常' when 2 then '失效' end status_,imgUrl_ FROM %s", appdb.HTCERTIFIED);
			sql.add(" where 1=1 ");
			if(headIn.hasValue("mobile_"))
				sql.add(" AND userCode_ LIKE '%s'", '%' +headIn.getString("mobile_")+ '%');
			if(headIn.hasValue("status_"))
				sql.add(" AND status_ LIKE '%s'", '%' +headIn.getString("status_")+ '%');
			if(headIn.hasValue("sxDate_"))
				sql.add(" AND sxDate_ LIKE '%s'", '%' +headIn.getString("sxDate_")+ '%');
			if(headIn.hasValue("date_"))
				sql.add(" AND createDate_ LIKE '%s'", '%' +headIn.getString("date_")+ '%');
			sql.open();
			if(!sql.eof())
				dataOut.appendDataSet(sql);
		}
		sql.close();
		return this.success();
	}
	
	/**
	 * 给时间追加天数
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
