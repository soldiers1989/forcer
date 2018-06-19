package com.huagu.admin.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 查询消息列表信息
 * 
 * @author xiaofei-pc
 *
 */
public class SvrMassageList extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();

		SqlQuery ds = new SqlQuery(this);
		ds.add("SELECT UID_,createDate_,title_,message_,");
		ds.add(" IF(type_=1,'系统公告',IF(type_= 2,'推荐消息',IF(type_= 3,'互动消息',IF(type_ = 4,'圈子消息',IF(type_=5,'派单消息',IF(type_=6,'客户消息','订单完成消息')))))) type_,");
		ds.add(" IF(belong_='customer','用户端',IF(belong_='master','师傅端','未知模块消息')) belong_,");
		ds.add(" IF(status_=0,'未读',IF(status_=1,'已读','未知')) status_,userCode_ FROM %s ", appdb.T_MESSAGE);
		ds.add(" where 1 = 1");
		if (headIn.getString("name_").length() == 11) {
			ds.add(" and userCode_ = '%s'", dataIn.getHead().getString("name_"));
		} else {
			if (headIn.hasValue("name_"))
				ds.add(" and name_ = '%s'", dataIn.getHead().getString("name_"));
		}
		if (headIn.hasValue("type_") && this.getTypeNum(dataIn.getHead().getString("type_")) != null) {
			ds.add(" and type_ = '%s'", this.getTypeNum(dataIn.getHead().getString("type_")));
		}
		if (headIn.hasValue("startTime_") && headIn.hasValue("endTime_")) {
			ds.add(" and createDate_  between '%s' and '%s'", headIn.getDateTime("startTime_"),
					headIn.getDateTime("endTime_"));
		} else if (headIn.hasValue("startTime_")) {
			ds.add(" and createDate_  >= '%s'", headIn.getDateTime("startTime_"));
		} else if (headIn.hasValue("endTime_")) {
			ds.add(" and createDate_  <= '%s'", headIn.getDateTime("endTime_"));
		}
		ds.add(" order by createDate_ DESC ");
		ds.open();
		if (!ds.eof()) {
			dataOut.appendDataSet(ds);
		}
		return success();
	}

	public String getTypeNum(String type_) {
		String typeInfo = null;

		switch (type_) {
		case "系统公告":
			typeInfo = "1";
			break;
		case "推荐消息":
			typeInfo = "2";
			break;
		case "互动消息":
			typeInfo = "3";
			break;
		case "圈子消息":
			typeInfo = "4";
			break;
		case "派单消息":
			typeInfo = "5";
			break;
		case "客户消息":
			typeInfo = "6";
			break;
		case "订单完成消息":
			typeInfo = "7";
			break;
		default:
			System.out.println("default");
			break;
		}
		return typeInfo;
	}

}
