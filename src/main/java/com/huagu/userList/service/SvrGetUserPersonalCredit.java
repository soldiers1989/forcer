package com.huagu.userList.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 查询个人用户征信配置
 * 
 * @author xiaofei-pc
 *
 */
public class SvrGetUserPersonalCredit extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("SELECT UID_,createDate_,createUser_,updateDate_,updateUser_,time_,userCode_,source_,yuanying_,node_,people_,method_,revision_, case status_ when 0 then '启用' when 1 then '失效' end status_,orderId_,type_,beizhu_ FROM %s ", appdb.ALONECREDIT);
		ds.add(" WHERE 1=1");
		if("add".equals(headIn.getString("type_s"))){
			ds.open();
			ds.append();
			ds.setField("createDate_", TDateTime.Now());
			ds.setField("createUser_", "admin");
			ds.setField("time_", TDateTime.Now());
			ds.setField("userCode_", headIn.getString("code_"));
			ds.setField("source_", headIn.getString("source_"));
			ds.setField("yuanying_", headIn.getString("yuanying_"));
			ds.setField("node_", headIn.getString("node_"));
			ds.setField("people_", "admin");
			if("0".equals(headIn.getString("type_")))
				ds.setField("method_", "押金比例浮动");
			if("1".equals(headIn.getString("type_")))
				ds.setField("method_", "是否给予押金");
			if("2".equals(headIn.getString("type_")))
				ds.setField("method_", "免押金额度跳转");
			if("3".equals(headIn.getString("type_")))
				ds.setField("method_", "租赁订单结算方式");
			ds.setField("revision_", headIn.getString("revision_"));
			ds.setField("status_", "0");
			ds.setField("orderId_", headIn.getString("orderId_"));
			ds.setField("type_", headIn.getString("type_"));
			ds.setField("beizhu_", headIn.getString("beizhu_"));
			ds.post();
		}else if("sel".equals(headIn.getString("type_"))){
			if(headIn.hasValue("name_"))
				ds.add(" and name_ like '%s'", '%' + headIn.getString("name_") + '%');
			if(headIn.hasValue("date_"))
				ds.add(" and date_ like '%s'", '%' + headIn.getString("date_") + '%');
			if(headIn.hasValue("fangfa_"))
				ds.add(" and fangfa_ like '%s'", '%' + headIn.getString("fangfa_") + '%');
			if(headIn.hasValue("statu_"))
				ds.add(" and statu_ like '%s'", '%' + headIn.getString("statu_") + '%');
			ds.open();
			if (!ds.eof()) 
				dataOut.appendDataSet(ds);
		}else if("up".equals(headIn.getString("type_"))){
			ds.add(" and UID_ = '%s'", headIn.getString("id_"));
			ds.open();
			if (!ds.eof()){
				ds.edit();
				ds.setField("status_", headIn.getString("status_"));
				ds.post();
			}
		}else{
			ds.add(" and userCode_ = '%s'", headIn.getString("code_"));
			ds.open();
			if (!ds.eof()) 
				dataOut.appendDataSet(ds);
		}
		return success();
	}

}
