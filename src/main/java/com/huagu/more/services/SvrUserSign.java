package com.huagu.more.services;

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
 * 
 * @describe 签到人数
 * @author 王姣
 * @date 2018年3月9日下午5:25:44
 * @return
 */
public class SvrUserSign extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		// 今日签到人数
		SqlQuery sql = new SqlQuery(this);
		sql.add("select count(*)  as sum  from %s where CURRENT_DATE = DATE_FORMAT(createTime_,'%s')", appdb.Sign,
				"%Y%m%d");
		sql.open();
		if (!sql.eof())
			// dataOut.getHead().copyValues(sql.getCurrent());
			dataOut.getHead().setField("sum", sql.getCurrent().getInt("sum"));

		// 我的签到总数
		SqlQuery sql1 = new SqlQuery(this);
		sql1.add("select count(*)  as sumSign  from %s ", appdb.Sign);
		sql1.add("where userCode_ = '%s'", headIn.getString("userCode"));
		sql1.open();
		if (!sql1.eof())
			// dataOut.getHead().copyValues(sql1.getCurrent());
			dataOut.getHead().setField("sumSign", sql1.getCurrent().getInt("sumSign"));

		// 拿到签到时间
		SqlQuery sqltime = new SqlQuery(this);
		// 获取本月的
		Date date = new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		int year = calendar.get(calendar.YEAR);
		int month = calendar.get(calendar.MONTH) + 1;
		sqltime.add("select UID_ , createTime_   from %s  ", appdb.Sign, "%Y%m%d");
		sqltime.add("where  userCode_ = '%s'", headIn.getString("userCode"));
		sqltime.add(" and Month(createTime_) = '%s' and Year(createTime_) = '%s'", month, year);
		sqltime.add("order by createTime_ desc");
		sqltime.open();
		if (!sqltime.eof())
			dataOut.appendDataSet(sqltime);

		return this.success();
	}

}
