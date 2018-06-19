package com.huagu.common.enums;

/**
 * @ClassName: CabinetStatus
 * @Description: 柜组状态（是否通电<=>是否接入系统）
 * @author tj
 * @date 2018年3月12日 上午11:37:18
 */
public enum CabinetStatus {

    /**
     * 0没有接入系统，1接入系统
     * 0没有启用，1启用中
     */
    NOTJOINUP, JOINUP;
    
}
