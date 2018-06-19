package com.huagu.box.manage.services;

import java.util.List;
import java.util.UUID;

import org.apache.commons.lang3.tuple.Pair;

import cn.cerc.jbean.core.CustomService;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.DataSetState;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.field.TDateTimeDefine;
import cn.cerc.jdb.mysql.BuildQuery;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.mysql.Transaction;

import com.huagu.common.enums.BoxType;
import com.huagu.common.enums.BoxVolume;
import com.huagu.common.global.appdb;
import com.huagu.maintain.forms.FrmMyCabinet;

/**
 * @ClassName: SvrMyBoxGroupManage
 * @Description: 后台机柜管理持久层操作
 * @author tj
 * @date 2018年3月12日 上午10:04:08
 */
public class SvrMyBoxGroupManage extends CustomService {
    
    /*
     * 柜组列表
     */
    public boolean list() {
        Record headIn = getDataIn().getHead();
        BuildQuery f = new BuildQuery(this);
        /*
         * 1.机柜名称
         * 2.添加时间
         * 3.最近接入系统时间
         * 4.柜组是否接入系统（是否通电）
         * 5.柜组挂靠社区简称
         * 6.社区编号
         * 7.查看柜组二维码
         * 8.柜组编号
         * 9.柜组GPS位置信息
         * 10.最近配置人员电话
         * 11.最近配置时间
         * 13.大箱子个数
         * 14.中箱子个数
         * 15.小箱子个数
         * 16.公益箱个数
         * 17.运维人员
         * 18.柜子启用暂停状态
         */
        f.byField("1", 1);
        if (headIn.hasValue("paramCabinetName")) {
            f.byField("c.name_", "*"+headIn.getString("paramCabinetName")+"*");
        }
        if (headIn.hasValue("paramCommunityName")) {
            f.byField("c.communityName_", "*"+headIn.getString("paramCommunityName")+"*");
        }
        if (headIn.hasValue("paramAddTime")) {
            f.byField("DATE_FORMAT(c.createDate_,'%YYYY-%MM-%dd %HH:%mm:%ss')", headIn.getString("paramAddTime"));
        }
        if (headIn.hasValue("paramConfigTime")) {
            f.byField("DATE_FORMAT(config.configDate_,'%YYYY-%MM-%dd %HH:%mm:%ss')", headIn.getString("paramConfigTime"));
        }
        if (headIn.hasValue("paramManagerPhone")) {
            f.byField("user.mobile_", "*"+headIn.getString("paramManagerPhone")+"*");
        }
        if (headIn.hasValue("paramStatus")) {
            f.byField("c.status_", headIn.getString("paramStatus"));
        }
        f.add("select distinct c.id_,c.name_,c.createDate_,c.joinUpDate_,c.joinStatus_,c.address_,c.communityName_,c.communityNum_,RIGHT(c.id_,6) as 'cid_',CONCAT(FORMAT(c.x_,'#.####'), ',',FORMAT(c.y_,'#.####')) as 'gps_',user.mobile_,config.configDate_,c.combinationInfo_,c.status_ from %s c", appdb.CABINET);
        f.add("left join %s config on c.id_=config.cabinetId_", appdb.CABINETCONFIGRECORD);
        f.add("left join %s user on config.managerId_=user.id_", appdb.S_Userinfo);
        f.setOrderText("order by config.configDate_ desc");
        DataSet cabinets = f.open();
        if (!cabinets.eof()) {
            for (Record record : cabinets) {
                //添加a标签，查看柜组二维码和详情
                String qLink = String.format("<a href='javascript:void(0);' data-id='%s' class='qrcode'>查看</a>", record.getString("id_"));
                record.setField("lookQrcode", qLink);
                // 详情展示柜组，箱子详情
                String bLink = String.format("<a href='FrmMyBoxGroupManage.cabinetDetail?cabId=%s'>查看</a>", record.getString("id_"));
                record.setField("lookIntoDetail", bLink);
                //查询各种箱子个数
                getBoxCount(record);
                //查询运维人员电话
                getManagerMobile(record);
            }
        }
        getDataOut().appendDataSet(cabinets);
        return true;
    }
    
