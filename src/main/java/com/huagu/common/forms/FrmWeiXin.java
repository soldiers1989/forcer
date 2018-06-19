package com.huagu.common.forms;

import javax.servlet.http.Cookie;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;

import com.huagu.common.global.WeixinUserInfo;
import com.huagu.common.tools.CommonUtil;
import com.huagu.common.tools.WeixinUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.core.Application;
import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.oss.OssSession;
import cn.cerc.jmis.core.ClientDevice;
import cn.cerc.jmis.core.MenuItem;
import cn.cerc.jmis.core.RequestData;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
import net.sf.json.JSONObject;

/**
 * @author Administrator
 *
 */
public class FrmWeiXin extends AbstractForm {
	public static Logger log = Logger.getLogger(FrmWeiXin.class);

	@Override
	public IPage execute() throws Exception {
		if (!wxLogin()) {
			throw new RuntimeException();
		}
		return new RedirectPage(this, "FrmRentWei");
	}
	
	public IPage more() throws Exception {
		if (!wxLogin()) {
			throw new RuntimeException();
		}
		return new RedirectPage(this, "FrmMore.userCenter");
	}
	
	public IPage qiandao() throws Exception {
		if (!wxLogin()) {
			throw new RuntimeException();
		}
		return new RedirectPage(this, "FrmMore.lijiqiandao");
	}

	/**
	 * 服务器重启，微信页面session失效，获取code
	 */
	public IPage anewLogin() {
		JsonPage page = new JsonPage(this);
		String url;
		String More = this.getRequest().getParameter("More");
		System.out.println(More);
		String corpNo = "";
		for (Cookie c : this.getRequest().getCookies()) {
			if ("corpNo".equals(c.getName())) {
				corpNo = c.getValue();
				System.out.println("拥有cookie");
			}
		}
		if (StringUtils.isEmpty(corpNo)) {
			corpNo = "727000";
		}
		ServerConfig config = new ServerConfig();
		String rootSite = config.getProperty("app.rootSite") + "/" + Application.getConfig().getPathForms();
		log.info("重新登录城市编号：" + corpNo);
		Record record = WeixinUtil.queryAppId(corpNo);
		if("More".equals(More)) {
			url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + record.getString("appID_")
			+ "&redirect_uri=" + rootSite + "/FrmWeixin.more&response_type=code&scope=snsapi_base&More="+ More +"&state=" + corpNo
			+ "#wechat_redirect";
		}else if("Ljqd".equals(More)){
			url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + record.getString("appID_")
			+ "&redirect_uri=" + rootSite + "/FrmWeixin.qiandao&response_type=code&scope=snsapi_base&More="+ More +"&state=" + corpNo
			+ "#wechat_redirect";
		}else {
			url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + record.getString("appID_")
			+ "&redirect_uri=" + rootSite + "/FrmWeixin&response_type=code&scope=snsapi_base&More="+ More +"&state=" + corpNo
			+ "#wechat_redirect";
		}
		log.info("微信登录url：" + url);
		
		page.setData(url);
		return page;
	}

	public boolean wxLogin() {
		LocalService svr = new LocalService(this, "SvrUserLogin.autoLogin");
		ServerConfig config = new ServerConfig();
		String corpNo = this.getRequest().getParameter("state");
		// 保存城市编号到cookie，用于服务器失效时，自动登录
		Cookie c = new Cookie("corpNo", corpNo);
		c.setMaxAge(-1);
		this.getResponse().addCookie(c);
		String code = this.getRequest().getParameter("code");
		log.info("获取到得到微信城市编码为：" + corpNo + ",code为：" + code);
		String openid = WeixinUtil.getOpenId(corpNo, code);

		ClientDevice client = (ClientDevice) this.getClient();
		client.setId(openid);
		client.setDevice(ClientDevice.device_weixin);

		log.info("device:" + this.getClient().getDevice());
		log.info("deviceId:" + this.getClient().getId());
		
		 // 获取接口访问凭证
        String accessToken = CommonUtil.getToken("wxe68dea4a67cc11b0", "864e2c7511b2467f68fc1a2ce819fd87").getAccessToken();
        /**
         * 获取用户信息
         */
        WeixinUserInfo user = getUserInfo(accessToken, openid);
        /*System.out.println("OpenID：" + user.getOpenId());
        System.out.println("关注状态：" + user.getSubscribe());
        System.out.println("关注时间：" + user.getSubscribeTime());
        System.out.println("昵称：" + user.getNickname());
        System.out.println("性别：" + user.getSex());
        System.out.println("国家：" + user.getCountry());
        System.out.println("省份：" + user.getProvince());
        System.out.println("城市：" + user.getCity());
        System.out.println("语言：" + user.getLanguage());
        System.out.println("头像：" + user.getHeadImgUrl());*/
        
		boolean resutl = svr.exec("userCode", openid, "terminal", openid, "token",
				config.getProperty(OssSession.oss_accessKeySecret, "") + "ABCD", "corpNo", corpNo, "freePwd", true,
				"name", user.getNickname(), "sex", user.getSex(), "imgUrl", user.getHeadImgUrl());
		if (!resutl) {
			throw new RuntimeException(svr.getMessage());
		}
		try (MemoryBuffer buffer = new MemoryBuffer(BufferType.getSessionInfo, this.getUserCode())) {
			buffer.setField("openid", openid);
		}

		String sid = svr.getDataOut().getHead().getString("SessionID_");
		if (sid != null && !sid.equals("")) {
			this.getRequest().setAttribute(RequestData.appSession_Key, sid);
			this.getRequest().getSession().setAttribute(RequestData.appSession_Key, sid);
		}
		return resutl;
	}

