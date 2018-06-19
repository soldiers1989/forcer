package com.huagu.common.global;

import cn.cerc.jdb.core.IHandle;

public class appdb {

	/**
	 * 中控屏版本更新表
	 */
	public static final String VERSION = "t_version";
	
	/**
	 * 征信配置表
	 */
	public static final String CREDITDEPLOY = "t_creditdeploy";
	
	/**
	 * 征信和订单表
	 */
	public static final String CREDITANDORDER = "t_creditandorder";
	
	/**
	 * 活体订单表
	 */
	public static final String HTCERTIFIED = "t_htCertified";
	
	/**
	 * 客户认证表
	 */
	public static final String CLIENTCERTIFIED = "t_clientcertified";
	
	/**
	 * 取货订单表
	 */
	public static final String QHORDER = "t_qhorder";
	
	/**
	 * 日账单总结管理表
	 */
	public static final String BILL = "t_bill";

	/**
	 * 账户金额记录
	 */
	public static final String RECORDACCOUNT = "t_recordaccount";

	/**
	 * 捐赠订单
	 */
	public static final String ORDERDONATION = "t_orderdonation";

	/**
	 * 捐赠订单
	 */
	public static final String FUNDSACCOUNT = "t_fundsaccount";
	
	/**
	 * 芝麻信用认证日志表
	 */
	public static final String SESAMELOG = "t_sesamelog";
		
	/**
	 * 个人配置征信单
	 */
	public static final String ALONECREDIT = "t_aloneCredit";

	/**
	 * 运维上报征信单
	 */
	public static final String OPERATELEVY = "t_operatelevy";
	 
	/**
	 * 分成表
	 */
	public static final String COMMISSION = "t_commission";
	 
	/**
	 * 分成表
	 */
	public static final String YCORDER = "t_ycorder";
	
	/**
	 * 微信公众号配置表
	 */
	public static final String WX_CONFIG = "t_wx_config";
	
	/**
	 * 交易记录表
	 */
	public final static String T_TRANSLOG = "t_translog";

	/**
	 * 各种文章表
	 */
	public final static String T_Article = "t_article";

	/**
	 * 用户关注表
	 */
	public final static String userGZ = "t_usergz";

	/**
	 * 帖子表
	 */
	public final static String POST = "t_post";

	/**
	 * 标签库表
	 */
	public final static String LABEL_STORE = "t_label_store";

	/**
	 * 帖子标签中间表
	 */
	public final static String post_label = "t_post_label";

	/**va
	 * 评论表
	 */
	public final static String DISCUSS = "t_discuss";
	/**
	 * 邀请表
	 */
	public final static String Invitation = "t_invitation";

	/**
	 * 手机验证码表
	 */
	public final static String MOBILE_CODE = "t_mobile_code";

	/**
	 * 数据统计-用户报表
	 */
	public static String getUserReportTable(IHandle handle) {
		return "t_user_report";
	}

	/**
	 * 数据统计-账户报表
	 */
	public static String getAccountReportTable(IHandle handle) {
		return "t_account_report";
	}

	/**
	 * 数据统计-交易报表
	 */
	public static String getTradeReportTable(IHandle handle) {
		return "t_trade_report";
	}

	/**
	 * 数据统计-服务报表
	 */
	public static String getServiceReportTable(IHandle handle) {
		return "t_service_report";
	}

	/**
	 * 数据统计-消息报表
	 */
	public static String getIllnessListTable(IHandle handle) {
		return "t_illness_list";
	}

	/**
	 * 角色权限关系表
	 */
	public static String getRoleAndPowerTable(IHandle handle) {
		return "t_roleAndPower";
	}

	/**
	 * 角色权限关系表
	 */
	public static String getAppAndTagTable(IHandle handle) {
		return "t_appandtag";
	}

	public static String getDataPoint(IHandle handle) {
		return "t_data_point";
	}

	/**
	 * 用户终端表
	 */
	public static final String USER_TERMINAL = "s_userterminal";

	/**
	 * 帮助中心(找师傅)
	 */
	public static final String T_HELP = "t_help";

	/**
	 * 反馈意见表
	 */
	public static final String T_Suggest = "t_suggestion";

	/**
	 * 用户表
	 */
	public static final String S_Userinfo = "s_userinfo";

	/**
	 * 管理员和用户中间关联表
	 */
	public static final String ADMINANDUSER = "t_adminanduser";
	
	/**
	 * 师傅表
	 */
	public static final String T_Worker = "t_worker";

	/**
	 * 技术成果表
	 */
	public static final String Achievement = "t_achievement";

	/**
	 * 广告图片，轮播图片
	 */
	public static final String T_AD = "t_ad";

	/**
	 * 城市表
	 */
	public static final String T_CITY = "t_city";

	/**
	 * 咨询表
	 */
	public static final String T_CONSULT = "t_consult";

	/**
	 * 图片表
	 */
	public static final String T_IMAGE = "t_image";

	/**
	 * 视频表
	 */
	public static final String T_VIDEO = "t_video";

	/**
	 * 信息表
	 */
	public static final String T_MESSAGE = "t_message";

	/**
	 * 好友表
	 */
	public static final String Friend = "t_friend";
	/**
	 * 关于我们表
	 */
	public static final String Aboutus = "t_aboutus";

	/**
	 * 订单表
	 */
	public static final String T_ORDER = "t_order";

	/**
	 * 订单修改表
	 */
	public static final String T_ORDER_UPDATE = "t_order_update";

	/**
	 * 订单状态表
	 */
	public static final String T_ORDER_STATUS = "t_order_status";

	/**
	 * 用户评价表
	 */
	public static final String T_USER_EVALUATE = "t_user_evaluate";

