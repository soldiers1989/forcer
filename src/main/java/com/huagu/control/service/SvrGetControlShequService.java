package com.huagu.control.service;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 查询社区服务Service
 * 
 * @author xiaofei-pc
 *
 */
public class SvrGetControlShequService extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		
		SqlQuery ShequService = new SqlQuery(this);
		ShequService.add("SELECT UID_,title_,content_,createDate_ FROM %s", appdb.T_Article);
		ShequService.add(" WHERE 1=1");
		ShequService.add(" and type_ = '19'");
		ShequService.open();
		if (!ShequService.eof()) {
			DataSet shequ = new DataSet();
			for (int i = 0; i < ShequService.size(); i++) {
				shequ.append();
				SqlQuery shang = new SqlQuery(this);
				SqlQuery xia = new SqlQuery(this);
				// 查询上一条
				shang.add("select  UID_,title_,content_,createDate_  from %s", appdb.T_Article);
				shang.add(" where UID_ = (select UID_ from %s where UID_ < %s order by UID_ desc limit 1)", appdb.T_Article, ShequService.getRecords().get(i).getString("UID_"));
				shang.add(" and type_ = '19'");
				shang.open();
				
				// 查询下一条
				xia.add("select  UID_,title_,content_,createDate_  from %s", appdb.T_Article);
				xia.add(" where UID_ = (select UID_ from %s where UID_ > %s order by UID_ asc limit 1)", appdb.T_Article, ShequService.getRecords().get(i).getString("UID_"));
				xia.add(" and type_ = '19'");
				xia.open();
				
				shequ.setField("UID_", ShequService.getRecords().get(i).getString("UID_"));
				shequ.setField("title_", ShequService.getRecords().get(i).getString("title_"));
				shequ.setField("content_", ShequService.getRecords().get(i).getString("content_"));
				shequ.setField("createDate_", ShequService.getRecords().get(i).getString("createDate_"));
				if(!shang.eof()){
					shequ.setField("shang_", shang.getString("title_"));
				}else{
					shequ.setField("shang_", "");
				}
				if(!xia.eof()){
					shequ.setField("xia_",  xia.getString("title_"));
				}else{
					shequ.setField("xia_",  "");
				}
				shang.close();
				xia.close();
			}
			ShequService.close();
			
			dataOut.appendDataSet(shequ);
		}

		return success();
	}

}
