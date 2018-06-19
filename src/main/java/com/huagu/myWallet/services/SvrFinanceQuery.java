package com.huagu.myWallet.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 *  @describe 财务列表查询展示
 *  @author 王姣
 *  @date   2018年4月3日下午2:56:32
 *  @return
 */
public class SvrFinanceQuery extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String name_ = head.getString("name_");
		String status_ = head.getString("status_");
		String platform_ = head.getString("platform_");
		String type_ = head.getString("type_");
		String orderId_ = head.getString("orderId_");
		String opeType_ = head.getString("opeType_");
		String createDate1 = head.getString("createDate1");
		String createDate2 = head.getString("createDate2");
		if(type_.equals("2")){
			type_ ="";
		}
		if(status_.equals("2")){
			status_ ="";
		}if(opeType_.equals("E")){
			opeType_ = "";
		}
		sql.add("select  r.UID_ ,u.name_,DATE_FORMAT(r.createTime_,'%s') as createTime_ ,r.out_trade_no_,r.platform_ ,r.type_ ,r.opeType_ ,r.amount_ ,r.status_ ,r.orderId_" ,"%Y-%m-%d %H:%i:%s");
		sql.add("from %s r join %s u  on r.userCode_ = u.code_" ,appdb.Record,appdb.S_Userinfo);
		sql.add("where 1 = 1");
		if(name_ != null && name_ != ""){
			sql.add("and u.name_ like '%s'" ,new String("%"+name_+"%"));
		}if(status_ != null && status_ != ""){
			sql.add("and status_ = '%s'" ,status_);
		}if(platform_ != null && platform_ != ""){
			sql.add("and platform_ = '%s' " ,platform_);
		}if(type_ != null && type_ != ""){
			sql.add("and type_ = '%s'" ,type_);
		}if(opeType_ != null && opeType_ != ""){
			sql.add("and opeType_ = '%s'" ,opeType_);
		}if(orderId_ != null && orderId_ != ""){
			sql.add("and orderId_ like '%s'" ,new String("%"+orderId_+"%"));
		}if (createDate1.equals("") && !createDate2.equals(""))
			sql.add(" and r.createTime_ < '%s'", createDate2);
		if (!createDate1.equals("") && createDate2.equals(""))
			sql.add("and r.createTime_ >= '%s'", createDate1);
		if (!createDate1.equals("") && !createDate2.equals(""))
			sql.add("and   r.createTime_ between '%s' and '%s'", createDate1, createDate2);
		sql.add("order by r.createTime_ desc");
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}

}
