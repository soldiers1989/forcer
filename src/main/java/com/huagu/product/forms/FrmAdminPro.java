package com.huagu.product.forms;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.oss.OssSession;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
import cn.cerc.jpage.grid.MutiPage;

public class FrmAdminPro extends AbstractForm{
	
	/**
	 * 后台商品管理
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "products/FrmProNameDetail.jsp");
		String proName_ = this.getRequest().getParameter("proName_");
		String fristNameId_ = this.getRequest().getParameter("fristNameId_");
		String twoNameId_ = this.getRequest().getParameter("twoNameId_");
		LocalService svr = new LocalService(this, "SvrAdminPro.queryProName");
		Record head = svr.getDataIn().getHead();
		head.setField("proName_", proName_);
		head.setField("fristNameId_", fristNameId_);
		head.setField("twoNameId_", twoNameId_);
		if(!svr.exec()){
			throw new RuntimeException();
		}
		if(!svr.getDataOut().eof()){
			page.add("proName_", proName_);
		}
		page.add("values",this.setPage(page, svr.getDataOut()));
		if(twoNameId_!=""&&twoNameId_!=null){
			if(!twoNameId_.equals("请选择")){
				if(!svr.getDataOut().eof()){
					page.add("twoName_",svr.getDataOut().getCurrent().getString("twoName_"));
					page.add("twoNameId_", twoNameId_);
					page.add("fristName_",svr.getDataOut().getCurrent().getString("fristName_"));
					page.add("fristNameId_", fristNameId_);
				}
			}
		}else{
			if(fristNameId_!=""&&fristNameId_!=null){
				if(!fristNameId_.equals("请选择")){
					page.add("fristName_",svr.getDataOut().getCurrent().getString("fristName_"));
					page.add("fristNameId_", fristNameId_);
				}
			}
		}
		return page;
	}
	
	/**
	 * 查看商品详情
	 * @Title: queryProdetail 
	 * @Description: TODO 
	 * @author 乔晨光
	 * @param @return
	 * @param @throws Exception    
	 * @return IPage
	 */
	public IPage queryProDetail() throws Exception{
		JspPage page = new JspPage(this, "products/FrmProductsDetail.jsp");
		
		return page;
		
	}
	
	/**
	 * 添加商品名称
	 * @Title: toAddProducts 
	 * @Description: TODO 
	 * @author 乔晨光
	 * @param @return
	 * @param @throws Exception    
	 * @return IPage
	 */
	public IPage toInsertProductsName() throws Exception{
		JspPage page = new JspPage(this, "products/FrmInsertProName.jsp");
		return page;
	}
	
