package com.huagu.my.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.other.utils;

	public class SvrAdrManager extends CustomService{
	
	/**
	 * 地址管理信息添加
	 * 
	 * @return
	 * @throws DataValidateException
	 */

	public boolean addadr() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String userId_ =  head.getString("userId_");
		String id = utils.newGuid();
		id = id.substring(1, id.length() - 1);
		id = id.replaceAll("-", "");
		
		if(head.hasValue("def")  && head.getString("def").equals("0")){
			SqlQuery sql2 = new SqlQuery(this);
			sql2.add("select * from %s ", appdb.Adr);
			sql2.add("where adrState_=0 and userId_='%s'",userId_);
			DataSet ds = sql2.open();
			if(!ds.eof()){//非空就要改為1
				sql2.edit();
				sql2.setField("adrState_","1");
				sql2.post();
			}
		}
		
		if(head.hasValue("boxId_")){
			String boxId_ = head.getString("boxId_");
			SqlQuery sql4 = new SqlQuery(this);
			sql4.add("select UID_,name_,address_,communityName_ from %s",appdb.CABINET);
			sql4.add("boxId_",boxId_);
			sql4.open();
			String carName_ = "";
			String address_ ="";
			String communityName_ = "";
			if(!sql4.eof()){//获取柜子名称
				Record r = sql4.getCurrent();
				carName_ = r.getString("name_");
				address_ = r.getString("address_");
				communityName_ = r.getString("communityName_");
				
			}
			
			SqlQuery sql3 = new SqlQuery(this);
			sql3.add("select UID_,id_ ,userId_ ,createData_,name_ ,telpho_ , adr_ ,exactadr_ ,adrState_,cabId_,boxName_ from %s where 1=1 ", appdb.Adr);
			sql3.add(" and  userId_='%s' and cabId_ is not null",userId_);
			sql3.open();
			if(!sql3.eof()){//不为空执行修改
				sql3.edit();
				sql3.setField("name_", head.getString("name"));
				sql3.setField("telpho_", head.getString("telpho"));
				sql3.setField("adr_", address_);
				sql3.setField("exactadr_", communityName_);
				sql3.setField("cabId_", head.getString("boxId_"));
				sql3.setField("boxName_", carName_);
				sql3.post();
			}
			if(sql3.eof()){//如果没记录就添加
				sql3.append();
				sql3.setField("id_", id);
				sql3.setField("userId_", userId_);
				sql3.setField("createData_", TDateTime.Now());
				sql3.setField("name_", head.getString("name"));
				sql3.setField("telpho_", head.getString("telpho"));
				sql3.setField("adr_", address_);
				sql3.setField("exactadr_", communityName_);
				sql3.setField("adrState_", 1 );
				sql3.setField("cabId_", boxId_ );
				sql3.setField("boxName_", carName_);
				sql3.post();
			}
			
		}
		if(!head.hasValue("boxId_")){
			sql.add("select UID_,id_,userid_,createData_,name_,telpho_,adr_,exactadr_,adrState_ from %s ", appdb.Adr);
			sql.open();
			sql.append();
			sql.setField("id_", id);
			sql.setField("userid_", userId_);
			sql.setField("createData_", TDateTime.Now());
			sql.setField("name_", head.getString("name"));
			sql.setField("telpho_", head.getString("telpho"));
			sql.setField("adr_", head.getString("adr"));
			sql.setField("exactadr_", head.getString("exactadr"));
			if(head.hasValue("def")){
				sql.setField("adrState_", head.getString("def") );
			}
			sql.post();
		}
		
		return true;
	}


	/**
	 * 地址管理信息删除
	 * 
	 * @return
	 * @throws DataValidateException
	 */
	public boolean deleteadr() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("select * from %s where adrState_ in('0','1')" , appdb.Adr);
		sql.add("and id_ = '%s'", head.getString("id"));
		sql.open();
		sql.edit();
		sql.setField("adrState_","2");
		sql.post();
		return true;

	}

	/**
	 * 地址管理信息修改
	 * 
	 * @return
	 * @throws DataValidateException
	 */
	public boolean adrmodify() throws DataValidateException {
		Record head = dataIn.getHead();
		String upDef = head.getString("upDef");
		String updateUser_;
		if(getUserCode() != ""){
			updateUser_ = this.getUserCode();
		}else{
			updateUser_ = "12345679";
		}
		if(upDef.equals("Y") && upDef != null){
			SqlQuery sql2 = new SqlQuery(this);
			sql2.add("select UID_,id_,name_,telpho_,adr_,exactadr_,remark_,adrState_ from %s ", appdb.Adr);
			sql2.add("where adrState_=0 and userId_='%s'", head.getString("userId"));
			DataSet ds = sql2.open();
			System.out.println(ds.eof());
			if(!ds.eof()){//非空就要改為1
				sql2.edit();
				sql2.setField("adrState_","1");
				sql2.post();
			}
		}
		SqlQuery sql = new SqlQuery(this);
		sql.add("select UID_,id_,userid_ ,name_,telpho_,adr_,exactadr_,remark_,adrState_ ,updateDate_,updateUser_ from %s where 1=1 ", appdb.Adr);
		sql.add("and id_= '%s'", head.getString("id"));
		sql.open();
		sql.edit();
		if(upDef.isEmpty()){
			sql.setField("updateUser_", updateUser_);
			sql.setField("updateDate_", TDateTime.Now());
			sql.setField("name_", head.getString("name"));
			sql.setField("telpho_", head.getString("telpho"));
			sql.setField("adr_", head.getString("adr"));
			sql.setField("exactadr_", head.getString("exactadr"));
			sql.setField("remark_", head.getString("remark"));
		}
		if(upDef.equals("Y")){
			sql.setField("adrState_","0");
		}
		sql.post();
		return true;
	}
	
	/**
	 * 地址管理信息查询
	 * 
	 * @return
	 * @throws DataValidateException
	 */

	public boolean querydata() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String falg = head.getString("falg");
		
        String userId_ = head.getSafeString("code_");
        if ("".equals(userId_)) 
        	userId_ = this.getUserCode();
        
		sql.add("select userId_,id_,name_,adr_,telpho_,exactadr_,remark_,adrState_ from %s where adrState_ in('0','1')", appdb.Adr);
		if(falg.equals("A")){
			sql.add("and id_='%s'", head.getString("id"));
		}else{
			sql.add("and userId_='%s'", userId_);
		}
		sql.add("order by createData_ desc");
		DataSet ds = sql.open();
		dataOut.appendDataSet(ds);
		return true;
	}
	
	//获取默认地址
	public boolean getDefAdr() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String orderType_ = head.getString("orderType_");
		sql.add("select * from %s where 1=1 " , appdb.Adr);
		if(orderType_.equals("2") && orderType_ != null){//送货上门
			sql.add("and adrState_=0 ");//0为默认
		}
		if(orderType_.equals("3") && orderType_ != null){//送货到柜
			sql.add("and cabId_ is not null ");//柜子id不可为空
		}
		sql.add("and userid_='%s'", head.getString("userid_"));
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return true;

	}
	
	//根据地址地址信息获取柜子信息
	public boolean getBox() throws DataValidateException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String city = head.getSafeString("city").replace("/", "");
		String exactadr_ = head.getSafeString("exactadr_");
		String city2 = city+exactadr_;
		sql.add("select id_,name_,address_ from %s where 1=1 ", appdb.CABINET);
		sql.add("and (address_ like %s or address_ like %s or address_ like %s )","'%"+city2+"%'","'%"+city+"%'","'%"+exactadr_+"%'"  );
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return true;
	}
}
