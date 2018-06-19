package com.huagu.common.ui;

public class CustomItem {

	private String key;
	private String keyClass = "name";
	private Object value;
	private String valueClass = "time";
	private String linkUrl; // 跳转路径
	private String componentType;

	public String getComponentType() {
		return componentType;
	}

	public void setComponentType(String componentType) {
		this.componentType = componentType;
	}

	public CustomItem() {
		this.setComponentType("item");
	}

	public CustomItem(String key, Object value) {
		this.setComponentType("item");
		this.key = key;
		this.value = value;
	}

	public CustomItem(String key, Object value, String linkUrl) {
		this.setComponentType("item");
		this.key = key;
		this.value = value;
		this.linkUrl = linkUrl;
	}

	public CustomItem(String key, Object value, String linkUrl, String keyClass) {
		this.setComponentType("item");
		this.key = key;
		this.value = value;
		this.linkUrl = linkUrl;
		this.keyClass = keyClass;
	}

	public CustomItem(String key, Object value, String linkUrl, String keyClass, String valueClass) {
		this.setComponentType("item");
		this.key = key;
		this.value = value;
		this.linkUrl = linkUrl;
		this.keyClass = keyClass;
		this.valueClass = valueClass;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getKeyClass() {
		return keyClass;
	}

	public void setKeyClass(String keyClass) {
		this.keyClass = keyClass;
	}

	public Object getValue() {
		return value;
	}

	public void setValue(Object value) {
		this.value = value;
	}

	public String getValueClass() {
		return valueClass;
	}

	public void setValueClass(String valueClass) {
		this.valueClass = valueClass;
	}

	public String getLinkUrl() {
		return linkUrl;
	}

	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
	}

}