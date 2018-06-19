package com.huagu.common.ui;

import cn.cerc.jpage.core.Component;
import cn.cerc.jpage.core.HtmlWriter;
import cn.cerc.jpage.vcl.Label;

public class MyDateBox extends Component {
	private String name;
	private String value;
	private String placeholder;
	private Label label;
	private String required = "";// 输入验证验证
	private String style = "";//添加行内样式

	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public MyDateBox(Component owner) {
		setOwner(owner);
	}

	@Override
	public void output(HtmlWriter html) {
		if (label != null)
			label.output(html);
		html.print("<input type='text' onClick='WdatePicker()' ");
		html.print(" name='%s'", name);
		html.print(" value='%s'", value == null ? "" : value);
		html.print(" style='%s'", style == null ? "" : style);
		html.print(" placeholder='%s'", placeholder == null ? "" : placeholder);
		html.print("  %s",  required);
		html.print(" />");
	}

	public String getName() {
		return name;
	}

	public String getValue() {
		return value;
	}

	public String getPlaceholder() {
		return placeholder;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public void setPlaceholder(String placeholder) {
		this.placeholder = placeholder;
	}

	public Label getLabel() {
		if (label == null)
			label = new Label();
		return label;
	}

	public void setLabel(Label label) {
		this.label = label;
	}

	public String getRequired() {
		return required;
	}

	public void setRequired(String required) {
		this.required = required;
	}

}
