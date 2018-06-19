package com.huagu.common.ui.phone;


import cn.cerc.jpage.core.Component;
import cn.cerc.jpage.core.HtmlWriter;
import cn.cerc.jpage.vcl.TextBox;

public class Block132 extends Component { 
	private TextBox textBox = new TextBox();
	
	public Block132(Component owner) {
		super(owner);
		this.textBox.setPlaceholder("请输入完整的单号");
		this.textBox.setType("text");
	}

	@Override
	public void output(HtmlWriter html) {
		html.println("<!-- %s -->", this.getClass().getName());
		html.print("<div class='block132'>");
		textBox.output(html); 
		html.print("</div>");
	}
	public TextBox getTextBox() {
		return textBox;
	}
	 

}
