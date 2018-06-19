package com.huagu.login.services;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jbean.other.SystemTable;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

import org.apache.commons.lang.StringUtils;

import com.huagu.common.constant.ReportConstant;
import com.huagu.common.global.appdb;
import com.huagu.common.util.DateUtil;

/*
 * 用户统计服务
 */
public class SvrReportUserAdd extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		int type = headIn.getInt("type");
		if(StringUtils.isEmpty(this.getUserCode())||StringUtils.isEmpty(this.getCorpNo())){
			//未登录用户
			return null;
		}
		
		//根据s_currentuser查询用户今日是否已登录过
		SqlQuery ds1 = new SqlQuery(this);
		ds1.add("select count(*) as count from %s ", SystemTable.get(SystemTable.getCurrentUser));
		ds1.add("where Account_ = '%s' and DATE_FORMAT(NOW(),'%%Y%%m%%d') = DATE_FORMAT(LoginTime_,'%%Y%%m%%d')", this.getUserCode());
		ds1.open();
		
		if(ds1.getInt("count") <= 1){
			//暂未登录+1
			SqlQuery ds = new SqlQuery(this);
			ds.add("select UID_,corpNo_,updateUser_,updateTime_,createUser_,createTime_,regist_count_,bind_count_,unbind_count_,login_count_ from %s", appdb.getUserReportTable(this));
			ds.add("where corpNo_ = '%s' and createTime_ = '%s'", this.getCorpNo(), DateUtil.getDay());
			ds.open();
			if(ds.eof()){
				ds.append();
				ds.setField("corpNo_", this.getCorpNo());
				ds.setField("updateUser_", this.getUserCode());
				ds.setField("updateTime_", DateUtil.getTime());
				ds.setField("createUser_", this.getUserCode());
				ds.setField("createTime_", DateUtil.getDay());
				ds.setField("regist_count_", ReportConstant.REPORT_REGIST == type?1:0);
				ds.setField("bind_count_", ReportConstant.REPORT_BIND == type?1:0);
				ds.setField("unbind_count_", ReportConstant.REPORT_UNBIND == type?1:0);
				ds.setField("login_count_", ReportConstant.REPORT_LOGIN == type?1:0);
			}else{
				ds.edit();
				ds.setField("updateUser_", this.getUserCode());
				ds.setField("updateTime_", DateUtil.getTime());
				if(ReportConstant.REPORT_REGIST == type)
					ds.setField("regist_count_", ds.getInt("regist_count_") + 1);
				if(ReportConstant.REPORT_BIND == type)
					ds.setField("bind_count_", ds.getInt("bind_count_") + 1);
				if(ReportConstant.REPORT_UNBIND == type)
					ds.setField("unbind_count_", ds.getInt("unbind_count_") + 1);
				if(ReportConstant.REPORT_LOGIN == type)
					ds.setField("login_count_", ds.getInt("login_count_") + 1);
			}
			ds.post();
		}
		return success();
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}
}
