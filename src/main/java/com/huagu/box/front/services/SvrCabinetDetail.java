package com.huagu.box.front.services;

import com.huagu.box.front.pojo.Goods;
import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.BuildQuery;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrCabinetDetail extends CustomService{
	//查询柜子里面的物品
	  public boolean CabinetDetail() {
		  	Record headIn = getDataIn().getHead();
		  	String cabinetId = headIn.getString("cabinetId");
		  	 String searchText = headIn.getString("searchText");
	        SqlQuery ds = new SqlQuery(this);  
            ds.add("select b.boxId_,pro.proId_ proId_,proZsImges_ as proImage_,pro.proName_,pro.dayRentMoney_,pro.cashPledge_,pb.zhuCode_,pro.discountPrice_,isDiscount_");
            ds.add("from %s b inner join %s pb on b.boxId_=pb.boxId_ inner join %s pn on pb.zhuCode_=pn.zhuCode_ inner join %s pro on pn.proId_=pro.proId_", appdb.BOX, appdb.PRONODEBOX, appdb.T_ProNode, appdb.T_Products);
            ds.add("where b.cabId_ = '%s'",cabinetId);
            ds.add(" and pro.proName_ like '%s'","%"+searchText+"%");
            ds.open();
            dataOut.appendDataSet(ds);
		return true;
	  }
}
