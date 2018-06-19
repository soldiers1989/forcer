package com.huagu.agentAndCom.forms;

import java.util.HashMap;
import java.util.Map;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;

/**
 *  @describe 区域管理
 *  @author 王姣
 *  @date   2018年3月31日上午11:18:27
 *  @return  
 */ 
public class FrmArea extends AbstractForm {

	/**
	 *  @describe 区域列表查询（后台）
	 *  @author 王姣
	 *  @date   2018年3月31日上午11:19:05
	 *  @return
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "area/areaList.jsp");
		//查询国家
		LocalService svr = new LocalService(this, "SvrAreaQuery");
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());	
		jsp.add("country", svr.getDataOut().getCurrent());
				
		return jsp;
	}
	
	/**
	 * 	根据国家查询省
	 *  @author wj  
	 *  @date 2018年5月29日
	 */
	public IPage queryProvince() throws Exception{
		JsonPage jspage=new JsonPage(this);
		//根据国家查询省	
		LocalService svrProvince = new LocalService(this, "SvrQueryProvince");
		Record headIn = svrProvince.getDataIn().getHead();
		headIn.setField("country_", this.getRequest().getParameter("country_"));
		if(!svrProvince.exec())
			throw new RuntimeException(svrProvince.getMessage());	
	//	jsp.add("provinces", svrProvince.getDataOut().getRecords());
		Map<String, String> map = new HashMap<String, String>();
	
		map.put("va",svrProvince.getDataOut().getRecords().toString());
		jspage.setData(map);
		return jspage;
		}
	
	/**
	 * 	根据省	查询市
	 *  @author wj  
	 *  @date 2018年5月29日
	 */
	public IPage queryCity() throws Exception{
		JsonPage jspage=new JsonPage(this);
		//根据省	查询市
		LocalService svrCity = new LocalService(this, "SvrCityShow");
		Record head = svrCity.getDataIn().getHead();
		head.setField("country_", this.getRequest().getParameter("country_"));
		if(!svrCity.exec())
			throw new RuntimeException(svrCity.getMessage());	
		/*	jsp.add("citys", svrCity.getDataOut().getRecords());*/
		Map<String, String> map = new HashMap<String, String>();
	
		map.put("va",svrCity.getDataOut().getRecords().toString());
		jspage.setData(map);
		return jspage;
		}
	
	/**
	 * 	根据市查询区域
	 *  @author wj  
	 *  @date 2018年5月29日
	 */
	public IPage queryAera() throws Exception{
		JsonPage jspage=new JsonPage(this);
		//根据市查询区域
		LocalService svrArea = new LocalService(this, "SvrAreaShow");
		Record headArea = svrArea.getDataIn().getHead();
		headArea.setField("country_", this.getRequest().getParameter("country_"));
		if(!svrArea.exec())
			throw new RuntimeException(svrArea.getMessage());	
		/*jsp.add("areas", svrArea.getDataOut().getRecords());*/
	Map<String, String> map = new HashMap<String, String>();

	map.put("va",svrArea.getDataOut().getRecords().toString());
	jspage.setData(map);
	return jspage;
	}
	
	/**
	 * 查看区域详情
	 * @author 王姣
	 * @date 2018年3月31日下午2:02:56
	 * @return  
	 */
	public IPage areaDetails() throws Exception{
		JspPage jsp = new JspPage(this, "area/areaDetail.jsp");
		LocalService svr = new LocalService(this, "SvrAreaDetail");
		Record head = svr.getDataIn().getHead();
		head.setField("UID_", this.getRequest().getParameter("UID_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("area", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	/**
	 * 区域修改
	 * @author 王姣
	 * @date 2018年3月31日下午2:41:42
	 * @return
	 */
	public IPage areaModify() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up != null && up.equals("up")){
			LocalService svr = new LocalService(this ,"SvrAreaModify");
			Record head = svr.getDataIn().getHead();
			head.setField("UID_", this.getRequest().getParameter("UID_"));
			head.setField("province_", this.getRequest().getParameter("province_"));
			head.setField("city_", this.getRequest().getParameter("city_"));
			head.setField("area_", this.getRequest().getParameter("area_"));
			head.setField("areaNum_", this.getRequest().getParameter("areaNum_"));
			head.setField("areaType_", this.getRequest().getParameter("areaType_"));
			head.setField("remark_", this.getRequest().getParameter("remark_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmArea");
		}else{
			JspPage jsp = new JspPage(this, "area/areaModify.jsp");
			LocalService svr = new LocalService(this, "SvrAreaDetail");
			Record head = svr.getDataIn().getHead();
			head.setField("UID_", this.getRequest().getParameter("UID_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			jsp.add("areas", svr.getDataOut().getCurrent());
			jsp.add("area", this.getRequest().getParameter("area"));
			return jsp;
		}
	}
	
	/**
	 * 删除区域信息
	 * @author 王姣
	 * @date 2018年3月31日下午3:27:46
	 * @return 
	 */ 
	public IPage areaDelete() throws Exception{
		LocalService svr = new LocalService(this, "SvrAreaDelete");
		Record head = svr.getDataIn().getHead();
		head.setField("UID_", this.getRequest().getParameter("UID_"));
		head.setField("area", this.getRequest().getParameter("area"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return new RedirectPage(this, "FrmArea");
	}
	
	/**
	 * 添加区域
	 * @author 王姣
	 * @date 2018年3月31日下午3:37:38
	 * @return  
	 */
	public IPage areaInsert() throws Exception{
		String in = this.getRequest().getParameter("in");
		if(in != null && in.equals("in")){
			LocalService svr = new LocalService(this ,"SvrAreaInsert");
			Record head = svr.getDataIn().getHead();
			head.setField("province_", this.getRequest().getParameter("province_"));
			head.setField("city_", this.getRequest().getParameter("city_"));
			head.setField("area_", this.getRequest().getParameter("area_"));
			head.setField("areaNum_", this.getRequest().getParameter("areaNum_"));
			head.setField("areaType_", this.getRequest().getParameter("areaType_"));
			head.setField("remark_", this.getRequest().getParameter("remark_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmArea");
		}else{
			JspPage jsp = new JspPage(this, "area/areaInsert.jsp");
			return jsp;
		}
	}
	
	@Override
	public boolean logon() {
		return true;
	}
}
