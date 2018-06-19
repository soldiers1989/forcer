package com.huagu.product.services;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.jackrabbit.uuid.UUID;
import org.apache.log4j.Logger;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.DataSetState;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.mysql.Transaction;

public class SvrAdminRentPro extends CustomService{
	private static final Logger log = Logger.getLogger(SvrAdminRentPro.class);
	
	//查询租赁物品列表
	public boolean queryRentProList() throws DataValidateException{
		DataSet dd = new DataSet();
		Record head = this.getDataIn().getHead();
		SqlQuery query = new SqlQuery(this);
		query.add("select UID_,proId_,createDate_ from t_pronode where isDel_='0'");
		query.add("group by proId_");
		query.add("order by createDate_ desc");
		query.open();
		if(!query.eof()){
			List<Record> records = query.getRecords();
			for(int i=0;i<records.size();i++){
				String proId_ = records.get(i).getString("proId_");
				SqlQuery ds = new SqlQuery(this);
				ds.add("select p.UID_ UID_,p.proId_ proId_,proName_,p.price_ price_,p.createDate_ createDate_,p.cashPledge_,"
						+ "(select count(zhuCode_) from t_prostate where (nodeState_='1' or nodeState_='2' or nodeState_='3' or nodeState_='4' or nodeState_='5') and proId_='%s') proLaberSum_,"
						+ "(select count(zhuCode_) from t_prostate where nodeState_='2' and proId_='%s') proGuiCount_,"
						+ "(select count(zhuCode_) from t_prostate where nodeState_='4' and proId_='%s') proTuCount_,"
						+ "(select count(zhuCode_) from t_prostate where nodeState_='3' and proId_='%s') proRentCount_,"
						+ "(select count(zhuCode_) from t_prostate where nodeState_='5' and proId_='%s') proSaleCount_,"
						+ "(select count(zhuCode_) from t_pronode where state_='3' and proId_='%s') proFixCount_,"
						+ "fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,twoState_,"
						+ "twoDel_,scrapTime_,n.proId_ pid,zhuCode_,proCostPrice_ from %s p left join %s ty on ty.twoNameId_=p.proTypeId_"
						+ " left join %s n on p.proId_=n.proId_",proId_,proId_,proId_,proId_
						,proId_,proId_,appdb.T_Products,appdb.T_Protype,appdb.T_ProNode);
				ds.add("where fristDel_=%s",0);
				ds.add("and twoDel_=%s",0);
				ds.add("and p.isDel_=%s",0);
				ds.add("and p.proId_='%s'",proId_);
				String proName_=head.getString("proName_");
				String fristNameId_=head.getString("fristNameId_");
				String twoNameId_=head.getString("twoNameId_");
				String zhuCode_=head.getString("zhuCode_");
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
				if(head.hasValue("zhuCode_")){
					ds.add("and zhuCode_ like '%s' ",new String("%"+zhuCode_+"%"));
				}
				ds.add("order by p.createDate_ desc");
				ds.open();
				 if (!ds.eof()) {
					 dd.getRecords().add(ds.getCurrent());					 
				 }
			}
			dataOut.appendDataSet(dd);
		}
		return true;
		
	}
	
	//查询租赁物品电子条码列表
	public boolean queryNodeList() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		SqlQuery ds = new SqlQuery(this);
		String zhuCode_=head.getString("zhuCode_");
		ds.add("select proName_,p.proId_ ppid,p.isDel_ pDel,proTypeId_,price_,"
				+ "(select count(zhuCode_) from t_prostate where nodeState_='3') proRentCount_,"
				+ "(select count(zhuCode_) from t_prostate where nodeState_='4') proSaleCount_,"
				+ "fristName_,fristNameId_,"
				+ "fristState_,fristDel_,twoName_,twoNameId_,twoState_,ciCode_,ciCodeName_,ciDel_, n.createDate_ createDate_,"
				+ "twoDel_,scrapTime_,n.* from %s p left join %s ty on ty.twoNameId_=p.proTypeId_"
				+ " left join %s n on p.proId_=n.proId_ left join %s c on n.zhuCode_=c.zhuCode_",appdb.T_Products,appdb.T_Protype,appdb.T_ProNode,appdb.T_CiNode);
		ds.add("where 1=1");
		ds.add("and n.isDel_=%s",0);
		ds.add("and ciDel_=%s",0);
		ds.add("and p.isDel_=%s",0);
		if(head.hasValue("proId_")){
			ds.add("and n.proId_='%s'",head.getString("proId_"));
		}
		if(head.hasValue("zhuCode_")){
			ds.add("and n.zhuCode_ like '%s' ",new String("%"+zhuCode_+"%"));
		}
		ds.add("group by c.zhuCode_");
		ds.open();
		
