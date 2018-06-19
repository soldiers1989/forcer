package com.huagu.operate.service;

import java.util.Calendar;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
/**
 * 添加/修改运费模板
 */
public class SvrAddStandard  extends AbstractService{

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		String nameId_ = headIn.getString("nameId_");
		SqlQuery ds = new SqlQuery(this);
		ds.add("select * from %s where 1=1",appdb.T_Feight);
		if(headIn.hasValue("nameId_")){
			ds.add(" and nameId_='%s'",nameId_);
		}
		ds.open();
		if(nameId_ == "" || nameId_ == null){
			ds.append();
			ds.setField("createUser_", this.getUserCode());
			ds.setField("createDate_", TDateTime.Now());
			ds.setField("name_", headIn.getString("name_"));
			//模板名Id
			Calendar calendar = Calendar.getInstance();
			long pro_ = calendar.getTime().getTime();
			String nameId=Long.toString(pro_);
			ds.setField("nameId_", nameId);
			ds.setField("method_", headIn.getString("method_"));
			ds.setField("fristJian_", headIn.getInt("fristJian_"));
			ds.setField("fristJianMoney_", headIn.getDouble("fristJianMoney_"));
			ds.setField("nextJian_", headIn.getInt("nextJian_"));
			ds.setField("nextJianMoney_", headIn.getDouble("nextJianMoney_"));
			ds.setField("baoFreight_", headIn.getInt("baoFreight_"));
			ds.setField("baoArea_", headIn.getString("baoArea_"));
			ds.setField("notBaoArea_", headIn.getString("notBaoArea_"));
			ds.post();
		}else{
			ds.edit();
			ds.setField("updateUser_", this.getUserCode());
			ds.setField("updateDate_", TDateTime.Now());
			ds.setField("name_", headIn.getString("name_"));
			ds.setField("method_", headIn.getString("method_"));
			ds.setField("fristJian_", headIn.getInt("fristJian_"));
			ds.setField("fristJianMoney_", headIn.getDouble("fristJianMoney_"));
			ds.setField("nextJian_", headIn.getInt("nextJian_"));
			ds.setField("nextJianMoney_", headIn.getDouble("nextJianMoney_"));
			ds.setField("baoFreight_", headIn.getInt("baoFreight_"));
			ds.setField("baoArea_", headIn.getString("baoArea_"));
			ds.setField("notBaoArea_", headIn.getString("notBaoArea_"));
			ds.post();
		}
		return this.success();
	}

}
