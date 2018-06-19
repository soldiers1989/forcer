package com.huagu.common.ui.phone;


import cn.cerc.jpage.core.Component;
import cn.cerc.jpage.core.HtmlWriter;
import cn.cerc.jpage.vcl.Image;
import cn.cerc.jpage.vcl.Span;

public class Block133 extends Component { 
	private Span title1 = new Span();
	private Span title2 = new Span();
	private Span title3 = new Span();
	private Image rightImage = new Image();
	private String QcUrl="#";
	public Block133(Component owner) {
		super(owner);
		title1.setText("title");
		title2.setText("title1");
		title3.setText("title3");
		rightImage.setSrc("jui/phone/block120_delete.png");
	}

	@Override
	public void output(HtmlWriter html) {
		html.println("<!-- %s -->", this.getClass().getName());
		html.print("<div class='block133'");
		html.print("QcUrl='");
		html.print(this.getQcUrl());
		html.print("'>");
		html.print("<ul><li>");
		html.print("<p>");
		this.title1.output(html);
		html.print("</p>");
		html.print("<time>");
		this.title2.output(html);
		this.title3.output(html);
		html.print("</time>");
		html.print("<span class='code'>");
		this.rightImage.output(html);
		html.print("</span>");
		html.print("</div>");
	}
	

	public Span getTitle1() {
		 return title1;
	}

	public Span getTitle2() {
		 return title2;
	}
	
	public Span getTitle3() {
		 return title3;
	}
	
	public Image getRightImage() {
		 return rightImage;
	}

	public String getQcUrl() {
		return QcUrl;
	}

	public void setQcUrl(String qcUrl) {
		QcUrl = qcUrl;
	}
}
