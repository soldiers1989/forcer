package com.huagu.admin.forms;

import java.util.LinkedHashMap;

import org.apache.commons.lang3.StringUtils;
import com.huagu.common.util.ParamUtil;
import com.huagu.common.ui.ButtonEnum;
import com.huagu.common.ui.MyTextBox;
import com.huagu.common.ui.P004Browser;
import com.huagu.common.ui.P005Form;
import com.huagu.common.ui.SimpleGrid;
import com.huagu.common.ui.TextEnum;
import com.huagu.common.ui.UrlButton;
import com.huagu.common.ui.columns.ConvertColumn;
import com.huagu.common.ui.columns.IndexColumn;
import com.huagu.common.ui.columns.OperatingColumn;
import com.huagu.common.ui.columns.StringColumn;
import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.RedirectPage;
import cn.cerc.jpage.core.Component;
import cn.cerc.jpage.vcl.ComboBox;
import cn.cerc.jpage.vcl.Label;
import cn.cerc.jpage.vcl.RadioBox;

/**
 * 
 * @ClassName: FrmUserManagerData
 * @Description: 后台新增角色
 * @author li
 * @date 2017年7月25日 下午2:36:09
 *
 */
public class FrmUserManagerData extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		P004Browser page = new P004Browser(this);
		page.setTitle("权限分配");

		UrlButton btnAdd = new UrlButton(page.getRightSide());
		btnAdd.setValue("新增");
		btnAdd.setUrl("FrmUserManagerData.append");

		// 绑定角色下拉框数据
		LocalService svrRole = new LocalService(this, "SvrRoleDataQuery");
		DataSet roles = svrRole.getDataOut();
		roles.append();
		roles.setField("UID_", "#");
		roles.setField("Name_", "请选角色");
		System.err.println( this.getRequest().getParameter("enabled_"));
		if (!svrRole.exec("isLive_", true, "enabled_", this.getRequest().getParameter("enabled_")))
			throw new RuntimeException(svrRole.getMessage());
		ComboBox combo2 = new ComboBox(page.getLeftSide());
		combo2.setId("roleId_");
		combo2.setName("roleId_");
		combo2.setDataSet(svrRole.getDataOut(), "UID_", "Name_");
		if (StringUtils.isNotBlank(getRequest().getParameter("roleId_")))
			combo2.setSelectId(getRequest().getParameter("roleId_"));
		else
			combo2.setSelectId("#");
		LinkedHashMap<String, String> options = new LinkedHashMap<String, String>();
		options.put("", "请选择状态");
		options.put("1", "启用");
		options.put("0", "停用");
		ComboBox select = new ComboBox(page.getLeftSide());
		select.setId("enabled_");
		select.setName("enabled_");
		select.setOptions(options);
		select.setSelectId(this.getRequest().getParameter("enabled_"));
		UrlButton button = new UrlButton(page.getLeftSide());
		button.setType(ButtonEnum.submit);
		button.setValue("查询");

		// 查询要显示的数据
		LocalService svr = new LocalService(this, "SvrUserManagerDataQuery");
		ParamUtil.ParamToHeadIn(page.getForm(), svr.getDataIn());
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		ParamUtil.addLog(this, "查询", "查询后台用户管理列表", "查询后台用户管理列表");
		DataSet userData = svr.getDataOut();
		// 添加datagrid
		SimpleGrid grid = page.getGrid();
		grid.setDataSet(userData);
		new IndexColumn(grid, "序号");
		new StringColumn(grid, "code_", "登录名");
		new StringColumn(grid, "name_", "姓名");
		new StringColumn(grid, "mobile_", "手机号");
		new StringColumn(grid, "mark_", "备注");
		new StringColumn(grid, "roleName", "用户角色");
		new StringColumn(grid, "loginTime_", "最近登录时间");
		new ConvertColumn(grid, "enabled_", "启停状态", new String[] { "0", "停用", "1", "启用", "异常" });
		new OperatingColumn(grid, "UID_", "操作", "FrmUserManagerData.append", "FrmUserManagerData.remove");
		grid.getPages().setPageSize(20);
		page.add("pages", grid.getPages());
		return page;
	}

	/**
	 * 新增
	 */
	public IPage append() throws Exception {
		P005Form page = new P005Form(this);
		page.setTitle(this.getParam("title", "") + "-保存");
		page.setAction("FrmUserManagerData.append");
		page.addScriptFile("/js/manage/FrmUserManagerData.js");
		page.addScriptFile("/js/manage/jquery.autocomplete.js");
		page.addScriptFile("/js/manage/frmRsou.js");
		page.addScriptFile("/js/manage/jquery.ui.js");
		page.addScriptFile("/js/manage/jquery-ui.min.js");
		page.addScriptFile("/js/manage/style.css");
		// 新增
		DataSet ds = new DataSet();
		page.getContent().addHidden("UID_", "-1");
		String uid_ = getRequest().getParameter("UID_");
		// 判断uid_，在page存值，在P005页面判断打印文字
		if (uid_ == null || uid_ == "-1") {
			page.add("message", "FrmUserManagerData.append");
		} else {
			page.add("message", "FrmUserManagerData.update");
		}
		String hosID = null;
		if (!(StringUtils.isEmpty(uid_) || uid_.equals("-1"))) {
			LocalService svr = new LocalService(this, "SvrUserManagerDataQuery");
			if (!svr.exec("UID_", uid_))
				throw new RuntimeException(svr.getMessage());
			ds = svr.getDataOut();
			page.getContent().addHidden("UID_", uid_);
			page.getContent().addHidden("hos_", hosID);
		}
		if (ds.eof())
			ds.append();

		MyTextBox name_ = new MyTextBox(page.addLine());
		name_.getLabel().setCaption("登录名");
		name_.setId("name_");
		name_.setName("name_");
		name_.setValue(ds.getString("name_"));
		name_.setRequired("required");
		name_.setRequired("required maxlength='8'");

		MyTextBox userName_ = new MyTextBox(page.addLine());
		userName_.getLabel().setCaption("真实姓名");
		userName_.setId("userName_");
		userName_.setName("userName_");
		userName_.setValue(ds.getString("userName_"));
		userName_.setRequired("required");
		userName_.setRequired("required maxlength='8'");
		
		if (!(StringUtils.isEmpty(uid_) || uid_.equals("-1"))) {
			// 不允许修改姓名
			name_.setReadonly(true);
			MyTextBox mobile_ = new MyTextBox(page.addLine());
			mobile_.getLabel().setCaption("手机号");
			mobile_.setId("mobile_");
			mobile_.setName("mobile_");
			mobile_.setType(TextEnum.number);
			mobile_.setValue(ds.getString("mobile_"));
		} else {
			MyTextBox mobile_ = new MyTextBox(page.addLine());
			mobile_.getLabel().setCaption("手机号");
			mobile_.setId("mobile_");
			mobile_.setName("mobile_");
			mobile_.setType(TextEnum.number);
			mobile_.setValue(ds.getString("mobile_"));
		}

		MyTextBox mark_ = new MyTextBox(page.addLine());
		mark_.getLabel().setCaption("备注");
		mark_.setId("mark_");
		mark_.setName("mark_");
		mark_.setValue(ds.getString("mark_"));
		// mark_.setRequired("required");
		
		/*MyTextBox idCard_ = new MyTextBox(page.addLine());
		idCard_.getLabel().setCaption("身份证");
		idCard_.setId("idCard_");
		idCard_.setName("idCard_");
		idCard_.setValue(ds.getString("idCard_"));*/
		// idCard_.setRequired("required maxlength='18' minlength='18'");

		// 绑定角色下拉框数据
		LocalService svrRole = new LocalService(this, "SvrRoleDataQuery");
		if (!svrRole.exec("isLive_", true))
			throw new RuntimeException(svrRole.getMessage());
		else {
			Component line = page.addLine();
			Label label = new Label(line);
			label.setCaption("分配角色");
			ComboBox combo2 = new ComboBox(line);
			combo2.setId("roleCode_");
			combo2.setName("roleCode_");
			combo2.setSelectId(ds.getString("roleCode_"));
			combo2.setDataSet(svrRole.getDataOut(), "UID_", "Name_");
		}

		Component lineIsLive = page.addLine();
		RadioBox rb1 = new RadioBox(lineIsLive);
		rb1.getLabel().setCaption("启用");
		rb1.setName("enabled_");
		rb1.setValue(Boolean.TRUE.toString());
		RadioBox rb2 = new RadioBox(lineIsLive);
		rb2.getLabel().setCaption("停用");
		rb2.setName("enabled_");
		rb2.setValue(Boolean.FALSE.toString());
		if ("true".equals(ds.getString("enabled_"))) {
			rb1.setIsSelected(true);
		} else {
			rb2.setIsSelected(true);
		}

		// 执行新增或修改操作
		String isSub = this.getRequest().getParameter("submit");
		if (StringUtils.isNotBlank(isSub)) {
			LocalService svr = new LocalService(this, "SvrUserManagerDataModify");
			ParamUtil.ParamToHeadIn(page.getForm(), svr.getDataIn());
			svr.getDataIn().getHead().setField("UID_", uid_);
			if (!svr.exec())
				throw new RuntimeException(svr.getMessage());
			if (uid_ == "-1") {
				ParamUtil.addLog(this, "新增", "新增后台用户信息", "新增后台用户:" + uid_);
			} else
				ParamUtil.addLog(this, "修改", "修改后台用户", "修改后台用户:" + page.getForm().getRequest().getParameter("name_"));
			return new RedirectPage(this, "FrmUserManagerData");
		}

		UrlButton sub = new UrlButton(page.addLine());
		sub.setName("submit");
		sub.setValue("提交");
		sub.setType(ButtonEnum.submit);
		return page;
	}

	/**
	 * 删除
	 */
	public IPage remove() throws Exception {
		String uid_ = getRequest().getParameter("UID_");
		LocalService svr = new LocalService(this, "SvrUserManagerDataDel");
		if (!svr.exec("UID_", uid_))
			throw new RuntimeException(svr.getMessage());
		ParamUtil.addLog(this, "删除", "删除后台用户", "删除后台用户:" + uid_);
		return new RedirectPage(this, "FrmUserManagerData");
	}

}
