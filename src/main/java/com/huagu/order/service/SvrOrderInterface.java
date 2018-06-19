package com.huagu.order.service;

import org.apache.log4j.Logger;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrOrderInterface extends CustomService {
	public Logger log = Logger.getLogger(this.getClass());
	
	//查询订单列表
	public boolean getCab() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_,updateDate_,updateUser_,boxId_,zhuCode_,status_,cabId_,del_ from %s ",appdb.t_pronode_box);
		sql.add("where cabId_ = '%s' and zhuCode_ = '%s' ",head.getString("cabId_"),head.getString("zhuCode_"));
		sql.add(" AND status_ = '1' and del_=1 ");
		/*sql.add("select * from %s ",appdb.t_pronode_box);
		sql.add("where cabId_='%s' and zhuCode_='%s' and del_=1 ",head.getString("cabId_"),head.getString("zhuCode_"));
		*/
		DataSet ds =  sql.open();
		if(!sql.eof()){
			sql.edit();
			sql.setField("updateDate_", TDateTime.Now());
			sql.setField("updateUser_", head.getSafeString("userCode_"));
			sql.setField("status_", '0');
			sql.post();
			this.getDataOut().appendDataSet(ds);
		}
		return true;
	}
	
	//用户关箱
	public boolean upCab() throws Exception {
		Record head = dataIn.getHead();
		
		/*//把这个商品从制定的柜子箱子中删除
		SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_,del_,zhuCode_ from %s ",appdb.t_pronode_box);
		sql.add("where cabId_='%s' and boxId_='%s' ",head.getString("cabId_"),head.getString("boxId_"));
		sql.open();
		Record r = sql.getCurrent();
		String zhuCode_ = r.getString("zhuCode_");
		sql.edit();
		sql.setField("del_", 0);
		sql.post();
		
		//改商品状态为在租
		SqlQuery sql2 = new SqlQuery(this);
		sql2.add("select UID_,nodeState_ from  %s ",appdb.T_ProState);
		sql2.add("where zhuCode_='%s'",zhuCode_);
		sql2.open();
		sql2.edit();
		sql2.setField("nodeState_", 3); //改为在租
		sql2.post();*/
		
		//改订单并修改起租时间
		SqlQuery sql3 = new SqlQuery(this);
		sql3.add("select UID_,orderState_,beginTime_,orderId_ from  %s ",appdb.T_ORDER);
		/*sql3.add("where zhuCode_='%s' and orderState_=3",zhuCode_);*/
		sql3.add("where orderId_ = '%s'", head.getSafeString("orderId_"));
		sql3.open();
		if(!sql3.eof()) {
			sql3.edit();
			if("gx".equals(head.getSafeString("type_")))
				sql3.setField("orderState_", 6); //改为待评价
			else
				sql3.setField("orderState_", 4); //改为在租
			sql3.setField("beginTime_", TDateTime.Now()); //起租时间
			sql3.post();
		}else {
			log.info("查询无此订单号！"+ head.getSafeString("orderId_"));
		}
		return true;
	}
	
}
