package com.huagu.product.services;

import org.apache.log4j.Logger;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrWeiPro extends CustomService{
	private static final Logger log = Logger.getLogger(SvrWeiPro.class);
	
	//查询租赁商品详情
	public IStatus queryProDetail(DataSet dataIn, DataSet dataOut) throws DataValidateException{
		Record headIn = dataIn.getHead();
		DataValidateException.stopRun("商品主电子条码不允许为空", !headIn.hasValue("zhuCode_"));
		SqlQuery ds = new SqlQuery(this);
		ds.add("select p.proName_,p.dayRentMoney_,p.discountPrice_,p.proId_,p.cashPledge_,p.isDiscount_,p.proZsImges_,p.proDesc_,");
		ds.add("p.posTage_,p.isDel_,p.proLbImges_,s.zhuCode_,t.twoImgUrl_,pb.boxId_,c.communityName_,c.communityNum_ from %s s",appdb.T_ProState);
		ds.add("left join %s p on s.proId_ = p.proId_",appdb.T_Products);
        ds.add("left join %s t on t.twoNameId_ = p.proTypeId_",appdb.T_Protype);
        ds.add("left join %s pb on pb.zhuCode_ = s.zhuCode_",appdb.t_pronode_box);
        ds.add("left join %s c on c.id_ = pb.cabId_",appdb.CABINET);
        ds.add("where (p.proState_=0 or p.proState_=2) and t.twoDel_=0");
        ds.add("and s.zhuCode_='%s'",headIn.getString("zhuCode_"));
		ds.open();
		if(!ds.eof()) {
		    dataOut.getHead().copyValues(ds.getCurrent());
		}
		return this.success();
	}
	
	//查询售卖商品详情
	public IStatus querySaleProDetail(DataSet dataIn, DataSet dataOut) throws DataValidateException{
		Record headIn = dataIn.getHead();
		DataValidateException.stopRun("商品入库单编号不能为空", !headIn.hasValue("ruKuId_"));
		SqlQuery ds = new SqlQuery(this);
		ds.add("select s.jinPrice_,s.salePrice_,s.offerPrice_,s.offerCount_,s.saleMemPrice_,s.proNumber_,s.barCode_,s.saleHomeAgency_,s.saleSupply_,p.proName_,p.proState_,");
		ds.add("p.posTage_,p.isDel_,p.proLbImges_,s.UID_,s.ruKuId_,s.proId_,p.proZsImges_,p.proDesc_ from %s s",appdb.T_Storage);
		ds.add("left join %s p on s.proId_ = p.proId_",appdb.T_Products);
//        ds.add("left join %s t on t.twoNameId_ = p.proTypeId_",appdb.T_Protype);
        ds.add("where (p.proState_=1 or p.proState_=2) ");
        ds.add("and p.isDel_=0");
        ds.add("and s.ruKuId_='%s'",headIn.getString("ruKuId_"));
		ds.open();
		if(!ds.eof()) {
		    dataOut.getHead().copyValues(ds.getCurrent());
		}
		return this.success();
	}

	//查询商品详情
	public boolean queryImg() throws DataValidateException{
		Record headIn = this.getDataIn().getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select UID_,proImgId_,proId_ from %s where 1=1",appdb.T_Products);
		if(headIn.hasValue("proId_")){
		ds.add(" and proId_='%s'",headIn.getString("proId_"));
		}
		ds.open();
		if(!ds.eof()){
			SqlQuery ds1 = new SqlQuery(this);
			ds1.add("select UID_,relevancelId_,imgPath_ from %s where 1=1",appdb.T_IMAGE);
			ds1.add(" and relevancelId_='%s'",ds.getString("proImgId_"));
			ds1.open();
			if(!ds1.eof()){
				dataOut.appendDataSet(ds1);
			}
		}	
		return true;
	}
	
	//查询商品颜色
	public boolean queryColor() throws DataValidateException{
		Record headIn = this.getDataIn().getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select s.jinPrice_,s.salePrice_,p.proName_, s.UID_,s.saleProColor_,s.proId_,p.proZsImges_,s.ruKuId_,(ruKuCount_-saleCount_-chCount_) leaveCount_ "
				+ "from %s s left join %s p on p.proId_=s.proId_ where 1=1",appdb.T_Storage,appdb.T_Products);
		if(headIn.hasValue("proId_")){
		ds.add(" and p.proId_='%s'",headIn.getString("proId_"));
		}
		ds.open();
		if(!ds.eof()){
			dataOut.appendDataSet(ds);
		}	
		return true;
	}
	
	//查询商品评价详情
		public boolean queryEvaluateDetail() throws DataValidateException{
			Record headIn = this.getDataIn().getHead();
			SqlQuery ds = new SqlQuery(this);
			String evaLevel_ = headIn.getString("evaLevel_");
			ds.add("select e.orderId_ eoid,evaLevel_,evaContent_,evaImgId_,evaState_,e.UserId_ UserId_,e.orderType_ orderType_,p.proId_ proId_,");
	        ds.add("imgPath_,payTime_,proName_");
	        ds.add("from %s e left join %s i on e.evaImgId_=i.relevancelId_ left join %s o on e.orderId_=o.orderId_ ", appdb.T_EVALUATE,appdb.T_IMAGE,appdb.T_ORDER);
	        ds.add("left join %s p on e.proId_=p.proId_ where 1=1",appdb.T_Products);
			if(headIn.hasValue("evaLevel_")){
				 if(evaLevel_.equals("1")){
					ds.add(" and (evaLevel_='5' or evaLevel_='4')");
				}else if(evaLevel_.equals("2")){
					ds.add(" and evaLevel_='3'");
				}else if(evaLevel_.equals("3")){
					ds.add(" and (evaLevel_='1' or evaLevel_='2')");
				}
			}
			ds.add(" and p.proId_='%s'",headIn.getString("proId_"));
			ds.open();
			if(!ds.eof()){
				dataOut.appendDataSet(ds);
			}
			SqlQuery dsNum = new SqlQuery(this);
			dsNum.add("select proId_,(select count(*) from %s where proId_='%s') as sum,",appdb.T_EVALUATE,headIn.getString("proId_"));
			dsNum.add("(select count(*) from %s where proId_='%s' and (evaLevel_=5 or evaLevel_=4)) praise,",appdb.T_EVALUATE,headIn.getString("proId_"));
			dsNum.add("(select count(*) from %s where proId_='%s' and evaLevel_=3) average,",appdb.T_EVALUATE,headIn.getString("proId_"));
			dsNum.add("(select count(*) from %s where proId_='%s' and (evaLevel_=1 or evaLevel_=2)) badReview ",appdb.T_EVALUATE,headIn.getString("proId_"));
			dsNum.add("from %s where proId_='%s'",appdb.T_EVALUATE,headIn.getString("proId_"));
			dsNum.setMaximum(1);
			dsNum.open();
			if(!dsNum.eof()) {
			    dataOut.getHead().copyValues(dsNum.getCurrent());
			}
			return true;
		}
}
