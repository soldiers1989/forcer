package com.huagu.product.services;

import org.apache.jackrabbit.uuid.UUID;
import org.apache.log4j.Logger;

import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

public class SvrHomeAd extends CustomService {
    private static final Logger log = Logger.getLogger(SvrRentWei.class);

    // 添加首页轮播图
    public boolean queryHomeAd() throws DataValidateException {
        // Record head = this.getDataIn().getHead();
        SqlQuery ds = new SqlQuery(this);
        ds.add("select h.UID_,h.imgSrc_ imgSrc_, imgPath_,imgDel_,relevancelId_,imgId_,isDel_,h.createUser_ createUser_,h.createDate_ createDate_, i.imgPath_ imgPath, h.imgSrc_ imgSrc_"
                + " from %s h join %s i on h.imgId_=i.relevancelId_ where 1=1", appdb.T_HomeAdvertise, appdb.T_IMAGE);
        ds.add("and imgDel_=%s", 0);
        ds.add("and isDel_=%s", 0);
        ds.open();
        if (!ds.eof()) {
            dataOut.appendDataSet(ds);
        }
        return true;
    }

    // 添加首页轮播图
    public boolean insertHomeAd() throws DataValidateException {
        Record head = this.getDataIn().getHead();
        String img_ = head.getString("Img_");
        SqlQuery ds = new SqlQuery(this);
        ds.add("select * from %s", appdb.T_HomeAdvertise);
        String imgId_ = UUID.randomUUID().toString();
        ds.open();
        ds.append(); 
        ds.setField("createUser_", this.getUserCode());
        ds.setField("createDate_", TDateTime.Now());
        ds.setField("imgId_", imgId_);
        ds.setField("isDel_", 0);
        ds.post();
        SqlQuery dsImg = new SqlQuery(this);
        dsImg.add("select * from %s", appdb.T_IMAGE);
        dsImg.open();
        dsImg.append();
        dsImg.setField("createUser_", this.getUserCode());
        dsImg.setField("createDate_", TDateTime.Now());
        dsImg.setField("relevancelId_", imgId_);
        dsImg.setField("imgPath_", img_);
        dsImg.setField("imgDel_", 0);
        dsImg.post();
        return true;

    }

    // 添加首页轮播图
    public boolean delHomeAd() throws DataValidateException {
        Record head = this.getDataIn().getHead();
        String imgId_ = head.getString("imgId_");
        SqlQuery ds = new SqlQuery(this);
        ds.add("select * from %s where 1=1", appdb.T_HomeAdvertise);
        ds.add(" and imgId_='%s'", imgId_);
        ds.open();
        if (!ds.eof()) {
            ds.edit();
            ds.setField("createUser_", this.getUserCode());
            ds.setField("createDate_", TDateTime.Now());
            ds.setField("isDel_", 1);
            ds.post();
            SqlQuery dsImg = new SqlQuery(this);
            dsImg.add("select * from %s where 1=1", appdb.T_IMAGE);
            dsImg.add(" and relevancelId_='%s'", imgId_);
            dsImg.open();
            if (!dsImg.eof()) {
                ds.edit();
                ds.setField("createUser_", this.getUserCode());
                ds.setField("createDate_", TDateTime.Now());
                ds.setField("imgId_", 1);
                ds.post();
            }
        }
        return true;
    }

    // 读取视频
    public boolean getHomeAd() throws DataValidateException {
    	Record head = this.getDataIn().getHead();
        SqlQuery ds = new SqlQuery(this);
        ds.add("select * from %s", appdb.T_HomeAdvertise);
        ds.add("where vedioId_ <>''");
        ds.add("and isDel_=%s", 0);
        ds.open();
        if (!ds.eof()) {
            dataOut.appendDataSet(ds);
        }
        return true;
    }
 // 查询单条视频
    public boolean selectAd() throws DataValidateException {
    	Record head = this.getDataIn().getHead();
        SqlQuery ds = new SqlQuery(this);
        ds.add("select UID_, createDate_, createUser_, updateDate_, imgId_, isDel_, vedioId_, imgSrc_ from %s", appdb.T_HomeAdvertise);
        ds.add("where UID_=%s",head.getString("UID_"));
        ds.add("and isDel_=%s", 0);
        ds.open();
        if (!ds.eof()) {
            dataOut.appendDataSet(ds);
        }
        return true;
    }

    // 修改视频
    public boolean upHomeAd() throws DataValidateException {
        Record headIn = this.dataIn.getHead();
        String vedioId_ = headIn.getString("vedioId_");
        String UID_ = headIn.getString("UID_");
        System.out.println("dedao ::::::"+UID_);
        SqlQuery ds = new SqlQuery(this);
        ds.add("select * from %s", appdb.T_HomeAdvertise);
        ds.add("where UID_=%s",UID_);
        ds.add("and isDel_=%s", 0);
        ds.open();
        ds.edit();
        // ds.setField("imgId_", headIn.getString("imgId_"));
        ds.setField("vedioId_", vedioId_);
        ds.post();
        return true;
    }
    //修改链接路径
    public boolean upLunBoAd() throws DataValidateException{ 
		Record headIn =dataIn.getHead(); 
		String UID_ =headIn.getString("UID_"); 
		String imgSrc_= headIn.getString("imgSrc_");
		SqlQuery sql =new SqlQuery(this);
		sql.add("select UID_, imgSrc_ from %s", appdb.T_HomeAdvertise);
		sql.add("where UID_ =%s",headIn.getString("UID_"));
		sql.open();
		sql.edit(); 
		sql.setField("imgSrc_", imgSrc_);
		sql.post();   
		return true;
		 
    }
    //查询单条链接数据
    public boolean selectLunBo() throws DataValidateException{ 
    	 SqlQuery sql =new SqlQuery(this);
 		Record head =dataIn.getHead(); 
 		sql.add("select h.UID_ UID_, imgSrc_,imgDel_,relevancelId_,imgId_,isDel_,h.createUser_ createUser_,h.createDate_ createDate_, i.imgPath_ imgPath"
                + " from %s h join %s i on h.imgId_=i.relevancelId_ where 1=1", appdb.T_HomeAdvertise, appdb.T_IMAGE);
 		sql.add("and h.UID_=%s",head.getString("UID_"));
 		sql.open();
 		if (!sql.eof()) {
            dataOut.appendDataSet(sql);
        } 
        return true;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
