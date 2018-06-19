package com.huagu.common.forms;

import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.oss.OssSession;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;

public class FrmProductImage extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		return null;
	}
	
	
	/**
	 *  编辑器插件，上传图片
	 * @return
	 * @throws Exception
	 */
	public IPage ckeditorUpImage() throws Exception {
		JsonPage page = new JsonPage(this);
		ServerConfig config = new ServerConfig();
		String serverPath = "http://"+config.getProperty("oss.bucket")+"."+config.getProperty("oss.endpoint");
		page.setData("");
		// 处理文件上传
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 设置最大缓存
		factory.setSizeThreshold(5 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		// 获取所有文件列表
		List<FileItem> uploadFiles = upload.parseRequest(getRequest());
		OssSession oss = (OssSession) this.getHandle().getProperty(OssSession.sessionId);
		// 取出上传的每一个文件
		for (int i = 0; i < uploadFiles.size(); i++) {
			FileItem fileItem = uploadFiles.get(i);
			if (!fileItem.isFormField()) {// 文件名
				if (fileItem.getSize() > 0) {
					String fileName = fileItem.getName().toLowerCase();
					String suffix = fileName.substring(fileName.indexOf("."));
					String fileUName = UUID.randomUUID().toString();
					PrintWriter out = this.getResponse().getWriter();
					String callback = this.getRequest().getParameter("CKEditorFuncNum");
					if((fileName.endsWith(".jpg") || fileName.endsWith(".png") || fileName.endsWith(".gif"))){  
						//如果传入的文件是图片文件，那么上传
						oss.upload("727000" + "/IMG/" + fileUName + suffix, fileItem.getInputStream());
						String path = serverPath+"/727000" + "/IMG/" + fileUName + suffix;
						out.println("<script type=\"text/javascript\">");  
						out.println("window.parent.CKEDITOR.tools.callFunction("+ callback + ",'" + path + "','')");   
						out.println("</script>");   
					} else if (fileName.endsWith(".mp4") || fileName.endsWith(".swf")) {
						//如果是视频文件，那么上传
						oss.upload("727000" + "/MV/" + fileUName + suffix, fileItem.getInputStream());
						String path = serverPath+"/727000" + "/MV/" + fileUName + suffix;
						out.println("<script type=\"text/javascript\">");  
						out.println("window.parent.CKEDITOR.tools.callFunction("+ callback + ",'" + path + "','')");   
						out.println("</script>");
						
					} else {
						out.println("<script type=\"text/javascript\">");    
						out.println("window.parent.CKEDITOR.tools.callFunction(" + callback + ",''," + "'文件格式不正确（必须为.jpg/.gif/.png/.swf文件）');");   
						out.println("</script>");  
						return page;
					}
				}
			}
		}
		return page;
	}
	
	public boolean logon() {
		return true;
	}


}
