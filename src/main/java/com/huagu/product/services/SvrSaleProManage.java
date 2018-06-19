package com.huagu.product.services;

import java.util.List;

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
import groovy.sql.Sql;

public class SvrSaleProManage  extends CustomService{
	private static final Logger log = Logger.getLogger(SvrSaleProManage.class);
	
	
	/**
	 * 查询售卖物品列表明细
	 * @Title: querySaleProList 
	 * @Description: TODO 
	 * @author 乔晨光
	 * @param @return
	 * @param @throws DataValidateException    
	 * @return boolean
	 */
	public boolean querySaleProList() throws DataValidateException{
		DataSet dd = new DataSet();
		Record head = this.getDataIn().getHead();
		String proId = head.getString("proId_");
		SqlQuery query = new SqlQuery(this);
/*		query.add("select p.UID_,p.proId_,p.createDate_,p.proState_,proName_,ty.twoName_,ty.fristName_,s.salePrice_,s.saleMemPrice_,s.barCode_,"
				 + "(select count(a.saleHomeAgency_) from (select UID_,saleHomeAgency_ from t_storage where proId_='%s' GROUP BY saleHomeAgency_) a) agencyCount,"
				+ "(select count(b.saleSupply_) from (select UID_,saleSupply_ from t_storage where proId_='%s' GROUP BY saleSupply_) b) supplyCount " 
				+ "from t_products p left join t_storage s on p.proId_=s.proId_ left join t_protype ty on p.proTypeId_=ty.twoNameId_ where isDel_='0'",proId,proId);*/
//		query.add("and proState_='1'");
		
		query.add("select p.UID_,p.proId_,p.createDate_,p.proState_,proName_,ty.twoName_,ty.fristName_,s.salePrice_,s.saleMemPrice_,s.barCode_,s.proNumber_,");
        query.add("(select count(a.saleHomeAgency_) from (select UID_,saleHomeAgency_ from %s where proId_='%s' GROUP BY saleHomeAgency_) a) agencyCount," ,appdb.T_Storage,proId);
        query.add("(select count(b.saleSupply_) from (select UID_,saleSupply_ from %s where proId_='%s' GROUP BY saleSupply_) b) supplyCount" ,appdb.T_Storage,proId);
		query.add("from %s p  join t_storage s on p.proId_=s.proId_ left join %s ty on p.proTypeId_=ty.twoNameId_ where isDel_='0'" ,appdb.T_Products ,appdb.T_Protype);
        query.add("group by p.proId_");
		query.add("order by createDate_ desc");
		query.open();
		if(!query.eof()){
			List<Record> records = query.getRecords();
			for(int i=0;i<records.size();i++){
				String proId_ = records.get(i).getString("proId_");
				SqlQuery sqlOrder =new SqlQuery(this);
				sqlOrder.add("select orderId_,proId_ from %s where 1=1",appdb.T_ORDER);
				sqlOrder.add("and proId_='%s'",proId_);
				sqlOrder.open();
				if(!sqlOrder.eof()){
					List<Record> listOrder = sqlOrder.getRecords();
					for(int j=0;j<listOrder.size();j++){
						String orderId_ = listOrder.get(j).getString("orderId_");
						SqlQuery sql =new SqlQuery(this);
						String proName_=head.getString("proName_");
						String fristNameId_=head.getString("fristNameId_");
						String twoNameId_=head.getString("twoNameId_");
						sql.add("select p.proName_,s.salePrice_,s.saleMemPrice_,s.barCode_,p.proId_,ty.twoName_,ty.fristName_,p.UID_,p.proState_,p.createDate_,"
								+ "(select count(a.saleHomeAgency_) from (select UID_,saleHomeAgency_ from t_storage where proId_='%s' GROUP BY saleHomeAgency_) a) agencyCount,"
								+ "(select count(b.saleSupply_) from (select UID_,saleSupply_ from t_storage where proId_='%s' GROUP BY saleSupply_) b) supplyCount,"
								+ "(select count(orderId_) from t_order where proId_='%s') saleCount_,"
								+ "(select sumMoney_ from t_order where orderId_='%s') sumMoney_,"
								+ "(select count(orderId_) from t_order where proId_='%s')*(select sumMoney_ from t_order where orderId_='%s') money_,ruKuCount_,"
								+ "jinPrice_*ruKuCount_ as jinSumMoney_"
								+ " from %s p left join %s s on s.proId_=p.proId_ left join %s ty on p.proTypeId_=ty.twoNameId_ where 1=1",proId_,proId_,proId_,orderId_,proId_,orderId_,appdb.T_Products,appdb.T_Storage,appdb.T_Protype);
//						sql.add("and p.proState_='1'");
						sql.add("and p.proId_='%s'",proId_);
						sql.add("and p.isDel_='0'");
						if(head.hasValue("proName_")){
							sql.add("and p.proName_ like '%s' ",new String("%"+proName_+"%"));
						}
						if(head.hasValue("fristNameId_")){
							if(!fristNameId_.equals("请选择")){
								sql.add("and ty.fristNameId_ like '%s' ",new String("%"+fristNameId_+"%"));
							}
						}
						if(head.hasValue("twoNameId_")){
							if(!twoNameId_.equals("请选择")){
								sql.add("and ty.twoNameId_ like '%s' ",new String("%"+twoNameId_+"%"));
							}
						}
						sql.add("group by p.proId_");
						sql.add("order by p.createDate_ desc");
						sql.open();
						 if (!sql.eof()) {
							 dd.getRecords().add(sql.getCurrent());					 
						 }
					}
				}else{
					 dd.getRecords().add(records.get(i));	
				 }
			}
			log.info(dd.getRecords());
			dataOut.appendDataSet(dd);
		}
		return true;
	}

