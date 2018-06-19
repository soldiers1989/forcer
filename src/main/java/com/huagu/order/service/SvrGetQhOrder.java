package com.huagu.order.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 取物单所有信息
 * @author xiaofei-pc
 *
 */
public class SvrGetQhOrder extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		sql.add("SELECT UID_, DATE_FORMAT(createTime_,'%s') as createTime_ ,id_,userCode_,orderId_,goodName_,zhuCode_,pzhuCode_,sqName_,cabinetName_,boxNo_, case isClosed_ when 2 then '否' when 1 then '是' end isClosed_ FROM %s", "%Y-%m-%d %H:%m:%s",appdb.QHORDER);
		sql.add(" where 1 = 1");
		if("up".equals(head.getString("type_"))){
			sql.add(" and ycNo_ = '%s'", head.getSafeString("ycNo_"));
			sql.open();
			sql.edit();
			sql.setField("clTime_", TDateTime.Now());
			sql.setField("markStatus_", "1");
			sql.setField("dealer", this.getUserCode());
			sql.post();
		}else if("add".equals(head.getString("type_"))){
			sql.setMaximum(0);
			sql.open();
			sql.append();
			sql.setField("createDate_", TDateTime.Now());
			sql.setField("ycNo_", head.getSafeString("ycNo_"));
			sql.setField("source_", head.getSafeString("source_"));
			sql.setField("orderId_", head.getSafeString("orderId_"));
			sql.setField("ycStatus_", head.getSafeString("orderStatus"));
			sql.setField("ycResult", head.getSafeString("result"));
			sql.setField("ycTime_", TDateTime.Now());
			sql.setField("markStatus_", "0");
			sql.post();
		}else {
			if(head.hasValue("goods_"))
				sql.add("and goodName_ like '%s'", "%"+ head.getString("goods_")+"%");
			if(head.hasValue("sqName_"))
				sql.add("and sqName_ like '%s'", "%"+head.getString("sqName_")+"%");
			if(head.hasValue("cabinetName_"))
				sql.add("and cabinetName_ like '%s'", "%"+head.getString("cabinetName_")+"%");
			if(head.hasValue("orderId_"))
				sql.add("and orderId_ like '%s'", "%"+head.getString("orderId_")+"%");
			if(head.hasValue("zhuCode_"))
				sql.add("and zhuCode_ like '%s'", "%"+head.getString("zhuCode_")+"%");
			if(head.hasValue("userCode_"))
				sql.add("and userCode_ like '%s'", "%"+head.getString("userCode_")+"%");
			sql.add(" ORDER BY createTime_ DESC");
			sql.open();
			if(!sql.eof())
				dataOut.appendDataSet(sql);
		}
		return this.success();
	}

}
