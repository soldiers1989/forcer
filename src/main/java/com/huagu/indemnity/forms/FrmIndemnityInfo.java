package com.huagu.indemnity.forms;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.huagu.common.util.ParamUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
import cn.cerc.jpage.grid.MutiPage;
/**
 * 	赔付单后台展示
 * @author wj  
 * @date 2018年5月9日 
 *
 */
public class FrmIndemnityInfo extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "indemnity/indemnityInfo.jsp");
		//查询用户赔付单
		LocalService svr = new LocalService(this ,"SvrIndemnityShow");
		Record head = svr.getDataIn().getHead();
		String  mobile_ = this.getRequest().getParameter("mobile_");
		head.setField("mobile_", mobile_);
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		/*jsp.add("indemnitys", svr.getDataOut().getRecords());*/
	
		
		//查询用户是否有订单（没有则不可以添加赔付单）
		 LocalService svrOrder = new LocalService(this, "SvrCheckUserOrder");
		 Record headIn = svrOrder.getDataIn().getHead();
		 headIn.setField("mobile_", mobile_);
		 if(!svrOrder.exec()){
			 throw new RuntimeException(svr.getMessage());
		 }
		 jsp.add("orderNum", svrOrder.getDataOut().getHead().getInt("orderNum"));
		jsp.add("indemnitys", this.setPage(jsp, svr.getDataOut()));
		jsp.add("mobile_", mobile_);
		ParamUtil.addLog(this, "查询", "查询后台用户赔付单列表", "查询后台用户赔付单列表");
		return jsp;
	}
   
	 /**
	  *  查询用户是否有订单（没有则不可以添加赔付单）
	  *  @author wj  
	  *  @date 2018年5月29日
	  */
	 public IPage checkUserOrder() throws Exception{
		 JsonPage json = new JsonPage(this);
		 String  mobile_ = this.getRequest().getParameter("mobile_");
		 LocalService svrOrder = new LocalService(this, "SvrCheckUserOrder");
			Record headIn = svrOrder.getDataIn().getHead();
			headIn.setField("mobile_", mobile_);
			if(!svrOrder.exec()){
				json.setData(false);
			}else{
				json.setData(true);
			}
			return json;
			
	/*		jsp.add("orderNum", svrOrder.getDataOut().getHead().getInt("orderNum"));*/
	 }
	
	// 设置分页
		private List<Record> setPage(AbstractJspPage page, DataSet dataSet) {
			List<Record> records = null;
			MutiPage pages = new MutiPage();
			pages.setRequest(getRequest());
			pages.setDataSet(dataSet);
			pages.setPageSize(20);
			page.add("pages", pages);
			if (dataSet.size() > 0) {
				records = new ArrayList<>();
				for (int i = pages.getBegin(); i <= pages.getEnd(); i++) {
					dataSet.setRecNo(i + 1);
					Record record = dataSet.getCurrent();
					records.add(record);
				}
			}
			return records;
		}
	
	/**
	 *  查看详情
	 *  @author wj  
	 *  @date 2018年5月10日  
	 */
	public IPage indemnityLook() throws Exception{
		JspPage jsp = new JspPage(this, "indemnity/indemnityLook.jsp");
		LocalService svr = new LocalService(this, "SvrIndemnityDetails");
		Record head = svr.getDataIn().getHead();
		head.setField("orderId_", this.getRequest().getParameter("orderId_"));
		head.setField("operateId_", this.getRequest().getParameter("operateId_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("details", svr.getDataOut().getCurrent());
		ParamUtil.addLog(this, "查询", "查询后台赔付单详情", "查询后台赔付单详情");
		return jsp;
	}
	
	/**
	 *  修改赔付单信息
	 *  @author wj  
	 *  @date 2018年5月10日 
	 */  
	public IPage updateIndemnity() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up!= null && up.equals("up")){
			LocalService svr = new LocalService(this, "SvrIndemnityUpdate");
			Record head = svr.getDataIn().getHead();
			head.setField("orderId_", this.getRequest().getParameter("orderId_"));
			head.setField("payReason_", this.getRequest().getParameter("payReason_"));
			head.setField("successMoney_", this.getRequest().getParameter("successMoney_"));
			head.setField("suggestMoney_", this.getRequest().getParameter("suggestMoney_"));
			head.setField("suggest_", this.getRequest().getParameter("suggest_"));
			head.setField("payDesc_", this.getRequest().getParameter("payDesc_"));
			head.setField("payRemark_", this.getRequest().getParameter("payRemark_"));
			head.setField("userId_", this.getRequest().getParameter("userId_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			ParamUtil.addLog(this, "修改", "后台修改用户赔付单信息", "后台修改赔付单信息");
			return new RedirectPage(this, "FrmIndemnityInfo?mobile_="+this.getRequest().getParameter("userId_"));
		}else{
			JspPage jsp = new JspPage(this, "indemnity/indemnityUpdate.jsp");
			//得到要修改的信息
			LocalService svr = new LocalService(this,"SvrUserAndIndemnity");
			Record head = svr.getDataIn().getHead();
			String orderId_ = this.getRequest().getParameter("orderId_");
			String mobile_ = this.getRequest().getParameter("mobile_");
			String payID_ = this.getRequest().getParameter("payID_");
			head.setField("orderId_", orderId_);
			if(!svr.exec()){
				throw new RuntimeException(svr.getMessage());
			}
			jsp.add("info", svr.getDataOut().getCurrent());
			
			//得到赔付单号相关联的租赁订单信息
			LocalService svrOrder = new LocalService(this, "SvrOrderInfo");
			Record headIn = svrOrder.getDataIn().getHead();
			headIn.setField("mobile_", mobile_);
			headIn.setField("payID_", payID_);
			headIn.setField("orderId_", orderId_);
			if(!svrOrder.exec("select","select")){
				throw new RuntimeException(svr.getMessage());
			}
			jsp.add("orderinfo", svrOrder.getDataOut().getRecords());
			jsp.add("mobile_", mobile_);
			jsp.add("payID_", payID_);
			jsp.add("orderId_", orderId_);
			
			//查询商品的历史运维情况
			LocalService yeRecords = new LocalService(this, "SvrGetywRecords");
			Record headYW = yeRecords.getDataIn().getHead();
			headYW.setField("orderId_", orderId_);
			if(!yeRecords.exec()){
				throw new RuntimeException(yeRecords.getMessage());
			}
			jsp.add("yeRecords", yeRecords.getDataOut().getRecords());
		
			return jsp;
		}
	}
	
	/**
	 *  添加赔付单信息
	 *  @author wj    
	 *  @date 2018年5月10日
	 */
	public IPage toIndemnityInsert() throws Exception{
		JspPage jsp = new JspPage(this, "indemnity/indemnityInsert.jsp");
		LocalService svr = new LocalService(this, "SvrGetOrderInfo");
		Record head = svr.getDataIn().getHead();
		String  userId_ = this.getRequest().getParameter("userId_");
		String orderId_ = this.getRequest().getParameter("orderId_");
		String mobile_ = this.getRequest().getParameter("mobile_");
		head.setField("mobile_", mobile_);
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("info", svr.getDataOut().getCurrent());
		
		//进入页面就产生赔付单号
		String  date = new  SimpleDateFormat("yyyyMMdd").format(new Date());   
		String str = date.substring(2, 8);
		String  guids = new String();
		String random = getRandom();
		guids="PF"+str+"112233"+random;
		
		
		if(orderId_!= null && mobile_ != null ){
		//根据查询的用户，以及输入的订单号，查询订单信息
		LocalService orderinfo = new LocalService(this, "SvrGetOrderInfos");
		Record headIn = orderinfo.getDataIn().getHead();	
		headIn.setField("userId_", userId_);
		headIn.setField("orderId_", orderId_);
		headIn.setField("mobile_", mobile_);
		if(!orderinfo.exec()){
			throw new RuntimeException(orderinfo.getMessage());
		}
		jsp.add("orderinfo", orderinfo.getDataOut().getRecords());
		jsp.add("orderId_", orderId_);
		jsp.add("mobile_", mobile_);
		//查询商品的历史运维情况
		LocalService yeRecords = new LocalService(this, "SvrGetywRecords");
		Record headYW = yeRecords.getDataIn().getHead();
		headYW.setField("orderId_", orderId_);
		if(!yeRecords.exec()){
			throw new RuntimeException(yeRecords.getMessage());
		}
		jsp.add("yeRecords", yeRecords.getDataOut().getRecords());
		}
		jsp.add("guids", guids);
		return jsp;
	}
	
	/**
	 *  添加赔付单
	 *  @author wj  
	 *  @date 2018年5月14日  
	 */
	public IPage indemnityInsert() throws Exception{
		LocalService svr = new LocalService(this, "SvrIndemnityInsert");
		Record head = svr.getDataIn().getHead();
		head.setField("payID_", this.getRequest().getParameter("payID_"));
		head.setField("payReason_", this.getRequest().getParameter("payReason_"));
		head.setField("suggestMoney_", this.getRequest().getParameter("suggestMoney_"));
		head.setField("successMoney_", this.getRequest().getParameter("successMoney_"));
		head.setField("suggest_", this.getRequest().getParameter("suggest_"));
		head.setField("payDesc_", this.getRequest().getParameter("payDesc_"));
		head.setField("payRemark_", this.getRequest().getParameter("payRemark_"));
		head.setField("userId_", this.getRequest().getParameter("userId_"));
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		ParamUtil.addLog(this, "添加", "后台为用户添加赔付单", "后台为用户添加赔付单");
		return new RedirectPage(this, "FrmIndemnityInfo?mobile_="+this.getRequest().getParameter("userId_"));
	}
	
	//随机产生赔付单号后七位
	public String getRandom() throws Exception{
		//查询最近一次的赔付单号
		LocalService svr = new LocalService(this, "SvrGetLastPayID");
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		String payID="";
		String lastPayId = svr.getDataOut().getHead().getString("payID_");
		if(lastPayId == null || lastPayId == ""){
			  payID = "000000";
		}else{ 
			String id = lastPayId.substring(14, 20);
			long str = Long.parseLong(id);
			long payID_=str+1;
			if(str<=9999999){
				payID=String.valueOf(payID_);
				//拼接0
				String aa="";
				for(int i = payID.length();i<6;i++){
					aa += "0" ;
				}
				payID=aa+payID;
			}else{
				return "false";
			}
		}
		return payID;
	}
	/**
	 *  赔付单生效
	 *  @author wj  
	 *  @date 2018年5月11日  
	 */
	public IPage effectIndemnity()  throws Exception{
		JsonPage json = new JsonPage(this);
		LocalService svr = new LocalService(this, "SvrOperateIndemnity");
		Record head = svr.getDataIn().getHead();
		head.setField("orderId_", this.getRequest().getParameter("orderId_"));
		head.setField("operateId_", this.getRequest().getParameter("operateId_"));
		head.setField("payState_", this.getRequest().getParameter("payState_"));
		if(!svr.exec()){
			json.setData(false);
			throw new RuntimeException(svr.getMessage());
		}
		json.setData(true);
		return  json;
	}
	
	/**
	 *  赔付单失效
	 *  @author wj  
	 *  @date 2018年5月11日  
	 */
	public IPage invalidIndemnity()  throws Exception{
		JsonPage json = new JsonPage(this);
		LocalService svr = new LocalService(this, "SvrInvalidIndemnity");
		Record head = svr.getDataIn().getHead();
		head.setField("orderId_", this.getRequest().getParameter("orderId_"));
		head.setField("operateId_", this.getRequest().getParameter("operateId_"));
		head.setField("payState_", this.getRequest().getParameter("payState_"));
		if(!svr.exec()){
			json.setData(false);
			throw new RuntimeException(svr.getMessage());
		}
		json.setData(true);
		return  json;
	}
	
	/**
	 *  查看订单详情
	 *  @author wj  
	 *  @date 2018年5月11日
	 */
	public IPage orderDetails() throws Exception{
		JspPage jsp = new JspPage(this, "indemnity/orderIndemnityDetails.jsp");
		LocalService svrOrder = new LocalService(this, "SvrOrderInfo");
		Record headIn = svrOrder.getDataIn().getHead();
		String orderId_ = this.getRequest().getParameter("orderId_");
		String mobile_ = this.getRequest().getParameter("mobile_");
		String payID_ = this.getRequest().getParameter("payID_");
		headIn.setField("mobile_", mobile_);
		headIn.setField("payID_", payID_);
		headIn.setField("orderId_", orderId_);
		if(!svrOrder.exec()){
			throw new RuntimeException(svrOrder.getMessage());
		}
		jsp.add("details", svrOrder.getDataOut().getCurrent());
		ParamUtil.addLog(this, "查询", "查询后台订单详情", "查询后台订单详情");
		return jsp;
	}
	
	/**
	 *  查看运维协议
	 *  @author wj  
	 *  @date 2018年5月12日  
	 */
	public IPage ywAgreement() throws Exception{
		JspPage jsp = new JspPage(this, "indemnity/ywAgreement.jsp");
		LocalService svr= new LocalService(this, "SvrInformationList.infoDetail");
		Record head = svr.getDataIn().getHead();
		head.setField("type_", this.getRequest().getParameter("type_"));
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		jsp.add("ywagreement", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	/**
	 * 删除关联运维单
	 *  @author wj  
	 *  @date 2018年5月12日  
	 */
	public IPage deleteYWLists() throws Exception{
		LocalService svr = new LocalService(this, "SvrDeleteYWlist");
		Record head = svr.getDataIn().getHead();
		head.setField("orderId_", this.getRequest().getParameter("orderId_"));
		head.setField("operateId_", this.getRequest().getParameter("operateId_"));
		if(!svr.exec()){
			throw new  RuntimeException(svr.getMessage());
		}
		ParamUtil.addLog(this, "删除", "后台删除关联运维单", "后台删除关联运维单");
		return new 	RedirectPage(this, "FrmIndemnityInfo");
	}
	
	/**
	 *  转手工结算
	 *  @author wj     
	 *  @date 2018年5月14日
	 */
	public IPage toHandSettle() throws Exception{
		JsonPage json = new JsonPage(this);
		LocalService svr = new LocalService(this, "SvrToHandSettle");
		Record head = svr.getDataIn().getHead();
		head.setField("orderId_", this.getRequest().getParameter("orderId_"));
		if(!svr.exec()){
			json.setData(false);
		}else{
			json.setData(true);
		}
		return json;
	}
	
	/**
	 *   手工结算
	 *  @author wj  
	 *  @date 2018年5月14日
	 */
	public IPage handSettle() throws Exception{
		JsonPage json = new JsonPage(this);
		LocalService svr = new LocalService(this, "SvrHandSettle");
		Record head = svr.getDataIn().getHead();
		head.setField("orderId_", this.getRequest().getParameter("orderId_"));
		if(!svr.exec()){
			json.setData(false);
		}else{
			json.setData(true);
		}
		return json;
	}
	@Override
	public boolean logon() {
		return true;
	}
}
