package com.huagu.product.services;


import org.apache.log4j.Logger;

import com.huagu.common.global.appdb;
import com.huagu.common.util.Distribution;
import com.huagu.common.util.StringUtils;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrRentWei extends CustomService{
	private static final Logger log = Logger.getLogger(SvrRentWei.class);
	
	
	//查询数码科技的热租
	public boolean queryDigital() throws DataValidateException {
		Record head = this.getDataIn().getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select p.UID_ UID_,fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,twoImgUrl_,proZsImges_,"
				+ "twoState_,twoDel_,p.proName_ proName_,cashPledge_,dayRentMoney_,price_,p.proId_ proId_,discountPrice_,isDiscount_,rentHotPush_,coDel_,nodeState_"
				+ " from t_protype ty left join t_products p on ty.twoNameId_=p.proTypeId_ left join t_prostate ts on p.proId_=ts.proId_");
		ds.add("where fristNameId_='1ffdd2ca-90fa-4fcd-ab04-20aacdd83643'");
		ds.add("and rentHotPush_=%s", 1);
		ds.add("and nodeState_=%s", 1);
		ds.add("and coDel_=%s", 0);
		ds.open();
		if(!ds.eof())
			dataOut.appendDataSet(ds);
			return true;
		
	}

	//查询奢侈酷玩的热租
	public boolean queryCool() throws DataValidateException {
		Record head = this.getDataIn().getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select p.UID_ UID_,fristName_,fristNameId_,fristState_,fristDel_,twoName_,twoNameId_,twoImgUrl_,proZsImges_,"
				+ "twoState_,twoDel_,proName_,cashPledge_,dayRentMoney_,price_,proId_,discountPrice_,isDiscount_,rentHotPush_"
				+ " from t_protype ty left join t_products p on ty.twoNameId_=p.proTypeId_");
		ds.add("where fristNameId_='13dacbc3-5b45-488e-8508-9d977dcec9e8'");
		ds.add("and rentHotPush_=%s", 1);
		ds.open();
		if(!ds.eof())
			dataOut.appendDataSet(ds);
			return true;
		
	}
	
	//根据一级分类查询二级的商品信息
	public boolean queryByFristNameId() throws DataValidateException {
		Record head = this.getDataIn().getHead();
		SqlQuery ds = new SqlQuery(this);
		String fristNameId_=head.getString("fristNameId_");
		String twoNameId_=head.getString("twoNameId_");
		ds.add("select p.UID_ UID_,p.proName_,s.zhuCode_ zhuCode_,p.dayRentMoney_,p.price_,p.discountPrice_,p.proId_,p.cashPledge_,p.isDiscount_,");
		ds.add("t.twoImgUrl_,t.fristName_,t.fristNameId_,t.fristState_,t.fristDel_,t.twoName_,t.twoNameId_,proZsImges_,");
        ds.add("pb.boxId_,c.communityName_,c.communityNum_ from %s s",appdb.T_ProState);
        ds.add("left join %s p on s.proId_ = p.proId_",appdb.T_Products);
        ds.add("left join %s t on t.twoNameId_ = p.proTypeId_",appdb.T_Protype);
        ds.add("left join %s pb on pb.zhuCode_ = s.zhuCode_",appdb.t_pronode_box);
        ds.add("left join %s c on c.id_ = pb.cabId_",appdb.CABINET);
        ds.add("where (p.proState_=0 or p.proState_=2) and t.twoDel_=0 and s.nodeState_=1");
		if(fristNameId_!=""&&fristNameId_!=null){
			ds.add("and t.fristNameId_='%s'",head.getString("fristNameId_"));
		}
		if(twoNameId_!=""&&twoNameId_!=null){
			ds.add("and t.twoNameId_='%s'",head.getString("twoNameId_"));
		}
		String sortType ="desc" ;
		String sort ="p.createDate_" ;
		if(head.hasValue("sort")) {
		    sort=head.getString("sort");
		    if("p.price_".equals(sort)) {
		        sortType="asc"; 
		    }
		}
		ds.add("order by %s %s",sort,sortType);
		ds.open();
		if(!ds.eof())
			dataOut.appendDataSet(ds);
			return true;
		
	}
	
	//搜索租赁商品
	public IStatus searchProduct(DataSet dataIn, DataSet dataOut) {
	    Record headIn = dataIn.getHead();
	    SqlQuery dsProduct = new SqlQuery(this);
	    String searchText = headIn.getString("searchText");
	    dsProduct.add("select p.proName_,p.dayRentMoney_,p.discountPrice_,p.proId_,p.cashPledge_,p.isDiscount_,p.proZsImges_,s.zhuCode_,");
	    dsProduct.add("t.twoImgUrl_,pb.boxId_,c.communityName_,c.communityNum_ from %s s",appdb.T_ProState);
	    dsProduct.add("left join %s p on s.proId_ = p.proId_",appdb.T_Products);
	    dsProduct.add("left join %s t on t.twoNameId_ = p.proTypeId_",appdb.T_Protype);
	    dsProduct.add("left join %s pb on pb.zhuCode_ = s.zhuCode_",appdb.t_pronode_box);
	    dsProduct.add("left join %s c on c.id_ = pb.cabId_",appdb.CABINET);
	    dsProduct.add("where (p.proState_=0 or p.proState_=2) and t.twoDel_=0 and s.nodeState_=1");
	    if(searchText != null && searchText != "") {
	        dsProduct.add("and p.proName_ like '%%%s%%'", headIn.getString("searchText"));
	    }else {
	        dsProduct.add("and p.proName_='%s'", headIn.getString("searchText"));
	    }
	    dsProduct.add("group by p.proName_");
	    dsProduct.open();
	    if(!dsProduct.eof()){
	        dataOut.appendDataSet(dsProduct);
	    }
	    return this.success();
	}
	
	//搜索售卖商品
	public IStatus searchSaleProduct(DataSet dataIn, DataSet dataOut) {
	    Record headIn = dataIn.getHead();
	    SqlQuery dsProduct = new SqlQuery(this);
	    String searchText = headIn.getString("searchText");
	    dsProduct.add("select s.jinPrice_,s.salePrice_,s.offerPrice_,s.offerCount_,s.saleMemPrice_,s.proNumber_,s.barCode_,s.saleHomeAgency_,s.saleSupply_,p.proName_,p.proState_,");
	    dsProduct.add("p.proZsImges_,p.isDel_,s.UID_,s.ruKuId_ from %s s",appdb.T_Storage);
	    dsProduct.add("left join %s p on s.proId_ = p.proId_",appdb.T_Products);
//	    dsProduct.add("left join %s t on t.twoNameId_ = p.proTypeId_",appdb.T_Protype);
	    dsProduct.add("where (p.proState_=1 or p.proState_=2) and p.isDel_=0");
	    if(searchText != null && searchText != "") {
	        dsProduct.add("and p.proName_ like '%%%s%%'", headIn.getString("searchText"));
	    }else {
	        dsProduct.add("and p.proName_='%s'", headIn.getString("searchText"));
	    }
	    dsProduct.open();
	    if(!dsProduct.eof()){
	        dataOut.appendDataSet(dsProduct);
	    }
	    return this.success();
	}
	
	//搜索附近
	public IStatus searchNear(DataSet dataIn, DataSet dataOut) throws DataValidateException {
	    Record headIn = dataIn.getHead();
	    DataValidateException.stopRun("传入当前经度", !headIn.hasValue("curlongitude"));
        DataValidateException.stopRun("传入当前纬度", !headIn.hasValue("curlatitude"));
        double curlongitude = headIn.getDouble("curlongitude");
        double curlatitude = headIn.getDouble("curlatitude");
	    SqlQuery dsProduct = new SqlQuery(this);
	    dsProduct.add("select p.proName_,p.dayRentMoney_,p.discountPrice_,p.proId_,p.cashPledge_,p.isDiscount_,p.proZsImges_,pb.zhuCode_,");
	    dsProduct.add("t.twoImgUrl_,pb.boxId_,c.id_,c.communityName_,c.communityNum_,c.x_,c.y_,c.address_ from %s c",appdb.CABINET);
	    dsProduct.add("left join %s pb on c.id_ = pb.cabId_",appdb.t_pronode_box);
	    dsProduct.add("left join %s s on pb.zhuCode_ = s.zhuCode_",appdb.T_ProState);
	    dsProduct.add("left join %s p on s.proId_ = p.proId_",appdb.T_Products);
	    dsProduct.add("left join %s t on t.twoNameId_ = p.proTypeId_",appdb.T_Protype);
	    dsProduct.add("where c.status_=1 and pb.status_ = 1 and s.nodeState_=1");
	    dsProduct.add("and s.coDel_=0 and (p.proState_=0 or p.proState_=2)");
	    dsProduct.open();
	    while(dsProduct.fetch()) {
	        double longitude = dsProduct.getDouble("x_");
            double latitude = dsProduct.getDouble("y_");
            if (StringUtils.isEmpty(longitude+"") || StringUtils.isEmpty(latitude+"")) {
                continue ;
            }
            
            double cabinetSearchDistance = Double.parseDouble(new ServerConfig().getProperty("cabinet.searchDistance", "1000")+"");
            
            Distribution start = new Distribution();
            start.setLongitude(curlongitude);
            start.setDimensionality(curlatitude);
            Distribution end = new Distribution();
            end.setLongitude(longitude);
            end.setDimensionality(latitude);
            double distance = new Distribution().getDistance(start, end);
            
            if (distance > cabinetSearchDistance) {
                continue ;
            }
            Record record = dsProduct.getCurrent();
            record.setField("distance", distance);
            dataOut.append();
            dataOut.copyRecord(record);
	    }
	    return this.success();
	}
	
	//查询热租分类
    public boolean getCoolType() throws DataValidateException {
        SqlQuery ds = new SqlQuery(this);
        ds.add("select p.proName_,p.dayRentMoney_,p.discountPrice_,p.proId_,p.cashPledge_,p.isDiscount_,");
        ds.add("t.fristName_,t.fristNameId_,COUNT(n.zhuCode_) as productCount from %s p",appdb.T_Products);
        ds.add("left join %s t on t.twoNameId_ = p.proTypeId_",appdb.T_Protype);
        ds.add("left join %s s on s.proId_ = p.proId_",appdb.T_ProState);
        ds.add("LEFT JOIN %s n on p.proId_ = n.proId_",appdb.T_ProNode);
        ds.add("where (p.proState_=0 or p.proState_=2) and p.rentHotPush_=1");
        ds.add("and p.isDel_=0 and t.fristState_=0 and t.fristDel_=0 and s.nodeState_=1");
        ds.add("group by t.fristNameId_");
        ds.add("HAVING COUNT(n.zhuCode_) >0 "); //商品ID 统计商品总数 
        ds.open();
        if(!ds.eof()) {
            dataOut.appendDataSet(ds);
        }
        return true;
        
    }
    //查询热租商品
    public boolean getCools() throws DataValidateException {
        SqlQuery dsType = new SqlQuery(this);
        dsType.add("select p.proName_,p.dayRentMoney_,p.discountPrice_,p.proId_,p.cashPledge_,p.isDiscount_,");
        dsType.add("t.fristName_,t.fristNameId_,COUNT(n.zhuCode_) as productCount from %s p",appdb.T_Products);
        dsType.add("left join %s t on t.twoNameId_ = p.proTypeId_",appdb.T_Protype);
        dsType.add("left join %s s on s.proId_ = p.proId_",appdb.T_ProState);
        dsType.add("LEFT JOIN %s n on s.proId_ = n.proId_",appdb.T_ProNode);
        dsType.add("where (p.proState_=0 or p.proState_=2) and p.rentHotPush_=1");
        dsType.add("and p.isDel_=0 and t.fristState_=0 and t.fristDel_=0 and s.nodeState_=1");
        dsType.add("group by t.fristNameId_");
        dsType.add("HAVING COUNT(n.zhuCode_) >0 "); //商品ID 统计商品总数 
        dsType.open();
        while(dsType.fetch()) {
            SqlQuery ds = new SqlQuery(this);
            ds.add("select p.proName_,p.dayRentMoney_,p.discountPrice_,p.proId_,p.cashPledge_,p.isDiscount_,p.proZsImges_,s.zhuCode_,");
            ds.add("t.fristName_,t.fristNameId_,t.twoImgUrl_,pb.boxId_,c.communityName_,c.communityNum_,c.address_,COUNT(n.zhuCode_) as productCount from %s s",appdb.T_ProState);
            ds.add("left join %s p on p.proId_ = s.proId_",appdb.T_Products);
            ds.add("left join %s t on t.twoNameId_ = p.proTypeId_",appdb.T_Protype);
            ds.add("left join %s pb on pb.zhuCode_ = s.zhuCode_",appdb.t_pronode_box);
            ds.add("left join %s c on c.id_ = pb.cabId_",appdb.CABINET);
            ds.add("LEFT JOIN %s n on s.proId_ = n.proId_",appdb.T_ProNode);
            ds.add("where (p.proState_=0 or p.proState_=2) and p.rentHotPush_=1");
            ds.add("and p.isDel_=0 and t.fristState_=0 and t.fristDel_=0 and s.nodeState_=1");
            ds.add("and t.fristNameId_='%s'",dsType.getString("fristNameId_"));
            ds.add("group by p.proId_ ");
            dsType.add("HAVING COUNT(n.zhuCode_) >0 "); //商品ID 统计商品总数 
            ds.setMaximum(2);
            ds.open();
            if(!ds.eof()) {
                dataOut.appendDataSet(ds);
            }
        }
        return true;
        
    }
    //查询首页公告
    public boolean getMessages() throws DataValidateException {
        SqlQuery ds = new SqlQuery(this);
        ds.add("select id_,title_,content_,type_,date_ from %s",appdb.T_Article);
        ds.add("where type_='18'");
        ds.add("order by date_ desc");
        ds.setMaximum(1);
        ds.open();
        if(!ds.eof()) {
            dataOut.appendDataSet(ds);
        }
        return true;
    }
}
