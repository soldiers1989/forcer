package com.huagu.product.services;

import org.apache.log4j.Logger;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrAdminSupply extends CustomService {
	private static final Logger log = Logger.getLogger(SvrAdminSupply.class);
	//查询供应商信息
		public boolean queryListSupply() throws DataValidateException {
			Record head = this.getDataIn().getHead();
			String supplyShortName_=head.getString("supplyShortName_");
			String tel_=head.getString("tel_");
			String businessModel_=head.getString("businessModel_");
			SqlQuery ds = new SqlQuery(this);
			ds.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,"
					+ "supplyId_,supplyShortName_,supplyFullName_,businessLicense_,companyTel_,supplyGoodsRange_,"
					+ "contact_,tel_,qq_,businessModel_,businessAdress_,registerMoney_,legalExpre_,isDel_,isAssociated_,proId_ ");
				ds.add("from %s where 1=1",appdb.T_SupplyPeople);
				ds.add("and isDel_=%s",'0');
				if(supplyShortName_!=null&&supplyShortName_!=""){
					ds.add("and supplyShortName_ like '%s' ",new String("%"+supplyShortName_+"%"));
				}
				if(tel_!=null&&tel_!=""){
					ds.add("and tel_ like '%s' ",new String("%"+tel_+"%"));
				}
				if(businessModel_!=null&&businessModel_!=""){
					ds.add("and businessModel_ like '%s' ",new String("%"+businessModel_+"%"));
				}
				ds.add("order by createDate_ desc ");
				ds.open();
				if(!ds.eof()){
					dataOut.appendDataSet(ds);
					return true;
				}else{
				return true;
				}
		}
	
	//添加供应商信息
	public boolean insertSupply() throws DataValidateException {
	Record head = this.getDataIn().getHead();
		//向分类表里插入数据
		SqlQuery ds = new SqlQuery(this);
		ds.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,"
				+ "supplyId_,supplyShortName_,supplyFullName_,businessLicense_,companyTel_,supplyGoodsRange_,"
				+ "contact_,tel_,qq_,businessModel_,businessAdress_,registerMoney_,legalExpre_,isDel_,isAssociated_,proId_ ");
			ds.add("from %s" ,appdb.T_SupplyPeople);
			ds.open();
			ds.append();
			ds.setField("createDate_", TDateTime.Now());
			ds.setField("createUser_", this.getUserCode());
			ds.setField("supplyId_", head.getString("supplyId_"));
			ds.setField("supplyShortName_", head.getString("supplyShortName_"));
			ds.setField("supplyFullName_", head.getString("supplyFullName_"));
			ds.setField("businessLicense_", head.getString("businessLicense_"));
			ds.setField("companyTel_", head.getString("companyTel_"));
			ds.setField("supplyGoodsRange_", head.getString("supplyGoodsRange_"));
			ds.setField("contact_", head.getString("contact_"));
			ds.setField("tel_", head.getString("tel_"));
			ds.setField("qq_", head.getString("qq_"));
			ds.setField("businessModel_", head.getString("businessModel_"));
			ds.setField("businessAdress_", head.getString("businessAdress_"));
			ds.setField("registerMoney_", head.getString("registerMoney_"));
			ds.setField("legalExpre_", head.getString("legalExpre_"));
			ds.post();
			return true;
		
	}
	
	//修改供应商信息
	public boolean updateSupply() throws DataValidateException {
		Record head = this.getDataIn().getHead();
		//向分类表里插入数据
		SqlQuery ds = new SqlQuery(this);
		ds.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,"
				+ "supplyId_,supplyShortName_,supplyFullName_,businessLicense_,companyTel_,supplyGoodsRange_,"
				+ "contact_,tel_,qq_,businessModel_,businessAdress_,registerMoney_,legalExpre_,isDel_,isAssociated_,proId_");
			ds.add("from %s where 1=1",appdb.T_SupplyPeople);
			ds.add("and supplyId_=%s",head.getString("supplyId_"));
			ds.open();
			if(!ds.eof()){
				ds.edit();
				ds.setField("updateDate_", TDateTime.Now());
				ds.setField("updateUser_", this.getUserCode());
				ds.setField("supplyId_", head.getString("supplyId_"));
				ds.setField("supplyShortName_", head.getString("supplyShortName_"));
				ds.setField("supplyFullName_", head.getString("supplyFullName_"));
				ds.setField("businessLicense_", head.getString("businessLicense_"));
				ds.setField("companyTel_", head.getString("companyTel_"));
				ds.setField("supplyGoodsRange_", head.getString("supplyGoodsRange_"));
				ds.setField("contact_", head.getString("contact_"));
				ds.setField("tel_", head.getString("tel_"));
				ds.setField("qq_", head.getString("qq_"));
				ds.setField("businessModel_", head.getString("businessModel_"));
				ds.setField("businessAdress_", head.getString("businessAdress_"));
				ds.setField("registerMoney_", head.getString("registerMoney_"));
				ds.setField("legalExpre_", head.getString("legalExpre_"));
				ds.post();
				return true;
			}else{
				return false;
			}
		
	}
	
	//供应商信息
	public boolean queryById() throws DataValidateException {
		Record head = this.getDataIn().getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,"
				+ "supplyId_,supplyShortName_,supplyFullName_,businessLicense_,companyTel_,supplyGoodsRange_,"
				+ "contact_,tel_,qq_,businessModel_,businessAdress_,registerMoney_,legalExpre_,isDel_,isAssociated_,proId_");
			ds.add("from %s where 1=1",appdb.T_SupplyPeople);
			ds.add("and supplyId_=%s",head.getString("supplyId_"));
			ds.open();
			if(!ds.eof()){
				dataOut.appendDataSet(ds);
				return true;
			}else{
				return false;
			}
		
	}
	
	//删除供应商信息
	public boolean delSupply() throws DataValidateException {
		Record head = this.getDataIn().getHead();
		SqlQuery ds = new SqlQuery(this);
		System.out.println(head.getString("supplyId_")+"===222222");
		ds.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,"
				+ "supplyId_,supplyShortName_,supplyFullName_,businessLicense_,companyTel_,supplyGoodsRange_,"
				+ "contact_,tel_,qq_,businessModel_,businessAdress_,registerMoney_,legalExpre_,isDel_,isAssociated_,proId_");
			ds.add("from %s where 1=1",appdb.T_SupplyPeople);
			ds.add("and supplyId_=%s",head.getString("supplyId_"));
			ds.open();
			if(!ds.eof()){
				ds.edit();
				ds.setField("isDel_", "1");
				ds.post();
				return true;
			}else{
				return false;
			}
		
	}
	/*public boolean delSupply() throws DataValidateException {
		Record head = this.getDataIn().getHead();
		SqlQuery ds = new SqlQuery(this);
		System.out.println(head.getString("supplyId_")+"===222222");
		ds.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,"
				+ "supplyId_,supplyShortName_,supplyFullName_,businessLicense_,companyTel_,supplyGoodsRange_,"
				+ "contact_,tel_,qq_,businessModel_,businessAdress_,registerMoney_,legalExpre_,isDel_,isAssociated_,proId_");
			ds.add("from %s where 1=1",appdb.T_SupplyPeople);
			ds.add("and supplyId_=%s",head.getString("supplyId_"));
			ds.add("and isDel_ = '0'");
			ds.open();
			if(!ds.eof()){
				ds.edit();
				ds.setField("isDel_", "1");
				ds.post();
				return true;
			}else{
				return false;
			}
		
	}*/
	
}
