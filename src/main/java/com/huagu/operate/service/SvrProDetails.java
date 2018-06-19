package com.huagu.operate.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.other.utils;

public class SvrProDetails extends CustomService {
	
	//根据主电子ID最近一次的运维情况
	public boolean findOpe() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("select *,(select count(zhuCode_) from %s where zhuCode_='%s' and type_='0') count_ from %s ",appdb.t_Operate,head.getString("zhuCode_"),appdb.t_Operate);
		sql.add(" where closeBoxTime_ in (select closeBoxTime_ from %s  where zhuCode_='%s' ORDER BY closeBoxTime_ desc   )",appdb.t_Operate,head.getString("zhuCode_"));
		DataSet ds =  sql.open();
		this.getDataOut().appendDataSet(ds);
		return true;
	}
	
	//运维信息录入
	public boolean addOperate() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		SqlQuery sql = new SqlQuery(this);
		String evaId_ = utils.newGuid();
		evaId_ = evaId_.substring(1, evaId_.length() - 1);
		evaId_ = evaId_.replaceAll("-", "");
		String evaImgId_ = utils.newGuid();
		evaImgId_ = evaImgId_.substring(1, evaImgId_.length() - 1);
		evaImgId_ = evaImgId_.replaceAll("-", "");
		sql.add("select UID_,ImageId_,operateId_,createDate_,nowLoss_,OpenBoxTime_,closeBoxTime_,leaveMess_,orderId_,zhuCode_,operateManId_,type_ from %s",appdb.t_Operate);
		sql.open();
		sql.append();
		sql.setField("operateId_", evaId_);
		sql.setField("nowLoss_", head.getString("nowLoss_"));
		sql.setField("createDate_", TDateTime.Now());
		//sql.setField("OpenBoxTime_", head.getString("OpenBoxTime_"));
		sql.setField("OpenBoxTime_", TDateTime.Now());
		//sql.setField("closeBoxTime_", head.getString("closeBoxTime_"));
		sql.setField("closeBoxTime_", TDateTime.Now());
		sql.setField("leaveMess_", head.getString("leaveMess_"));
		sql.setField("orderId_", head.getString("orderId_"));
		sql.setField("zhuCode_", head.getString("zhuCode_"));
		sql.setField("operateManId_", head.getString("operateManId_"));
		if(head.hasValue("falg")){
			sql.setField("type_", 2);
		}
		if(!head.hasValue("falg")){
			sql.setField("ImageId_", evaImgId_);
			sql.setField("type_", 0);
		}
		sql.post();
		
		//存照片
		if(!head.hasValue("falg")){
			SqlQuery sql2 = new SqlQuery(this);
			sql2.add("select UID_,createDate_,relevancelId_,imgPath_ from %s ",appdb.T_IMAGE);
			sql2.open();
			sql2.append();
			sql2.setField("relevancelId_",evaImgId_);
			sql2.setField("imgPath_",head.getString("file"));
			sql2.setField("createDate_",TDateTime.Now());
			sql2.post();
		}
		
		//修改主电子条码商品状态
		SqlQuery sql3 = new SqlQuery(this);
		sql3.add("select UID_,operateState_,scrapState_ from %s ",appdb.T_ProNode);
		sql3.add(" where zhuCode_='%s'", head.getString("zhuCode_"));
		sql3.open();
		sql3.edit();
		if(!head.hasValue("falg")){
			sql3.setField("operateState_", "1");
		}
		if(head.hasValue("falg")){
			sql3.setField("operateState_", "0");
		}
		sql3.setField("scrapState_",  head.getString("nowLoss_"));
		sql3.post();
		
		//修改订单为完成
		SqlQuery sql4 = new SqlQuery(this);
		sql4.add("select UID_,orderState_ from %s ",appdb.T_ORDER);
		sql4.add("where orderId_='%s'",head.getString("orderId_"));
		sql4.open();
		sql4.edit();
		sql4.setField("orderState_", 7);
		sql4.post();
		return true;
		
	}
	
	//查询商品的前3次运维记录
	public boolean findOrdList() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("select i.createDate_,u.code_,o.orderId_,o.orderType_,o.recPhone_,o.receiver_,o.beginTime_,o.returnType_,o.returnMethod_,o.returnOverTime_,o.userId_,");
		sql.add("op.leaveMess_,i.imgPath_,op.operateManName_,op.OpenBoxTime_,u.name_ ");
		sql.add("from %s o " ,appdb.T_ORDER);
		sql.add("join %s op  on op.orderId_ = o.orderId_ " ,appdb.t_Operate);
		sql.add("left join %s i on op.ImageId_=i.relevancelId_ " ,appdb.T_IMAGE);
		sql.add("join %s u   on op.operateManId_=u.code_ " ,appdb.S_Userinfo);
		sql.add("where o.zhuCode_='%s'",head.getString("zhuCode_"));
		sql.add("group by  o.orderId_");
		sql.add("ORDER BY o.beginTime_ DESC");
		sql.setMaximum(3);
		DataSet ds =  sql.open();
		this.getDataOut().appendDataSet(ds);
		return true;
	}
			

	// 根据用户Id获取订单信息
	public boolean findHisOrd() throws Exception {
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("select o.*,p.* from %s o ",appdb.T_ORDER);
		sql.add("left join %s p on o.proId_=p.proId_ ",appdb.T_Products);
		sql.add("where userId_='%s'", head.getString("userId_"));
		sql.add("ORDER BY o.beginTime_ DESC");
		sql.open();
		sql.setMaximum(3);
		DataSet ds =  sql.open();
		this.getDataOut().appendDataSet(ds);
		return true;
	}
	
	//查询商品的前3次运维记录
	public boolean finduser() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("select * from %s",appdb.S_Userinfo);
		sql.add(" where code_='%s'",head.getString("userId_"));
		sql.open();
		DataSet ds =  sql.open();
		this.getDataOut().appendDataSet(ds);
		return true;
	}
	
	
}
