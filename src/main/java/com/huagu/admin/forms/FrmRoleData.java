package com.huagu.admin.forms;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.huagu.common.util.ParamUtil;
import com.huagu.common.ui.ButtonEnum;
import com.huagu.common.ui.MyTextBox;
import com.huagu.common.ui.P004Browser;
import com.huagu.common.ui.P005Form;
import com.huagu.common.ui.SimpleGrid;
import com.huagu.common.ui.UrlButton;
import com.huagu.common.ui.columns.ConvertColumn;
import com.huagu.common.ui.columns.IndexColumn;
import com.huagu.common.ui.columns.LinkColumn;
import com.huagu.common.ui.columns.OperatingColumn;
import com.huagu.common.ui.columns.StringColumn;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.tools.MD5;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jpage.core.Component;
import cn.cerc.jpage.vcl.RadioBox;

/**
 * 
 * @ClassName: FrmRoleData
 * @Description: 后台权限查询
 * @author li
 * @date 2017年11月23日
 *
 */
public class FrmRoleData extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		P004Browser page = new P004Browser(this);
		page.setTitle(this.getParam("title", ""));
		page.addScriptFile("/js/manage/frmRole.js");

		UrlButton btnAdd = new UrlButton(page.getRightSide());
		btnAdd.setValue("新增");
		btnAdd.setUrl("FrmRoleData.append");

		/*
		 * Button btnFp = new Button(page.getRightSide());
		 * btnFp.setValue("分配功能"); btnFp.setUrl("FrmRoleData.sendPowerJsp");
		 * btnFp.setCheckBoxName("roleIds");
		 */

		// 查询要显示的数据
		LocalService svr = new LocalService(this, "SvrRoleDataQuery");
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		ParamUtil.addLog(this, "查询", "角色列表查询", "角色列表查询");
		DataSet ds = svr.getDataOut();
		if (ds.eof())
			ds.append();
		ds.first();
		while (ds.fetch()) {
			LocalService svr2 = new LocalService(this, "SvrRoleDataCount");
			if (!svr2.exec("UID_", ds.getField("UID_")))
				throw new RuntimeException(svr2.getMessage());
			ds.setField("exitUser_", svr2.getDataOut().getField("roles_"));
		}
		// 添加datagrid
		SimpleGrid grid = page.getGrid();
		grid.setDataSet(ds);
		new IndexColumn(grid, "序号");
		new StringColumn(grid, "Name_", "角色");
		new StringColumn(grid, "exitUser_", "存在用户数");
		new StringColumn(grid, "Remark_", "说明");
		new StringColumn(grid, "menuName_", "功能分配");
		new ConvertColumn(grid, "isLive_", "启停状态", new String[] { "true", "启用", "false", "停用", "异常" });
		new OperatingColumn(grid, "UID_", "修改/删除", "FrmRoleData.append",
		"FrmRoleData.remove");
		/*LinkColumn linkCol = new LinkColumn(grid, "修改", "FrmRoleData.append");
		linkCol.addItem("UID_", "UID_");*/
		LinkColumn lc = new LinkColumn(grid, "分配功能", "FrmRoleData.sendPowerJsp");
		lc.addItem("roleId", "UID_");
		lc.setWidth(90);
		grid.getPages().setPageSize(20);
		page.add("pages", grid.getPages());
		return page;
	}

	public IPage append() throws Exception {
		P005Form page = new P005Form(this);
		page.setTitle(this.getParam("title", "") + "-保存");
		page.addScriptFile("/js/manage/frmRoleAppend.js");
		page.setAction("FrmRoleData.append");

		// 新增
		DataSet ds = new DataSet();
		page.getContent().addHidden("UID_", "-1");

		// 显示修改信息
		String uid_ = getRequest().getParameter("UID_");
		if (StringUtils.isNotBlank(uid_)) {
			LocalService svr = new LocalService(this, "SvrRoleDataQuery");
			if (!svr.exec("UID_", uid_))
				throw new RuntimeException(svr.getMessage());

			ds = svr.getDataOut();
			page.getContent().addHidden("UID_", uid_);
		}
		if (ds.eof())
			ds.append();

		// 判断页面显示的文字
		if (uid_ == null) {
			page.add("message", "FrmRoleData.append");
		} else {
			page.add("message", "FrmRoleData.update");
		}

		// 将查到的数据绑定到控件中
		MyTextBox role_ = new MyTextBox(page.addLine());
		role_.getLabel().setCaption("角色名称");
		role_.setId("Name_");
		role_.setName("Name_");
		role_.setValue(ds.getString("Name_"));
		role_.setRequired("required");
		// role_.setRequired("required");

		MyTextBox description_ = new MyTextBox(page.addLine());
		description_.getLabel().setCaption("说明");
		description_.setId("Remark_");
		description_.setName("Remark_");
		description_.setValue(ds.getString("Remark_"));
		description_.setRequired("required");

		Component line = page.addLine();
		RadioBox rb1 = new RadioBox(line);
		rb1.getLabel().setCaption("启用");
		rb1.setName("isLive_");
		rb1.setValue(Boolean.TRUE.toString());
		RadioBox rb2 = new RadioBox(line);
		rb2.getLabel().setCaption("停用");
		rb2.setName("isLive_");
		rb2.setValue(Boolean.FALSE.toString());
		if ("true".equals(ds.getString("isLive_"))) {
			rb1.setIsSelected(true);
		} else {
			rb2.setIsSelected(true);
		}

		// 执行新增或修改操作
		String isSub = this.getRequest().getParameter("submit");
		if (StringUtils.isNotBlank(isSub)) {
			LocalService svr = new LocalService(this, "SvrRoleDataModify");
			ParamUtil.ParamToHeadIn(page.getForm(), svr.getDataIn());
			svr.getDataIn().getHead().setField("UID_", uid_);
			svr.getDataIn().getHead().setField("roleName", this.getRequest().getParameter("roleName"));
			svr.getDataIn().getHead().setField("Remark_", this.getRequest().getParameter("Remark_"));
			svr.getDataIn().getHead().setField("isLive_", this.getRequest().getParameter("isLive_"));
			if (!svr.exec())
				throw new RuntimeException(svr.getMessage());
			if (uid_ == "-1") {
				ParamUtil.addLog(this, "修改", "修改角色定义", "修改角色id：" + uid_);
			} else {
				ParamUtil.addLog(this, "新增", "新增一个角色", "新增一个角色：" + page.getForm().getRequest().getParameter("Name_"));
			}
			return execute();
		}

		UrlButton sub = new UrlButton(page.addLine());
		sub.setName("submit");
		sub.setValue("提交");
		sub.setType(ButtonEnum.submit);

		return page;
	}

	public IPage sendPowerJsp() throws Exception {
		JspPage page = new JspPage(this);
		page.setJspFile("admin/powerCheckboxs.jsp");
		LocalService svr = new LocalService(this, "SvrPowerQuery");
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("lists", svr.getDataOut().getRecords());
		System.out.println(svr.getDataOut().getRecords());
		String roleId = this.getRequest().getParameter("roleId");
		svr = new LocalService(this, "SvrRoleAddPower");
		if (svr.exec("query", true, "roleId_", roleId))
			page.add("userPowers", svr.getDataOut().getRecords());
		page.add("roleId", roleId);
		return page;
	}

	public IPage sendPower() throws Exception {
		LocalService svr = new LocalService(this, "SvrRoleAddPower");
		LocalService svr1 = new LocalService(this, "SvrRoleAddPowerDel");
		String[] powerIds = this.getRequest().getParameterValues("powerIds");
		String roleId = this.getRequest().getParameter("roleId");
		if (!svr1.exec("roleId_", roleId))
			throw new RuntimeException(svr1.getMessage());
		for (String powerId : powerIds) {
			if (!svr.exec("roleId_", roleId, "powerId_", powerId))
				throw new RuntimeException(svr.getMessage());
		}
		ParamUtil.addLog(this, "修改", "修改角色功能", "修改角色id：" + roleId);
		return execute();
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
	 * 验证角色名称是否存在
	 */
	public IPage checkRoleName() throws Exception {
		JsonPage page = new JsonPage(this);
		String status = "success";
		Map<String, String> returnJson = new HashMap<>();
		String roleName = getRequest().getParameter("roleName");
		String id = getRequest().getParameter("id");

		LocalService svr = new LocalService(this, "SvrCheckRoleName");
		if (!svr.exec("roleName", roleName, "id", id)) {
			status = svr.getMessage();
			returnJson.put("status", status);
		}
		page.setData(returnJson);
		return page;
	}

	public static void main(String[] args) {
		System.out.println(MD5.get("xiao19951"));
	}
	
	@Override
	public boolean logon() {
		return false;
	}

}
