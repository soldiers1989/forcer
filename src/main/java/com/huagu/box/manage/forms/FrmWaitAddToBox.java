package com.huagu.box.manage.forms;

import com.huagu.common.ui.P004Browser;
import com.huagu.common.ui.SimpleGrid;
import com.huagu.common.ui.columns.IndexColumn;
import com.huagu.common.ui.columns.StringColumn;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jmis.form.AbstractForm;

public class FrmWaitAddToBox extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		 P004Browser page = new P004Browser(this);
	        page.setTitle("待配置柜组");
	        page.add("backbutton", "1");
	        LocalService svr = new LocalService(this, "SvrMyBoxGroupManage.checkBox");
	        if (!svr.exec()) {
	            throw new RuntimeException(svr.getMessage());
	        }
	        
	        DataSet result = svr.getDataOut();
	        SimpleGrid grid = page.getGrid();
	        grid.setDataSet(result);
	        
	        new IndexColumn(grid, "序号");
	        new StringColumn(grid, "cabId_", "柜组编号");
	        new StringColumn(grid, "joinUpDate_", "最近接入系统的时间");
	        new StringColumn(grid, "wstr_", "柜组配置状态");
	        grid.getPages().setPageSize(10);
	        page.add("pages", grid.getPages());
	        return page;
	}

}
