package com.huagu.control.service;

import com.huagu.common.global.appdb;
import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 查询单个箱子信息接口
 * 
 * @author xiaofei-pc
 *
 */
public class SvrGetControlHome extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		
		SqlQuery cabinetImgList = new SqlQuery(this);
		cabinetImgList.add("select c.UID_ UID_,c.id_ id_,c.carouselId_,img.imgPath_ imgPath_ from %s c JOIN %s img ON c.carouselId_ = img.relevancelId_ ",
				appdb.Cabinet, appdb.T_IMAGE);
		cabinetImgList.add(" WHERE 1=1");
		cabinetImgList.add(" AND c.id_ = '%s'", headIn.getSafeString("cobId_"));
		cabinetImgList.open();
		if (!cabinetImgList.eof()) {
			dataOut.appendDataSet(cabinetImgList);
		}

		return success();
	}

}
