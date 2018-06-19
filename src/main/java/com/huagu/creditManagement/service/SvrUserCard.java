package com.huagu.creditManagement.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * @describe 用户身份证更新
 * @date 2018年3月21日
 * @return
 */
public class SvrUserCard extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		String userCode_ = this.getUserCode();
		if("".equals(userCode_))
			userCode_ = "15071506306";
			
		SqlQuery sql = new SqlQuery(this);
		sql.add("SELECT a.UID_,id_,code_,cardName_,cardId_,zhimaNum_,cardNum_ FROM %s a", appdb.S_Userinfo);
		sql.add("left join %s b on a.code_ = b.userCode_",appdb.BankCardCount);
		sql.add(" where 1=1 ");
		sql.add(" AND code_ = '%s'", userCode_);
		sql.open();
		if("s".equals(headIn.getString("type_"))){
			dataOut.appendDataSet(sql);
		}
		if("i".equals(headIn.getSafeString("type_"))){
			sql.edit();
			sql.setField("cardName_", headIn.getString("name_"));
			sql.setField("cardId_", headIn.getString("certNo_"));
			sql.post();
		}
		if("u".equals(headIn.getSafeString("type_"))){
			sql.edit();
			sql.setField("zhimaNum_", headIn.getString("fraction"));
			sql.post();
		}
		
		return this.success();
	}

}
