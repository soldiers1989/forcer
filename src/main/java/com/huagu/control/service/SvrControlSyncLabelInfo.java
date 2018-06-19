package com.huagu.control.service;

import java.util.List;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.huagu.common.global.LabelInfo;
import com.huagu.common.global.appdb;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;
import cn.cerc.jdb.mysql.Transaction;

/**
 * 中控屏同步箱子Service
 * 
 * @author xiaofei-pc 传入 柜子ID 添加柜子的对应的箱子ID
 */
public class SvrControlSyncLabelInfo extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		try (Transaction tx = new Transaction(this)) {
			SqlQuery sync = new SqlQuery(this);
			sync.add("SELECT UID_,createDate_,createUser_,updateDate_,id_,name_,carouselId_,joinUpDate_,joinStatus_,combinationInfo_,address_,communityName_,communityNum_,x_,y_ FROM %s",
					appdb.Cabinet);
			sync.add(" WHERE id_ = '%s'", headIn.getString("cabinetId"));
			// 增加柜子信息
			if (sync.eof()) {
				sync.append();
				sync.setField("createDate_", TDateTime.Now());
				sync.setField("createUser_", headIn.getSafeString("userCode"));
				sync.setField("id_", headIn.getSafeString("cabinetId"));
				sync.post();
			}
			
			List<LabelInfo> labelInfo = JSON.parseArray(headIn.getSafeString("labelInfo"), LabelInfo.class);
			
			for (int i = 0; i < labelInfo.size(); i++) {// 添加独立标签表
				SqlQuery addBox = new SqlQuery(this);
				addBox.add("SELECT UID_,createDate_,createUser_,updateDate_,updateUser_,cabinetId,numOrder,lockNumber,hostAnt,childAnt,goodsLab FROM t_cabinetlabelinfo");
				addBox.add(" where 1 =1");
				addBox.add(" and cabinetId = '%s'", headIn.getSafeString("cabinetId"));
				addBox.add(" and numOrder = '%s'", labelInfo.get(i).getNumOrder());
				addBox.open();
				if(!addBox.eof()) {
					addBox.edit();
					addBox.setField("updateDate_", TDateTime.Now());
					addBox.setField("updateUser_", headIn.getSafeString("userCode"));
					addBox.setField("cabinetId", headIn.getSafeString("cabinetId"));
					addBox.setField("lockNumber", labelInfo.get(i).getLockNumber());
					addBox.setField("numOrder", labelInfo.get(i).getNumOrder());
					addBox.setField("childAnt", labelInfo.get(i).getChildAnt());
					addBox.setField("hostAnt", labelInfo.get(i).getHostAnt());
					addBox.setField("goodsLab", labelInfo.get(i).getGoodsLab());
					addBox.post();
				}else {
					addBox.append();
					addBox.setField("createDate_", TDateTime.Now());
					addBox.setField("createUser_", headIn.getSafeString("userCode"));
					addBox.setField("updateDate_", TDateTime.Now());
					addBox.setField("cabinetId", headIn.getSafeString("cabinetId"));
					addBox.setField("lockNumber", labelInfo.get(i).getLockNumber());
					addBox.setField("numOrder", labelInfo.get(i).getNumOrder());
					addBox.setField("childAnt", labelInfo.get(i).getChildAnt());
					addBox.setField("hostAnt", labelInfo.get(i).getHostAnt());
					addBox.setField("goodsLab", labelInfo.get(i).getGoodsLab());
					addBox.post();
				}
			}
			
			// 添加柜子箱子表
			for (int i = 0; i < labelInfo.size(); i++) {
				SqlQuery addBox1 = new SqlQuery(this);
				addBox1.add("select UID_,createDate_,createUser_,updateDate_,updateUser_,cabId_,boxId_,boxName_,boxVolume_,boxType_,emptyStatus_,boxDesc_,boxOrderLock_,boxLockUD_,boxStatus_,numOrder,lockNumber,hostAnt,childAnt,goodsLab from %s",
						appdb.BOX);
				addBox1.add(" where cabId_ = '%s'", headIn.getSafeString("cabinetId"));
				addBox1.add(" and boxId_ = '%s'", labelInfo.get(i).getNumOrder());
				addBox1.open();
				if(!addBox1.eof()){
					addBox1.edit();
					addBox1.setField("updateDate_", TDateTime.Now());
					addBox1.setField("updateUser_", headIn.getSafeString("userCode"));
					addBox1.setField("cabId_", headIn.getSafeString("cabinetId"));
					addBox1.setField("boxId_", labelInfo.get(i).getNumOrder());
					addBox1.setField("boxName_", headIn.getSafeString("cabinetId") + "的箱子");
					addBox1.setField("boxType_", 0);
					addBox1.setField("boxDesc_", headIn.getSafeString("cabinetId") + "的箱子");
					addBox1.setField("boxOrderLock_", 0);
					addBox1.setField("boxLockUD_", labelInfo.get(i).getLockNumber());
					addBox1.setField("boxStatus_", 0);
					addBox1.setField("lockNumber", labelInfo.get(i).getLockNumber());
					addBox1.setField("numOrder", labelInfo.get(i).getNumOrder());
					addBox1.setField("childAnt", labelInfo.get(i).getChildAnt());
					addBox1.setField("hostAnt", labelInfo.get(i).getHostAnt());
					addBox1.setField("goodsLab", labelInfo.get(i).getGoodsLab());
					addBox1.post();
				}else {
					addBox1.append();
					addBox1.setField("createDate_", TDateTime.Now());
					addBox1.setField("createUser_", headIn.getSafeString("userCode"));
					addBox1.setField("cabId_", headIn.getSafeString("cabinetId"));
					addBox1.setField("boxId_", labelInfo.get(i).getNumOrder());
					addBox1.setField("boxName_", headIn.getSafeString("cabinetId") + "的箱子");
					addBox1.setField("boxType_", 0);
					addBox1.setField("boxDesc_", headIn.getSafeString("cabinetId") + "的箱子");
					addBox1.setField("boxOrderLock_", 0);
					addBox1.setField("boxLockUD_", labelInfo.get(i).getLockNumber());
					addBox1.setField("boxStatus_", 0);
					addBox1.setField("lockNumber", labelInfo.get(i).getLockNumber());
					addBox1.setField("numOrder", labelInfo.get(i).getNumOrder());
					addBox1.setField("childAnt", labelInfo.get(i).getChildAnt());
					addBox1.setField("hostAnt", labelInfo.get(i).getHostAnt());
					addBox1.setField("goodsLab", labelInfo.get(i).getGoodsLab());
					addBox1.post();
				}
			}
			
			tx.commit();
		} catch (Exception e) {
			return fail("同步失败");
		}
		return success();
	}

}
