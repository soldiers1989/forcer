package com.huagu.myWallet.services;

import com.huagu.common.global.appdb;
import com.huagu.myWallet.forms.FrmAdjust;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 财务平台所有用户余额
 *  @author lxf
 *  @date   2018年4月26日下午2:56:32
 *  @return
 */
public class SvrGetFinanceOvervicw extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		if("up".equals(head.getString("type_"))){
			// 调出账户减钱
			sql.add("SELECT UID_,id_,name_,balance_,type_,desc_ FROM %s", appdb.FUNDSACCOUNT);
			sql.add(" where id_ = '%s'", head.getString("czong_"));
			sql.open();
			if(!sql.eof()){
				Double qamount_ = sql.getDouble("balance_");
				Double hamount_ = qamount_ - head.getDouble("money_");
				sql.edit();
				sql.setField("balance_", hamount_);
				sql.post();
				try {
					FrmAdjust.addRecordLog(handle, head.getDouble("money_"), "支出", qamount_, hamount_,  head.getString("czong_"), "调入账户"+ head.getString("rzong_"));
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			SqlQuery add = new SqlQuery(this);
			// 调入账户加钱
			add.add("SELECT UID_,id_,name_,balance_,type_,desc_ FROM %s", appdb.FUNDSACCOUNT);
			add.add(" where id_ = '%s'", head.getString("rzong_"));
			add.open();
			if(!add.eof()){
				Double qamount_ = add.getDouble("balance_");
				Double hamount_ = qamount_ + head.getDouble("money_");
				add.edit();
				add.setField("balance_", hamount_);
				add.post();
				try {
					FrmAdjust.addRecordLog(handle, head.getDouble("money_"), "收入", qamount_, hamount_, head.getString("rzong_"), "调出账户"+ head.getString("czong_"));
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
		}else{
			sql.add("SELECT UID_,id_,name_,balance_,type_,desc_ FROM %s", appdb.FUNDSACCOUNT);
			sql.open();
			if(!sql.eof())
				dataOut.appendDataSet(sql);
		}
			
		return this.success();
	}

}
