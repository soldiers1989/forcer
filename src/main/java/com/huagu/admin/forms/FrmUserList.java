package com.huagu.admin.forms;

import java.util.LinkedHashMap;
import com.huagu.common.ui.ButtonEnum;
import com.huagu.common.ui.MyDateBox;
import com.huagu.common.ui.MyTextBox;
import com.huagu.common.ui.P004Browser;
import com.huagu.common.ui.SimpleGrid;
import com.huagu.common.ui.UrlButton;
import com.huagu.common.ui.columns.ImageColumn;
import com.huagu.common.ui.columns.IndexColumn;
import com.huagu.common.ui.columns.StringColumn;
import com.huagu.common.util.ParamUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.RedirectPage;
import cn.cerc.jpage.vcl.ComboBox;
import cn.cerc.jpage.vcl.Label;

/**
 * 
 * @ClassName: FrmUserList
 * @Description: 后台用户列表查询
 * @author li
 * @date 2017年12月11日
 *
 */
public class FrmUserList extends AbstractForm {
	@Override
	public IPage execute() throws Exception {
		P004Browser page = new P004Browser(this);
		page.setTitle("用户列表");// 设置标题
		page.setTitle(this.getParam("title", ""));
		page.addScriptFile("/js/manage/frmRole.js");

		MyDateBox startBox = new MyDateBox(page.getLeftSide());
		startBox.setStyle("width:180px !important");
		startBox.setName("startTime_");
		startBox.setPlaceholder("开始时间");
		startBox.getLabel().setCaption("结束时间");
		startBox.setValue(getRequest().getParameter("startTime_"));

		Label lab = new Label(page.getLeftSide());
		lab.setCaption("-");

		MyDateBox endBox = new MyDateBox(page.getLeftSide());
		endBox.setStyle("width:180px !important");
		endBox.setName("endTime_");
		endBox.setPlaceholder("结束时间");
		endBox.getLabel().setCaption("结束时间");
		endBox.setValue(getRequest().getParameter("endTime_"));

		MyTextBox user_ = new MyTextBox(page.getLeftSide());
		user_.setStyle("width:180px");
		user_.setId("name_");
		user_.setName("name_");
		user_.setPlaceholder("请输入用户名或手机号");
		LinkedHashMap<String, String> userOptions = new LinkedHashMap<String, String>();
		userOptions.put("", "请选择状态");
		userOptions.put("1", "启用");
		userOptions.put("0", "禁用");
		ComboBox userSelect = new ComboBox(page.getLeftSide());
		userSelect.setId("enabled_");
		userSelect.setName("enabled_");
		userSelect.setOptions(userOptions);
		userSelect.setSelectId(this.getRequest().getParameter("enabled_"));
		UrlButton btnQuery = new UrlButton(page.getLeftSide());
		btnQuery.setType(ButtonEnum.submit);
		btnQuery.setValue("查询");

		// 查询要显示的数据
		LocalService svr = new LocalService(this, "SvrUserList");
		ParamUtil.ParamToHeadIn(page.getForm(), svr.getDataIn());
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		ParamUtil.addLog(this, "查询", "后台用户列表查询", "后台用户列表查询");

		DataSet ds = svr.getDataOut();
		// 根据自己想要的数据结构格式化数据
		if (ds.getRecNo() > 0) {
			for (Record r : ds.getRecords()) {
				r.getItems().put("zhuangtai",
						FrmUserList.getState(r.getBoolean("enabled_"), r.getString("code_"), this));
			}
		}
		// 添加datagrid
		SimpleGrid grid = page.getGrid();
		grid.setDataSet(ds);
		new IndexColumn(grid, "序号");
		new StringColumn(grid, "name_", "用户名");
		new StringColumn(grid, "code_", "手机号");
		new StringColumn(grid, "createTime_", "注册时间");
		new StringColumn(grid, "address_", "地址");
		new StringColumn(grid, "susuNo_", "术术号");
		ImageColumn imgCol = new ImageColumn(grid);
		imgCol.setTitle("头像");
		imgCol.setField("imgUrl_");
		new StringColumn(grid, "workYears_", "工作年限");
		new StringColumn(grid, "position_", "职位");
		new StringColumn(grid, "trade_", "从事行业");
		new StringColumn(grid, "zhuangtai", "状态");
		page.add("pages", grid.getPages());
		return page;
	}

	/**
	 * 删除
	 */
	public IPage remove() throws Exception {
		String UID_ = this.getRequest().getParameter("UID_");
		LocalService svr = new LocalService(this, "SvrRoleDel");
		if (!svr.exec("UID_", UID_))
			throw new RuntimeException(svr.getMessage());
		ParamUtil.addLog(this, "删除", "删除角色", "删除角色:" + UID_);
		return execute();
	}

	/**
	 * 更新用户状态
	 */
	public IPage updateState() throws Exception {
		String code_ = this.getRequest().getParameter("code_");
		String state_ = this.getRequest().getParameter("state_");
		LocalService svr = new LocalService(this, "SvrUserStateUpdate");
		if (!svr.exec("state_", state_, "code_", code_))
			throw new RuntimeException(svr.getMessage());
		ParamUtil.addLog(this, "修改", "修改用户状态", "修改用户状态");
		return new RedirectPage(this, "FrmUserList");
	}

	/**
	 * 启动禁用状态
	 * 
	 * @param handle
	 * @return
	 */
	public static String getState(Boolean enabled_, String code_, IHandle handle) {
		if (enabled_ == false) {
			return "<input class='button addBtn'  type='button' onclick=\"javascript:window.location.href='FrmUserList.updateState?state_=1&code_="
					+ code_ + "'\" value='禁用'/>";
		} else {
			return "<input class='button addBtn'  type='button' onclick=\"javascript:window.location.href='FrmUserList.updateState?state_=0&code_="
					+ code_ + "'\" value='启用'/>";
		}
	}

	@Override
	public boolean logon() {
		return false;
	}

}
