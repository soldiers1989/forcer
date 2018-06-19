package com.huagu.common.ui.columns;

import java.util.ArrayList;
import java.util.List;

import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jpage.core.Component;
import cn.cerc.jpage.core.HtmlWriter;
import cn.cerc.jpage.core.IField;
import cn.cerc.jpage.grid.DataGrid;

public class StringColumn extends AbstractColumn {
	private boolean init = false;
	private DataSet dataSet;
	private List<IField> columns;

	public StringColumn(Component owner) {
		super(owner);
	}

	public StringColumn(Component owner, String field, String title) {
		super(owner, field, title);
	}
	
	public StringColumn(Component owner, String field, String title,int width) {
		super(owner, field, title);
		super.setWidth(width);
	}

	public void add(String value) {
		this.getGrid().getCurrent().addData(this, value);
	}

	@Override
	public String format(Object value) {
		if (!(value instanceof Record))
			return value.toString();

		Record ds = (Record) value;
		String data = ds.getString(this.getField());
	    if ("true".equals(data)) {
	        data = "是";
	    } else if ("false".equals(data)) {
	        data = "否";
	    }
		if (this.isReadonly())
			return data;

		if (!(this.getOwner() instanceof DataGrid))
			return data;

		if (!this.init) {
			DataGrid grid = (DataGrid) this.getOwner();
			if (grid.getPrimaryKey() == null)
				throw new RuntimeException("BaseGrid.primaryKey is null");

			dataSet = grid.getDataSet();
			columns = new ArrayList<>();
			for (IField field : grid.getMasterLine().getFields()) {
				if (field instanceof StringColumn)
					columns.add(field);
			}
			this.init = true;
		}

		HtmlWriter html = new HtmlWriter();
		html.print("<input");
		html.print(" id='%s'", this.getDataId());
		html.print(" type='text'");
		html.print(" name='%s'", this.getField());
		html.print(" value='%s'", data);
		html.print(" data-focus='[%s]'", this.getDataFocus());
		html.print(" onkeydown='tableDirection(event,this)'");
		html.print(" oninput='tableOnChanged(this)'");
		html.println("/>");
		return html.toString();
	}

	private String getDataId() {
		int recNo = dataSet.getRecNo();
		int colNo = columns.indexOf(this);
		String selfId = String.format("%d_%d", recNo, colNo);
		return selfId;
	}

	private String getDataFocus() {
		int recNo = dataSet.getRecNo();
		int colNo = columns.indexOf(this);

		String prior = recNo > 1 ? String.format("%d_%d", recNo - 1, colNo) : "0";
		String next = recNo < dataSet.size() ? String.format("%d_%d", recNo + 1, colNo) : "0";
		String left = colNo > 0 ? String.format("%d_%d", recNo, colNo - 1) : "0";
		String right = colNo < columns.size() - 1 ? String.format("%d_%d", recNo, colNo + 1) : "0";
		return String.format("\"%s\",\"%s\",\"%s\",\"%s\"", left, prior, right, next);
	}
}
