package com.huagu.common.util;

public class WxPayConstants {
    //第三方用户唯一ID
    public static String APPID = "wxe68dea4a67cc11b0";
    //第三方用户唯一凭证密码
    public static String APP_SECRET = "864e2c7511b2467f68fc1a2ce819fd87";
    //商户ID
    public static String MCH_ID = "1499372782";
    //微信商户平台-账户设置-安全设置-api安全,配置32位key
    public static String KEY  = "hDhke1dsHweShRnqAPZvS7i4sEnPhKFo";
    //交易类型
    public static String TRADE_TYPE_JS = "JSAPI";
    //微信支付回调url(钱包充值)
    public static String NOTIFY_URL = "http://yqx2018.lucland.com/forms/FrmRechargeNotify.notifyWechatpay";
    //微信支付回调url(微信支付)
    public static String Order_URL = "http://yqx2018.lucland.com/forms/FrmRechargeNotify.WXpay";
}
