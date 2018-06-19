package com.huagu.product.services;

import org.apache.log4j.Logger;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrQueryPro_ByCabinet extends CustomService{
	private static final Logger log = Logger.getLogger(SvrAdminRentPro.class);
	
	
	//根据柜组查询物品存放情况
	public boolean queryProByCabinet() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		String zhuCode_ = head.getString("zhuCode_");
		String homeAgency_ = head.getString("homeAgency_");
		String name_ = head.getString("name_");
		String communityName_ = head.getString("communityName_");
		SqlQuery sql=new SqlQuery(this);
		sql.add("select c.id_,c.name_,c.address_,c.communityName_,c.communityNum_,c.areaId_,c.status_,b.cabId_,b.boxId_,b.emptyStatus_,b.boxLockUD_,"
				+ "pb.status_ pbstatus_,pb.zhuCode_ pbzhuCode_,pb.boxId_ pbboxId_,n.zhuCode_,p.proName_,n.homeAgency_,n.proId_"
				+ " from %s c left join %s b on c.id_=b.cabId_ left join %s pb on pb.boxId_=b.boxId_ left join %s n on n.zhuCode_=pb.zhuCode_ "
				+ "left join %s p on p.proId_=n.proId_ where 1=1",appdb.CABINET,appdb.BOX,appdb.PRONODEBOX,appdb.T_ProNode,appdb.T_Products);
		sql.add("and b.emptyStatus_ =1");
		sql.add("and c.status_ =1");
		if(head.hasValue("zhuCode_")){
			sql.add("and n.zhuCode_ like '%s' ",new String("%"+zhuCode_+"%"));
		}
		if(head.hasValue("homeAgency_")){
			sql.add("and n.homeAgency_ like '%s' ",new String("%"+homeAgency_+"%"));
		}
		if(head.hasValue("name_")){
			sql.add("and c.name_ like '%s' ",new String("%"+name_+"%"));
		}
		if(head.hasValue("communityName_")){
			sql.add("and c.communityName_ like '%s' ",new String("%"+communityName_+"%"));
		}
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);
		}
	return true;
	}

	

	//物品电子条码状态查询与变更
	public boolean nodeQueryUpdate() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		String zhuCode_ = head.getString("zhuCode_");
		String homeAgency_ = head.getString("homeAgency_");
		String nodeState_ = head.getString("nodeState_");
		String updateDate_ = head.getString("updateDate_");
		SqlQuery sql=new SqlQuery(this);
		sql.add("select p.createUser_,p.proId_,p.proName_,o.userId_,yw.operateManName_,y.fristName_,y.twoName_,n.zhuCode_,n.homeAgency_,s.nodeState_,DATE_FORMAT(s.updateDate_,'%s') as updateDate_"
				+ " from %s p left join %s y on p.proTypeId_=y.twoNameId_ left join %s n on p.proId_=n.proId_ left join %s s on p.proId_=s.proId_ left join %s o "
				+ "on p.proId_=o.proId_ left join %s yw on p.proId_=yw.proId_ where 1=1"
				,"%Y-%m-%d %H:%m:%s",appdb.T_Products,appdb.T_Protype,appdb.T_ProNode,appdb.T_ProState,appdb.T_ORDER,appdb.t_Operate);
		sql.add("and s.coDel_ ='0'");
		sql.add("and y.twoDel_ ='0'");
		sql.add("and n.isDel_ ='0'");
		if(head.hasValue("zhuCode_")){
			sql.add("and n.zhuCode_ like '%s' ",new String("%"+zhuCode_+"%"));
		}
		if(head.hasValue("homeAgency_")){
			sql.add("and n.homeAgency_ like '%s' ",new String("%"+homeAgency_+"%"));
		}
		if(head.hasValue("nodeState_")){
			sql.add("and s.nodeState_ ='%s'",new String(nodeState_));
		}
		if (updateDate_ != null && updateDate_ != ""){
	          sql.add("and s.updateDate_ like '%s'",new String("%"+updateDate_+"%"));
	    }
		sql.add("group by n.zhuCode_");
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);
		}
	return true;
	}
	
	//物品电子条码状态查询与变更
	public boolean updateZaiKu() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		String zhuCode_ = head.getString("zhuCode_");
		SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_,nodeState_,zhuCode_,updateDate_ from %s where 1=1",appdb.T_ProState);
		if(head.hasValue("zhuCode_")){
			sql.add("and zhuCode_='%s'",zhuCode_);
		}
		sql.open();
		if(!sql.eof()){
			sql.edit();
			sql.setField("nodeState_", 1);
			sql.setField("updateDate_", TDateTime.Now());
			sql.post();
		}
		return true;
	}
}
