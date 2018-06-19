package com.huagu.product.services;

import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import org.apache.log4j.Logger;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.DataSetState;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.mysql.Transaction;

public class SvrAdminPro extends CustomService{
	private static final Logger log = Logger.getLogger(SvrAdminPro.class);
	
	//添加商品名称
	public boolean insertProductsName() throws DataValidateException{
		Record headIn = this.getDataIn().getHead();
			SqlQuery ds = new SqlQuery(this);
			String userCode=this.getUserCode();
			//userCode="13607659820";
			ds.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,proName_,proId_,dayRentMoney_,cashPledge_,price_,"
					+ "proTypeId_,proImgId_,proDesc_,proState_,proVideoId_,proZsImges_,proLbImges_,"
					+ "proModelId_,discountPrice_,isDiscount_,salesHotPush_,salesTypeMenu_,salesFine_,salesNewPro_,rentHotPush_,rentTypeMenu_,"
					+ "rentFine_,rentNewPro_");
			ds.add("from %s where 1=1",appdb.T_Products);
			ds.add("and proName_='%s'",headIn.getString("proName_"));
			ds.open();
			if(!ds.eof()){
				return false;
			}else{
				//商品的Id
				Calendar calendar = Calendar.getInstance();
				long pro_ = calendar.getTime().getTime();
				String proIdNew_=Long.toString(pro_);
				ds.append();
				ds.setField("createDate_", TDateTime.Now());
				ds.setField("createUser_", userCode);
				ds.setField("proId_", proIdNew_);
				ds.setField("proName_", headIn.getString("proName_"));
				ds.setField("proZsImges_", headIn.getString("proZsImges_"));
				ds.setField("proLbImges_", headIn.getString("proLbImges_"));
				ds.setField("proTypeId_", headIn.getString("twoNameId_"));
				ds.setField("salesHotPush_", headIn.getString("salesHotPush_"));
				ds.setField("salesTypeMenu_", headIn.getString("salesTypeMenu_"));
				ds.setField("salesNewPro_", headIn.getString("salesNewPro_"));
				ds.setField("rentHotPush_", headIn.getString("rentHotPush_"));
				ds.setField("salesFine_", headIn.getString("salesFine_"));
				ds.setField("rentTypeMenu_", headIn.getString("rentTypeMenu_"));
				ds.setField("rentFine_", headIn.getString("rentFine_"));
				ds.setField("rentNewPro_", headIn.getString("rentNewPro_"));
				ds.post();
				
				SqlQuery ds1 = new SqlQuery(this);
				ds1.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,proId_");
				ds1.add("from %s",appdb.T_ProNode);
				ds1.open();
				ds1.append();
				System.out.println("proIdNew_"+proIdNew_);
				ds1.setField("proId_", proIdNew_);
				ds1.post();
				
				//添加商品名称时，默认为在库状态
				SqlQuery sqlState = new SqlQuery(this);
				sqlState.add("select UID_ ,createDate_,createUser_,nodeState_ , proId_   from %s " ,appdb.T_ProState);
				sqlState.open();
				sqlState.append();
				sqlState.setField("createDate_", TDateTime.Now());
				sqlState.setField("createUser_", this.getUserCode());
				sqlState.setField("proId_", proIdNew_);
				sqlState.setField("nodeState_", 1);
				sqlState.post();
				
				return true;
			}
			
		
	}
	
	//查看商品名称列表
	public boolean queryProName() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		SqlQuery query = new SqlQuery(this);
		query.add("select UID_,proId_,createDate_ from %s where isDel_='0'" ,appdb.T_ProNode);
		query.add("group by proId_");
		query.add("order by createDate_ desc");
		query.open();
		if(!query.eof()){
			List<Record> records = query.getRecords();
			for(int i=0;i<records.size();i++){
				String proId_ = records.get(i).getString("proId_");
				SqlQuery ds = new SqlQuery(this);
				ds.add("select pro.UID_ UID_,pro.proId_,pro.isDel_ isDel,salesHotPush_,salesTypeMenu_,salesFine_,salesNewPro_,rentHotPush_,rentTypeMenu_,"
						+ "rentFine_,rentNewPro_,proName_,fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,"
						+ "(select count(zhuCode_) from t_prostate where(nodeState_='1' or nodeState_='2' or nodeState_='3' or nodeState_='4' or nodeState_='5') and proId_='%s') proLaberSum_,"
						+ "(select count(zhuCode_) from t_prostate where nodeState_='2' and proId_='%s') proGuiCount_, pro.updateDate_ updateDate_"
						+ "twoState_,twoDel_ from %s ty join %s pro on ty.twoNameId_=pro.proTypeId_"
						,proId_,proId_,appdb.T_Protype,appdb.T_Products);
				ds.add("where fristDel_=%s",0);
				ds.add("and twoDel_=%s",0);
				ds.add("and isDel_=%s",0);
				ds.add("and pro.proId_='%s'",proId_);
				String proName_=head.getString("proName_");
				String fristNameId_=head.getString("fristNameId_");
				String twoNameId_=head.getString("twoNameId_");
				if(head.hasValue("proName_")){
					ds.add("and proName_ like '%s' ",new String("%"+proName_+"%"));
				}
				if(head.hasValue("fristNameId_")){
					if(!fristNameId_.equals("请选择")){
						ds.add("and fristNameId_ like '%s' ",new String("%"+fristNameId_+"%"));
					}
				}
				if(head.hasValue("twoNameId_")){
					if(!twoNameId_.equals("请选择")){
						ds.add("and twoNameId_ like '%s' ",new String("%"+twoNameId_+"%"));
					}
				}
				ds.add("order by pro.updateDate_");
				ds.open();
				if(!ds.eof())
					dataOut.appendDataSet(ds);
			}
		}
			return true;
		
	}
	//查询单个商品名称
	public boolean queryById() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select pro.*,fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,"
				+ "twoState_,twoDel_ from %s ty join %s pro on ty.twoNameId_=pro.proTypeId_",appdb.T_Protype,appdb.T_Products);
		ds.add("where fristDel_=%s",0);
		ds.add("and twoDel_=%s",0);
		ds.add("and proId_='%s'",head.getString("proId_"));
		ds.add("order by updateDate_");
		ds.open();
		if(!ds.eof()){
			dataOut.appendDataSet(ds);
			return true;
		}else{
		return false;
		}
	}
	
	//修改商品名称
	public boolean updateProName() throws DataValidateException{
		Record headIn = this.getDataIn().getHead();
		SqlQuery ds = new SqlQuery(this);
		String proLbImges_ = headIn.getString("proLbImges_");
		String  proZsImges_ = headIn.getString("proZsImges_");
		ds.add("select * from %s ",appdb.T_Products);
		ds.add("where proId_='%s'",headIn.getString("proId_"));
		ds.open();
		if(!ds.eof()){
			ds.edit();
			ds.setField("updateDate_", TDateTime.Now());
			ds.setField("updateUser_", this.getUserCode());
			ds.setField("proName_", headIn.getString("proName_"));
			ds.setField("proTypeId_", headIn.getString("twoNameId_"));
			ds.setField("salesHotPush_", headIn.getString("salesHotPush_"));
			ds.setField("salesTypeMenu_", headIn.getString("salesTypeMenu_"));
			ds.setField("salesNewPro_", headIn.getString("salesNewPro_"));
			ds.setField("salesFine_", headIn.getString("salesFine_"));
			ds.setField("rentHotPush_", headIn.getString("rentHotPush_"));
			ds.setField("rentTypeMenu_", headIn.getString("rentTypeMenu_"));
			ds.setField("rentFine_", headIn.getString("rentFine_"));
			ds.setField("rentNewPro_", headIn.getString("rentNewPro_"));
			if(proLbImges_ != null && proLbImges_ != ""){
				ds.setField("proLbImges_", proLbImges_);
			}
			if(proZsImges_ != null && proZsImges_ != ""){
				ds.setField("proZsImges_", proZsImges_);
			}
			ds.post();
//			SqlQuery ds1 = new SqlQuery(this);
//			ds.add("select * from %s ",appdb.T_Products);
//			ds.add("and proId_='%s'",headIn.getString("proId_"));
			return true;
		}else{
		return false;
		}
	}
	//删除商品名称
	public boolean delProName() throws DataValidateException{
		Record headIn = this.getDataIn().getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select * from %s ",appdb.T_Products);
		ds.add("where proId_='%s'",headIn.getString("proId_"));
		ds.open();
		if(!ds.eof()){
			ds.edit();
			ds.setField("isDel_", "1");
			ds.post();
		}
		SqlQuery ds1 = new SqlQuery(this);
		ds1.add("select * from %s ",appdb.T_ProNode);
		ds1.add("where proId_='%s'",headIn.getString("proId_"));
		ds1.open();
		if(!ds1.eof()){
			List<Record> list = ds1.getRecords();
			ds1.edit();
			ds1.setBatchSave(true);
			for(int i=0;i<list.size();i++){
				list.get(i).setState(DataSetState.dsEdit);
				list.get(i).setField("isDel_","1");
			}
			ds1.save();
		}
		return true;
	}
	
	/**
	 * 删除商品详情图片
	 * @Title: delImg 
	 * @Description: TODO 
	 * @author 乔晨光
	 * @param @return
	 * @param @throws DataValidateException    
	 * @return boolean
	 */
	public boolean delImg() throws DataValidateException {
		Record headIn = this.getDataIn().getHead();
		String UID_ = headIn.getString("UID_");
		SqlQuery ds = new SqlQuery(this);
		ds.add("select UID_,imgPath_,type_,relevancelId_ from %s where 1=1",appdb.T_IMAGE);
		if(UID_!=""&&UID_!=null){
			ds.add("and UID_=%s",UID_);
		}else{
			ds.add("and UID_=%s","abc");
		}
		ds.open();
		if(!ds.eof()){
			ds.delete();
			ds.post();
		}
		return true;
	}
	
	//根据主电子条码获取商品信息
	public boolean findPro() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		/*SqlQuery ds = new SqlQuery(this);
		ds.add("select * from %s ",appdb.T_Products);
		ds.add("where proId_=(select proId_ from %s where zhuCode_='%s')",appdb.T_ProNode,head.getString("zhuCode_"));
		ds.open();
		if(!ds.eof()){
			dataOut.appendDataSet(ds);
			return true;
		}else{
			return false;
		}*/
		SqlQuery sql = new SqlQuery(this);
		sql.add("SELECT b.cabId_ cabId_,ps.proId_,ps.dayRentMoney_, b.boxId_ boxId_,pd.zhuCode_ zhuCode_,ps.proName_ proName_,proZsImges_ ,ps.discountPrice_, boxName_, boxVolume_, boxType_,ps.cashPledge_,ps.isDiscount_, emptyStatus_,lockDate_,boxOrderLock_,boxStatus_,status_ FROM %s b", appdb.BOX);
		sql.add(" LEFT JOIN %s pb ON b.boxId_ = pb.boxId_", appdb.t_pronode_box);
		sql.add(" AND b.cabId_ = pb.cabId_");
		sql.add(" LEFT JOIN %s pd ON pd.zhuCode_ = pb.zhuCode_", appdb.T_ProNode);
		sql.add(" LEFT JOIN %s ps ON ps.proId_ = pd.proId_", appdb.T_Products);
		sql.add(" WHERE pd.zhuCode_ = '%s'", head.getString("zhuCode_"));
		sql.open();
		if (!sql.eof()){
			dataOut.appendDataSet(sql);
			return true;
		}else{
			return false;
		}
	}
	
}
