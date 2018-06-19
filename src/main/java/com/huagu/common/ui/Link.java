package com.huagu.common.ui;

public class Link {
	private String name; // 显示名字
	private String linkUrl; // 跳转路径
	private String cssClass; // 样式class
	private String componentType;

	public String getComponentType() {
		return componentType;
	}

	public void setComponentType(String componentType) {
		this.componentType = componentType;
	}

	public Link() {
		this.setComponentType("link");
	}

	public Link(String name, String linkUrl) {
		this.name = name;
		this.linkUrl = linkUrl;
	}

	public Link(String name, String linkUrl, String cssClass) {
		this.name = name;
		this.linkUrl = linkUrl;
		this.cssClass = cssClass;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLinkUrl() {
		return linkUrl;
	}

	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}

	public String getCssClass() {
		return cssClass;
	}

	public void setCssClass(String cssClass) {
		this.cssClass = cssClass;
	}

}