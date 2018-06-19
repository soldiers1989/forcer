package com.huagu.box.manage.services;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
/** 
 *  银行卡认证
 * @author wj  
 * @date 2018年6月4日 
 *
 */
public class SvrBankCards extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery sql = new SqlQuery(this);
		Record head = dataIn.getHead();
		String userName_ = head.getString("userName_");
		String lastDate_ = head.getString("lastDate_");
		String lastMoneyTime_ = head.getString("lastMoneyTime_");
		String status_ = head.getString("status_");
		if(status_.equals("-1")){
			status_ = "";
		}
		sql.add("select createTime_, createUser_,userName_, DATE_FORMAT(lastDate_,'%s') as lastDate_ ,rzTime_,lastBankCard_,bankAccount_ ,bankUserName_ ,account_ ,lastMoney_ , DATE_FORMAT(lastMoneyTime_,'%s') as lastMoneyTime_ ,wrongTime_ ,status_  from %s" ,"%Y-%m-%d %H:%m:%s","%Y-%m-%d %H:%m:%s",appdb.BankCard);
		sql.add("where 1 = 1");
		if(userName_ != null && userName_ != ""){
			sql.add("and userName_ like '%s'" ,new String("%"+userName_+"%"));
		}
		if(lastDate_ != null && lastDate_ != ""){
			sql.add("and lastDate_ like '%s'" ,new String("%"+lastDate_+"%"));
		}
		if(lastMoneyTime_ != null && lastMoneyTime_ != ""){
			sql.add("and lastMoneyTime_ like '%s'" , new String("%"+lastMoneyTime_+"%"));
		}
		if(status_ != null && status_ != ""){
			sql.add("and status_ like '%s'" ,new String("%"+status_+"%"));
		}
		sql.add("order by lastDate_ desc");
		sql.open();
		if(!sql.eof()){
			dataOut.appendDataSet(sql);
		}
		return this.success();
		
	}

}
