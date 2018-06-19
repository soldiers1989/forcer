package com.huagu.order.forms;

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
 *  按社区归属订单查询
 * @author wj  
 * @date 2018年5月24日 
 *
 */
public class FrmCommunityOrders extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "order/communityOrders.jsp");
		LocalService svr = new LocalService(this, "SvrCommOrdersQuery");
		Record head = svr.getDataIn().getHead();
		head.setField("proName_", this.getRequest().getParameter("proName_"));
		head.setField("payTime", this.getRequest().getParameter("payTime"));
		head.setField("orderId_", this.getRequest().getParameter("orderId_"));
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		// 缓存查询条件用做导出
        try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, this.getUserCode(), "SvrCommOrdersQuery")) {
            buff.setField("data", svr.getDataIn().getJSON());
        }
		jsp.add("commorders", this.setPage(jsp, svr.getDataOut()));
		jsp.add("proName_", this.getRequest().getParameter("proName_"));
		jsp.add("payTime", this.getRequest().getParameter("payTime"));
		jsp.add("orderId_", this.getRequest().getParameter("orderId_"));
		ParamUtil.addLog(this, "查询", "查询后台按社区归属订单", "查询后台按社区归属订单");
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

	@Override
	public boolean logon() {
		return true;
	}
}
