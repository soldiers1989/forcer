package com.huagu.creditManagement.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * @describe 查询/更改后台征信配置
 * @date 2018年3月21日
 * @return
 */
public class SvrGetCreditDeploy extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		if("up".equals(headIn.getString("type_"))){
			if(headIn.getString("credit") != ""){
				sql.add("SELECT UID_,type_,money_,moneyS_ FROM %s", appdb.CREDITDEPLOY);
				sql.add(" where 1=1 AND type_ = 1");
				sql.open();
				sql.edit();
				sql.setField("moneyS_", sql.getString("money_"));
				sql.setField("money_", headIn.getString("credit"));
				sql.post();
			}
			if(headIn.getString("credit1") != ""){
				sql.add("SELECT UID_,type_,money_,moneyS_ FROM %s", appdb.CREDITDEPLOY);
				sql.add(" where 1=1 AND type_ = 2");
				sql.open();
				sql.edit();
				sql.setField("moneyS_", sql.getString("money_"));
				sql.setField("money_", headIn.getString("credit1"));
				sql.post();
			}
			if(headIn.getString("credit2") != ""){
				sql.add("SELECT UID_,type_,money_,moneyS_ FROM %s", appdb.CREDITDEPLOY);
				sql.add(" where 1=1 AND type_ = 3");
				sql.open();
				sql.edit();
				sql.setField("moneyS_", sql.getString("money_"));
				sql.setField("money_", headIn.getString("credit2"));
				sql.post();
			}
			if(headIn.getString("credit3") != ""){
				sql.add("SELECT UID_,type_,money_,moneyS_ FROM %s", appdb.CREDITDEPLOY);
				sql.add(" where 1=1 AND type_ = 4");
				sql.open();
				sql.edit();
				sql.setField("moneyS_", sql.getString("money_"));
				sql.setField("money_", headIn.getString("credit3"));
				sql.post();
			}
			if(headIn.getString("credit4") != ""){
				sql.add("SELECT UID_,type_,money_,moneyS_ FROM %s", appdb.CREDITDEPLOY);
				sql.add(" where 1=1 AND type_ = 5");
				sql.open();
				sql.edit();
				sql.setField("moneyS_", sql.getString("money_"));
				sql.setField("money_", headIn.getString("credit4"));
				sql.post();
			}
		}else{
			sql.add("SELECT UID_,type_,money_ FROM %s", appdb.CREDITDEPLOY);
			sql.add(" where 1=1 ");
			sql.open();
			if(!sql.eof())
				dataOut.appendDataSet(sql);
		}
		
		return this.success();
	}

}
