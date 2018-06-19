package com.huagu.product.forms;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.huagu.common.util.StringUtils;
import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;

public class FrmRentWei extends AbstractForm{

	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "products/FrmRentHome.jsp");
		LocalService svr = new LocalService(this, "SvrProType.queryProTypes");
		if(!svr.exec()){
		    page.add("msg", svr.getMessage());
            return page;
		} 
		page.add("values",svr.getDataOut().getRecords());
//		LocalService svr1 = new LocalService(this, "SvrRentWei.queryDigital");
//		if(!svr1.exec()){
//			page.add("msg", svr1.getMessage());
//            return page;
//		} 
//		System.out.println("333"+svr1.getDataOut());
//		if(!svr1.getDataOut().eof()){
//			page.add("Digital_firstNameId_", svr1.getDataOut().getString("firstNameId_"));	
//			page.add("Digital_firstName_", svr1.getDataOut().getString("firstName_"));
//		}
//		page.add("digital", svr1.getDataOut().getRecords());
//		LocalService svr2 = new LocalService(this, "SvrRentWei.queryCool");
//		if(!svr2.exec()){
//		    page.add("msg", svr2.getMessage());
//            return page;
//		} 
//		System.out.println("222"+svr2.getDataOut());
//		if(!svr1.getDataOut().eof()){
//			page.add("Cool_firstNameId_", svr1.getDataOut().getString("firstNameId_"));
//			page.add("Cool_firstName_", svr1.getDataOut().getString("firstName_"));
//		}
//		page.add("cool", svr2.getDataOut().getRecords());
		//首页轮播图
        LocalService svrHomeLunBo = new LocalService(this, "SvrHomeAd.queryHomeAd");
        if(!svrHomeLunBo.exec()) {
            page.add("msg", svrHomeLunBo.getMessage());
            return page;
        }
		//查询热租商品分类
        LocalService svrCoolType = new LocalService(this, "SvrRentWei.getCoolType");
        if(!svrCoolType.exec()) {
            page.add("msg", svrCoolType.getMessage());
            return page;
        }
        //查询热租商品
        LocalService svrCool = new LocalService(this, "SvrRentWei.getCools");
        if(!svrCool.exec()) {
            page.add("msg", svrCool.getMessage());
            return page;
        }
        //查询系统公告
        LocalService svrMsg = new LocalService(this, "SvrRentWei.getMessages");
        if(!svrMsg.exec()) {
            page.add("msg", svrMsg.getMessage());
            return page;
        }
		/*String signature = "";
		String timestamp = "";
		String nonceStr = "";

		// 获取微信jssdk---access_token
		String js_accessToken = FrmMap.getJSSDKAccessToken();
		// 获取微信jssdk---ticket
		String jsapi_ticket = FrmMap.getJSSDKTicket(js_accessToken);
		System.out.println("jsapi_ticket===" + jsapi_ticket);

		// 获取完整的URL地址
		String fullPath1 = "http://" + this.getRequest().getServerName() // 服务器地址
				+ this.getRequest().getContextPath()// 项目名称
				+ this.getRequest().getServletPath();// 请求页面或其他地址
		Sign sign = new Sign();
		// 获取参数传到页面 注入config里面进行微信验证，并调用起微信扫一扫 进行扫码
		Map<String, String> ret = sign.sign(jsapi_ticket, fullPath1);
		for (Map.Entry entry : ret.entrySet()) {
			if (entry.getKey().equals("signature")) {
				signature = entry.getValue().toString();
			} else if (entry.getKey().equals("jsapi_ticket")) {
				jsapi_ticket = entry.getValue().toString();
			} else if (entry.getKey().equals("timestamp")) {
				timestamp = entry.getValue().toString();
			} else if (entry.getKey().equals("nonceStr")) {
				nonceStr = entry.getValue().toString();
			}
		}
		
		page.add("appId", WxPayConstants.APPID);
		page.add("timestamp", timestamp);
		page.add("nonceStr", nonceStr);
		page.add("signature", signature);
		page.add("jsapi_ticket", jsapi_ticket);
		
		System.out.println(timestamp+"----"+WxPayConstants.APPID+"----"+nonceStr+"----"+signature+"----"+jsapi_ticket);
		*/
        List<Record> records = svrHomeLunBo.getDataOut().getRecords();
		for(Record r:records ){
			String imgPath_ = r.getSafeString("imgPath_");
			imgPath_ = imgPath_.replace("[", "");	
			imgPath_ = imgPath_.replace("]", "");
			r.setField("imgPath_", imgPath_);
		}
        page.add("lunbo", svrHomeLunBo.getDataOut().getRecords());
        page.add("types", svrCoolType.getDataOut().getRecords());
        page.add("coolList", svrCool.getDataOut().getRecords());