	/**
	 * 微信第三方登录
	 * 
	 * @return
	 */
	public IPage wxClientLogin() {
		JspPage page = new JspPage(this, "/login/login.jsp");
		this.getMenu().setParam(MenuItem.TITLE, "绑定手机号");
		String openid = this.getRequest().getParameter("openid");
		if (openid == null || "".equals(openid)) {
			return new RedirectPage(this, "Login");
		}
		// 是否首次登录
		LocalService localServer = new LocalService(this, "SvrGetUserMobileByUserCode");
		boolean resutl = localServer.exec("userName", openid);
		if (!resutl) {
			throw new RuntimeException(localServer.getMessage());
		}
		if (localServer.getDataOut().eof()) {
			// 首次登录去到绑定手机号页面
			page.add("openid", openid);
			return page;
		}

		// 登录
		LocalService svr = new LocalService(this, "SvrUserLogin.autoLogin");
		ServerConfig config = new ServerConfig();

		resutl = svr.exec("userCode", openid, "terminal", this.getClient().getId(), "token",
				config.getProperty(OssSession.oss_accessKeySecret, "") + "ABCD", "corpNo", 727000, "freePwd", true);
		if (!resutl) {
			throw new RuntimeException(svr.getMessage());
		}
		try (MemoryBuffer buffer = new MemoryBuffer(BufferType.getSessionInfo, this.getUserCode())) {
			buffer.setField("openid", openid);
		}

		String sid = svr.getDataOut().getHead().getString("SessionID_");
		if (sid != null && !sid.equals("")) {
			this.getRequest().setAttribute(RequestData.appSession_Key, sid);
			this.getRequest().getSession().setAttribute(RequestData.appSession_Key, sid);
		}

		return new RedirectPage(this, "FrmRentWei");
	}
	
	/**
     * 获取用户信息
     * 
     * @param accessToken 接口访问凭证
     * @param openId 用户标识
     * @return WeixinUserInfo
     */
    public static WeixinUserInfo getUserInfo(String accessToken, String openId) {
        WeixinUserInfo weixinUserInfo = null;
        // 拼接请求地址
        String requestUrl = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=ACCESS_TOKEN&openid=OPENID";
        requestUrl = requestUrl.replace("ACCESS_TOKEN", accessToken).replace("OPENID", openId);
        // 获取用户信息
        JSONObject jsonObject = CommonUtil.httpsRequest(requestUrl, "GET", null);

        if (null != jsonObject) {
            try {
                weixinUserInfo = new WeixinUserInfo();
                // 用户的标识
                weixinUserInfo.setOpenId(jsonObject.getString("openid"));
                // 关注状态（1是关注，0是未关注），未关注时获取不到其余信息
                weixinUserInfo.setSubscribe(jsonObject.getInt("subscribe"));
                // 用户关注时间
                weixinUserInfo.setSubscribeTime(jsonObject.getString("subscribe_time"));
                // 昵称
                weixinUserInfo.setNickname(jsonObject.getString("nickname"));
                // 用户的性别（1是男性，2是女性，0是未知）
                weixinUserInfo.setSex(jsonObject.getInt("sex"));
                // 用户所在国家
                weixinUserInfo.setCountry(jsonObject.getString("country"));
                // 用户所在省份
                weixinUserInfo.setProvince(jsonObject.getString("province"));
                // 用户所在城市
                weixinUserInfo.setCity(jsonObject.getString("city"));
                // 用户的语言，简体中文为zh_CN
                weixinUserInfo.setLanguage(jsonObject.getString("language"));
                // 用户头像
                weixinUserInfo.setHeadImgUrl(jsonObject.getString("headimgurl"));
            } catch (Exception e) {
                if (0 == weixinUserInfo.getSubscribe()) {
                    log.info("用户{}已取消关注" + weixinUserInfo.getOpenId());
                } else {
                    int errorCode = jsonObject.getInt("errcode");
                    String errorMsg = jsonObject.getString("errmsg");
                    log.info("获取用户信息失败 errcode:{} errmsg:{}" + errorCode + "===" + errorMsg);
                }
            }
        }
        return weixinUserInfo;
    }
	
    public static void main(String args[]) {
        // 获取接口访问凭证
    	String accessToken = CommonUtil.getToken("wxe68dea4a67cc11b0", "864e2c7511b2467f68fc1a2ce819fd87").getAccessToken();
        /**
         * 获取用户信息
         */
        WeixinUserInfo user = getUserInfo(accessToken, "o_QGQ0qQMZoEg9TGBBvOhsoOA2yk");
        System.out.println("OpenID：" + user.getOpenId());
        System.out.println("关注状态：" + user.getSubscribe());
        System.out.println("关注时间：" + user.getSubscribeTime());
        System.out.println("昵称：" + user.getNickname());
        System.out.println("性别：" + user.getSex());
        System.out.println("国家：" + user.getCountry());
        System.out.println("省份：" + user.getProvince());
        System.out.println("城市：" + user.getCity());
        System.out.println("语言：" + user.getLanguage());
        System.out.println("头像：" + user.getHeadImgUrl());
    }
    
	@Override
	public boolean logon() {
		return true;
	}

}
