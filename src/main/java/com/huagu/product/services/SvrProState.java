package com.huagu.product.services;

import org.apache.log4j.Logger;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrProState extends CustomService{
	private static final Logger log = Logger.getLogger(SvrProState.class);
	
	//查询租赁物品列表
		public boolean queryRentProList() throws DataValidateException{
			Record head = this.getDataIn().getHead();
			SqlQuery ds = new SqlQuery(this);
			ds.add("select P.UID_ UID_,proLaberSum_,p.proId_ proId_,proName_,"
					+ "fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,twoState_,"
					+ "twoDel_,scrapTime_,n.proId_ pid,zhuCode_ from %s p left join %s ty on ty.twoNameId_=p.proTypeId_"
					+ " left join %s n on p.proId_=n.proId_",appdb.T_Products,appdb.T_Protype,appdb.T_ProNode);
			ds.add("where fristDel_=%s",0);
			ds.add("and twoDel_=%s",0);
			ds.add("and p.isDel_=%s",0);
			String proName_=head.getString("proName_");
			String fristNameId_=head.getString("fristNameId_");
			String twoNameId_=head.getString("twoNameId_");
			String zhuCode_=head.getString("zhuCode_");
			if(head.hasValue("proName_")){
				ds.add("and proName_ like '%s' ",new String("%"+proName_+"%"));
			}
			if(head.hasValue("fristNameId_")){
				ds.add("and fristNameId_ like '%s' ",new String("%"+fristNameId_+"%"));
			}
			if(head.hasValue("twoNameId_")){
				ds.add("and twoNameId_ like '%s' ",new String("%"+twoNameId_+"%"));
			}
			if(head.hasValue("zhuCode_")){
				ds.add("and zhuCode_ like '%s' ",new String("%"+zhuCode_+"%"));
			}
			//ds.add("order by updateDate_");
			ds.open();
			if(!ds.eof()){
				dataOut.appendDataSet(ds);
				return true;
			}else{
			return false;
			}
		}

}
