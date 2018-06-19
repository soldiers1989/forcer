package com.huagu.box.front.services;

import java.util.Set;

import com.huagu.box.front.pojo.BoxInfo;
import com.huagu.box.front.pojo.Goods;
import com.huagu.common.enums.CabinetStatus;
import com.huagu.common.global.appdb;
import com.huagu.common.util.Distribution;
import com.huagu.common.util.StringUtils;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.FieldDefs;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.mysql.BuildQuery;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * @ClassName: SvrMyBoxGroup
 * @Description: 用户端机柜持久层操作
 * @author tj
 * @date 2018年3月22日 上午8:55:01
 */
public class SvrMyBoxGroup extends CustomService {
    
    /*
     * 查看柜组详情
     */
    public boolean detail() {
        Record headIn = getDataIn().getHead();
        String cabinetId = headIn.getString("cabinetId");
        BuildQuery f = new BuildQuery(this);
        f.byField("id_", cabinetId);
        f.add("select UID_,id_,carouselId_,communityName_,communityNum_,address_ from %s", appdb.CABINET);
        DataSet result = f.open();
        BoxInfo bi = new BoxInfo();
        if (!result.eof()) {
            Record aBox = result.getCurrent();
            bi.setCommunityName(aBox.getString("communityName_"));
            bi.setCommunityNum(aBox.getString("communityNum_"));
            bi.setAddress(aBox.getString("address_"));
            
            //轮播图
            BuildQuery fimage = new BuildQuery(this);
            fimage.byField("relevancelId_", aBox.getString("carouselId_"));
            fimage.add("select imgPath_ from %s", appdb.T_IMAGE);
            DataSet imageResult = fimage.open();
            Set<String> images = bi.getImages();
            if (!imageResult.eof()) {
                for (Record r : imageResult) {
                    images.add(r.getString("imgPath_"));
                }
            }
            
            //商品
            BuildQuery fgood = new BuildQuery(this);
            fgood.byField("b.cabId_", cabinetId);
            fgood.add("select b.boxId_,pro.proId_ proId_,proZsImges_ as proImage_,pro.proName_,pro.dayRentMoney_,pro.cashPledge_,pb.zhuCode_,pro.discountPrice_", appdb.T_IMAGE);
            fgood.add("from %s b inner join %s pb on b.boxId_=pb.boxId_ inner join %s pn on pb.zhuCode_=pn.zhuCode_ inner join %s pro on pn.proId_=pro.proId_", appdb.BOX, appdb.PRONODEBOX, appdb.T_ProNode, appdb.T_Products);
            DataSet goodResult = fgood.open();
            if (!goodResult.eof()) {
                for (Record r : goodResult) {
                    Goods goods = new Goods();
                    goods.setProId(r.getString("proId_"));
                    goods.setNum(r.getString("boxId_"));
                    goods.setImageUrl(r.getString("proImage_"));
                    goods.setName(r.getString("proName_"));
                    goods.setMoney(r.getString("dayRentMoney_") + "元/天");
                    goods.setDiscountPrice(r.getString("discountPrice_"));
                    goods.setPledge(r.getString("cashPledge_"));
                    goods.setZhuCode(r.getString("zhuCode_"));
                    bi.getGoods().add(goods);
                }
            }
            
        }
        
        getDataOut().getHead().setField("boxInfo", bi);
        System.out.println(bi);
        return true;
    }
    
    /*
     * 附近柜组列表查询
     */
    public boolean list() throws DataValidateException {
        Record headIn = getDataIn().getHead();
        DataValidateException.stopRun("传入当前经度", !headIn.hasValue("curlongitude"));
        DataValidateException.stopRun("传入当前纬度", !headIn.hasValue("curlatitude"));
        double curlongitude = headIn.getDouble("curlongitude");
        double curlatitude = headIn.getDouble("curlatitude");
        
        BuildQuery f = new BuildQuery(this);
        f.byField("status_", CabinetStatus.JOINUP.ordinal());
        f.byField("joinStatus_", CabinetStatus.JOINUP.ordinal());
        f.add("select id_,communityName_,communityNum_,x_,y_,address_ from %s", appdb.CABINET);
        DataSet cabinets = f.open();
        DataSet result = getDataOut();
        if (!cabinets.eof()) {
            for (Record cabinet : cabinets) {
                double longitude = cabinet.getDouble("x_");
                double latitude = cabinet.getDouble("y_");
                if (StringUtils.isEmpty(longitude+"") || StringUtils.isEmpty(latitude+"")) {
                    continue ;
                }
                
                double cabinetSearchDistance = Double.parseDouble(new ServerConfig().getProperty("cabinet.searchDistance", "1000")+"");
                
                Distribution start = new Distribution();
                start.setLongitude(curlongitude);
                start.setDimensionality(curlatitude);
                Distribution end = new Distribution();
                end.setLongitude(longitude);
                end.setDimensionality(latitude);
                double distance = new Distribution().getDistance(start, end);
                
                if (distance > cabinetSearchDistance) {
                    continue ;
                }
                
                cabinet.setField("distance", (int)distance);
                result.append();
                FieldDefs fd = new FieldDefs();
                fd.add("id_","communityName_","communityNum_","address_","distance");
                result.copyRecord(cabinet, fd);
            }
        }
        return true;
    }
    
    public IStatus boxPosition(DataSet dataIn,DataSet dataOut) throws DataValidateException {
        Record headIn = dataIn.getHead();
        DataValidateException.stopRun("柜子id不允许为空！", !headIn.hasValue("cabinetId"));
        SqlQuery dsBox = new SqlQuery(this);
        dsBox.add("select id_,communityName_,communityNum_,x_,y_,address_,name_ from %s",appdb.CABINET);
        dsBox.add("where id_='%s'",headIn.getString("cabinetId"));
        dsBox.open();
        if(!dsBox.eof()) {
            dataOut.getHead().copyValues(dsBox.getCurrent());
        }
        return this.success();
    }
    
}
