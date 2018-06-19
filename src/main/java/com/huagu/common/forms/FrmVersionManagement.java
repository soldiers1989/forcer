package com.huagu.common.forms;

import java.util.List;
import java.util.UUID;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import com.huagu.common.util.ParamUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.oss.OssSession;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;

public class FrmVersionManagement extends AbstractForm {
	@SuppressWarnings("unused")
	private static final Logger LOGGER = Logger.getLogger(FrmVersionManagement.class);

	/**
	 * 查询中控屏列表
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "common/versionManagement.jsp");
		LocalService getVersion = new LocalService(this, "SvrGetVersion");
		if(!getVersion.exec()){
			throw new RuntimeException(getVersion.getMessage());
		}
		
		jsp.add("version", getVersion.getDataOut().getRecords());
		ParamUtil.addLog(this, "查询", "查看中控屏版本信息", "查看中控屏版本信息");
		return new JspPage(this, "common/versionManagement.jsp");
	}
	
	public IPage addPage(){
		JspPage jsp = new JspPage(this, "common/addVersion.jsp");
		
		return jsp;
	}
	
	/**
	 * 添加中控屏安装包信息
	 * @return
	 * @throws Exception
	 */
	public IPage addVersion() throws Exception{
		String fileKey = null;
		String versionNum_ = this.getRequest().getParameter("versionNum_");
		String versionFile_ = this.getRequest().getParameter("versionFile_");
		String versionName_ = this.getRequest().getParameter("versionName_");
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
					String fileUName = UUID.randomUUID().toString();
					if (fileName.endsWith(".jpg") || fileName.endsWith(".png") || fileName.endsWith(".gif")
							|| fileName.endsWith(".jpeg") || fileName.endsWith(".JPEG") || fileName.endsWith(".apk")
							 || fileName.endsWith(".exe")) {// 图片上传
						if (fileName.endsWith(".jpg"))
							fileUName += ".jpg";
						if (fileName.endsWith(".png"))
							fileUName += ".png";
						if (fileName.endsWith(".gif"))
							fileUName += ".gif";
						if (fileName.endsWith(".jpeg"))
							fileUName += ".jpeg";
						if (fileName.endsWith(".JPEG"))
							fileUName += ".JPEG";
						if (fileName.endsWith(".apk"))
							fileUName += ".apk";
						if (fileName.endsWith(".exe"))
							fileUName += ".exe";
						oss.upload("zsf" + "/IMG/" + fileUName, fileItem.getInputStream());
						fileKey = "zsf" + "/IMG/" + fileUName;
					} else {
						oss.upload("zsf" + fileUName, fileItem.getInputStream());
						fileKey = "zsf" + fileUName;
					}
				}
			} else {
				if ("versionNum_".equals(fileItem.getFieldName()))
					versionNum_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");

				if ("versionName_".equals(fileItem.getFieldName()))
					versionName_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				
				if ("versionFile_".equals(fileItem.getFieldName()))
					versionFile_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
			}
		}
		
		ServerConfig config = new ServerConfig();
		String path = "http://" + config.getProperty("oss.bucket") + "."
				+ config.getProperty("oss.endpoint") + "/" + fileKey;
		
		LocalService upCabinetImg = new LocalService(this, "SvrGetVersion");
		if(!upCabinetImg.exec("type_","add","versionName_", versionName_, "versionNum_", versionNum_, "versionFile_", path)){
			throw new RuntimeException(upCabinetImg.getMessage());
		}

		ParamUtil.addLog(this, "查询", "上传中控屏最新版本安装包", "上传中控屏最新版本安装包");
		return new RedirectPage(this, "FrmVersionManagement");
	}
	
	/**
	 * 删除中控屏安装包信息
	 * @return
	 * @throws Exception
	 */
	public JsonPage delVersion() throws Exception{
		JsonPage json = new JsonPage(this);
		String id_ = this.getRequest().getParameter("id_");
		LocalService upCabinetImg = new LocalService(this, "SvrGetVersion");
		if(!upCabinetImg.exec("type_","del", "id_", id_))
			json.setData(false);
		else
			json.setData(true);

		ParamUtil.addLog(this, "删除", "删除中控屏版本安装包id"+id_, "删除中控屏版本安装包"+id_);
		return json;
	}
	
	public boolean logon() {
		return true;
	}
}
