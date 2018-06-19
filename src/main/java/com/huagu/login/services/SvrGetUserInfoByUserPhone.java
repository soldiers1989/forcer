package com.huagu.login.services;

import static cn.cerc.jdb.other.utils.newGuid;

import java.util.Date;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jbean.other.SystemTable;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlOperator;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 登录验证
 * 
 * @author xiaofei-pc
 *
 */
public class SvrGetUserInfoByUserPhone extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		SqlQuery ds = new SqlQuery(this);
		SqlQuery getUserInfo = new SqlQuery(this);
		String userCode_ = dataIn.getHead().getString("mobile");
		/**
		 * 727000 用户端 727111 运维端
		 */
		String CorpNo_ = dataIn.getHead().getString("CorpNo_");

		// 如果是运维端登录查询是否被绑定为运维人员
		if ("727111".equals(CorpNo_)) {
			ds.add("select * from %s where code_='%s'", SystemTable.get(SystemTable.getUserInfo),
					dataIn.getHead().getString("mobile"));
			
			ds.add(" and binding = '2'");
			ds.open();
			dataOut.appendDataSet(ds);
		}
		// 查询用户是否存在
		if ("727000".equals(CorpNo_)) {
			ds.add("select * from %s where code_='%s'", SystemTable.get(SystemTable.getUserInfo),
					dataIn.getHead().getString("mobile"));

			ds.open();
			if (ds.eof()) {
				// 如果查询不到值,就执行注册的方法,注册完再查询
				System.err.println("没有查询到用户，我要先注册一遍");
				this.register(userCode_, CorpNo_);
				getUserInfo.add("select * from %s where code_='%s'", SystemTable.get(SystemTable.getUserInfo),
						userCode_);
				getUserInfo.open();
			}
			dataOut.appendDataSet(getUserInfo);
		}
		return success();
	}

	private String register(String userCode, String corpNo) {
		// 保存用户信息表
		Record record = new Record();
		record.setField("id_", GuidFixStr(newGuid()));
		record.setField("code_", userCode);
		record.setField("name_", "启享"+ userCode.substring(userCode.length()-4, userCode.length()));
		record.setField("corpNo_", corpNo);
		record.setField("roleCode_", 2);
		record.setField("createTime_", new Date());
		record.setField("overMoney_", 0);
		record.setField("mobile_", userCode);
		record.setField("imgUrl_", "http://hg-oss-yf2.oss-cn-beijing.aliyuncs.com/zsf/IMG/ff1bde42-61ea-4864-b6cb-1bb3dfd02790.png");

		SqlOperator operatoer = new SqlOperator(this);
		operatoer.setTableName(SystemTable.get(SystemTable.getUserInfo));
		operatoer.insert(record);

		return record.getString("code_");

	}

	private String GuidFixStr(String guid) {
		String str = guid.substring(1, guid.length() - 1);
		return str.replaceAll("-", "");
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}
}