    private void getBoxCount(Record record) {
        String cabinetId = record.getString("id_");
        /*公益箱只统计总个数，不按大中小来统计 
                                租赁柜，分大、中、小，三种规格
                                属于租赁箱的，还得判断是大、中、小，然后分别累计
                                属于公益箱属性的，累计全个数，*/
        //查询各种箱子个数
        SqlQuery boxes = new SqlQuery(this);
        boxes.add("select count(*) as count,boxType_,boxVolume_ from %s", appdb.BOX);
        boxes.add("where cabId_='%s'", cabinetId);
        boxes.add("group by boxType_,boxVolume_");
        boxes.open();
        if (boxes.eof()) {
            record.setField("zlbig_", 0);
            record.setField("zlmiddle_", 0);
            record.setField("zlsmall_", 0);
            record.setField("gy_", 0);
        } else {
            for (Record r : boxes) {
                if (BoxType.PUBLICBENEFIT.ordinal() == r.getInt("boxType_")) {
                    record.setField("gy_", r.getInt("count"));
                } else if (BoxType.LEASE.ordinal() == r.getInt("boxType_")) {
                    if (BoxVolume.BIG.ordinal() == r.getInt("boxVolume_")) {
                        record.setField("zlbig_", r.getInt("count"));
                    } else if (BoxVolume.MIDDLE.ordinal() == r.getInt("boxVolume_")) {
                        record.setField("zlmiddle_", r.getInt("count"));
                    } else if (BoxVolume.SMALL.ordinal() == r.getInt("boxVolume_")) {
                        record.setField("zlsmall_", r.getInt("count"));
                    } else {
                        throw new RuntimeException("不存在的租赁箱子大小");
                    }
                } else {
                    throw new RuntimeException("不存在的箱子类型");
                }
            }
        }
    }
    
    private void getManagerMobile(Record record) {
        StringBuffer mobiles;
        String communityNum = record.getString("communityNum_");
        SqlQuery mms = new SqlQuery(this);
        mms.add("select u.mobile_ from %s as cm inner join %s as u on cm.managerId_=u.id_", appdb.CABINETMANAGER, appdb.S_Userinfo);
        mms.add("where cm.communityNum_='%s'", communityNum);
        mms.add("and u.isOperate_='1'");
        mms.open();
        if (mms.eof()) {
            mobiles = new StringBuffer();
        } else {
            mobiles = new StringBuffer();
            List<Record> records = mms.getRecords();
            for (int i = 0; i < records.size(); i++) {
                mobiles.append(records.get(i).getString("mobile_"));
                if (i != records.size() - 1) {
                    mobiles.append("<br/>");
                }
            }
        }
        record.setField("mobiles_", mobiles.toString());
    }
    
    /*
     * 柜组详情，箱子列表
     * 1.柜组编号
     * 2.箱锁UD（自动主键）
     * 3.箱锁闭启状态
     * 4.最近箱锁关闭时间
     * 5.箱锁编号
     * 6.箱锁用途
     * 7.箱子型号
     * 8.箱锁内空箱状态
     * 9.箱锁内是否订单锁定状态
     * 10.箱锁内存放物品名称
     * 11.箱锁内存放物品主电子条码
     * 12.箱锁内存放物品配件电子条码
     * 
     * 箱子与主电子条码对应，主电子条码才是唯一的商品标识
     * 
     */
    public boolean cabinetDetail() {
        String cabId = getDataIn().getHead().getString("cabId");
        BuildQuery f = new BuildQuery(this);
        f.byField("b.cabId_", cabId);
        f.add("select RIGHT(cabId_,6) as 'cabId_',b.boxLockUD_,boxStatus_,lockDate_,RIGHT(b.boxId_,6) as 'boxId_',b.boxType_,b.boxVolume_,b.emptyStatus_,b.boxOrderLock_ from t_box b", appdb.BOX);
        DataSet result = f.open();
        if (!result.eof()) {
            for (int i = 0; i < result.size(); i++) {
                Record r = result.getRecords().get(i);
                /*'锁箱启闭状态0未启用，1启用'*/
                changeValue(r, "boxStatus_", "关闭", "开启");
                /*'箱子类型（0租赁箱，1公益箱）'*/
                changeValue(r, "boxType_", new int[]{0, 1}, new String[]{"租赁箱", "公益箱"});
                /*'箱子体型（0大，1中，2小）'*/
                changeValue(r, "boxVolume_", new int[]{0, 1, 2}, new String[]{"大", "中", "小"});
                /*'箱子内空箱状态（0空箱，1有物品）'*/
                changeValue(r, "emptyStatus_", "空", "有");
                /*'箱子订单锁定状态（0自由，1锁定）'*/
                changeValue(r, "boxOrderLock_", "否", "是");
                
                //查询商品信息
                //1.物品名称
                //2.主电子条码
                //3.配件电子条码
                
                // 箱子id
                String boxId_ = r.getString("boxId_");
                BuildQuery fq = new BuildQuery(this);
                fq.byField("pb.boxId_", boxId_);
                fq.byField("pb.status_", 1);
                fq.byField("p.isDel_", 0);
                fq.byField("pro.isDel_", 0);
                fq.add("select p.zhuCode_ as 'zhuCode_',pro.proName_ as 'name_' from %s pb left outer join %s p on pb.zhuCode_=p.zhuCode_ "
                        + "left outer join %s pro on p.proId_=pro.proId_", appdb.PRONODEBOX, appdb.T_ProNode, appdb.T_Products);
                DataSet proInfo = fq.open();
                if (!proInfo.eof()) {
                    Record pi = proInfo.getCurrent();
                    r.setField("name_", pi.getString("name_"));
                    r.setField("mBarcode_", pi.getString("zhuCode_"));
                    fq = new BuildQuery(this);
                    fq.byField("zhuCode_", pi.getString("zhuCode_"));
                    fq.byField("ciDel_", 0);
                    fq.add("select ciCode_ from %s", appdb.T_CiNode);
                    DataSet cinode = fq.open();
                    if (!cinode.eof()) {
                        r.setField("pBarcode_", cinode.getCurrent().getString("ciCode_"));
                    } else {
                        r.setField("pBarcode_", "");
                    }
                } else {
                    r.setField("name_", "");
                    r.setField("mBarcode_", "");
                    r.setField("pBarcode_", "");
                }
                
            }
        }
        System.err.println(result);
        getDataOut().appendDataSet(result);
        return true;
    }
    
