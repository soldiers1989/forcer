package com.huagu.common.ui.phone;


import cn.cerc.jpage.core.Component;
import cn.cerc.jpage.core.HtmlWriter;
import cn.cerc.jpage.vcl.Button;

public class Block134 extends Component { 
	private Button inputBtn = new Button();
	
	public Block134(Component owner) {
		super(owner);
	}

	@Override
	public void output(HtmlWriter html) {
		html.println("<!-- %s -->", this.getClass().getName());
		html.print("<div class='block134'>");
		inputBtn.output(html); 
		html.print("</div>");
	}
	public Button getInputBtn() {
		return inputBtn;
	}
	 

}
