package com.huagu.maintain.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrChangeAdress  extends AbstractService{

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		String userCode = this.getUserCode();
		if ("".equals(userCode)) {
			userCode = "13277031262";
		}
		Record headIn = dataIn.getHead();
		String Jname= headIn.getString("Jname");
		String isShouhuo = headIn.getString("isShouhuo");
		SqlQuery sql = new SqlQuery(this);
		sql.add("SELECT distinct c.id_ id_,c.createDate_ createDate_,c.name_ name_,c.address_ address_,c.communityName_ FROM %s c", appdb.CABINET);
		sql.add(" JOIN %s cm ON c.communityNum_ = cm.communityNum_", appdb.CABINETMANAGER);
		sql.add(" JOIN %s cb on cb.cabId_=c.id_",appdb.BOX);
		sql.add(" join %s tor on tor.boxId_ = cb.boxId_",appdb.ORDERDONATION);
		sql.add(" JOIN %s ct ON ct.communityId_ = cm.communityNum_ WHERE cm.managerId_ = '%s'", appdb.Community, userCode);
		sql.add(" and c.cabinetType_='1'");
		if(isShouhuo != null & isShouhuo.length()>0){
		sql.add(" and tor.shStatus_ ='%s'",isShouhuo);
		}
		if(Jname != null &Jname.length()>0){
		sql.add(" and ct.communityJname_ like '%s'",'%' +Jname + '%');
		}
		sql.open();
		if (!sql.eof())
			dataOut.appendDataSet(sql);
		return this.success();
	}
}