	//添加商品名称
	public IPage insertProductsName() throws Exception{
		JsonPage page =new JsonPage(this);
		String fristNameId_ = this.getRequest().getParameter("fristNameId_");//一级分类名称
		String twoNameId_ = this.getRequest().getParameter("twoNameId_");//二级分类名称
		String proName_ = this.getRequest().getParameter("proName_");//商品名称
		String salesHotPush_ = this.getRequest().getParameter("salesHotPush_");
		String salesTypeMenu_ = this.getRequest().getParameter("salesTypeMenu_");
		String salesFine_ = this.getRequest().getParameter("salesFine_");
		String salesNewPro_ = this.getRequest().getParameter("salesNewPro_");
		String rentHotPush_ = this.getRequest().getParameter("rentHotPush_");
		String rentTypeMenu_ = this.getRequest().getParameter("rentTypeMenu_");
		String rentFine_ = this.getRequest().getParameter("rentFine_");
		String rentNewPro_ = this.getRequest().getParameter("rentNewPro_");
		String partCode = getRequest().getParameter("partCode");
		// 处理文件上传
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 设置最大缓存
		factory.setSizeThreshold(5 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		System.out.println("upload+"+upload);
		// 获取所有文件列表
		List<FileItem> uploadFiles = upload.parseRequest(getRequest());
		OssSession oss = (OssSession) this.getHandle().getProperty(OssSession.sessionId);
		ServerConfig config = new ServerConfig();	
		String fileKey = null;
		String path = "http://" + config.getProperty("oss.bucket") + "." + config.getProperty("oss.endpoint") + "/"; 
		String proZsImges_="";
		List<String> list=new ArrayList<String>();
		// 取出上传的每一个文件
		System.out.println("uploadFiles.size()"+uploadFiles.size());
		for (int i = 0; i < uploadFiles.size(); i++) {
			FileItem fileItem = uploadFiles.get(i);
			if (!fileItem.isFormField()) {// 文件名
				if (fileItem.getSize() > 0) {
					String formName = fileItem.getFieldName();
					String fileName = fileItem.getName().toLowerCase();
					String fileUName = UUID.randomUUID().toString();
					if (fileName.endsWith(".jpg") || fileName.endsWith(".png") || fileName.endsWith(".gif")|| fileName.endsWith(".jpeg")|| fileName.endsWith(".JPEG")) {// 图片上传
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
						fileKey = "yqx/IMG/" + fileUName;
						oss.upload(fileKey, fileItem.getInputStream());	
						if(formName.contains("proZsImges_")){
							proZsImges_=path+fileKey;
						}
						
						if(formName.contains("proLbImges_")){
							list.add(path+fileKey);
						}
					} 
				}
			} else {
				if ("partCode".equals(fileItem.getFieldName()))
					partCode = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("fristNameId_".equals(fileItem.getFieldName()))
					fristNameId_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("twoNameId_".equals(fileItem.getFieldName()))
					twoNameId_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("proName_".equals(fileItem.getFieldName()))
					proName_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("salesHotPush_".equals(fileItem.getFieldName()))
					salesHotPush_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("salesTypeMenu_".equals(fileItem.getFieldName()))
					salesTypeMenu_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("salesFine_".equals(fileItem.getFieldName()))
					salesFine_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("salesNewPro_".equals(fileItem.getFieldName()))
					salesNewPro_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("rentHotPush_".equals(fileItem.getFieldName()))
					rentHotPush_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("rentTypeMenu_".equals(fileItem.getFieldName()))
					rentTypeMenu_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("rentFine_".equals(fileItem.getFieldName()))
					rentFine_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("rentNewPro_".equals(fileItem.getFieldName()))
					rentNewPro_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
			}
		}
		LocalService svr = new LocalService(this, "SvrAdminPro.insertProductsName");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("fristNameId_", fristNameId_);
		headIn.setField("twoNameId_", twoNameId_);
		headIn.setField("proName_", proName_);
		headIn.setField("proZsImges_", proZsImges_);
		headIn.setField("proLbImges_", list);
		headIn.setField("salesHotPush_", salesHotPush_);
		headIn.setField("salesTypeMenu_", salesTypeMenu_);
		headIn.setField("salesFine_", salesFine_);
		headIn.setField("salesNewPro_", salesNewPro_);
		headIn.setField("rentHotPush_", rentHotPush_);
		headIn.setField("rentTypeMenu_", rentTypeMenu_);
		headIn.setField("rentFine_", rentFine_);
		headIn.setField("rentNewPro_", rentNewPro_);
		if (!svr.exec()) {
			page.setData(false);
		}else{
			page.setData(true);
		}
		return page;
	}
	
	//修改商品名称
	public IPage toUpdateProductsName() throws Exception{
		JspPage page = new JspPage(this, "products/FrmUpdateProName.jsp");
		String proId_ = this.getRequest().getParameter("proId_");//二级分类名称
		LocalService svr = new LocalService(this, "SvrAdminPro.queryById");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("proId_", proId_);
		if(!svr.exec()){
			throw new RuntimeException();
		}
		 List<Record> records = svr.getDataOut().getRecords();
			for(Record r:records ){
				String imgPath_ = r.getSafeString("proLbImges_");
				imgPath_ = imgPath_.replace("[", "");	
				imgPath_ = imgPath_.replace("]", "");
				r.setField("proLbImges_", imgPath_);
			}
		
		page.add("value", svr.getDataOut().getCurrent());
		page.add("proZsImges_", svr.getDataOut().getCurrent().getString("proZsImges_"));
		page.add("fristName_", svr.getDataOut().getCurrent().getString("fristName_"));
		page.add("twoName_", svr.getDataOut().getCurrent().getString("twoName_"));
		page.add("fristNameId_", svr.getDataOut().getCurrent().getString("fristNameId_"));
		page.add("twoNameId_", svr.getDataOut().getCurrent().getString("twoNameId_"));
		page.add("proId_", svr.getDataOut().getCurrent().getString("proId_"));
		page.add("proName_", svr.getDataOut().getCurrent().getString("proName_"));
		return page;
	}
	
	//修改商品名称
	public IPage updateProductsName() throws Exception{
		JsonPage page =new JsonPage(this);
		String fristNameId_ = this.getRequest().getParameter("fristNameId_");//一级分类名称
		String twoNameId_ = this.getRequest().getParameter("twoNameId_");//二级分类名称
		String proName_ = this.getRequest().getParameter("proName_");//商品名称
		String proId_ = this.getRequest().getParameter("proId_");
		String salesHotPush_ = this.getRequest().getParameter("salesHotPush_");
		String salesTypeMenu_ = this.getRequest().getParameter("salesTypeMenu_");
		String salesFine_ = this.getRequest().getParameter("salesFine_");
		String salesNewPro_ = this.getRequest().getParameter("salesNewPro_");
		String rentHotPush_ = this.getRequest().getParameter("rentHotPush_");
		String rentTypeMenu_ = this.getRequest().getParameter("rentTypeMenu_");
		String rentFine_ = this.getRequest().getParameter("rentFine_");
		String rentNewPro_ = this.getRequest().getParameter("rentNewPro_");
		String partCode = getRequest().getParameter("partCode");
		// 处理文件上传
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 设置最大缓存
		factory.setSizeThreshold(5 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		System.out.println("upload+"+upload);
		// 获取所有文件列表
		List<FileItem> uploadFiles = upload.parseRequest(getRequest());
		OssSession oss = (OssSession) this.getHandle().getProperty(OssSession.sessionId);
		ServerConfig config = new ServerConfig();
		// 取出上传的每一个文件
		String path = "http://" + config.getProperty("oss.bucket") + "." + config.getProperty("oss.endpoint") + "/"; 
		String proZsImges_="";
		List<String> proLbImges_=new ArrayList<String>();
		String fileKey = null;
		for (int i = 0; i < uploadFiles.size(); i++) {
			FileItem fileItem = uploadFiles.get(i);
			if (!fileItem.isFormField()) {// 文件名
				if (fileItem.getSize() > 0) {
					String formName = fileItem.getFieldName();
					String fileName = fileItem.getName().toLowerCase();
					String fileUName = UUID.randomUUID().toString();
					if (fileName.endsWith(".jpg") || fileName.endsWith(".png") || fileName.endsWith(".gif")|| fileName.endsWith(".jpeg")|| fileName.endsWith(".JPEG")) {// 图片上传
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
						oss.upload("yqx" + "/IMG/" + fileUName, fileItem.getInputStream());
						fileKey = "yqx" + "/IMG/" + fileUName;
						
						if(formName.contains("proZsImges_")){
							proZsImges_=path+fileKey;
						}
						
						if(formName.contains("proLbImges_")){
							proLbImges_.add(path+fileKey);
						}
					}
				}
			} else {
				if ("proId_".equals(fileItem.getFieldName()))
					proId_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("partCode".equals(fileItem.getFieldName()))
					partCode = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("fristNameId_".equals(fileItem.getFieldName()))
					fristNameId_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("twoNameId_".equals(fileItem.getFieldName()))
					twoNameId_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("proName_".equals(fileItem.getFieldName()))
					proName_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("salesHotPush_".equals(fileItem.getFieldName()))
					salesHotPush_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("salesTypeMenu_".equals(fileItem.getFieldName()))
					salesTypeMenu_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("salesFine_".equals(fileItem.getFieldName()))
					salesFine_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("salesNewPro_".equals(fileItem.getFieldName()))
					salesNewPro_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("rentHotPush_".equals(fileItem.getFieldName()))
					rentHotPush_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("rentTypeMenu_".equals(fileItem.getFieldName()))
					rentTypeMenu_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("rentFine_".equals(fileItem.getFieldName()))
					rentFine_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("rentNewPro_".equals(fileItem.getFieldName()))
					rentNewPro_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
			}
		}
		LocalService svr = new LocalService(this, "SvrAdminPro.updateProName");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("proId_", proId_);
		headIn.setField("fristNameId_", fristNameId_);
		headIn.setField("twoNameId_", twoNameId_);
		headIn.setField("proName_", proName_);
		headIn.setField("salesHotPush_", salesHotPush_);
		headIn.setField("salesTypeMenu_", salesTypeMenu_);
		headIn.setField("salesFine_", salesFine_);
		headIn.setField("salesNewPro_", salesNewPro_);
		headIn.setField("rentHotPush_", rentHotPush_);
		headIn.setField("rentTypeMenu_", rentTypeMenu_);
		headIn.setField("rentFine_", rentFine_);
		headIn.setField("rentNewPro_", rentNewPro_);
		headIn.setField("proLbImges_", proLbImges_);
		headIn.setField("proZsImges_", proZsImges_);
		if (!svr.exec()) {
			page.setData(false);
		}else{
			page.setData(true);
		}
		return page;
		
	}
	
	/**
	 * 插入图片或视频
	 * @throws Exception 
	* @Title: publish 
	 */
	public IPage insertPictureByArtificer() throws Exception {
		JsonPage page=new JsonPage(this);
		String pathFinal="";
		//处理文件上传
		DiskFileItemFactory factory = new DiskFileItemFactory();
		//设置最大缓存
		factory.setSizeThreshold(10 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		//获取所有文件列表
		List<FileItem> uploadFiles = upload.parseRequest(this.getRequest());
		OssSession oss = (OssSession) this.getHandle().getProperty(OssSession.sessionId);
		ServerConfig sc = new ServerConfig();
		String path = "http://" + sc.getProperty("oss.bucket") + "." + sc.getProperty("oss.endpoint") + "/";
		String fileKey = "";
		//取出上传的每一个文件
		for (int i = 0; i < uploadFiles.size(); i++) {
			FileItem fileItem  = uploadFiles.get(i);
		if (!fileItem.isFormField()) {
			if (fileItem.getSize() > 0) {
				String formName = fileItem.getFieldName();
				String fileName = fileItem.getName();
				String fileUName = UUID.randomUUID().toString();
				if (fileName.endsWith(".jpg") || fileName.endsWith(".png") || fileName.endsWith(".gif")|| fileName.endsWith(".jpeg")|| fileName.endsWith(".JPEG")) {// 图片上传
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
					fileKey = "YQX/ZNG/IMG/" + fileUName;
					oss.upload(fileKey, fileItem.getInputStream());
						pathFinal=path + fileKey;
				} else if (fileName.endsWith(".mp4")||fileName.endsWith(".MOV")||fileName.endsWith(".3GP")||fileName.endsWith(".MPV")||fileName.endsWith(".AVI")){
					//视频上传
					if (fileName.endsWith(".mp4"))
						fileUName += ".mp4";
					if (fileName.endsWith(".MOV"))
						fileUName += ".MOV";
					if (fileName.endsWith(".3GP"))
						fileUName += "3GP";
					if (fileName.endsWith(".MPV"))
						fileUName += "MPV";
					if (fileName.endsWith(".AVI"))
						fileUName += "AVI";
					fileKey = "YQX/ZNG/VIDEO/" + fileUName;
					oss.upload(fileKey, fileItem.getInputStream());
						pathFinal=path + fileKey;
				}
			}
		} 
		}
		 page.setData(pathFinal);
		 return page;
	}
	
	/**
	 * 删除商品详情图片
	 * 
	 * @Title: publish
	 */
	public IPage delImg() throws Exception {
		JsonPage page=new JsonPage(this);
		String UID_ = this.getRequest().getParameter("UID_");
		LocalService svr = new LocalService(this, "SvrAdminPro.delImg");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("UID_", UID_);
		if(svr.exec()) {
			throw new RuntimeException(svr.getMessage());
		}
		page.setData("true");
		return page;
	}
	
	//删除商品名称
	public IPage delProductsName() throws Exception{
		String proId_ = this.getRequest().getParameter("proId_");
		LocalService svr = new LocalService(this, "SvrAdminPro.delProName"); 
		Record head=svr.getDataIn().getHead();
		head.setField("proId_", proId_);
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		return new RedirectPage(this, "FrmAdminPro");
		
	}
	
	//分页
		private List<Record> setPage(AbstractJspPage page, DataSet dataSet) {
			List<Record> records = null;
			MutiPage pages = new MutiPage();
			pages.setRequest(getRequest());
			pages.setDataSet(dataSet);
			pages.setPageSize(10);
			page.add("pages", pages);
			if (dataSet.size() > 0) {
				records = new ArrayList<>();
				for (int i = pages.getBegin(); i <= pages.getEnd(); i++) {
					dataSet.setRecNo(i + 1);
					Record record = dataSet.getCurrent();
					records.add(record);
				}
			}
			return records;
		}
	
	public boolean logon() {
		return true;
	}
}
