package com.huagu.common.ui.phone;


import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import cn.cerc.jpage.core.Component;
import cn.cerc.jpage.core.HtmlWriter;
import cn.cerc.jpage.vcl.Span;

public class Block130 extends Component{
	private Span leftText = new Span();
	private Span rightText =  new Span();
	private List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

	public List<Map<String, Object>> getList() {
		return list;
	}

	public void setList(List<Map<String, Object>> list) {
		this.list = list;
	}

	public Block130(Component owner) {
		super(owner);
		
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void output(HtmlWriter html) {
		html.println("<!-- %s -->", this.getClass().getName());
		html.print("<div class='block130'>");
		html.print("<ul>");
		
		for(Map<String, Object> map : this.list){
			html.print("<li>");
			Set set = map.entrySet(); 
			Iterator iterator = set.iterator();  
			while (iterator.hasNext()){  
	        	Map.Entry  mapentry = (Map.Entry) iterator.next();
	        	html.print("<div class='box'>");
				html.print("<div class='name'>%s", mapentry.getKey());
				html.print("</div>");
				html.print("<div class='con'>%s",mapentry.getValue()); 
				html.print("</div>");
				html.print("</div>");
			}
			html.print("</li>");
		}
		html.print("</ul>");
		html.print("</div>");
	}

	public Span getLeftText(){
		return this.leftText;
	} 
	
	public Span getRightText(){
		return this.rightText;
	}
}
