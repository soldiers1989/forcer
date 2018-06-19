package com.huagu.agentAndCom.forms;

import java.util.ArrayList;
import java.util.List;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
import cn.cerc.jpage.grid.MutiPage;
/**
 *  @describe 社区管理
 *  @author 王姣
 *  @date   2018年3月26日上午11:40:49
 *  @return
 */
public class FrmCommunity extends AbstractForm {

	/**
	 *  @describe  社区列表查询
	 *  @author 王姣
	 *  @date   2018年3月26日上午11:42:22
	 *  @return
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "agentCom/agentQuery.jsp");
		LocalService svr = new LocalService(this, "SvrComQuery");
		if(!svr.exec())
			throw new Exception(svr.getMessage());
		jsp.add("coms", this.setPage(jsp, svr.getDataOut()));
		return jsp;
	}	
	
	
	// 设置分页
	private List<Record> setPage(AbstractJspPage page, DataSet dataSet) {
		List<Record> records = null;
		MutiPage pages = new MutiPage();
		pages.setRequest(getRequest());
		pages.setDataSet(dataSet);
		pages.setPageSize(2);
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
	 * 添加社区
	 * @author 王姣
	 * @date 2018年3月26日下午3:20:18
	 * @return    
	 */
	public IPage insertCommunity() throws Exception{
		String in = this.getRequest().getParameter("in");
		if(in != null && in.equals("in")){
			LocalService svr = new LocalService(this, "SvrInsertCommunity");
			Record head = svr.getDataIn().getHead();
			head.setField("communityName_", this.getRequest().getParameter("communityName_"));
			head.setField("communityJname_", this.getRequest().getParameter("communityJname_"));
			head.setField("wuYeJname_", this.getRequest().getParameter("wuYeJname_"));
			head.setField("wuYeName_", this.getRequest().getParameter("wuYeName_"));
			head.setField("wuYePhone_", this.getRequest().getParameter("wuYePhone_"));
			head.setField("communityArea_", this.getRequest().getParameter("communityArea_"));
			head.setField("doorPlate_", this.getRequest().getParameter("doorPlate_"));
			head.setField("address_", this.getRequest().getParameter("address_"));
			head.setField("area_", this.getRequest().getParameter("area_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmAgent");
		}else{
			JspPage jsp = new JspPage(this, "com/insertCommunity.jsp");
			return jsp;
		}
		
	}
	
	/**
	 * 修改社区信息
	 * @author 王姣
	 * @date 2018年3月27日上午9:28:17
	 * @return
	 */
	public IPage modifyCommunity() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up != null && up.equals("up")){
			LocalService svr = new LocalService(this ,"SvrComModify");
			Record head = svr.getDataIn().getHead();
			head.setField("communityJname_", this.getRequest().getParameter("communityJname_"));
			head.setField("wuYeJname_", this.getRequest().getParameter("wuYeJname_"));
			head.setField("wuYeName_", this.getRequest().getParameter("wuYeName_"));
			head.setField("wuYePhone_", this.getRequest().getParameter("wuYePhone_"));
			head.setField("communityArea_", this.getRequest().getParameter("communityArea_"));
			head.setField("doorPlate_", this.getRequest().getParameter("doorPlate_"));
			head.setField("address_", this.getRequest().getParameter("address_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			return new RedirectPage(this, "FrmAgent");
		}else{
			JspPage jsp = new JspPage(this, "com/modifyCommunity.jsp");
			LocalService svr = new LocalService(this, "SvrGetComById");
			Record head = svr.getDataIn().getHead();
			head.setField("communityId_", this.getRequest().getParameter("communityId_"));
			if(!svr.exec())
				throw new RuntimeException(svr.getMessage());
			jsp.add("com", svr.getDataOut().getCurrent());
			return jsp;
		}
	}
	
	/**
	 * 变更社区代理挂靠
	 * @author 王姣
	 * @date 2018年3月28日上午10:39:15
	 * @return  
	 */
	public IPage changeCom() throws Exception{
		String up = this.getRequest().getParameter("up");
		if(up != null && up.equals("up")){
			LocalService svr = new LocalService(this, "SvrChangeCom");
			Record head = svr.getDataIn().getHead();
			head.setField("communityId_", this.getRequest().getParameter("communityId_"));
			head.setField("communityJname_", this.getRequest().getParameter("communityJname_"));
			head.setField("wuYeJname_", this.getRequest().getParameter("wuYeJname_"));
			head.setField("address_", this.getRequest().getParameter("address_"));
			if(!svr.exec()){
				throw new RuntimeException(svr.getMessage());
			}
			return new RedirectPage(this, "FrmAgent");
		}else{
			JspPage jsp = new JspPage(this, "com/changeCom.jsp");
			String   communityId_ = this.getRequest().getParameter("communityId_");
			//拿到要变更的数据
			LocalService svr = new LocalService(this, "SvrGetComById");
			Record head = svr.getDataIn().getHead();
			head.setField("communityId_", communityId_);
			if(!svr.exec()){
				throw new RuntimeException(svr.getMessage());
			}
			
			//查询当前挂靠代理
			LocalService svrAgent = new LocalService(this, "SvrComAgentQuery");
			if(!svrAgent.exec("communityId_",communityId_)){
				throw new RuntimeException(svrAgent.getMessage());
			}
			jsp.add("agents", svrAgent.getDataOut().getRecords());
			jsp.add("change", svr.getDataOut().getCurrent());
			return jsp;
		}
	}
	
	/**
	 * 删除代理挂靠
	 * @author 王姣
	 * @date 2018年3月28日下午2:20:41
	 * @return 
	 */
	public IPage deleteAgent() throws Exception{
		LocalService svr = new LocalService(this, "SvrDeleteComAgent");
		Record head = svr.getDataIn().getHead();
		head.setField("agentId_", this.getRequest().getParameter("agentId_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return new RedirectPage(this, "FrmAgent");
	}
	
	/**
	 * 删除社区信息
	 * @author 王姣
	 * @date 2018年3月31日上午9:37:57
	 * @return 
	 */
	public IPage deleteCom() throws Exception{
		LocalService svr = new LocalService(this, "SvrDeleteCom");
		Record head = svr.getDataIn().getHead();
		head.setField("communityId_", this.getRequest().getParameter("communityId_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return new RedirectPage(this, "FrmAgent");
	}
	
	/**
	 * 添加省级代理（逻辑有问题，暂时搁置，需要和金秀沟通）
	 * @author 王姣
	 * @date 2018年3月31日上午10:21:14
	 * @return
	 */
	public IPage insertProvinceAgent() throws Exception{
		String in = this.getRequest().getParameter("in");
		if(in != null && in.equals("in")){
			LocalService svr = new LocalService(this, "SvrProvinceAgent");
			Record head = svr.getDataIn().getHead();
			head.setField("agentNo_", this.getRequest().getParameter("agentNo_"));
			head.setField("agentJname_", this.getRequest().getParameter("agentJname_"));
			head.setField("agentName_", this.getRequest().getParameter("agentName_"));
			head.setField("agentArea_", this.getRequest().getParameter("agentArea_"));
			return new RedirectPage(this, "FrmAgent");
		}else{
			JspPage jsp = new JspPage(this, "agentCom/provinceAgent.jsp");
/*			LocalService svr = new LocalService(this, "SvrGetComById");
			Record head = svr.getDataIn().getHead();
			head.setField("communityId_", this.getRequest().getParameter("communityId_"));
			if(!svr.exec()){
				throw new RuntimeException(svr.getMessage());
			}
			jsp.add("province", svr.getDataOut().getCurrent());
*/			return jsp;
		}
		
	}
	@Override
	public boolean logon() {
		return true;
	}

}