	//查询入库单列表
	public boolean queryRKList() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		String proName_=head.getString("proName_");
		String fristNameId_=head.getString("fristNameId_");
		String twoNameId_=head.getString("twoNameId_");
		String saleHomeAgency_=head.getString("saleHomeAgency_");
		String saleSupply_=head.getString("saleSupply_");
		String saleRuKuTime_=head.getString("saleRuKuTime_");
		DataSet dd = new DataSet();
		SqlQuery query = new SqlQuery(this);
		query.add("select UID_,proId_,createDate_,proState_ from %s where isDel_='0'",appdb.T_Products);
//		query.add("and proState_='1'");
		query.add("order by createDate_ desc");
		query.open();
		if(!query.eof()){
			List<Record> records = query.getRecords();
			for(int i=0;i<records.size();i++){
			String proId_ = records.get(i).getString("proId_");
			SqlQuery rkQueryList = new SqlQuery(this);
			rkQueryList.add("select UID_,ruKuId_,proId_ from %s where proId_='%s'",appdb.T_Storage,proId_);
			rkQueryList.open();
				if(!rkQueryList.eof()){
					List<Record> rkList = rkQueryList.getRecords();
					b1:for(int j=0;j<rkList.size();j++){
						String ruKuId_ = rkList.get(j).getString("ruKuId_");
						SqlQuery rkQuery = new SqlQuery(this);
						rkQuery.add("select s.ruKuId_,s.saleHomeAgency_,s.saleSupply_,s.jinPrice_,s.saleRuKuTime_,s.saleServerDeadTime_,"
								+ "ty.twoName_,ty.fristName_,p.proName_,s.chCount_,s.chTime_,s.createDate_,s.ruKuCount_,"
								+ "((select sum(ruKuCount_) from t_storage where proId_='%s')-(select sum(chCount_) from t_storage where proId_='%s')) sumKuCun_"
								+ " from %s s left join %s p on s.proId_=p.proId_ left join %s ty on p.proTypeId_=ty.twoNameId_ where 1=1 ",proId_,proId_,appdb.T_Storage,appdb.T_Products,appdb.T_Protype);
						if(ruKuId_==""||ruKuId_==null){
							continue b1;
						}else{
							rkQuery.add("and s.ruKuId_='%s'",ruKuId_);
						}
						if(head.hasValue("proName_")){
							rkQuery.add("and p.proName_ like '%s' ",new String("%"+proName_+"%"));
						}
						if(head.hasValue("fristNameId_")){
							if(!fristNameId_.equals("请选择")){
								rkQuery.add("and ty.fristNameId_ like '%s' ",new String("%"+fristNameId_+"%"));
							}
						}
						if(head.hasValue("twoNameId_")){
							if(!twoNameId_.equals("请选择")){
								rkQuery.add("and ty.twoNameId_ like '%s' ",new String("%"+twoNameId_+"%"));
							}
						}
						if(head.hasValue("saleSupply_")){
							rkQuery.add("and s.saleSupply_ like '%s' ",new String("%"+saleSupply_+"%"));
						}
						if(head.hasValue("saleHomeAgency_")){
							rkQuery.add("and s.saleHomeAgency_ like '%s' ",new String("%"+saleHomeAgency_+"%"));
						}
						if(head.hasValue("saleRuKuTime_")){
							rkQuery.add("and s.saleRuKuTime_ like '%s'",new String("%"+saleRuKuTime_+"%"));
						}
						rkQuery.add("order by s.createDate_");
						rkQuery.open();
						if(!rkQuery.eof()){
							dd.getRecords().add(rkQuery.getCurrent());		
						}
					}
				}
			
			}
			log.info(dd);
			dataOut.appendDataSet(dd);
		}
	return true;
	}
	
	//查询物品属性上面的售卖和租赁的情况
	public boolean queryProDetail() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		String proId_ = head.getString("proId_");
		SqlQuery ds = new SqlQuery(this);
		ds.add("select proName_,fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,twoState_,p.proId_,"
				+ "(select count(zhuCode_) from t_prostate where nodeState_='3') proRentCount_,"
				+ "(select count(orderId_) from t_order where proId_='%s') proSaleCount_"
				+ " from %s p left join %s ty on ty.twoNameId_=p.proTypeId_ where 1=1",proId_,appdb.T_Products,appdb.T_Protype);
		ds.add("and p.proId_='%s'",proId_);
		ds.open();
		if(!ds.eof()){
			dataOut.appendDataSet(ds);
		}
		return true;
	}
	
	//查询售卖单个商品的物品属性
	public boolean queryById() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		String proId_ = head.getString("proId_");
		SqlQuery ds = new SqlQuery(this);
		ds.add("select * from %s where 1=1",appdb.T_Products);
		ds.add("and proId_='%s'",proId_);
		ds.open();
		if(!ds.eof()){
			SqlQuery ds1 = new SqlQuery(this);
			ds1.add("select P.UID_ UID_,proLaberSum_,p.proId_ proId_,p.isDel_ isDel_,proName_,p.proState_,proColor_,s.offerPrice_,s.offerCount_,s.salePrice_,"
					+ "proImgId_,proDesc_,discountPrice_,proWeight_,proSize_,isDiscount_,saleJiFen_,posTage_,s.saleMemPrice_,s.barCode_,s.ruKuCount_,s.proNumber_,"
					+ "(select count(zhuCode_) from t_prostate where nodeState_='3') proRentCount_,dayRentMoney_,cashPledge_,price_,"
					+ "(select count(orderId_) from t_order where proId_='%s') proSaleCount_,imgPath_,imgDel_,"
					+ "fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,twoState_,"
					+ "twoDel_,scrapTime_,n.proId_ pid from %s s left join %s p on s.proId_=p.proId_ left join %s ty on ty.twoNameId_=p.proTypeId_"
					+ " left join %s n on p.proId_=n.proId_ left join %s i on p.proImgId_=i.relevancelId_"
					,proId_,appdb.T_Storage,appdb.T_Products,appdb.T_Protype,appdb.T_ProNode,appdb.T_IMAGE);
			ds1.add("where 1=1");
			ds1.add("and p.proId_='%s'",head.getString("proId_"));
			ds1.open();
			if(!ds1.eof()){
				dataOut.appendDataSet(ds1);
			}
		}
		return true;
	}
	
	//查询售卖商品的入库情况
	public boolean queryRuKuById() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		String proId_ = head.getString("proId_");
		SqlQuery ds = new SqlQuery(this);
		ds.add("select * from %s where 1=1",appdb.T_Products);
		ds.add("and proId_='%s'",proId_);
		ds.open();
		if(!ds.eof()){
			SqlQuery ds1 = new SqlQuery(this);
			ds1.add("select P.UID_ UID_,proLaberSum_,p.proId_ proId_,p.isDel_ isDel_,proName_,p.proState_,p.proColor_,s.offerPrice_,s.offerCount_,s.salePrice_,"
					+ "p.proImgId_,p.proDesc_,p.discountPrice_,p.proWeight_,p.proSize_,p.isDiscount_,p.saleJiFen_,p.posTage_,s.saleMemPrice_,s.barCode_,s.ruKuCount_,"
					+ "(select count(zhuCode_) from t_prostate where nodeState_='3') proRentCount_,dayRentMoney_,cashPledge_,price_,"
					+ "(select count(orderId_) from t_order where proId_='%s') proSaleCount_,"
					+ "((select sum(ruKuCount_) from t_storage where proId_='%s')-(select sum(chCount_) from t_storage where proId_='%s')) sumKuCun_,"
					+ "fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,twoState_,"
					+ "(select count(UID_) c from t_storage where proId_='%s' and  ISNULL(saleSupply_)) couSupply_,"
					+ "twoDel_ from %s p left join %s ty on ty.twoNameId_=p.proTypeId_"
					+ " left join %s s on p.proId_=s.proId_"
					,proId_,proId_,proId_,proId_,appdb.T_Products,appdb.T_Protype,appdb.T_Storage);
			ds1.add("where 1=1");
			ds1.add("and p.proId_='%s'",head.getString("proId_"));
			ds1.open();
			if(!ds1.eof()){
				dataOut.appendDataSet(ds1);
			}
		}
		return true;
		
	}
	
	//查询售卖商品的入库情况
	public boolean queryRuKuByRKId() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		String ruKuId_ = head.getString("ruKuId_");
		SqlQuery ds = new SqlQuery(this);
		ds.add("select proId_ from %s where 1=1",appdb.T_Storage);
		ds.add("and ruKuId_='%s'",ruKuId_);
		ds.open();
		if(!ds.eof()){
			String proId_ = ds.getCurrent().getString("proId_");
			SqlQuery queryRK = new SqlQuery(this);
			queryRK.add("select s.proId_,s.ruKuId_,s.saleHomeAgency_,s.saleSupply_,s.ruKuCount_,s.chCount_,p.proName_,"
					+ "(select count(UID_) from t_storage where saleSupply_=(select saleSupply_ from t_storage where ruKuId_='%s') and proId_='%s') supplyKuCunSum_,"
					+ "((select sum(ruKuCount_) from t_storage where proId_='%s')-(select sum(chCount_) from t_storage where proId_='%s')) sumKuCun_,"
					+ "(select count(zhuCode_) from t_prostate where nodeState_='3') proRentCount_,"
					+ "(select count(orderId_) from t_order where proId_='%s') proSaleCount_,"
					+ "fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,twoState_"
					+ " from %s s left join %s p on s.proId_=p.proId_ left join %s ty on ty.twoNameId_=p.proTypeId_ where 1=1"
					,ruKuId_,proId_,proId_,proId_,proId_,appdb.T_Storage,appdb.T_Products,appdb.T_Protype);
			queryRK.add("and s.ruKuId_='%s'",ruKuId_);
			queryRK.open();
			if(!queryRK.eof()){
				dataOut.appendDataSet(queryRK);
			}
		}
		return true;
	}

	//售卖商品的冲红插入
	public boolean toCHong() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		String ruKuId_ = head.getString("ruKuId_");
		String chCount_ = head.getString("chCount_");
		SqlQuery ds = new SqlQuery(this);
		ds.add("select UID_,ruKuId_,chCount_,chTime_ from %s where 1=1",appdb.T_Storage);
		ds.add("and ruKuId_='%s'",ruKuId_);
		ds.open();
		if(!ds.eof()){
			ds.edit();
			ds.setField("chCount_", chCount_);
			ds.setField("chTime_", TDateTime.Now());
			ds.post();
		}
		return true;
	}
	
	//添加售卖商品的物品属性
	public boolean insertSaleProAttr() throws DataValidateException{
		Record head = this.getDataIn().getHead();
//        DataValidateException.stopRun("商品原租赁价不允许小于0！", head.getDouble("dayRentMoney_")<0);
//        DataValidateException.stopRun("押金不允许小于0！", head.getDouble("cashPledge_")<0);
		SqlQuery ds = new SqlQuery(this);
		ds.add("select * from %s where 1=1",appdb.T_Products);
		ds.add("and proId_='%s'",head.getString("proId_"));
		ds.open();
		if(!ds.eof()){
			ds.edit();
			ds.setField("proColor_",head.getString("proColor_"));
			ds.setField("proDesc_",head.getString("proDesc_"));
			ds.setField("posTage_",head.getString("posTage_"));
			ds.setField("saleJiFen_",head.getString("saleJiFen_"));
			ds.post();
			SqlQuery insetAttr = new SqlQuery(this);
			insetAttr.add("select * from %s where 1=1",appdb.T_Storage);
			insetAttr.add("and proId_='%s'",head.getString("proId_"));
			insetAttr.open();
			if(!insetAttr.eof()){
				insetAttr.edit();
				insetAttr.setField("salePrice_",head.getDouble("salePrice_"));
				insetAttr.setField("saleMemPrice_",head.getDouble("saleMemPrice_"));
				insetAttr.setField("offerCount_",head.getInt("offerCount_"));
				insetAttr.setField("offerPrice_",head.getDouble("offerPrice_"));
				insetAttr.setField("proNumber_",head.getString("proNumber_"));
				insetAttr.post();
			}else{
				insetAttr.append();
				insetAttr.setField("proId_",head.getString("proId_"));
				insetAttr.setField("salePrice_",head.getDouble("salePrice_"));
				insetAttr.setField("saleMemPrice_",head.getDouble("saleMemPrice_"));
				insetAttr.setField("offerCount_",head.getInt("offerCount_"));
				insetAttr.setField("offerPrice_",head.getDouble("offerPrice_"));
				insetAttr.setField("proNumber_",head.getString("proNumber_"));
				insetAttr.post();
			}
		}
		return true;
		
	}
	
	//售卖商品的入库
	public boolean saleProRuKu() throws DataValidateException{
		Record head = this.getDataIn().getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select * from %s where 1=1",appdb.T_Storage);
//		ds.add("and proId_='%s'",head.getString("proId_"));
		ds.open();
//		if(!ds.eof()){
			ds.append();
			ds.setField("proId_", head.getString("proId_"));
			ds.setField("createUser_", this.getUserCode());
			ds.setField("createDate_", TDateTime.Now());
			ds.setField("saleHomeAgency_",head.getString("saleHomeAgency_"));
			ds.setField("saleSupply_",head.getString("saleSupply_"));
			ds.setField("ruKuId_",head.getString("ruKuId_"));
			ds.setField("jinPrice_",head.getDouble("jinPrice_"));
			ds.setField("ruKuCount_",head.getInt("ruKuCount_"));
			ds.setField("jinSum_",head.getDouble("jinSum_"));
			ds.setField("saleServerDeadTime_",head.getDate("saleServerDeadTime_"));
			ds.setField("saleRuKuTime_",head.getDate("saleRuKuTime_"));
			ds.setField("pici_",head.getString("pici_"));
			ds.post();
//		}
		return true;
	}
	

}
