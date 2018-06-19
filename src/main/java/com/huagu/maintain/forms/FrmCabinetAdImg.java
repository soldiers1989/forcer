package com.huagu.maintain.forms;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.oss.OssSession;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;

/**
 * 柜子广告图片维护
 * 
 * @author xiaofei-pc
 *
 */
public class FrmCabinetAdImg extends AbstractForm {
	private static final Logger LOGGER = Logger.getLogger(FrmCabinetAdImg.class);

	@Override
	public IPage execute() throws Exception {
		String type_ = this.getRequest().getParameter("type_");
		JspPage jsp = new JspPage(this, "ad/FrmCabinetAdd.jsp");
		LocalService cabinetAd = new LocalService(this, "SvrCabinetAd");
		if (!cabinetAd.exec("type_", type_)) {
			throw new RuntimeException(cabinetAd.getMessage());
		}
		return jsp;
	}

	/**
	 * 跳转修改柜子图片页面 cabinetId 柜子ID
	 */
	public IPage upLunBoAd() throws Exception {
		String cabinetId_ = this.getRequest().getParameter("id_");
		JspPage jsp = new JspPage(this, "ad/FrmCabinetUp.jsp");

		jsp.add("cabinetId_", cabinetId_);
		return jsp;
	}

	/**
	 * 修改图片
	 * 
	 * @throws FileUploadException
	 * @throws IOException
	 */
	public IPage upCabinetAd() throws FileUploadException, IOException {
		String fileKey = null;
		List<String> cabinetAdImg = new ArrayList<String>();
		String cabinetId_ = this.getRequest().getParameter("cabinetId_");
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
							|| fileName.endsWith(".jpeg") || fileName.endsWith(".JPEG")) {// 图片上传
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
						oss.upload("zsf" + "/IMG/" + fileUName, fileItem.getInputStream());
						fileKey = "zsf" + "/IMG/" + fileUName;
					} else {
						oss.upload("zsf" + fileUName, fileItem.getInputStream());
						fileKey = "zsf" + fileUName;
					}

					ServerConfig config = new ServerConfig();
					String path = "http://" + config.getProperty("oss.bucket") + "."
							+ config.getProperty("oss.endpoint") + "/" + fileKey;
					cabinetAdImg.add(path);
				}
			} else {
				if ("cabinetId_".equals(fileItem.getFieldName()))
					cabinetId_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
			}
		}
		System.err.println(cabinetAdImg);
		System.err.println(removeDuplicate(cabinetAdImg));

		LocalService upCabinetImg = new LocalService(this, "SvrCabinetImgAd");
		if(!upCabinetImg.exec("cabinetId_", cabinetId_, "cabinetAd", removeDuplicate(cabinetAdImg))){
			throw new RuntimeException(upCabinetImg.getMessage());
		}
		
		/* json.setData(path); */
		return new RedirectPage(this, "FrmAdminHomeAdManage");
	}

	public static List removeDuplicate(List list) {
		for (int i = 0; i < list.size() - 1; i++) {
			for (int j = list.size() - 1; j > i; j--) {
				if (list.get(j).equals(list.get(i))) {
					list.remove(j);
				}
			}
		}
		return list;
	}

	public boolean logon() {
		return true;
	}

}
