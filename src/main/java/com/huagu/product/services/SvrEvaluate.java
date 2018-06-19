package com.huagu.product.services;

import org.apache.log4j.Logger;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrEvaluate extends CustomService{
	private static final Logger log = Logger.getLogger(SvrEvaluate.class);

	
	//评价管理查询
	public boolean queryUserEvaluate() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		String evaState_ = head.getString("evaState_");
		String evaLevel_ = head.getString("evaLevel_");
		String beginTime_ = head.getString("beginTime_");
		TDateTime beginNew = TDateTime.fromDate(beginTime_);
		String endTime_ = head.getString("endTime_");
		TDateTime endNew = TDateTime.fromDate(endTime_);
		String keywords = head.getString("keywords");
		SqlQuery sq=new SqlQuery(this);
		sq.add("select e.UID_ UID_,e.proId_,  DATE_FORMAT(e.createDate_,'%s') as createDate_,e.orderId_ orderId_,evaLevel_,name_,"
				+ "evaContent_,evaState_,UserId_,orderType_,isShow_,proName_ "
				+ "from %s e left join %s s on e.UserId_=s.id_ left join %s p on e.proId_=p.proId_ where 1=1","%Y-%m-%d %H:%m:%s",appdb.T_EVALUATE,appdb.S_Userinfo,appdb.T_Products);
		if(keywords!=""&&keywords!=null){
			sq.add("and (proName_ like '%s' or e.orderId_ like '%s' or evaContent_ like '%s' or name_ like '%s')",
					new String("%"+keywords+"%"),new String("%"+keywords+"%"),new String("%"+keywords+"%"),new String("%"+keywords+"%"));
		}
		if(evaState_!=""&&evaState_!=null){
			sq.add("and evaState_=%s",evaState_);
		}
		if(evaLevel_!=""&&evaLevel_!=null){
			if(!evaLevel_.equals("0")){
			sq.add("and evaLevel_=%s",evaLevel_);
			}
		}
		if(beginTime_!=""&&beginTime_!=null){
			sq.add("and e.createDate_>%s",beginNew);
		}
		if(endTime_!=""&&endTime_!=null){
			sq.add("and e.createDate_>%s",endNew);
		}
		sq.open();
		if(!sq.eof()){
			dataOut.appendDataSet(sq);
		}
		return true;
	}
	
	//查看并回复 用户评价
	public boolean toQueryEvaluateById() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		String orderId_ = head.getString("orderId_");
		String zhuCode_ = head.getString("zhuCode_");
		SqlQuery sql=new SqlQuery(this);
		sql.add("select e.createDate_ createDate_,IFNULL(name_,code_) userName_,evaState_,evaLevel_,evaContent_,e.orderId_ orderId_,"
				+ "evaId_,e.UserId_ userId_,e.proId_ proId_,e.orderType_,isShow_,p.proName_ proName_,imgPath_,payTime_"
				+ " from %s e left join %s o on e.orderId_=o.orderId_ left join %s s on e.UserId_=s.id_ left join %s p on e.proId_=p.proId_ left join %s i on e.evaImgId_=i.relevancelId_ where 1=1"
				,appdb.T_EVALUATE,appdb.T_ORDER,appdb.S_Userinfo,appdb.T_Products,appdb.T_IMAGE);
		sql.add("and i.imgDel_=%s",0);
		if(orderId_!=""&&orderId_!=null){
			sql.add(" and e.orderId_='%s'",orderId_);
		}
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);
		}
		return true;
	}
	
	//管理员回复 用户评价
		public boolean replyEvaluateById() throws DataValidateException{
			Record head = this.getDataIn().getHead();
			String orderId_ = head.getString("orderId_");
			String adminReply_ = head.getString("adminReply_");
			SqlQuery sql=new SqlQuery(this);
			sql.add("select UID_,updateDate_,updateUser_,orderId_,adminReply_ from %s where 1=1",appdb.T_EVALUATE);
			if(orderId_!=""&&orderId_!=null){
				sql.add(" and orderId_='%s'",orderId_);
			}
			sql.open();
			if(!sql.eof()){
				sql.edit();
				sql.setField("updateDate_", TDateTime.Now());
				sql.setField("updateUser_",this.getUserCode());
				sql.setField("adminReply_", adminReply_);
				sql.post();
			}
			return true;
		}
}
