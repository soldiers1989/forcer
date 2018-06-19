package com.huagu.more.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.mysql.Transaction;

/**
 *  @describe 签到
 *  @author 王姣
 *  @date   2018年3月9日下午3:34:06
 *  @return
 */
public class SvrSign extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		try(Transaction tx = new Transaction(this)) { 
			/*String userCode;
			if(getUserCode() != null ){
				 userCode = this.getUserCode();
			}else{
				 userCode = "17620458925";
			}*/
			Record head = dataIn.getHead();
			
			
			//查询积分类型表里签到积分值
			SqlQuery sqlSign = new SqlQuery(this);
			sqlSign.add("select UID_ ,type_,integral_ from %s" ,appdb.IngetralType);
			sqlSign.add("where type_ = '0'");
			sqlSign.open();
			
			
			//签到后，用户获得积分
			SqlQuery sql2 = new SqlQuery(this);
			sql2.add("select UID_ ,id_ ,code_ ,userJifen_ ,updateTime_ ,createTime_  from %s" ,appdb.S_Userinfo);
			sql2.add("where code_ = '%s'" ,head.getString("userCode"));
			sql2.open();
			sql2.edit();
			sql2.setField("userJifen_", sql2.getInt("userJifen_")+sqlSign.getInt("integral_"));
			sql2.post();
			
			//往签到表里 添加记录
			SqlQuery sql = new SqlQuery(this);
			sql.add("select UID_ ,createTime_ ,userCode_ from %s" ,appdb.Sign);
			//sql.add("where userCode_ = '%s'" ,head.getString("userCode"));
			sql.open();
			sql.append();
			sql.setField("createTime_", TDateTime.Now());
			sql.setField("userCode_", sql2.getField("code_"));
			sql.post();
			
			//积分表添加记录
			SqlQuery sql1 = new SqlQuery(this);
			sql1.add("select UID_ ,createTime_ ,userCode_ ,integral_ ,remark_,type_ from  %s" ,appdb.Integral);
			sql1.open();
			sql1.append();
			sql1.setField("createTime_", TDateTime.Now());
			sql1.setField("userCode_",sql.getField("userCode_"));
			sql1.setField("integral_", sqlSign.getInt("integral_"));
			sql1.setField("remark_", "签到获得积分");
			sql1.setField("type_", 0);
			sql1.post();
			
		tx.commit();  
		}
		return this.success();
	}

}
