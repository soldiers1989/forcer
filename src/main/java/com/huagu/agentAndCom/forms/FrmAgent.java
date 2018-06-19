package com.huagu.agentAndCom.forms;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

public class FrmAgent extends AbstractForm {

	/**
	 *  @describe  代理商管理列表(后台)
	 *  @author 王姣
	 *  @date   2018年3月23日上午8:58:46
	 *  @return      
	 */  
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "agentCom/agentQuery.jsp");
		LocalService svrAgent = new LocalService(this, "SvrAgentQuery");
		Record head = svrAgent.getDataIn().getHead();
		head.setField("agentJname_", this.getRequest().getParameter("agentJname_"));
		if(!svrAgent.exec())
			throw new RuntimeException(svrAgent.getMessage());
		jsp.add("agentJname_", this.getRequest().getParameter("agentJname_"));
		jsp.add("agents", svrAgent.getDataOut().getRecords());
		
		
		LocalService svrCom = new LocalService(this, "SvrComQuery");
		Record headIn = svrCom.getDataIn().getHead();
		headIn.setField("communityJname_", this.getRequest().getParameter("communityJname_"));
		if(!svrCom.exec())
			throw new Exception(svrCom.getMessage());
		jsp.add("coms", this.setPage(jsp,svrCom.getDataOut()));
		jsp.add("communityJname_", this.getRequest().getParameter("communityJname_"));
		return jsp;
	}
	
	// 设置分页
	private List<Record> setPage(AbstractJspPage page, DataSet dataSet) {
		List<Record> records = null;
		MutiPage pages = new MutiPage();
		pages.setRequest(getRequest());
		pages.setDataSet(dataSet);
		pages.setPageSize(10);
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
	 * 查看关联社区详情（后台）
	 * @author 王姣
	 * @date 2018年3月23日下午2:13:51
	 * @return
	 */
	public IPage linkSheQu() throws Exception{
		JspPage jsp = new JspPage(this, "agentCom/comDetails.jsp");
		LocalService svr = new LocalService(this, "SvrComsQuery");
		Record head = svr.getDataIn().getHead();
		head.setField("agentId_", this.getRequest().getParameter("agentId_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		jsp.add("com", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	/**
	 * 修改代理商信息
	 * @author 王姣
	 * @date 2018年3月23日下午3:45:06
	 * @return
	 */
	public IPage agentModify() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up != null && up.equals("up")){
			LocalService svr = new LocalService(this, "SvrAgentModify");
			Record head = svr.getDataIn().getHead();
			head.setField("UID_", this.getRequest().getParameter("UID_"));
			head.setField("agentNo_", this.getRequest().getParameter("agentNo_"));
			head.setField("agentJname_", this.getRequest().getParameter("agentJname_"));
			head.setField("agentName_", this.getRequest().getParameter("agentName_"));
			head.setField("agentLevel_", this.getRequest().getParameter("agentLevel_"));
			head.setField("agentArea_", this.getRequest().getParameter("agentArea_"));
			head.setField("areaid_", this.getRequest().getParameter("areaid_"));
			head.setField("province_", this.getRequest().getParameter("province_"));
			head.setField("city_", this.getRequest().getParameter("city_"));
			head.setField("area_", this.getRequest().getParameter("area_"));
			if(!svr.exec()){	
				throw new RuntimeException(svr.getMessage());
			}
			return new RedirectPage(this, "FrmAgent");
		}else{
			JspPage jsp = new JspPage(this, "agentCom/agentMpdify.jsp");
			LocalService svr = new LocalService(this, "SvrAgentDetails");
			Record head = svr.getDataIn().getHead();
			String communityId_ =  this.getRequest().getParameter("communityId_");
			String agentId_ =  this.getRequest().getParameter("agentId_");
			head.setField("agentId_", agentId_);
			head.setField("communityId_",communityId_);
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			jsp.add("agent", svr.getDataOut().getCurrent());
			
			
			//查询所属的省市区
			LocalService svr1 = new LocalService(this, "SvrGetAgentArea");
			Record headIn =svr1.getDataIn().getHead();
			headIn.setField("agentId_", agentId_);
			if(!svr1.exec()){
				throw new RuntimeException(svr1.getMessage());
			}
			jsp.add("area", svr1.getDataOut().getCurrent());
			return jsp;
		}
	}
	
	/**
	 * 添加代理商
	 * @author 王姣
	 * @date 2018年3月23日下午5:12:00
	 * @return
	 */
	public IPage insertAgent() throws Exception{
		String in = this.getRequest().getParameter("in");
		if(in != null && in.equals("in")){
			LocalService svr = new LocalService(this, "SvrAgentInsert");
			Record head = svr.getDataIn().getHead();
			head.setField("areaid_", this.getRequest().getParameter("areaid_"));
			head.setField("province_", this.getRequest().getParameter("province_"));
			head.setField("city_", this.getRequest().getParameter("city_"));
			head.setField("area_", this.getRequest().getParameter("area_"));
			head.setField("agentNo_", this.getRequest().getParameter("agentNo_"));
			head.setField("agentJname_", this.getRequest().getParameter("agentJname_"));
			head.setField("agentName_", this.getRequest().getParameter("agentName_"));
			head.setField("agentLevel_", this.getRequest().getParameter("agentLevel_"));
			head.setField("agentArea_", this.getRequest().getParameter("agentArea_"));
			if(!svr.exec()){
				throw new RuntimeException(svr.getMessage());
			}
			return new RedirectPage(this, "FrmAgent");
		}else{
			JspPage jsp = new JspPage(this, "agentCom/agentInsert.jsp");
			return jsp;
		}
		
	}
	
	/**
	 * 删除代理商信息
	 * @author 王姣
	 * @date 2018年3月23日下午5:35:56
	 * @return
	 */
	public IPage deleteAgent() throws Exception{
		LocalService svr = new LocalService(this, "SvrAgentDelete");
		Record head = svr.getDataIn().getHead();
		head.setField("UID_", this.getRequest().getParameter("UID_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return new RedirectPage(this, "FrmAgent");
	}
	
	/**
	 * 变更代理商的社区管辖
	 * @author 王姣
	 * @date 2018年3月29日上午9:51:55
	 * @return  
	 */
	public IPage changeAgent() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up != null &&up.equals("up")){
			LocalService svr = new LocalService(this, "SvrChangeAgent");
			Record head = svr.getDataIn().getHead();
			head.setField("agentId_", this.getRequest().getParameter("agentId_"));
			head.setField("agentNo_", this.getRequest().getParameter("agentNo_"));
			head.setField("agentJname_", this.getRequest().getParameter("agentJname_"));
			head.setField("agentName_", this.getRequest().getParameter("agentName_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmAgent");
		}else{
			JspPage jsp = new JspPage(this, "agentCom/changeAgent.jsp");
			LocalService svr = new LocalService(this,"SvrGetChangeAgent");
			Record head = svr.getDataIn().getHead();
			String  agentId_ = this.getRequest().getParameter("agentId_");
			head.setField("agentId_", agentId_);
			if(!svr.exec())
				throw  new RuntimeException(svr.getMessage());
			
			//查询当前管辖社区
			LocalService svrCom = new LocalService(this ,"SvrComsQuery");
			Record headIn = svrCom.getDataIn().getHead();
			headIn.setField("agentId_", agentId_);
			if(!svrCom.exec())
				throw  new RuntimeException(svrCom.getMessage());
			
			jsp.add("coms", svrCom.getDataOut().getRecords());
			jsp.add("change", svr.getDataOut().getCurrent());
			return jsp;
		}
		
	}
	
	/**
	 * 查询省份
	 * @author 王姣
	 * @date 2018年4月2日下午5:05:13
	 * @return
	 */
	public IPage selectProvince() throws Exception{
		JsonPage jspage=new JsonPage(this);
		LocalService svrProvince = new LocalService(this, "SvrQueryAddress");
		if(!svrProvince.exec())
			throw new RuntimeException();
		Map<String, String> map = new HashMap<String, String>();

		map.put("provinces", svrProvince.getDataOut().getRecords().toString());
		jspage.setData(map);
		return jspage;
	}
	
	
	/**
	 * 查询市
	 * @author 王姣
	 * @date 2018年4月2日下午5:05:13
	 * @return
	 */
	public IPage selectCity() throws Exception{
		JsonPage jspage=new JsonPage(this);
		LocalService svrCity = new LocalService(this, "SvrQueryCityArea");
		Record head = svrCity.getDataIn().getHead();
		head.setField("province_", this.getRequest().getParameter("province_"));
		if(!svrCity.exec())
			throw new RuntimeException();
		Map<String, String> map = new HashMap<String, String>();

		map.put("citys", svrCity.getDataOut().getRecords().toString());
		jspage.setData(map);
		return jspage;
	}
	
	
	/**
	 * 查询区
	 * @author 王姣
	 * @date 2018年4月2日下午5:05:13
	 * @return
	 */
	public IPage selectArea() throws Exception{
		JsonPage jspage=new JsonPage(this);
		LocalService svrArea = new LocalService(this, "SvrQueryArea");
		Record head = svrArea.getDataIn().getHead();
		head.setField("city_", this.getRequest().getParameter("city_"));
		if(!svrArea.exec())
			throw new RuntimeException();
		Map<String, String> map = new HashMap<String, String>();

		map.put("areas", svrArea.getDataOut().getRecords().toString());
		jspage.setData(map);
		return jspage;
	}
	
	@Override
	public boolean logon() {     
		return true;
	}
}
