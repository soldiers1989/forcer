package com.huagu.common.ui;

import com.huagu.common.util.MenuFactory;

import cn.cerc.jbean.form.IForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jpage.core.Component;
import cn.cerc.jpage.core.ActionForm;

public class P005Form extends AbstractJspPage {
	// 页面顶部title
	private String title;
	private ActionForm content;

	public P005Form(IForm form) {
		super(form);
		// 页面左侧菜单栏
		this.add("menus", MenuFactory.getMenuList(form.getHandle()));
		this.setJspFile("ui/P005.jsp");

		content = new ActionForm();
		content.setId("submitForm");
		add("content", content);
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.add("title", title);
		this.title = title;
	}

	public ActionForm getContent() {
		return content;
	}

	public String getAction() {
		return this.content.getAction();
	}

	public void setAction(String action) {
		this.content.setAction(action);
	}

	public Component addLine(){
		return new MyGroupBox(content);
	}
}
