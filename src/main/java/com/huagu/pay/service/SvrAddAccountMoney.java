package com.huagu.pay.service;

import com.huagu.common.global.appdb;
import com.huagu.myWallet.forms.FrmAdjust;
import com.huagu.pay.enums.accountdb;
import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.mysql.Transaction;

/**
 * @ClassName: SvrAddAccountMoney
 * @Description: 添加平台账户交易记录并追加商户余额
 * @author lxf
 * @date 2018年4月2日 9:44:22
 * 
 */
public class SvrAddAccountMoney extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record head = dataIn.getHead();
		try (Transaction tx = new Transaction(this)) {
			SqlQuery sql = new SqlQuery(this);
			// 调出账户减钱
			sql.add("SELECT UID_,id_,name_,balance_,type_,desc_ FROM %s", appdb.FUNDSACCOUNT);
			sql.add(" where id_ = '%s'", head.getString("czong_"));
			sql.open();

			// 添加/减少平台账户余额
			SqlQuery addZong = new SqlQuery(this);
			addZong.add("SELECT UID_,id_,name_,balance_,type_,desc_ FROM %s", appdb.FUNDSACCOUNT);
			addZong.add(" where id_ = '%s'", accountdb.ZONGE);
			addZong.open();

			// 添加/减少平台用户可用账户余额
			SqlQuery addUser = new SqlQuery(this);
			addUser.add("SELECT UID_,id_,name_,balance_,type_,desc_ FROM %s", appdb.FUNDSACCOUNT);
			addUser.add(" where id_ = '%s'", accountdb.KEYONG);
			addUser.open();

			if ("wi".equals(head.getString("type_"))) {
				if (!sql.eof()) {
					Double qamount_ = sql.getDouble("balance_");
					Double hamount_ = qamount_ + head.getDouble("totalFee");
					sql.edit();
					sql.setField("balance_", hamount_);
					sql.post();
					try {
						FrmAdjust.addRecordLog(handle, head.getDouble("totalFee"), "收入", qamount_, hamount_,
								head.getString("czong_"), head.getSafeString("userCode") + "提现");
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				if (!addZong.eof()) {
					Double qamount_ = addZong.getDouble("balance_");
					Double hamount_ = qamount_ - head.getDouble("totalFee");
					addZong.edit();
					addZong.setField("balance_", hamount_);
					addZong.post();
					try {
						FrmAdjust.addRecordLog(handle, head.getDouble("totalFee"), "支出", qamount_, hamount_,
								accountdb.ZONGE, head.getSafeString("userCode") + "提现");
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				if (!addUser.eof()) {
					Double qamount_ = addUser.getDouble("balance_");
					Double hamount_ = qamount_ - head.getDouble("totalFee");
					addUser.edit();
					addUser.setField("balance_", hamount_);
					addUser.post();
					try {
						FrmAdjust.addRecordLog(handle, head.getDouble("totalFee"), "支出", qamount_, hamount_,
								accountdb.KEYONG, head.getSafeString("userCode") + "提现");
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			} else {
				if (!sql.eof()) {
					Double qamount_ = sql.getDouble("balance_");
					Double hamount_ = qamount_ + head.getDouble("totalFee");
					sql.edit();
					sql.setField("balance_", hamount_);
					sql.post();
					try {
						FrmAdjust.addRecordLog(handle, head.getDouble("totalFee"), "收入", qamount_, hamount_,
								head.getString("czong_"), head.getSafeString("userCode") + "充值");
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				if (!addZong.eof()) {
					Double qamount_ = addZong.getDouble("balance_");
					Double hamount_ = qamount_ + head.getDouble("totalFee");
					addZong.edit();
					addZong.setField("balance_", hamount_);
					addZong.post();
					try {
						FrmAdjust.addRecordLog(handle, head.getDouble("totalFee"), "收入", qamount_, hamount_,
								 accountdb.ZONGE, head.getSafeString("userCode") + "充值");
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				if (!addUser.eof()) {
					Double qamount_ = addUser.getDouble("balance_");
					Double hamount_ = qamount_ + head.getDouble("totalFee");
					addUser.edit();
					addUser.setField("balance_", hamount_);
					addUser.post();
					try {
						FrmAdjust.addRecordLog(handle, head.getDouble("totalFee"), "收入", qamount_, hamount_,
								 accountdb.KEYONG, head.getSafeString("userCode") + "充值");
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
			tx.commit();
		}

		return success();
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}

}
