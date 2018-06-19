package com.huagu.common.ui.columns;

import cn.cerc.jdb.core.Record;
import cn.cerc.jpage.core.Component;
import cn.cerc.jpage.core.DataSource;
import cn.cerc.jpage.core.HtmlWriter;
import cn.cerc.jpage.core.IColumn;
import cn.cerc.jpage.grid.ObjectGrid;

public class AbstractColumn extends Component implements IColumn {
	private String title;// 列头
	private String field;
	private String align;
	private int width = 50;
	private boolean readonly;

	public AbstractColumn(Component owner) {
		super(owner);
		if (owner instanceof DataSource) {
			DataSource dataView = (DataSource) owner;
			dataView.addField(this);
			this.setReadonly(dataView.isReadonly());
		}
	}

	public AbstractColumn(Component owner, String title) {
		this(owner);
		this.setTitle(title);
	}

	public AbstractColumn(Component owner, String field, String title) {
		this(owner);
		this.setTitle(title);
		this.setField(field);
	}

	@Override
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Override
	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	@Override
	public String format(Object value) {
		if (value instanceof Record)
			return ((Record) value).getString(this.field);
		else
			return value.toString();
	}

	@Deprecated
	public void writeInput(HtmlWriter html, Record record) {
		html.print("<div>");
		html.print("%s", this.getTitle());
		html.print("<input id='%s'", this.field);
		html.print(" name='%s'", this.field);
		html.print(" value='%s'", record.getString(this.field));
		html.print(">");
		html.print("</div>");
	}

	public ObjectGrid getGrid() {
		if (this.getOwner() instanceof ObjectGrid)
			return (ObjectGrid) this.getOwner();
		else
			return null;
	}

	public boolean isReadonly() {
		return readonly;
	}

	public void setReadonly(boolean readonly) {
		this.readonly = readonly;
	}

	@Override
	public int getWidth() {
		return width;
	}

	public void setWidth(int width) {
		this.width = width;
	}

	@Override
	public String getAlign() {
		return align;
	}

	public void setAlign(String align) {
		this.align = align;
	}
}
