package com.huagu.community.forms;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;

public class FrmCommunityList extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "community/communityList.jsp");
		LocalService svr = new LocalService(this, "SvrCommunityList.getSvrCommunityList");
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", svr.getDataOut().getRecords());
		return page;
	}

	// 添加
	public IPage addCommunityList() throws Exception {
		LocalService svr = new LocalService(this, "SvrCommunityList.addSvrCommunityList");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("content_", this.getRequest().getParameter("content_"));
		headIn.setField("title_", this.getRequest().getParameter("title_"));
		headIn.setField("date_", this.getRequest().getParameter("date_"));
		headIn.setField("id_", this.getRequest().getParameter("id_"));
		headIn.setField("type_", this.getRequest().getParameter("type_"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return new RedirectPage(this, "FrmCommunityList");
	}

	// 跳转到添加页面
	public IPage gotoaddCommunityList() throws Exception {
		JspPage page = new JspPage(this, "community/addcommunityList.jsp");
		return page;
	}

	// 删除
	public IPage delCommunityList() throws Exception {
		String id_ = this.getRequest().getParameter("id_");
		LocalService svr = new LocalService(this, "SvrCommunityList.delSvrCommunityList");
		if (!svr.exec("id_", id_))
			throw new RuntimeException(svr.getMessage());
		return execute();
	}

	// 跳转到修改页面
	public IPage gotoCommunityList() throws Exception {
		JspPage page = new JspPage(this, "community/upcommunityList.jsp");
		String id_ = this.getRequest().getParameter("id_");
		LocalService svr = new LocalService(this, "SvrCommunityList.getSvrCommunityList");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("falg", 1);
		headIn.setField("id_", id_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("values", svr.getDataOut().getCurrent());
		return page;
	}

	// 修改
	public IPage upCommunityList() throws Exception {
		LocalService svr = new LocalService(this, "SvrCommunityList.upSvrCommunityList");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("id_", this.getRequest().getParameter("id_"));
		headIn.setField("title_", this.getRequest().getParameter("title_"));
		headIn.setField("content_", this.getRequest().getParameter("content_"));
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return execute();
	}

	// 测试
	public IPage test() throws Exception {
		JspPage jsp = new JspPage(this, "setUp/test.jsp");

		return jsp;
	}

	// 测试
	public JsonPage testJson() throws Exception {
		JsonPage json = new JsonPage(this);
		
        /*Map map = new HashMap();    
        Enumeration paramNames = this.getRequest().getParameterNames();    
        while (paramNames.hasMoreElements()) {    
            String paramName = (String) paramNames.nextElement();    
    
            String[] paramValues = this.getRequest().getParameterValues(paramName);    
            if (paramValues.length == 1) {    
                String paramValue = paramValues[0];    
                if (paramValue.length() != 0) {    
                    map.put(paramName, paramValue);    
                }    
            }    
        }    
    
        Set<Map.Entry<String, String>> set = map.entrySet();    
        String text = "";  
        for (Map.Entry entry : set) {    
        	System.out.println(entry.getKey() + ":" + entry.getValue());
            text += entry.getKey() + ":" + entry.getValue();  
        	System.out.println("text------->"+text);
        }    
        if(text.startsWith("[") && text.endsWith("]")){  
            return text;  
        }  
        return ""; */ 
		String text_ = this.getRequest().getParameter("text_");
		String file_ = this.getRequest().getParameter("file_");
		// 处理文件上传
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 设置最大缓存
		factory.setSizeThreshold(10 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		// 获取所有文件列表
		List<FileItem> uploadFiles = upload.parseRequest(this.getRequest());
		// 取出上传的每一个文件
		for (int i = 0; i < uploadFiles.size(); i++) {
			FileItem fileItem = uploadFiles.get(i);
			// 表单元素
			if ("text_".equals(fileItem.getFieldName()))
				text_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
			// 表单元素
			if ("file_".equals(fileItem.getFieldName()))
				file_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");

		}
		System.out.println("json:" + text_);
		System.out.println("json:" + file_);
		
		if (text_ != null) {
			json.setData(true);
		} else {
			json.setData(false);
		}

		return json;
	}

	@Override
	public boolean logon() {
		return true;
	}

}
