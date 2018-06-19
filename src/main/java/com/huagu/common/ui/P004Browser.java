package com.huagu.common.ui;

import com.huagu.common.util.MenuFactory;

import cn.cerc.jbean.form.IForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jpage.core.Component;

public class P004Browser extends AbstractJspPage {
	// 页面顶部title
	private String title;
	//Action
	private String formAction;
	// 页面下方表格
	private SimpleGrid grid;
	private Component leftSide;
	private Component rightSide;
	private Component tab;

	public P004Browser(IForm form) {
		super(form);
		// 页面左侧菜单栏
		this.add("menus", MenuFactory.getMenuList(form.getHandle()));
		this.setJspFile("/ui/P004.jsp");
		
		tab = new Component();
		add("tab", tab);
		
		leftSide = new Component();
		add("leftSide", leftSide);

		rightSide = new Component();
		add("rightSide", rightSide);
		
		grid = new SimpleGrid(null);
		grid.setRequest(form.getRequest());
		this.add("grid", grid);
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
		add("title",title);
	}

	public SimpleGrid getGrid() {
		return grid;
	}

	public Component getLeftSide() {
		return leftSide;
	}

	public Component getRightSide() {
		return rightSide;
	}

	public Component getTab() {
		return tab;
	}
	
	public String getFormAction() {
		return formAction;
	}

	public void setFormAction(String formAction) {
		this.formAction = formAction;
		add("formAction", formAction);
	}

	
}
