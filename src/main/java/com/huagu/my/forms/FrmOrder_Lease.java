package com.huagu.my.forms;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.huagu.common.constant.WxConfigConstant;
import com.huagu.common.util.StringUtils;
import com.huagu.common.util.WxPayConstants;
import com.huagu.myWallet.forms.FrmMyWallet;
import com.huagu.pay.forms.FrmRechargeNotify;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
import net.sf.json.JSONObject;
/**
  
 * @author 张俊森
 * @Time   FrmOrder_Lease.recharge
 */
public class FrmOrder_Lease extends AbstractForm {
	
	
	private static Logger log = Logger.getLogger(FrmRechargeNotify.class);
	@Override
//	public IPage execute() throws Exception {
//		String orderType_ =  this.getRequest().getParameter("orderType_");
//		String userId_ = getUserCode();
//		if(userId_==null||"".equals(userId_)) {
//		    userId_ = "17620458925";
//		}
//		String zhuCode_ = this.getRequest().getParameter("zhuCode_");
//		JspPage page = null;
//		if(orderType_.equals("1")){//自取租赁
//			page = new JspPage(this, "my/nowRent.jsp");
//			LocalService svr2 = new LocalService(this, "SvrAdminPro.findPro");//获取商品信息,根据注电子条码获取
//			Record head = svr2.getDataIn().getHead();
//			head.setField("zhuCode_", zhuCode_);
//			if (!svr2.exec())
//				throw new RuntimeException(svr2.getMessage());
//			if(!svr2.getDataOut().bof()){
//				page.add("pro", svr2.getDataOut().getCurrent());
//				page.add("zhuCode_", zhuCode_);
//			}
//		}
//		if(orderType_.equals("2") || orderType_.equals("3")){//寄送上门，送货到柜
//			page = new JspPage(this, "my/nowRentExpress.jsp");
//			
//			LocalService svr2 = new LocalService(this, "SvrAdminPro.findPro");//获取商品信息,根据商品Id
//			Record head = svr2.getDataIn().getHead();
//			head.setField("zhuCode_", zhuCode_);
//			if (!svr2.exec())
//				throw new RuntimeException(svr2.getMessage());
//			if(!svr2.getDataOut().bof()){
//				page.add("pro", svr2.getDataOut().getCurrent());
//				page.add("zhuCode_", zhuCode_);
//			}
//		}
//		LocalService svr = new LocalService(this, "SvrAdrManager.getDefAdr");
//		Record headIn = svr.getDataIn().getHead();
//		headIn.setField("userid_", userId_);  
//		headIn.setField("orderType_", orderType_);
//		if (!svr.exec())
//			throw new RuntimeException(svr.getMessage());
//		if(!svr.getDataOut().bof()){
//			page.add("users", svr.getDataOut().getCurrent());
//		}
//		
//		LocalService svr3 = new LocalService(this, "SvrOrder_Lease.getBox");
//		Record headIn3 = svr3.getDataIn().getHead();
//		headIn3.setField("zhuCode_", zhuCode_);
//		if (!svr3.exec())
//			throw new RuntimeException(svr3.getMessage());
//		if(!svr3.getDataOut().bof()){
//			page.add("box", svr3.getDataOut().getCurrent());
//		}
//		
//		page.add("orderType", orderType_);
//		page.add("userId", userId_);
//		page.add("zhuCode_", zhuCode_);
//		return page;
//	}
	
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "order/WXpayment.jsp");
		jsp.add("orderType_", this.getRequest().getParameter("orderType_"));
		jsp.add("zhuCode_", this.getRequest().getParameter("zhuCode_"));
		return jsp;
	}
	//向订单列表加信息
	public IPage addOrderr_Lease() throws Exception {
		LocalService svr = new LocalService(this, "SvrOrder_Lease.addOrderr_Lease");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("userId_", this.getRequest().getParameter("userId"));//用户ID
		headIn.setField("proId_", this.getRequest().getParameter("proId"));//商品ID
		headIn.setField("zhuCode_", this.getRequest().getParameter("zhuCode"));//主电子条码
		headIn.setField("rentTime_", this.getRequest().getParameter("rentTime"));//租期时长
		headIn.setField("sumRentMoney_", this.getRequest().getParameter("sumRentMoney"));//总租金
		headIn.setField("coupon_", this.getRequest().getParameter("coupon"));//优惠卷
		headIn.setField("couponId_", this.getRequest().getParameter("couponId_"));//优惠卷
		headIn.setField("reliefDeposit_", this.getRequest().getParameter("reliefDeposit"));//减免押金
		headIn.setField("sumMoney_", this.getRequest().getParameter("sumMoney"));//付款金额
		headIn.setField("allowReturnMoney_", this.getRequest().getParameter("allowReturnMoney"));//可退金额
		headIn.setField("remark_", this.getRequest().getParameter("remark"));//留言
		headIn.setField("consumeId_", this.getRequest().getParameter("consumeId_"));//用户消费信息ID
		String orderType = this.getRequest().getParameter("orderType");
		headIn.setField("orderType_",orderType );//订单类型
		if(orderType.equals("1")){
			headIn.setField("beginTime_", this.getRequest().getParameter("beginTime"));//起租时间
			
			headIn.setField("returnTime_", this.getRequest().getParameter("returnOverTime"));//归还时间
		}
		/*if(orderType.equals("2") || orderType.equals("3")){
			headIn.setField("shippingCosts_", this.getRequest().getParameter("shippingCosts"));//运费
			headIn.setField("receiver_", this.getRequest().getParameter("receiver"));//收件人
			headIn.setField("recPhone_", this.getRequest().getParameter("recPhone"));//联系电话
			headIn.setField("recAdr_", this.getRequest().getParameter("recAdr"));//收货地址
		}*/
		if(orderType.equals("2")){
			headIn.setField("shippingCosts_", this.getRequest().getParameter("shippingCosts"));//运费
			headIn.setField("receiver_", this.getRequest().getParameter("receiver"));//收件人
			headIn.setField("recPhone_", this.getRequest().getParameter("recPhone"));//联系电话
			headIn.setField("recAdr_", this.getRequest().getParameter("recAdr"));//收货地址
		}
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		
		return new RedirectPage(this, "FrmOrder_My.execute?userId="+this.getRequest().getParameter("userId"));
	}
	
	
	//更换下单地址（前往用户地址页面）
	public IPage addAdrEdit() throws Exception {
		JspPage page = new JspPage(this, "my/userAdrList.jsp");
		LocalService svr = new LocalService(this, "SvrAdrManager.querydata");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("userid", this.getRequest().getParameter("userid"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", svr.getDataOut().getRecords());
		page.add("userid", this.getRequest().getParameter("userid"));
		page.add("orderType_", this.getRequest().getParameter("orderType_"));
		page.add("zhuCode_", this.getRequest().getParameter("zhuCode_"));
		return page;
	}
	
	//使用零钱支付
	public IPage payment() throws Exception {
		JsonPage page = new JsonPage(this);
		String userId_ = getUserCode();
		if(userId_ == null || "".equals(userId_)) {
		    userId_ = "17620458925";
		}
		LocalService svr = new LocalService(this, "SvrOrder_Lease.payment");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("code_", userId_);
		headIn.setField("orderId_", this.getRequest().getParameter("orderId_"));
		headIn.setField("sumMoney", this.getRequest().getParameter("sumMoney"));
		
		if (!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		Map<String, String> returnJson = new HashMap<>();
		String consumeId_ = headIn.getString("consumeId_");
		returnJson.put("consumeId_", consumeId_);
		page.setData(returnJson);
		return page;
	}
	
	/**
	 * 跳转去支付 页面
	 */
	public IPage recharge() throws Exception {
		JspPage page = null;
		/*String code = this.getRequest().getParameter("code");// 这个请求用户的openid返回的code
		String openid = "";
		if (null != code && !"".equals(code)) {
			String url = WxConfigConstant.GET_OPENID_URL;
			url = url.replace("APPID", WxPayConstants.APPID);
			url = url.replace("SECRET", WxPayConstants.APP_SECRET);
			url = url.replace("CODE", code);
			String resultStr = FrmMyWallet.httpRequest(url, "GET", null);
			System.out.println("访问微信接口，得到当前的openId返回结果是：" + resultStr);
			if (StringUtils.notEmpty(resultStr) && resultStr.contains("openid")) {
				JSONObject resultJson = JSONObject.fromObject(resultStr);
				openid = resultJson.getString("openid");
				String userCode = this.getUserCode();
				this.getRequest().getSession().setAttribute(userCode, openid);
			}
			
		}
		String state = this.getRequest().getParameter("state");// 这个请求用户的openid返回的code
*/		String state = "A56464545B1";
		String zhuCode_ = state.substring(1,state.indexOf("B"));
		String orderType_ = state.substring(state.indexOf("B")+1, state.length());
		
		String userId_ = getUserCode();
		if(userId_==null||"".equals(userId_)) {
		    userId_ = "17620458925";
		}
		
		if(orderType_.equals("1")){//自取租赁
			page = new JspPage(this, "my/nowRent.jsp");
		}
		if(orderType_.equals("2") || orderType_.equals("3")){//寄送上门，送货到柜
			page = new JspPage(this, "my/nowRentExpress.jsp");
		}
		
		//地址管理（默认地址）
		LocalService svr = new LocalService(this, "SvrAdrManager.getDefAdr");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("userid_", userId_);
		headIn.setField("orderType_", orderType_);	
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		if(!svr.getDataOut().bof()){
			page.add("users", svr.getDataOut().getCurrent());
		}
		
		//根据主电子条码获取商品信息
		LocalService svr2 = new LocalService(this, "SvrAdminPro.findPro");//获取商品信息,根据商品Id
		Record head = svr2.getDataIn().getHead();
		head.setField("zhuCode_", zhuCode_);
		if (!svr2.exec())
			throw new RuntimeException(svr2.getMessage());
		if(!svr2.getDataOut().bof()){	
			System.out.println("svr2.getDataOut().getCurrent()"+svr2.getDataOut().getCurrent());
			 page.add("cashPledge_", svr2.getDataOut().getCurrent().getInt("cashPledge_"));
			page.add("pro", svr2.getDataOut().getCurrent());
			page.add("zhuCode_", zhuCode_);
		}
		
		//根据主电子条码获取箱子信息
		LocalService svr3 = new LocalService(this, "SvrOrder_Lease.getBox");
		Record headIn3 = svr3.getDataIn().getHead();
		headIn3.setField("zhuCode_", zhuCode_);
		if (!svr3.exec())
			throw new RuntimeException(svr3.getMessage());
		if(!svr3.getDataOut().bof()){
			page.add("box", svr3.getDataOut().getCurrent());
		}
		
		//获取优惠券
		LocalService svr4 = new LocalService(this, "SvrOrder_Lease.getCoupon");
		Record headIn4 = svr4.getDataIn().getHead();
		headIn4.setField("userId_", userId_);
		if (!svr4.exec())
			throw new RuntimeException(svr4.getMessage());
		if(!svr4.getDataOut().bof()){
			page.add("coupons", svr4.getDataOut().getRecords());
		}
		page.add("orderType", orderType_);
		page.add("userId", userId_);
		page.add("zhuCode_", zhuCode_);
		/*page.add("openid", openid);*/
		
		//优惠金额
		//查询芝麻信用是否达标
		LocalService svrSesame = new  LocalService(this, "SvrSesameQuery.sesameQuery");	
		if(!svrSesame.exec()){
			throw new RuntimeException(svrSesame.getMessage());
		}
	    page.add("mySesame", svrSesame.getDataOut().getCurrent().getInt("sesameFen_"));
	    page.add("sqStatus_", svrSesame.getDataOut().getCurrent().getString("sqStatus_"));
	    page.add("rzStatus_", svrSesame.getDataOut().getCurrent().getString("rzStatus_"));
	    
	    //查询积分
	    LocalService getCreditDeploy = new LocalService(this, "SvrGetCreditDeploy");
		if (!getCreditDeploy.exec())
			throw new RuntimeException(getCreditDeploy.getMessage());
		page.add("credit", getCreditDeploy.getDataOut().getRecords().get(0).getInt("money_"));
		page.add("credit1", getCreditDeploy.getDataOut().getRecords().get(1).getInt("money_"));
		page.add("credit2", getCreditDeploy.getDataOut().getRecords().get(2).getInt("money_"));
		page.add("credit3", getCreditDeploy.getDataOut().getRecords().get(3).getInt("money_"));
		page.add("credit4", getCreditDeploy.getDataOut().getRecords().get(4).getInt("money_"));
	    
		return page;
	}
	
	public boolean logon() {
		return true;
	}
}
