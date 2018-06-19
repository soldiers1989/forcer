package com.huagu.maintain.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * @describe 给柜子添加图片
 * @date 2018年3月21日
 * @return
 */
public class SvrCabinetImgAd extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		List<String> cabinetAdImg = new ArrayList<String>();

        String imgPath_ = headIn.getString("cabinetAd");
        imgPath_ = imgPath_.replace("[", "");
        imgPath_ = imgPath_.replace("]", "");
        
		SqlQuery sql = new SqlQuery(this);
		sql.add("SELECT UID_,createDate_,createUser_,relevancelId_,imgPath_,imgDel_ FROM %s", appdb.T_IMAGE);
		sql.add(" where 1=1 ");
		sql.add(" and relevancelId_ = '%s'", headIn.getString("cabinetId_"));
		sql.open();
		if(!sql.eof()){
			sql.delete();
			cabinetAdImg = Arrays.asList(imgPath_.split(","));
		    for (int i = 0; i < cabinetAdImg.size(); i++) {
				sql.append();
				sql.setField("createDate_", TDateTime.Now());
				sql.setField("createUser_", "admin");
				sql.setField("relevancelId_", headIn.getString("cabinetId_"));
				sql.setField("imgPath_", cabinetAdImg.get(i));
			    sql.post();
			}
			
		}else{
			cabinetAdImg = Arrays.asList(imgPath_.split(","));
		    for (int i = 0; i < cabinetAdImg.size(); i++) {
				sql.append();
				sql.setField("createDate_", TDateTime.Now());
				sql.setField("createUser_", "admin");
				sql.setField("relevancelId_", headIn.getString("cabinetId_"));
				sql.setField("imgPath_", cabinetAdImg.get(i));
			    sql.post();
			}
		}
		
		return this.success();
	}

}
