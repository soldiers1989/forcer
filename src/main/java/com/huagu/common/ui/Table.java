package com.huagu.common.ui;

import java.util.ArrayList;
import java.util.List;

public class Table {

	private List<CustomItem> treeMap;
	private List<List<CustomItem>> tableItems;
	/*
	 * 组件类型
	 */
	private String componentType;

	public String getComponentType() {
		return componentType;
	}

	public void setComponentType(String componentType) {
		this.componentType = componentType;
	}

	public Table() {
		this.setComponentType("table");
	}

	public void append() {
		treeMap = new ArrayList<CustomItem>();
		getTableItems().add(treeMap);
	}

	public void addTableItem(String key, Object value) {
		if (treeMap == null)
			append();
		treeMap.add(new CustomItem(key, value));
	}

	public List<List<CustomItem>> getTableItems() {
		if (tableItems == null)
			tableItems = new ArrayList<List<CustomItem>>();
		return tableItems;
	}

	public void setTableItems(List<List<CustomItem>> contentItems) {
		this.tableItems = contentItems;
	}

}