	/**
	 * 师傅评价表
	 */
	public static final String T_ARTIFICER_EVALUATE = "t_artificer_evaluate";

	/**
	 * 技术成果表
	 */
	public static final String T_ACHIEVEMENT = "t_achievement";
	/**
	 * 医院表
	 */
	public static final String HOSPITAL = "t_hospital";
	/**
	 * 行业表
	 */
	public static final String Trade = "t_trade";
	/**
	 * 收藏关注表
	 */
	public static final String Concoll = "t_concoll";
	/**
	 * 后台管理员日志
	 */
	public static final String MANAGE_LOGS = "t_manageLogs";
	/**
	 * 省份表
	 */
	public static final String Province = "t_province";
	/**
	 * 区域表  
	 */
	public static final String Area = "t_area";
	/**
	 * 订单推荐师傅表
	 */
	public static final String OrderRecMaster_ = "t_orderRecMaster_";
	
	/**
	 * 订单结算天数表
	 */
	public static final String Settlement = "t_settlement";
	/**
	 * 首页轮播图表
	 */
	public static final String T_HomeAdvertise = "t_homeadvertise";
	/**
	 * 商品表
	 */
	public static final String T_Products = "t_products";
	/**
	 * 商品分类表
	 */
	public static final String T_Protype = "t_protype";
	/**
	 * 商品电子条码信息表
	 */
	public static final String T_ProNode = "t_pronode";
	/**
	 * 售卖商品的入库情况表
	 */
	public static final String T_Storage = "t_storage";
	/**
	 * 商品的配件电子条码信息表
	 */
	public static final String T_CiNode = "t_cinode";
	/**
	 * 商品状态表
	 */
	public static final String T_ProState = "t_prostate";
	/**
	 * 供应商信息表
	 */
	public static final String T_SupplyPeople = "t_supplypeople";

	
	/**
	 * 用户地址表
	 */
	public static final String Adr = "t_adr";

	/**
	 * 意见回馈表
	 */
	public static final String Feedback = " t_feedback";


	
	/**
	 * 签到表
	 */
	public static final String Sign = "t_sign";
	

	/**
	 * 用户凭组协议表
	 */
	public static final String Consultation = "t_consultation";
	
	/***********************************************************************************/
	
	/******柜组里面包含多个箱子，可组装，有不同规格******/
	
	/**
	 * 柜组表
	 */
	public static final String CABINET = "t_cabinet";
	
	/**
	 * 社区运维人员中间表
	 */
	public static final String CABINETMANAGER = "t_cabinet_manager";
	
	/**
	 * 柜组配置记录表(记录柜组配置历史)
	 */
	public static final String CABINETCONFIGRECORD = "t_cabinet_configRecord";
	
	/**
	 * 柜组区域表
	 */
	public static final String CABINETAREA = "t_cabinetarea";
	
	/**
	 * 箱子表
	 */
	public static final String BOX = "t_box";
	
	/**
	 * 箱子与主电子条码中间表
	 */
	public static final String PRONODEBOX = "t_pronode_box";
	
	/***********************************************************************************/
	
	/** 
	* 交易明细表
	 */
	public static final String Record = "t_record";

	/**
	 * 积分表
	 */
	public static final String Integral = "t_integral";
	

	/**
	 * 评价表
	 */
	public static final String T_EVALUATE = "t_evaluate";
	/**
	 * 消息列表
	 */
	public static final String Newslist = "t_newslist";

	/**
	 * 捐赠表
	 */
	public static final String Donation = "t_donation";

	
	/**
	 * 柜子表
	 */
	public static final String Cabinet = "t_cabinet";

	/**
	 * 帮助中心表
	 */
	public static final String Helpcenter = "t_helpcenter";
	

	/**  
	 * 优惠券和用户中间表
	 */
	public static final String t_couponanduser = "t_couponanduser";
	
	/**  
	 * 优惠券管理
	 */
	public static final String t_coupon = "t_coupon";
	
	
	/**
	 * 商务合作表
	 */
	public static final String Busperation = "t_buscooperaation";
	
	/**
	 * 使用流程
	 */
	public static final String UseProcess = "t_useprocess";
	

	 /**
	 * 代理商表
	 */
	public static final String Agent = "t_agent";
	
	/**
	 * 社区表
	 */
	public static final String Community = "t_community";
	
	/**
	 * 用户消费记录表
	 */
	public static final String T_Consume = "t_consume";
	
	/**
	 * 运维表
	 */
	public static final String t_Operate = "t_operate";
	
	
	/**
	 * 社区代理商中间表
	 */
	public static final String AgentCom = "t_agentCom";
	
	/**
	 *主电子条码与箱子中间表  
	 */
	public static final String t_pronode_box = "t_pronode_box";
	
	/**
     *商品收藏表  
     */
    public static final String Collect = "t_collect";
	/**
     *积分等级表
     */
    public static final String IngetralLevel = "t_integrallevel";
    /**
     *积分类型表
     */
    public static final String IngetralType = "t_integralType";
    /**
     *运费模板表
     */
    public static final String T_Feight = "t_freight";
    /**
     *取物单
     */
    public static final String qhorder = "t_qhorder";
    /**
     *归还单
     */ 
    public static final String ReturnGoods = "t_returnGoods";
    /**
     *赔付单
     */
    public static final String Pay = "t_pay";
    
    /**
     *  退货单
     */
    public static final String goodsRejected = "t_goodsrejected";
	
    /**
     *  银行卡认证
     */
    public static final String BankCard = "t_bankcard";
	
    /**
	 * 银行卡绑定
	 */
    public static final String BankCardCount = "t_bankcardcount";
}
