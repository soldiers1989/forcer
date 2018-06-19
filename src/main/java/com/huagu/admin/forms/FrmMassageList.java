package com.huagu.admin.forms;

import java.util.LinkedHashMap;
import com.huagu.common.ui.ButtonEnum;
import com.huagu.common.ui.MyDateBox;
import com.huagu.common.ui.MyTextBox;
import com.huagu.common.ui.P004Browser;
import com.huagu.common.ui.SimpleGrid;
import com.huagu.common.ui.UrlButton;
import com.huagu.common.ui.columns.IndexColumn;
import com.huagu.common.ui.columns.StringColumn;
import com.huagu.common.util.ParamUtil;
import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jpage.vcl.ComboBox;
import cn.cerc.jpage.vcl.Label;

/**
 * 
 * @ClassName: FrmMassageList
 * @Description: 后台消息列表查询
 * @author li
 * @date 2017年12月11日
 *
 */
public class FrmMassageList extends AbstractForm {
	@Override
	public IPage execute() throws Exception {
		P004Browser page = new P004Browser(this);
		page.setTitle("消息列表");// 设置标题
		page.setTitle(this.getParam("title", ""));
		page.addScriptFile("/js/manage/frmRole.js");

		MyDateBox startBox = new MyDateBox(page.getLeftSide());
		startBox.setStyle("width:180px !important");
		startBox.setName("startTime_");
		startBox.setPlaceholder("开始时间");
		startBox.setValue(getRequest().getParameter("startTime_"));

		Label lab = new Label(page.getLeftSide());
		lab.setCaption("-—-");

		MyDateBox endBox = new MyDateBox(page.getLeftSide());
		endBox.setStyle("width:180px !important");
		endBox.setName("endTime_");
		endBox.setPlaceholder("结束时间");
		endBox.setValue(getRequest().getParameter("endTime_"));

		MyTextBox user_ = new MyTextBox(page.getLeftSide());
		user_.setStyle("width:180px");
		user_.setId("name_");
		user_.setName("name_");
		user_.setPlaceholder("请输入用户名或手机号");
		/*
		 * LinkedHashMap<String, String> userOptions = new LinkedHashMap<String,
		 * String>(); userOptions.put("", "请选择状态"); userOptions.put("1", "启用");
		 * userOptions.put("0", "禁用"); ComboBox userSelect = new
		 * ComboBox(page.getLeftSide()); userSelect.setId("enabled_");
		 * userSelect.setName("enabled_"); userSelect.setOptions(userOptions);
		 * userSelect.setSelectId(this.getRequest().getParameter("enabled_"));
		 */

		// 加载消息数据库消息所有类型
		LinkedHashMap<String, String> options = new LinkedHashMap<>();
		options.put("#", "请选择类型");
		LocalService getMsgType = new LocalService(this, "SvrMsgType");
		if (!getMsgType.exec())
			throw new Exception(getMsgType.getMessage());
		for (Record record : getMsgType.getDataOut().getRecords()) {
			options.put(record.getSafeString("type_"), record.getSafeString("type_"));
		}
		ComboBox box = new ComboBox(page.getLeftSide());
		box.setName("type_");
		box.setOptions(options);
		box.setSelectId(getRequest().getParameter("type_"));

		UrlButton btnQuery = new UrlButton(page.getLeftSide());
		btnQuery.setType(ButtonEnum.submit);
		btnQuery.setValue("查询");

		UrlButton btnAdd = new UrlButton(page.getRightSide());
		btnAdd.setValue("发送系统消息");
		btnAdd.setUrl("FrmMassageList.append");

		// 查询要显示的数据
		LocalService svr = new LocalService(this, "SvrMassageList");
		ParamUtil.ParamToHeadIn(page.getForm(), svr.getDataIn());
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		ParamUtil.addLog(this, "查询", "后台消息列表查询", "后台消息列表查询");

		DataSet ds = svr.getDataOut();
		// 根据自己想要的数据结构格式化数据
		/*
		 * if (ds.getRecNo() > 0) { for (Record r : ds.getRecords()) {
		 * r.getItems().put("zhuangtai",
		 * FrmMassageList.getState(r.getBoolean("enabled_"),
		 * r.getString("code_"), this)); } }
		 */
		// 添加datagrid
		SimpleGrid grid = page.getGrid();
		grid.setDataSet(ds);
		new IndexColumn(grid, "序号");
		new StringColumn(grid, "userCode_", "发送人帐号");
		new StringColumn(grid, "title_", "消息标题");
		new StringColumn(grid, "message_", "消息内容");
		new StringColumn(grid, "type_", "消息类型");
		new StringColumn(grid, "belong_", "消息所属");
		new StringColumn(grid, "status_", "消息状态");
		new StringColumn(grid, "createDate_", "创建时间");
		page.add("pages", grid.getPages());
		return page;
	}

	/**
	 * 后台发送系统消息
	 * 
	 * @return
	 * @throws Exception
	 */
	public IPage append() throws Exception {
		String title_ = this.getRequest().getParameter("title_");
		String massage_ = this.getRequest().getParameter("massage_");
		String belong_ = this.getRequest().getParameter("belong_");
		JsonPage page = new JsonPage(this);
		if (!"".equals(title_) && title_ != null) {
			ParamUtil.addLog(this, "添加", "管理员后台发送系统消息", "管理员后台发送系统消息");
			LocalService addMsg = new LocalService(this, "SvrMassageAdd");
			if (!addMsg.exec("title_", title_, "message_", massage_, "belong_", belong_)) {
				page.setData(false);
			} else {
				page.setData(true);
			}

		} else {
			JspPage pages = new JspPage(this, "news/FrmMessage_execute.jsp");
			return pages;
		}
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

	@Override
	public boolean logon() {
		return false;
	}

}
