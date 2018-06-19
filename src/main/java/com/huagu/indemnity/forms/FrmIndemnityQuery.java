package com.huagu.indemnity.forms;

import java.util.ArrayList;
import java.util.List;

import com.huagu.common.util.ParamUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jpage.grid.MutiPage;
/**
 *  后台赔付单全查列表展示
 * @author wj  
 * @date 2018年5月22日 
 *
 */
public class FrmIndemnityQuery extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "indemnity/indemnityQuery.jsp");
		LocalService svr = new LocalService(this ,"SvrIndemnityList");
		Record head = svr.getDataIn().getHead();
		head.setField("mobile_", this.getRequest().getParameter("mobile_"));
		head.setField("homeAgency_", this.getRequest().getParameter("homeAgency_"));
		head.setField("orderId_", this.getRequest().getParameter("orderId_"));
		head.setField("proName_", this.getRequest().getParameter("proName_"));
		head.setField("payReason_", this.getRequest().getParameter("payReason_"));
		head.setField("operateId_", this.getRequest().getParameter("operateId_"));
		head.setField("payStatus_", this.getRequest().getParameter("payStatus_"));
		if(!svr.exec())
			throw new RuntimeException(svr.getMessage());
		// 缓存查询条件用做导出
        try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, this.getUserCode(), "SvrIndemnityList")) {
            buff.setField("data", svr.getDataIn().getJSON());
        }
		jsp.add("indemnitys", this.setPage(jsp, svr.getDataOut()));
		jsp.add("mobile_", this.getRequest().getParameter("mobile_"));
		jsp.add("homeAgency_", this.getRequest().getParameter("homeAgency_"));
		jsp.add("orderId_", this.getRequest().getParameter("orderId_"));
		jsp.add("proName_", this.getRequest().getParameter("proName_"));
		jsp.add("payReason_", this.getRequest().getParameter("payReason_"));
		jsp.add("operateId_", this.getRequest().getParameter("operateId_"));
		jsp.add("payStatus_", this.getRequest().getParameter("payStatus_"));
		ParamUtil.addLog(this, "查询", "查询后台 赔付单列表", "查询后台 赔付单列表");
		return jsp;
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
	 *  @date 2018年5月22日
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
	
	@Override
	public boolean logon() {
		return true;
	}

}
