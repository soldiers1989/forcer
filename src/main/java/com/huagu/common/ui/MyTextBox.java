package com.huagu.common.ui;

import cn.cerc.jpage.core.Component;
import cn.cerc.jpage.core.HtmlWriter;
import cn.cerc.jpage.vcl.Label;

public class MyTextBox extends Component {
	private String name = "";
	private String value = "";
	private String placeholder = "";
	private String maxlength = "";
	private TextEnum type = TextEnum.text;
	private Label label;
	private String _class = "";// 给元素添加Class
	private String readonly = "";// 是否只读
	private String required = "";// 输入验证验证
	private String style = "";//添加行内样式

	public String getRequired() {
		return required;
	}

	public void setRequired(String required) {
		this.required = required;
	}

	public void setLabel(Label label) {
		this.label = label;
	}

	@Override
	public void output(HtmlWriter html) {
		if (label != null)
			label.output(html);
		if (type.equals(TextEnum.multi)) {
			html.print("<textarea class='%s' %s %s %s name='%s' placeholder='%s' >%s</textarea>", _class, readonly,
					required,maxlength,name, placeholder, value);
		} else {
			html.print("<input class='%s' %s %s type='%s' %s name='%s' placeholder='%s' value='%s' style='%s'/>", _class, readonly,
					required, type,maxlength,name,placeholder,value,style);
		}

	}

	public MyTextBox(Component owner) {
		super(owner);
	}

	public MyTextBox() {
		super();
	}

	public String getReadonly() {
		return readonly;
	}

	public void setReadonly(Boolean flag) {
		if (flag)
			this.readonly = "readonly";
	}

	public String get_class() {
		return _class;
	}

	public void set_class(String _class) {
		this._class = _class;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
	    if (null == value) {
	        value = "";
	    }
		this.value = value;
	}
	
	public int getMaxlength() {
		return Integer.parseInt(maxlength.substring(maxlength.indexOf("'")+1,maxlength.lastIndexOf("'")));
	}
	
	public void setMaxlength(int maxlength) {
		this.maxlength = String.format("maxlength='%s'",maxlength);
	}
	
	public String getPlaceholder() {
		return placeholder;
	}

	public void setPlaceholder(String placeholder) {
		this.placeholder = placeholder;
	}

	public Label getLabel() {
		if (label == null)
			label = new Label();
		return label;
	}

	public TextEnum getType() {
		return type;
	}

	public void setType(TextEnum type) {
		this.type = type;
	}
	
	public String getStyle() {
		return this.style;
	}
	public void setStyle(String style) {
		this.style = style;
	}

}
