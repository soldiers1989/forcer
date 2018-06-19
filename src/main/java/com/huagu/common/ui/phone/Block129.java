package com.huagu.common.ui.phone;

import cn.cerc.jpage.core.Component;
import cn.cerc.jpage.core.HtmlWriter;
import cn.cerc.jpage.vcl.TextBox;

/**
 * 部门管理
 * 
 * @author 郭向军
 *
 */
public class Block129 extends Component {
	private TextBox textBox = new TextBox();
	public Block129(Component owner) {
		super(owner);
		this.textBox.setPlaceholder("请输入完整的单号");
		this.textBox.setType("text");
	}

	@Override
	public void output(HtmlWriter html) {
		html.println("<!-- %s -->", this.getClass().getName());
		html.print("<div class='block129'>");
		html.print("<div class='sch'>");
		textBox.output(html); 
		html.print("</div>");
		html.print("</div>");
	}

	public TextBox getTextBox() {
		return textBox;
	}

}
