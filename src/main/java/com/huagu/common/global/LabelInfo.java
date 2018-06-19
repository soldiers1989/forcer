package com.huagu.common.global;

/**
* 类名: LabelInfo </br>
* 描述: 锁的基本信息  </br>
* 开发人员： lxf </br>
* 创建时间：  2018-6-9 </br>
* 发布版本：V1.0  </br>
 */
public class LabelInfo {
    private String lockNumber;
    private String numOrder;
    private String childAnt;
    private String hostAnt;
    private String goodsLab;
    
	public String getLockNumber() {
		return lockNumber;
	}
	public void setLockNumber(String lockNumber) {
		this.lockNumber = lockNumber;
	}
	public String getNumOrder() {
		return numOrder;
	}
	public void setNumOrder(String numOrder) {
		this.numOrder = numOrder;
	}
	public String getChildAnt() {
		return childAnt;
	}
	public void setChildAnt(String childAnt) {
		this.childAnt = childAnt;
	}
	public String getHostAnt() {
		return hostAnt;
	}
	public void setHostAnt(String hostAnt) {
		this.hostAnt = hostAnt;
	}
	public String getGoodsLab() {
		return goodsLab;
	}
	public void setGoodsLab(String goodsLab) {
		this.goodsLab = goodsLab;
	}

}