    /*
     * 将数据库中的bit类型枚举值转换成展示的汉语
     */
    public static void changeValue(Record record, String key, String... value) {
        boolean result = record.getBoolean(key);
        String str = "";
        if (!result) {
            str = value[0];
        } else {
            str = value[1];
        }
        record.setField(key, str);
    }
    
    /*
     * 将数据库中的int类型的枚举值转换成展示的汉语
     * 其中key和value两个参数是根据下标一一对应的
     */
    public static void changeValue(Record record, String vk, int[] key, String[] value) {
        if (key == null || value == null || key.length != value.length) {
            throw new RuntimeException("参数错误");
        }
        int result = record.getInt(vk);
        for (int i = 0; i < key.length; ++i) {
            if (result == key[i]) {
                record.setField(vk, value[i]);
            }
        }
    }
    
    /*
     * 查询待配置的柜组
     */
    public boolean checkBox() {
        BuildQuery f = new BuildQuery(this);
        f.byField("joinStatus_", 0);
        f.add("select RIGHT(id_,6) as 'cabId_', joinUpDate_, '待配置接入' as 'wstr_' from %s", appdb.CABINET);
        DataSet result = f.open();
        if (!result.eof()) {
            getDataOut().appendDataSet(result);
        }
        return true;
    }
    
    /*
     * 添加柜组
     */
    @SuppressWarnings("unchecked")
    public boolean addBox() {
        try (Transaction tx = new Transaction(this)) {
            Record headIn = getDataIn().getHead();
            List<String> paths = (List<String>)headIn.getField("paths");
            /*StringBuffer imageIds = new StringBuffer();*/
            String relId = UUID.randomUUID().toString();
            if (paths != null && paths.size() > 0) {
                SqlQuery ds = new SqlQuery(this);
                ds.add("select createDate_,createUser_,relevancelId_,imgPath_ from %s", appdb.T_IMAGE);
                ds.setMaximum(0);
                ds.open();
                ds.setBatchSave(true);
                for (String path : paths) {
                    /*imageIds.append(relId + ",");*/
                    Record r = new Record();
                    r.setState(DataSetState.dsInsert);
                    r.setField("createDate_", TDateTime.Now());
                    r.setField("createUser_", getUserCode());
                    r.setField("relevancelId_", relId);
                    r.setField("imgPath_", path);
                    ds.getRecords().add(r);
                }
                ds.save();
            }
            
            /*imageIds.substring(0, imageIds.lastIndexOf(","));*/
            
            String communityName = headIn.getString("communityName");
            String communityNum = headIn.getString("communityNum");
            String cabinetName = headIn.getString("cabinetName");
            SqlQuery ds = new SqlQuery(this);
            ds.add("select createDate_,createUser_,name_,id_,carouselId_,joinStatus_,communityName_,communityNum_,x_,y_,status_ from %s", appdb.CABINET);
            ds.open();
            ds.append();
            ds.setField("createDate_", TDateTime.Now());
            ds.setField("createUser_", getUserCode());
            ds.setField("name_", cabinetName);
            ds.setField("id_", getUUID());
            ds.setField("carouselId_", relId);
            ds.setField("joinStatus_", 0);
            ds.setField("communityName_", communityName);
            ds.setField("communityNum_", communityNum);
            Pair<String, String> pair = FrmMyCabinet.getLngLatFromOneAddr(communityName);
            Object x_ = pair.getLeft();
            Object y_ = pair.getRight();
            ds.setField("x_", x_.toString());
            ds.setField("y_", y_.toString());
            ds.setField("status_", 0);
            //根据communityName算出经纬度。。。后续添加
            ds.post();
            tx.commit();
        }
        return true;
    }
    
    public static String getUUID() {
        return UUID.randomUUID().toString().replace("-", "");
    }
    
    public static void main(String[] args) {
//        System.out.println(UUID.randomUUID().toString().replaceAll("-", ""));
        String s = "123,344,555,332,";
        System.out.println(s.substring(0, s.lastIndexOf(',')));
    }

}