		SqlQuery ds1 = new SqlQuery(this);
		ds1.add("select proName_,p.proId_ ppid,p.isDel_ pDel,proTypeId_,price_,"
				+ "(select count(zhuCode_) from t_prostate where nodeState_='2') proRentCount_,"
				+ "(select count(zhuCode_) from t_prostate where nodeState_='5') proSaleCount_,"
				+ "fristName_,fristNameId_,"
				+ "fristState_,fristDel_,twoName_,twoNameId_,twoState_,ciCode_,ciCodeName_,ciDel_, n.createDate_ createDate_,"
				+ "twoDel_,scrapTime_,n.* from %s p left join %s ty on ty.twoNameId_=p.proTypeId_"
				+ " left join %s n on p.proId_=n.proId_ left join %s c on n.zhuCode_=c.zhuCode_",appdb.T_Products,appdb.T_Protype,appdb.T_ProNode,appdb.T_CiNode);
		ds1.add("where 1=1");
		ds1.add("and n.isDel_=%s",0);
		ds1.add("and ciDel_=%s",0);
		ds1.add("and p.isDel_=%s",0);
		if(head.hasValue("proId_")){
			ds1.add("and n.proId_='%s'",head.getString("proId_"));
		}
		if(head.hasValue("zhuCode_")){
			ds1.add("and n.zhuCode_ like '%s' ",new String("%"+zhuCode_+"%"));
		}
		ds1.add("group by c.ciCode_");
		ds1.open();
		