//        System.out.println("svrMsg.getDataOut().getRecords()"+svrMsg.getDataOut().getRecords());
        page.add("messages", svrMsg.getDataOut().getRecords());
        page.add("userCode_", this.getUserCode());
		return page;
	}

	//查询一级商品信息
	public IPage queryFristId() throws Exception{
		JspPage page = new JspPage(this, "products/FrmFristProDetail.jsp");
		String fristNameId_ = this.getRequest().getParameter("fristNameId_");
		LocalService svr = new LocalService(this, "SvrProType.queryProTypes"); 
		if(!svr.exec()){
		    page.add("msg", svr.getMessage());
		    return page;
		}
		LocalService svr2 = new LocalService(this, "SvrProType.querySecondType"); 
        Record head=svr2.getDataIn().getHead();
        head.setField("fristNameId_", fristNameId_);
        if(!svr2.exec()){
            page.add("msg", svr2.getMessage());
            return page;
        }
		page.add("fristNameId_", svr2.getDataOut().getHead().getString("fristNameId"));
		page.add("value", svr.getDataOut().getRecords());
		page.add("products", svr2.getDataOut().getRecords());
		return page;
			
	}
	//查询一级商品信息
	public IPage queryFristIdJson() throws Exception{
		JsonPage page =new JsonPage(this);
		//JspPage page = new JspPage(this, "products/FrmFristProDetail.jsp");
		String fristNameId_ = this.getRequest().getParameter("fristNameId_");
		LocalService svr = new LocalService(this, "SvrProType.queryType"); 
		Record head=svr.getDataIn().getHead();
		head.setField("fristNameId_", fristNameId_);
		if(!svr.exec()){
			throw new RuntimeException();
		}
		Map<String, String> map = new HashMap<String, String>();
		System.err.println(svr.getDataOut().getRecords().toString());
		map.put("va", svr.getDataOut().getRecords().toString());
		page.setData(map);
		return page;
			
	}
	
	//查询二级商品信息
	public IPage queryByFristId() throws Exception{
		JspPage page = new JspPage(this, "products/FrmSecondProDetail.jsp");
		String fristNameId_ = this.getRequest().getParameter("fristNameId_");
		String twoNameId_ = this.getRequest().getParameter("twoNameId_");
		String sort = this.getRequest().getParameter("sort");
		LocalService svr = new LocalService(this, "SvrRentWei.queryByFristNameId"); 
		Record head=svr.getDataIn().getHead();
		head.setField("fristNameId_", fristNameId_);
		head.setField("twoNameId_", twoNameId_);
		head.setField("sort", sort);
		if(!svr.exec()){
			throw new RuntimeException();
		}
		page.add("frist", fristNameId_);
		page.add("two", twoNameId_);
		if(!svr.getDataOut().eof()) {
		    page.add("fristName_", svr.getDataOut().getString("fristName_"));
		    page.add("twoName_", svr.getDataOut().getString("twoName_"));
		}else {
		    page.add("fristName_", "商品列表");
		}
		page.add("value", svr.getDataOut().getRecords());
		page.add("sort", sort);
		return page;
		
	}
	//跳转到搜索商品界面
	public IPage GOTOSearchProduct(){
		 JspPage jsp = new JspPage(this, "products/FrmGOTOSearch.jsp");
		 String lng = getRequest().getParameter("lng");
		 String lat = getRequest().getParameter("lat");
		 jsp.add("lng", lng);
		 jsp.add("lat", lat);
		return jsp;
		
	}
	
	
	//租赁商品搜索
	public IPage searchProduct(){
	    JspPage jsp = new JspPage(this, "products/FrmSearchProduct.jsp");
	    String submit=this.getRequest().getParameter("submit");
	    String fristNameId_=this.getRequest().getParameter("fristNameId_");
	    if(submit!=null&&!"".equals(submit)) {
	        String searchText = this.getRequest().getParameter("searchText");
	        LocalService svr = new LocalService(this,"SvrRentWei.searchProduct"); 
	        Record headIn = svr.getDataIn().getHead();
	        headIn.setField("searchText", searchText);
	        headIn.setField("fristNameId",fristNameId_);
	        if(!svr.exec()){
	            jsp.add("msg", svr.getMessage());
	            return jsp;
	        }
	        jsp.add("products", svr.getDataOut().getRecords());
	        jsp.add("searchText", searchText);
	    }
	    // 当前的经纬度
	    String lng = getRequest().getParameter("lng");
	    String lat = getRequest().getParameter("lat");
	    if (StringUtils.isEmpty(lng) || StringUtils.isEmpty(lat)) {
	        // TODO 默认地址，待删除
	        lng = "113.872166";
	        lat = "22.581929";
	    }
	    LocalService svrNear = new LocalService(this, "SvrRentWei.searchNear");
        if (!svrNear.exec("curlongitude", lng, "curlatitude", lat)) {
            jsp.add("msg", svrNear.getMessage());
            return jsp;
        }
	    jsp.add("nears", svrNear.getDataOut().getRecords());
	    jsp.add("lng", lng);
	    jsp.add("lat", lat);
	    return jsp;
	}
	
	//售卖商品搜索
	public IPage searchSaleProduct(){
		JspPage jsp = new JspPage(this, "products/FrmSearchSaleProduct.jsp");
		String submit=this.getRequest().getParameter("submit");
        String searchText = this.getRequest().getParameter("searchText");
		    if(submit!=null&&!"".equals(submit)) {
		        LocalService svr = new LocalService(this,"SvrRentWei.searchSaleProduct"); 
		        Record headIn = svr.getDataIn().getHead();
		        headIn.setField("searchText", searchText);
		        if(!svr.exec()){
		            jsp.add("msg", svr.getMessage());
		            return jsp;
		        }
		        jsp.add("saleProducts", svr.getDataOut().getRecords());
		    }
		 /*   if(!svr.exec()){
	            jsp.add("msg", svr.getMessage());
	            return jsp;
	        }*/
		    jsp.add("searchText", searchText);
		return jsp;
	}
	
	
	public boolean logon() {
		return true;
	}
}
