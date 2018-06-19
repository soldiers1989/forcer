package com.huagu.control.service;

import com.huagu.common.global.appdb;
import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 查询固定柜子下的所有箱子信息
 * @author xiaofei-pc
 *
 */
public class SvrGetControl extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		SqlQuery ds = new SqlQuery(this);
		ds.add("select UID_,createDate_,createUser_,id_,name_,carouselId_,joinUpDate_,joinStatus_,communityName_,communityNum_,address_,desc_,status_ from %s",
				appdb.Cabinet);
		ds.add(" where 1=1");
		ds.add(" and id_ = '%s'", headIn.getSafeString("cobId_"));
		ds.open();
		if(!ds.eof()){
			SqlQuery addBox = new SqlQuery(this);
			addBox.add("SELECT pn.proId_ proId_,o.zhuCode_ zhuCode_,o.beginTime_ beginTime_, o.returnTime_ returnTime_, pd.proName_ proName_,pd.dayRentMoney_ dayRentMoney_,o.sumMoney_ sumMoney_,pd.proZsImges_ proZsImges_ FROM %s b", appdb.BOX);
			addBox.add(" JOIN t_pronode_box p ON b.boxId_ = p.boxId_");
			addBox.add(" JOIN t_pronode pn ON pn.zhuCode_ = p.zhuCode_");
			addBox.add(" JOIN t_products pd ON pd.proId_ = pn.proId_");
			addBox.add(" JOIN t_order o ON o.zhuCode_ = pn.zhuCode_");
			addBox.add(" WHERE b.cabId_ = '%s' AND o.orderState_ = '4'", headIn.getSafeString("cobId_"));
			addBox.open();
			if(!addBox.eof()){
				/*for (int i = 0; i < addBox.getRecords().size(); i++) {
					
				}*/
				dataOut.appendDataSet(addBox);
			}
		}
		
		return success();
	}

}
