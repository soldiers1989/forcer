package com.huagu.my.forms;

import java.util.HashMap;
import java.util.Map;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;

public class FrmAdrmanage extends AbstractForm{
	
	
	/**
	 * 我的收货地址列表（前台）
	 * @author 王姣
	 * @date 2018年3月22日上午9:31:47
	 * @return
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "my/placemanage.jsp");
//		String userid = this.getRequest().getParameter("userid_");
		LocalService svr = new LocalService(this, "SvrAdrManager.querydata");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("userid", 1234);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", svr.getDataOut().getRecords());
		return page;
	}
	
	
	//添加收货地址
	public IPage goIncreaseadr() throws Exception {
		JspPage page = null;
		String orderType_ =  this.getRequest().getParameter("orderType_");
		if(orderType_ == null || orderType_.equals("2")){
			page = new JspPage(this, "my/Increaseadr.jsp");
		}
		if(orderType_ != null && orderType_.equals("3")){
			page = new JspPage(this, "my/cabinetOrder.jsp");
			String userId = this.getUserCode();
			if(userId == "" || userId == null){
				userId = "13554799682";
			}
			LocalService svr = new LocalService(this, "SvrAdrManager.getDefAdr");
			if (!svr.exec("userid_",userId,"orderType_",orderType_))
				
			page.add("user", svr.getDataOut().getCurrent());
		}
		page.add("userId",  this.getRequest().getParameter("userId"));
		page.add("mode",  this.getRequest().getParameter("mode"));
		page.add("orderType_", orderType_);
		page.add("zhuCode_",  this.getRequest().getParameter("zhuCode_"));
		return page;
	}
	
	public IPage addadr() throws Exception {
		LocalService svr = new LocalService(this, "SvrAdrManager.addadr");
		String userId = this.getUserCode();
		if(userId == "" || userId == null){
			userId = "17620458925";
		}
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("userId_",userId);
		headIn.setField("name", this.getRequest().getParameter("name"));
		headIn.setField("telpho", this.getRequest().getParameter("telpho"));
		headIn.setField("adr", this.getRequest().getParameter("city-picker3"));
		headIn.setField("exactadr", this.getRequest().getParameter("exactadr_"));
		headIn.setField("def", this.getRequest().getParameter("def"));
		headIn.setField("boxId_", this.getRequest().getParameter("boxId_"));
		headIn.setField("orderType_", this.getRequest().getParameter("orderType_"));  
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		
		//return new RedirectPage(this, "Adrmanage.goIncreaseadr?userId="+this.getRequest().getParameter("userId"));
		if( this.getRequest().getParameter("mode").equals("1") &&  this.getRequest().getParameter("mode") !=null ){
			return new RedirectPage(this, "FrmOrder_Lease.addAdrEdit?userid="+this.getRequest().getParameter("userId")+"&orderType_="+this.getRequest().getParameter("orderType_")+"&zhuCode_="+this.getRequest().getParameter("zhuCode_"));
		}
		if( this.getRequest().getParameter("mode").equals("2") &&  this.getRequest().getParameter("mode") !=null ){
			return new RedirectPage(this, "FrmOrder_Lease.execute?userid="+this.getRequest().getParameter("userId")+"&orderType_="+this.getRequest().getParameter("orderType_")+"&zhuCode_="+this.getRequest().getParameter("zhuCode_"));
		}
		return new RedirectPage(this, "FrmAdrmanage");

	}

	public IPage updadr() throws Exception {
		JspPage page = new JspPage(this, "my/editadr.jsp");
		String falg = this.getRequest().getParameter("falg");
		String id = this.getRequest().getParameter("id_");
		LocalService svr = new LocalService(this, "SvrAdrManager.querydata");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("falg", falg);
		if (!svr.exec("id",id))
			throw new RuntimeException(svr.getMessage());
		page.add("values", svr.getDataOut().getCurrent());
		return page;
	}
	
	public	IPage updaddr() throws Exception {
		String id = this.getRequest().getParameter("id_");
		LocalService svr = new LocalService(this, "SvrAdrManager.adrmodify");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("id", id);
		headIn.setField("userid", 1234);
		headIn.setField("name", this.getRequest().getParameter("name"));
		headIn.setField("telpho", this.getRequest().getParameter("telpho"));
		headIn.setField("exactadr", this.getRequest().getParameter("exactadr"));
		headIn.setField("adr", this.getRequest().getParameter("city-picker3"));
		headIn.setField("remark", this.getRequest().getParameter("remark"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return new RedirectPage(this, "FrmAdrmanage");
	}
	
	public	IPage upDef() throws Exception {
		String id = this.getRequest().getParameter("id_");
		String userId = this.getRequest().getParameter("userId_");
		LocalService svr = new LocalService(this, "SvrAdrManager.adrmodify");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("id", id);
		headIn.setField("userId", userId);
		headIn.setField("upDef", "Y");
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		
		return new RedirectPage(this, "FrmAdrmanage.updadr?id_="+id+"&falg=A");
	}
	
	public void deleteadr() throws Exception {
		String id = this.getRequest().getParameter("id_");
		LocalService svr = new LocalService(this, "SvrAdrManager.deleteadr");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("id", id);
		headIn.setField("userid", 1234);
		headIn.setField("def", this.getRequest().getParameter("def"));
		String def=this.getRequest().getParameter("def");
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
	}
	
	public IPage selmation() throws Exception {
		return null;
	}
	
	//获取用户输入地址的附近柜子
	public IPage getBox() throws Exception {
		JsonPage page = new JsonPage(this);
		LocalService svr = new LocalService(this, "SvrAdrManager.getBox");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("city", this.getRequest().getParameter("city"));
		headIn.setField("exactadr_", this.getRequest().getParameter("exactadr_"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		Map<String, String> returnJson = new HashMap<>();
		returnJson.put("box", svr.getDataOut().getRecords().toString());
		page.setData(returnJson);
		return page;
	}
	
	@Override
	public boolean logon() {
		return true;
	}

}
