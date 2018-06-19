package com.huagu.admin.forms;

import java.util.LinkedHashMap;

import com.huagu.common.ui.ButtonEnum;
import com.huagu.common.ui.MyDateBox;
import com.huagu.common.ui.P004Browser;
import com.huagu.common.ui.SimpleGrid;
import com.huagu.common.ui.UrlButton;
import com.huagu.common.ui.columns.IndexColumn;
import com.huagu.common.ui.columns.StringColumn;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jpage.vcl.ComboBox;

/**
 * 后台操作日志查询 FrmLogData
 * 
 * @author xiaofei-pc
 *
 */
public class FrmLogData extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		P004Browser page = new P004Browser(this);
		page.setTitle(this.getParam("title", ""));

		MyDateBox StartBox = new MyDateBox(page.getLeftSide());
		StartBox.setStyle("width:180px !important");
		StartBox.setName("startDate");
		StartBox.setPlaceholder("开始时间");
		StartBox.getLabel().setCaption("开始时间");
		StartBox.setValue(getRequest().getParameter("startDate"));

		MyDateBox endBox = new MyDateBox(page.getLeftSide());
		endBox.setStyle("width:180px !important");
		endBox.setName("endDate");
		endBox.setPlaceholder("结束时间");
		endBox.getLabel().setCaption("结束时间");
		endBox.setValue(getRequest().getParameter("endDate"));

		LinkedHashMap<String, String> options = new LinkedHashMap<>();
		options.put("#", "请选择类型");
		LocalService svr = new LocalService(this, "SvrLogType");
		if (!svr.exec())
			throw new Exception(svr.getMessage());
		for (Record record : svr.getDataOut().getRecords()) {
			options.put(record.getSafeString("operateType_"), record.getSafeString("operateType_"));
		}
		ComboBox box = new ComboBox(page.getLeftSide());
		box.setName("operateType_");
		box.setOptions(options);
		box.setSelectId(getRequest().getParameter("operateType_"));

		UrlButton button = new UrlButton(page.getLeftSide());
		button.setType(ButtonEnum.submit);
		button.setValue("查询");

		// 导出参数说明，service：调用的查询服务，exportKey：查询条件缓存的key，templateId：后台xml配置的模板ID
		UrlButton button2 = new UrlButton(page.getLeftSide());
		button2.setValue("导出(Excel)");
		button2.setUrl(String.format("FrmExcel?service=%s&exportKey=%s&templateId=%s", "SvrLogQuery", "FrmLogData",
				"LogTemplate"));

		svr = new LocalService(this, "SvrLogQuery");
		if (!svr.exec("startDate", getRequest().getParameter("startDate"), "endDate",
				getRequest().getParameter("endDate"), "operateType_", getRequest().getParameter("operateType_")))
			throw new RuntimeException(svr.getMessage());
		// 缓存查询条件用做导出
		try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, this.getUserCode(), "FrmLogData")) {
			buff.setField("data", svr.getDataIn().getJSON());
		}
		DataSet ds = svr.getDataOut();
		SimpleGrid grid = page.getGrid();
		grid.setDataSet(ds);
		new IndexColumn(grid, "序号");
		new StringColumn(grid, "operateData_", "日期/时间");
		new StringColumn(grid, "operateType_", "类型");
		new StringColumn(grid, "operate_", "操作行为");
		new StringColumn(grid, "operateUser_", "操作人");
		new StringColumn(grid, "operateAdress_", "操作IP");
		new StringColumn(grid, "operateDetail_", "详情");
		grid.getPages().setPageSize(20);
		page.add("pages", grid.getPages());

		return page;
	}

}
