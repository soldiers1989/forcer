package com.huagu.common.constant;

/**
 *  数据统计类型
 * @author Administrator
 *
 */
public class ReportConstant {

	/*-------------- 用户统计 ----------------*/
	/** 注册  */
	public static int REPORT_REGIST = 1;
	/** 绑定  */
	public static int REPORT_BIND = 2;
	/** 解除绑定  */
	public static int REPORT_UNBIND = 3;
	/** 登录  */
	public static int REPORT_LOGIN = 4;

	/*-------------- 交易统计 ----------------*/
	/** 创建订单  */
	public static int REPORT_TRADE_CREATE = 1;
	/** 付款订单  */
	public static int REPORT_TRADE_PAY = 2;
	/** 取消订单  */
	public static int REPORT_TRADE_CANCEL = 3;

	/*-------------- 资讯消息统计 ----------------*/
	/** 消息推送  */
	public static int REPORT_MESS_PUSH = 1;
	/** 消息点击  */
	public static int REPORT_MESS_CLICK = 2;

	
}
