package com.huagu.common.ui.phone;

import cn.cerc.jpage.core.Component;
import cn.cerc.jpage.core.HtmlWriter;
import cn.cerc.jpage.vcl.Span;

public class Block202 extends Component{
	private Span title1= new Span();
	private Span title2= new Span();
	private Span title3= new Span();
	public Block202(Component owner) {
		super(owner);
		title1.setText("全部使用");
		title2.setText("未使用");
		title3.setText("已使用");
	}
	
	@Override
	public void output(HtmlWriter html) {
		html.println("<!-- %s -->", this.getClass().getName());
		html.print("<div class='block202'>");
		html.print("<a class='item' href='javascript:void(0);'>");
		this.title1.output(html);
		html.print("</a>");
		html.print("<a class='item' href='javascript:void(0);'>");
		this.title2.output(html);
		html.print("</a>");
		html.print("<a class='item' href='javascript:void(0);'>");
		this.title3.output(html);
		html.print("</a>");
		html.print("</div>");
	}
	
	public Span getTitle1(){
		return title1;
	}
	public Span getTitle2(){
		return title2;
	}
	public Span getTitle3(){
		return title3;
	}
}