		StringBuffer sb=new StringBuffer();
		StringBuffer sbName=new StringBuffer();
		List<Record> li = ds.getRecords();
		List<Record> list = ds1.getRecords();
		DataSet data=new DataSet();
		for(int i=0;i<li.size();i++){
			Record record = li.get(i);
			for(int j=0;j<list.size();j++){
				Record record1 = list.get(j);
				if(record.getString("zhuCode_").equals(record1.getString("zhuCode_"))){
					sb.append(record1.getString("ciCode_"));
					sb.append(" ");
				}
			}
			for(int j=0;j<list.size();j++){
				Record record1 = list.get(j);
				if(record.getString("zhuCode_").equals(record1.getString("zhuCode_"))){
					sbName.append(record1.getString("ciCodeName_"));
					sbName.append(" ");
				}
			}
			Record nrecord = new Record();
			nrecord.setField("proName_", record.getString("proName_"));
			nrecord.setField("proTypeId_", record.getString("proTypeId_"));
			nrecord.setField("price_", record.getString("price_"));
			nrecord.setField("proRentCount_", record.getInt("proRentCount_"));
			nrecord.setField("proSaleCount_", record.getInt("proSaleCount_"));
			nrecord.setField("fristName_", record.getString("fristName_"));
			nrecord.setField("fristNameId_", record.getString("fristNameId_"));
			nrecord.setField("twoName_", record.getString("twoName_"));
			nrecord.setField("twoNameId_", record.getString("twoNameId_"));
			nrecord.setField("proId_", record.getString("proId_"));
			nrecord.setField("zhuCode_", record.getString("zhuCode_"));
			nrecord.setField("ciCode_", sb);
			nrecord.setField("ciCodeName_", sbName);
			nrecord.setField("homeAgency_", record.getString("homeAgency_"));
			nrecord.setField("supplyUser_", record.getString("supplyUser_"));
			nrecord.setField("enterKu_", record.getString("enterKu_"));
			nrecord.setField("serverDeadTime_", record.getString("serverDeadTime_"));
			nrecord.setField("state_", record.getString("state_"));
			nrecord.setField("remark_", record.getString("remark_"));
			nrecord.setField("scrapState_", record.getString("scrapState_"));
			nrecord.setField("proCostPrice_", record.getString("proCostPrice_"));
			nrecord.setField("updateDate_", record.getString("updateDate_"));
			nrecord.setField("createDate_", record.getString("createDate_"));
			data.getRecords().add(nrecord);
			 sb=new StringBuffer();
		}
		if(!ds.eof())
			dataOut.appendDataSet(data);
		return true;
		
	}
	
	//查询电子条码状态
	public boolean queryNodeState() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		SqlQuery ds = new SqlQuery(this);
		String zhuCode_=head.getString("zhuCode_");
		ds.add("select p.proName_ proName_,p.proId_,n.zhuCode_,c.ciCode_ ciCode_,n.createDate_ createDate_,");
		ds.add("(case when s.nodeState_='1' then '在库' ");
		ds.add("when s.nodeState_='2' then '在柜' ");
		ds.add("when s.nodeState_='3' then '在租' ");
		ds.add("when s.nodeState_='4' then '在途' ");
		ds.add("when s.nodeState_='5' then '已售' end) as nodeState_");
		ds.add("from %s p", appdb.T_Products);
		ds.add("left join %s n on p.proId_=n.proId_",appdb.T_ProNode);
		ds.add("left join t_cinode c on n.zhuCode_=c.zhuCode_ ");
		ds.add("left join (select * from t_prostate where coDel_=0) s on n.zhuCode_=s.zhuCode_ where 1=1");
		ds.add("and p.isDel_=%s",0);
		ds.add("and c.ciDel_=%s",0);
		if(zhuCode_!=""&&zhuCode_!=null){
			ds.add("and n.zhuCode_ like '%s' ",new String("%"+zhuCode_+"%"));
		}
		ds.add("group by c.zhuCode_");
		ds.open();
		
		SqlQuery ds1 = new SqlQuery(this);
		ds1.add("select p.proName_ proName_,p.proId_,n.zhuCode_,c.ciCode_ ciCode_,s.nodeState_,n.createDate_ createDate_ from t_products p left join t_pronode n on p.proId_=n.proId_ "
				+ "left join t_cinode c on n.zhuCode_=c.zhuCode_ left join (select * from t_prostate where coDel_=0) s on n.zhuCode_=s.zhuCode_ where 1=1");
		ds1.add("and p.isDel_=%s",0);
		ds1.add("and c.ciDel_=%s",0);
		if(zhuCode_!=""&&zhuCode_!=null){
			ds1.add("and n.zhuCode_ like '%s' ",new String("%"+zhuCode_+"%"));
		}
		ds1.add("group by c.ciCode_");
		ds1.open();
		StringBuffer sb=new StringBuffer();
		List<Record> li = ds.getRecords();
		List<Record> list = ds1.getRecords();
		DataSet data=new DataSet();
		for(int i=0;i<li.size();i++){
			Record record = li.get(i);
			for(int j=0;j<list.size();j++){
				Record record1 = list.get(j);
				if(record.getString("zhuCode_").equals(record1.getString("zhuCode_"))){
					sb.append(record1.getString("ciCode_"));
					sb.append(" ");
				}
			}
			Record nrecord = new Record();
			nrecord.setField("proName_", record.getString("proName_"));
			nrecord.setField("proId_", record.getString("proId_"));
			nrecord.setField("zhuCode_", record.getString("zhuCode_"));
			nrecord.setField("ciCode_", sb);
			nrecord.setField("nodeState_", record.getString("nodeState_"));
			nrecord.setField("createDate_", record.getString("createDate_"));
			data.getRecords().add(nrecord);
			 sb=new StringBuffer();
		}
		if(!ds.eof())
			dataOut.appendDataSet(data);
			return true;
	}
	
	//查询电子条码状态
	@SuppressWarnings("unchecked")
	public boolean queryImportData() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		List<String> importli=(ArrayList<String>) head.getField("temp");
		SqlQuery ds = new SqlQuery(this);
		ds.add("select p.proName_ proName_,p.proId_,n.zhuCode_,c.ciCode_ ciCode_,s.nodeState_,n.createDate_ createDate_ from t_products p left join t_pronode n on p.proId_=n.proId_ "
				+ "left join t_cinode c on n. zhuCode_=c.zhuCode_ left join (select * from t_prostate where coDel_=0) s on n.zhuCode_=s.zhuCode_ where 1=1");
		ds.add("and p.isDel_=%s",0);
		ds.add("and c.ciDel_=%s ",0);
		if(importli.size()!=0){
			System.out.println("importli.size()"+importli.size());
			ds.add("and n.zhuCode_ in(");
			for(int i=0;i<importli.size();i++){
				String zhuCode_ = importli.get(i);
				if(i==0&&zhuCode_!=""&&zhuCode_!=null){
					ds.add("'%s'",zhuCode_);
				}
				if(i>0&&zhuCode_!=""&&zhuCode_!=null){
					ds.add(",'%s'",zhuCode_);
				}
			}
			ds.add(")");
		}
		ds.add("group by c.zhuCode_");
		ds.open();
		
		SqlQuery ds1 = new SqlQuery(this);
		ds1.add("select p.proName_ proName_,p.proId_,n.zhuCode_,c.ciCode_ ciCode_,s.nodeState_,n.createDate_ createDate_ from t_products p left join t_pronode n on p.proId_=n.proId_ "
				+ "left join t_cinode c on n.zhuCode_=c.zhuCode_ left join (select * from t_prostate where coDel_=0) s on n.zhuCode_=s.zhuCode_ where 1=1");
		ds1.add("and p.isDel_=%s",0);
		ds1.add("and c.ciDel_=%s",0);
		if(importli.size()!=0){
			ds1.add("and n.zhuCode_ in(");
			for(int i=0;i<importli.size();i++){
				String zhuCode_ = importli.get(i);
				if(i==0&&zhuCode_!=""&&zhuCode_!=null){
					ds1.add("'%s'",zhuCode_);
				}
				if(i>0&&zhuCode_!=""&&zhuCode_!=null){
					ds1.add(",'%s'",zhuCode_);
				}
			}
			ds1.add(")");
		}
		ds1.add("group by c.ciCode_");
		ds1.open();
		StringBuffer sb=new StringBuffer();
		List<Record> li = ds.getRecords();
		List<Record> list = ds1.getRecords();
		DataSet data=new DataSet();
		for(int i=0;i<li.size();i++){
			Record record = li.get(i);
			for(int j=0;j<list.size();j++){
				Record record1 = list.get(j);
				if(record.getString("zhuCode_").equals(record1.getString("zhuCode_"))){
					sb.append(record1.getString("ciCode_"));
					sb.append(" ");
				}
			}
			Record nrecord = new Record();
			nrecord.setField("proName_", record.getString("proName_"));
			nrecord.setField("proId_", record.getString("proId_"));
			nrecord.setField("zhuCode_", record.getString("zhuCode_"));
			nrecord.setField("ciCode_", sb);
			nrecord.setField("nodeState_", record.getString("nodeState_"));
			nrecord.setField("createDate_", record.getString("createDate_"));
			data.getRecords().add(nrecord);
			 sb=new StringBuffer();
		}
		if(!ds.eof())
			dataOut.appendDataSet(data);
			return true;
			
	}
	
	//添加电子条码状态
    public boolean insertNode() throws DataValidateException {
    	DataSet params = this.getDataIn();
		List<Record> list = params.getRecords();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select * from %s",appdb.T_ProState);
		ds.setMaximum(0);
		ds.open();
		ds.setBatchSave(true);
		for(int i=0;i<list.size();i++){
			Record record = list.get(i);
			Record nrecord = new Record();
			nrecord.setState(DataSetState.dsInsert);
			nrecord.setField("proName_", record.getString("proName_"));
			nrecord.setField("createDate_", TDateTime.Now());
			nrecord.setField("createUser_", this.getUserCode());
			nrecord.setField("proId_", record.getString("proId_"));
			nrecord.setField("zhuCode_", record.getString("zhuCode_"));
			nrecord.setField("ciCode_", record.getString("ciCode_"));
			nrecord.setField("nodeState_", 1);
			ds.getRecords().add(nrecord);
		}
		ds.save();
		return true;
	}
    
	
	//导入电子条码状态
    public boolean importInsertNode() throws DataValidateException {
        try (Transaction tx = new Transaction(this)) {
            DataSet dataIn = this.getDataIn();
            dataIn.first();
            while (dataIn.fetch()) {
                SqlQuery ds = new SqlQuery(this);
                ds.add("select * from %s", appdb.T_ProState);
                ds.add("where zhuCode_='%s'",dataIn.getString("zhuCode_"));
                ds.open();
                if(!ds.eof()) {
                    ds.edit();
                    ds.setField("nodeState_", 1);
                    ds.post();
                }
            }
            tx.commit();
        }
        return true;
    }
	
	//查询租赁单个商品的物品属性
	public boolean queryById() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		String proId_ = head.getString("proId_");
		SqlQuery ds = new SqlQuery(this);
		ds.add("select * from %s where 1=1",appdb.T_Products);
		ds.add("and proId_='%s'",proId_);
		ds.open();
		if(!ds.eof()){
			SqlQuery ds1 = new SqlQuery(this);
			ds1.add("select P.UID_ UID_,proLaberSum_,p.proId_ proId_,p.isDel_ isDel_,proName_,p.proState_,"
					+ "proImgId_,proDesc_,discountPrice_,proWeight_,proSize_,isDiscount_,jifen_,posTage_,"
					+ "(select count(zhuCode_) from t_prostate where nodeState_='3') proRentCount_,dayRentMoney_,cashPledge_,price_,"
					+ "(select count(orderId_) from t_order where proId_='%s') proSaleCount_,imgPath_,imgDel_,"
					+ "fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,twoState_,"
					+ "twoDel_,scrapTime_,n.proId_ pid from %s p left join %s ty on ty.twoNameId_=p.proTypeId_"
					+ " left join %s n on p.proId_=n.proId_ left join %s i on p.proImgId_=i.relevancelId_"
					,proId_,appdb.T_Products,appdb.T_Protype,appdb.T_ProNode,appdb.T_IMAGE);
			ds1.add("where 1=1");
			ds1.add("and p.proId_='%s'",head.getString("proId_"));
//			ds1.add("and p.proState_='0'");
//			ds1.add("and twoNameId_='%s'",ds.getString("proTypeId_"));
//			ds1.add("and fristDel_=%s",0);
//			ds1.add("and twoDel_=%s",0);
//			ds1.add("and p.isDel_=%s",0);
//			ds1.add("and i.imgDel_=%s",0);
//			ds1.add("group by proId_");
			ds1.open();
			if(!ds1.eof()){
				dataOut.appendDataSet(ds1);
			}
		}
		return true;
	}
	
	//查询租赁单个商品的物品属性
	public boolean queryImg() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		SqlQuery queryPro = new SqlQuery(this);
		queryPro.add("select * from %s where 1=1",appdb.T_Products);
		queryPro.add("and proId_='%s'",head.getString("proId_"));
		queryPro.open();
		if(!queryPro.eof()){
			SqlQuery ds = new SqlQuery(this);
			ds.add("select * from %s where 1=1",appdb.T_IMAGE);
			ds.add("and relevancelId_='%s'",queryPro.getString("proImgId_"));
			ds.open();
			if(!ds.eof()){
				dataOut.appendDataSet(ds);
			}
		}
		
		return true;
		
	}
		
	//添加租赁单个商品的物品属性
	public boolean insertProAttr() throws DataValidateException{
		Record head = this.getDataIn().getHead();
        DataValidateException.stopRun("商品原租赁价不允许小于0！", head.getDouble("dayRentMoney_")<0);
        DataValidateException.stopRun("押金不允许小于0！", head.getDouble("cashPledge_")<0);
		SqlQuery ds = new SqlQuery(this);
		ds.add("select * from %s where 1=1",appdb.T_Products);
		ds.add("and proId_='%s'",head.getString("proId_"));
		ds.open();
		if(!ds.eof()){
			ds.edit();
			ds.setField("dayRentMoney_",head.getDouble("dayRentMoney_"));
			ds.setField("cashPledge_",head.getDouble("cashPledge_"));
			ds.setField("price_",head.getDouble("price_"));
			ds.setField("proDesc_",head.getString("proDesc_"));
			//ds.setField("proLaberSum_",head.getString("proLaberSum_"));
			ds.setField("discountPrice_",head.getDouble("discountPrice_"));
			ds.setField("proWeight_",head.getString("proWeight_"));
			ds.setField("proSize_",head.getString("proSize_"));
			ds.setField("jifen_",head.getString("jifen_"));
			ds.setField("posTage_",head.getString("posTage_"));
			ds.setField("proSize_",head.getString("proSize_"));
//			ds.setField("scrapTime_",head.getString("scrapTime_"));
			if(head.hasValue("isDiscount_")) {
			    ds.setField("isDiscount_", head.getString("isDiscount_"));
			}else {
			    ds.setField("isDiscount_", "0");
			}
			ds.post();
			}
			SqlQuery ds1 = new SqlQuery(this);
			ds1.add("select * from %s where 1=1",appdb.T_ProNode);
			ds1.add("and proId_='%s'",head.getString("proId_"));
			ds1.open();
			if(!ds1.eof()){	
				ds1.edit();
				ds1.setField("createDate_", TDateTime.Now());
				ds1.setField("createUser_", this.getUserCode());
				ds1.setField("scrapTime_",head.getString("scrapTime_"));
				ds1.post();
			}
			return true;
		}
		
	//添加租赁单个商品的电子条码信息
	@SuppressWarnings("unchecked")
	public boolean insertProNode() throws DataValidateException, ParseException{
		Record headIn = this.getDataIn().getHead();
		SqlQuery check = new SqlQuery(this);
		if(headIn.hasValue(headIn.getString("zhuCode_"))){
			check.add("select * from %s where 1=1",appdb.T_ProNode);
			check.add("and zhuCode_='%s'",headIn.getString("zhuCode_"));
			check.open();
		}
		if(!check.eof()){
			return false;
		}{
			List<String> code = (ArrayList<String>) headIn.getField("code");
			List<String> codeName = (ArrayList<String>) headIn.getField("codeName");
			SqlQuery ds = new SqlQuery(this);
			ds.add("select * from %s where 1=1",appdb.T_ProNode);
			ds.add("and proId_='%s'",headIn.getString("proId_"));
			ds.open();
			 try (Transaction tx = new Transaction(this)) { 
			if(!ds.eof()){
				if(ds.getString("zhuCode_").equals("")){
					ds.edit();
					ds.setField("updateDate_", TDateTime.Now());
					//ds.setField("proId_", headIn.getString("proId_"));
					ds.setField("updateUser_", this.getUserCode());
					ds.setField("zhuCode_", headIn.getString("zhuCode_"));
					ds.setField("homeAgency_", headIn.getString("homeAgency_"));
					ds.setField("supplyUser_", headIn.getString("supplyUser_"));
					ds.setField("scrapState_",headIn.getString("scrapState_"));
					ds.setField("state_",headIn.getString("state_"));
					ds.setField("remark_",headIn.getString("remark_"));
					ds.setField("proCostPrice_",headIn.getString("proCostPrice_"));
					ds.setField("enterKu_",TDateTime.fromDate(headIn.getString("enterKu_")));
					ds.setField("serverDeadTime_",TDateTime.fromDate(headIn.getString("serverDeadTime_")));
					ds.post();
					
					SqlQuery sql = new SqlQuery(this);
					sql.add("select  p.proId_ ,n.zhuCode_,  p.proTypeId_ , y.twoNameId_  from  t_products p  ");
					sql.add("join   t_pronode n   on p.proId_=n.proId_ ");
					sql.add("join  t_protype y on p.proTypeId_=y.twoNameId_");
					sql.add("where n.zhuCode_ = '%s'" ,headIn.getString("zhuCode_"));
					sql.open();
					
					
					SqlQuery sqlTYpe = new SqlQuery(this);
					sqlTYpe.add("select UID_ , createDate_ ,createUser_ ,twoNameId_, twoDel_ from t_protype");
					sqlTYpe.add("where twoNameId_ = '%s'" ,sql.getField("proTypeId_"));
					sqlTYpe.open();
					sqlTYpe.edit();
					sqlTYpe.setField("createUser_",this.getUserCode());
					sqlTYpe.setField("createDate_", TDateTime.Now());
					sqlTYpe.setField("twoDel_", 0);
					sqlTYpe.post();
					
					SqlQuery sqlState = new SqlQuery(this);
					sqlState.add("select UID_ , createDate_ ,createUser_ ,zhuCode_, coDel_ from %s" ,appdb.T_ProState);
					sqlState.open();
					sqlState.append();
					sqlState.setField("proId_", headIn.getString("proId_"));
					sqlState.setField("createUser_",this.getUserCode());
					sqlState.setField("createDate_", TDateTime.Now());
					sqlState.setField("coDel_", 0);
					sqlState.post();
					
					SqlQuery sqlNode = new SqlQuery(this);
					sqlNode.add("select UID_ , createDate_ ,createUser_ ,zhuCode_, isDel_ from %s" ,appdb.T_ProNode);
					sqlNode.add("where  zhuCode_ = '%s'" ,headIn.getString("zhuCode_"));
					sqlNode.open();
					sqlNode.edit();
					sqlNode.setField("createUser_",this.getUserCode());
					sqlNode.setField("createDate_", TDateTime.Now());
					sqlNode.setField("isDel_", 0);
					sqlNode.post();
					
				}else{
					ds.append();
					ds.setField("createDate_", TDateTime.Now());
					ds.setField("proId_", headIn.getString("proId_"));
					ds.setField("createUser_", this.getUserCode());
					ds.setField("zhuCode_", headIn.getString("zhuCode_"));
					ds.setField("homeAgency_", headIn.getString("homeAgency_"));
					ds.setField("supplyUser_", headIn.getString("supplyUser_"));
					ds.setField("scrapState_",headIn.getString("scrapState_"));
					ds.setField("state_",headIn.getString("state_"));
					ds.setField("remark_",headIn.getString("remark_"));
					ds.setField("proCostPrice_",headIn.getString("proCostPrice_"));
					ds.setField("enterKu_",TDateTime.fromDate(headIn.getString("enterKu_")));
					ds.setField("serverDeadTime_",TDateTime.fromDate(headIn.getString("serverDeadTime_")));
					ds.post();
				}
				SqlQuery ds1 = new SqlQuery(this);
				ds1.add("select * from %s where 1=1",appdb.T_CiNode);
				ds1.add("and zhuCode_='%s'",ds.getString("zhuCode_"));
				ds1.open();
				for(int i=0;i<code.size();i++){
					if(code.get(i)!=null&&code.get(i)!=""){
						ds1.append();
						ds1.setField("createDate_", TDateTime.Now());
						ds1.setField("createUser_", this.getUserCode());
						ds1.setField("zhuCode_", ds.getString("zhuCode_"));
						ds1.setField("ciCode_", code.get(i));
						ds1.setField("ciCodeName_", codeName.get(i));
						ds1.post();
					}
				}
			}
			 tx.commit();
			    }
		}
		
		return true;
	}
	
	//添加租赁单个商品的电子条码信息
	@SuppressWarnings("unchecked")
	public boolean updateProNode() throws DataValidateException, ParseException{
		Record headIn = this.getDataIn().getHead();
		List<String> code = (ArrayList<String>) headIn.getField("code");
		List<String> codeName = (ArrayList<String>) headIn.getField("codeName");
		SqlQuery ds = new SqlQuery(this);
		ds.add("select * from %s where 1=1",appdb.T_ProNode);
		ds.add("and proId_='%s'",headIn.getString("proId_"));
		ds.add("and zhuCode_='%s'",headIn.getString("zhuCode_"));
		ds.open();
		if(!ds.eof()){
				ds.edit();
				ds.setField("updateDate_", TDateTime.Now());
				ds.setField("updateUser_", this.getUserCode());
//				ds.setField("zhuCode_", headIn.getString("zhuCode_"));
				ds.setField("homeAgency_", headIn.getString("homeAgency_"));
				ds.setField("supplyUser_", headIn.getString("supplyUser_"));
				ds.setField("scrapState_",headIn.getString("scrapState_"));
//				ds.setField("state_",headIn.getString("state_"));
//				ds.setField("remark_",headIn.getString("remark_"));
				ds.setField("proCostPrice_",headIn.getString("proCostPrice_"));
//				ds.setField("enterKu_",TDateTime.fromDate(headIn.getString("enterKu_")));
//				ds.setField("serverDeadTime_",TDateTime.fromDate(headIn.getString("serverDeadTime_")));
				ds.post();
			}
			SqlQuery ds1 = new SqlQuery(this);
			ds1.add("select * from %s where 1=1",appdb.T_CiNode);
			ds1.add("and zhuCode_='%s'",ds.getString("zhuCode_"));
			ds1.open();
			if(!ds1.eof()){
				ds1.setBatchSave(true);
				ds1.edit();
				List<Record> records = ds1.getRecords();
				for(int j=0;j<records.size();j++){
//					for(int i=0;i<code.size();i++){
//						if(code.get(i)!=null&&code.get(i)!=""){
							records.get(j).setField("updateDate_", TDateTime.Now());
							records.get(j).setField("updateUser_",this.getUserCode());
							records.get(j).setField("zhuCode_", ds.getString("zhuCode_"));
							records.get(j).setField("ciCode_", code.get(j));
							records.get(j).setField("ciCodeName_", codeName.get(j));
//							ds1.setField("updateDate_", TDateTime.Now());
//							ds1.setField("updateUser_", this.getUserCode());
//							ds1.setField("zhuCode_", ds.getString("zhuCode_"));
//							ds1.setField("ciCode_", code.get(i));
//							ds1.setField("ciCodeName_", codeName.get(i));
//						}
//					}
				}
				ds1.save();
			}
		return true;
	}
		
	//删除电子条码信息
	public boolean delProNode() throws DataValidateException{
		Record headIn = this.getDataIn().getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select UID_,zhuCode_,isDel_ from %s where 1=1",appdb.T_ProNode);
		ds.add("and zhuCode_='%s'",headIn.getString("zhuCode_"));
		ds.open();
		if(!ds.eof()){
			ds.edit();
			ds.setField("isDel_", 1);
			ds.post();
			//删除商品状态表里的信息
			SqlQuery ds2 = new SqlQuery(this);
			ds2.add("select UID_,zhuCode_,coDel_ from %s where 1=1",appdb.T_ProState);
			ds2.add("and zhuCode_='%s'",headIn.getString("zhuCode_"));
			ds2.open();
			if(!ds2.eof()){
				ds2.edit();
				ds2.setField("coDel_", 1);
				ds2.post();
			}
			//删除配件电子条码信息
			SqlQuery ds1 = new SqlQuery(this);
			ds1.add("select UID_,zhuCode_,ciDel_ from %s where 1=1",appdb.T_CiNode);
			ds1.add("and zhuCode_='%s'",headIn.getString("zhuCode_"));
			ds1.open();
			if(!ds1.eof()){
				List<Record> list = ds1.getRecords();
				ds1.edit();
				ds1.setBatchSave(true);
				for(int i=0;i<list.size();i++){
					list.get(i).setState(DataSetState.dsEdit);
					list.get(i).setField("ciDel_","1");
				}
				ds1.save();;
			}
		}
		return true;
			
	}
	
	//上传图片
	public boolean ajaxData() throws DataValidateException{
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select *");
		ds.add(" from %s where 1=1", appdb.T_Products);
		ds.add("and proId_='%s'",headIn.getString("proId_"));
		ds.open();
		if(!ds.eof()){
			String proImgId_;
			if(ds.getString("proImgId_")!="" || ds.getString("proImgId_")!=null){
				proImgId_=ds.getString("proImgId_");
			}else{
				 proImgId_ = UUID.randomUUID().toString();
			}
			ds.edit();
			ds.setField("proImgId_", proImgId_);
			ds.post();
			
			String imgstr[]=headIn.getString("imgUrl").replace("[", "").replace("]", "").toString().split(",");
			
			if(ds.getString("proImgId_")!="" || ds.getString("proImgId_")!=null){
				SqlQuery ds1 = new SqlQuery(this);
				ds1.add("select * from %s where 1=1",appdb.T_IMAGE);
				ds1.add("and relevancelId_ ='%s'",proImgId_);
				ds1.open();
				if(!ds1.eof()){
					ds1.setBatchSave(true);
					for(int i=0;i<imgstr.length;i++){
						if(imgstr[i].length()>80){
							Record r = new Record();
							r.setState(DataSetState.dsEdit);
							ds1.setField("imgPath_", imgstr[i]);
							ds1.setField("updateDate_", TDateTime.Now());
							ds1.setField("updateUser_", this.getUserCode());
							ds1.getRecords().add(r);
						}
					}
					ds1.save();
				}else{
					SqlQuery ds3 = new SqlQuery(this);
					ds3.add("select * from %s where 1=1",appdb.T_IMAGE);
					ds3.open();
					ds3.setBatchSave(true);
					for(int i=0;i<imgstr.length;i++){
						if(imgstr[i].length()>80){
							Record r = new Record();
		                    r.setState(DataSetState.dsInsert);
							r.setField("relevancelId_", proImgId_);
							r.setField("imgPath_", imgstr[i]);
							r.setField("createDate_", TDateTime.Now());
							r.setField("createUser_", this.getUserCode());
							ds3.getRecords().add(r);
						}
					}
					ds3.save();
				}
			}else{
				SqlQuery ds2 = new SqlQuery(this);
				ds2.add("select * from %s where 1=1",appdb.T_IMAGE);
				ds2.open();
				ds2.setBatchSave(true);
				for(int i=0;i<imgstr.length;i++){
					if(imgstr[i].length()>80){
						Record r = new Record();
	                    r.setState(DataSetState.dsInsert);
						r.setField("relevancelId_", proImgId_);
						r.setField("imgPath_", imgstr[i]);
						r.setField("createDate_", TDateTime.Now());
						r.setField("createUser_", this.getUserCode());
						ds2.getRecords().add(r);
					}
				}
				ds2.save();
			}
			
		}
		return true;
	}
		
	//根据主电子条码获取附件信息
	public boolean findCixx() throws DataValidateException{
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("select *,(select count(*) from t_prostate where zhuCode_='%s' and nodeState_=2) num_ from %s where 1=1",head.getString("zhuCode_"),appdb.T_CiNode);
		sql.add(" and zhuCode_='%s'",head.getString("zhuCode_"));
		sql.open();
		if(!sql.eof())
			dataOut.appendDataSet(sql);
		return true;
	}
	
	//根据商品Id判断该主电子条码Id是否此类商品的
	public boolean findzhuCode() throws DataValidateException{
		Record head = dataIn.getHead();
		SqlQuery sql = new SqlQuery(this);
		sql.add("select zhuCode_ from %s where 1=1",appdb.T_ProNode);
		sql.add(" and proId_='%s'",head.getString("proId_"));
		sql.open();
		if(!sql.eof()){
			List<Record> records = sql.getRecords();
			for(Record r:records){
				if(r.getString("zhuCode_").equals(head.getString("zhuCode_"))){
					SqlQuery sql2 = new SqlQuery(this);
					sql2.add("select zhuCode_ from %s where 1=1",appdb.T_ProNode);
					sql2.add(" and zhuCode_='%s'",head.getString("zhuCode_"));
					sql2.open();
					dataOut.appendDataSet(sql2);
				}
				
			}
		}
		return true;
	}
}
