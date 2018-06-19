package com.huagu.product.forms;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

public class FrmAdminProType extends AbstractForm{

	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "products/FrmTypeDetail.jsp");
		String proName_ = this.getRequest().getParameter("proName_");
		String fristNameId_ = this.getRequest().getParameter("fristNameId_");
		String twoNameId_ = this.getRequest().getParameter("twoNameId_");
		LocalService svr = new LocalService(this, "SvrProType.queryProTypes");
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
			if(!svr.getDataOut().eof()){
				page.add("twoName_",svr.getDataOut().getCurrent().getString("twoName_"));
				page.add("twoNameId_", twoNameId_);
				page.add("fristName_",svr.getDataOut().getCurrent().getString("fristName_"));
				page.add("fristNameId_", fristNameId_);
			}
		}else{
			if(fristNameId_!=""&&fristNameId_!=null){
				if(!svr.getDataOut().eof()){
					page.add("fristName_",svr.getDataOut().getCurrent().getString("fristName_"));
					page.add("fristNameId_", fristNameId_);
				}
			}
		}
		return page;
	}
	
	/**
	 * 添加分类
	 * @Title: toAddProducts 
	 * @Description: TODO 
	 * @author 乔晨光
	 * @param @return
	 * @param @throws Exception    
	 * @return IPage
	 */
	public IPage toInsertProType() throws Exception{
		JspPage page = new JspPage(this, "products/FrmInsertType.jsp");
		String fristNameId_ = this.getRequest().getParameter("fristNameId_");//一级分类ID
		String twoNameId_ = this.getRequest().getParameter("twoNameId_");//二级分类ID
		if(fristNameId_ != null && fristNameId_ != ""){
			LocalService svr = new LocalService(this, "SvrGetFirstName");
			Record head = svr.getDataIn().getHead();
			head.setField("fristNameId_", this.getRequest().getParameter("fristNameId_"));
			if(!svr.exec()){
				throw new RuntimeException(svr.getMessage());
			}
			page.add("name", svr.getDataOut().getCurrent());
		}
		page.add("fristNameId_", fristNameId_);
		return page;
		
	}
	/**
	 * 添加分类
	 * @Title: InsertProType 
	 * @Description: TODO 
	 * @author 乔晨光
	 * @param @return
	 * @param @throws Exception    
	 * @return IPage
	 */
	public IPage InsertProType() throws Exception{
		String fristNameId_ = this.getRequest().getParameter("fristNameId_");//一级分类ID
		String fristName_ = this.getRequest().getParameter("fristName_");//一级分类名称
		String twoName_ = this.getRequest().getParameter("twoName_");//二级分类名称
		String fileKey = null;
		// 未见类型
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
		// 取出上传的每一个文件
		for (int i = 0; i < uploadFiles.size(); i++) {
			FileItem fileItem = uploadFiles.get(i);
			if (!fileItem.isFormField()) {// 文件名
				if (fileItem.getSize() > 0) {
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
					} else {
						oss.upload("yqx" + partCode + fileUName, fileItem.getInputStream());
						fileKey = "yqx" + partCode + fileUName;
					}
				}
			} else {
				if ("partCode".equals(fileItem.getFieldName()))
					partCode = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("fristName_".equals(fileItem.getFieldName()))
					fristName_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("twoName_".equals(fileItem.getFieldName()))
					twoName_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("fristNameId_".equals(fileItem.getFieldName()))
					fristNameId_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
			}
		}
		ServerConfig config = new ServerConfig();
		String path = "http://" + config.getProperty("oss.bucket") + "." + config.getProperty("oss.endpoint") + "/"
				+ fileKey;
		if (fileKey == null) {
			path = "";
		}
		JsonPage page =new JsonPage(this);
		LocalService svr = new LocalService(this, "SvrProType.insertProType");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("fristName_", fristName_);
		headIn.setField("twoName_", twoName_);
		headIn.setField("fristNameId_", fristNameId_);
		headIn.setField("path", path);
		if (!svr.exec()) {
			page.setData(false);
			throw new RuntimeException();
		}
		page.setData(true);
		return page;
		}
	


	public IPage queryProTypes() throws Exception{
		JsonPage jspage=new JsonPage(this);
		LocalService svr = new LocalService(this, "SvrProType.queryProTypes");
		Record head = svr.getDataIn().getHead();
		if(!svr.exec()){
			throw new RuntimeException();
		}
		Map<String, String> map = new HashMap<String, String>();

		map.put("va", svr.getDataOut().getRecords().toString());
		jspage.setData(map);
		return jspage;
		
	}
	
	//添加商品名称时查询的分类
	public IPage queryProTy() throws Exception{
		JsonPage jspage=new JsonPage(this);
		LocalService svr = new LocalService(this, "SvrProType.queryProTypes");
		Record head = svr.getDataIn().getHead();
		if(!svr.exec()){
			throw new RuntimeException();
		}
		Map<String, String> map = new HashMap<String, String>();
		 String string = svr.getDataOut().getRecords().toString();
		 System.out.println(string);
		map.put("va", svr.getDataOut().getRecords().toString());
		jspage.setData(map);
		return jspage;
		
	}
	/**
	 * 查询分类
	 * @Title: queryProType 
	 * @Description: TODO 
	 * @author 乔晨光
	 * @param @return
	 * @param @throws Exception    
	 * @return IPage
	 */
	public IPage queryType() throws Exception{
		JsonPage jspage=new JsonPage(this);
		String fristNameId_ = this.getRequest().getParameter("fristNameId_");//一级分类ID
		String twoNameId_ = this.getRequest().getParameter("twoNameId_");//二级分类ID
		LocalService svr = new LocalService(this, "SvrProType.queryType");
		Record head = svr.getDataIn().getHead();
		head.setField("fristNameId_", fristNameId_);
		head.setField("twoNameId_", twoNameId_);
		if(!svr.exec()){
			throw new RuntimeException();
		}
		
		Map<String, String> map = new HashMap<String, String>();

		map.put("va", svr.getDataOut().getRecords().toString());
		jspage.setData(map);
		return jspage;
		
	}
	//修改分类
	public IPage toUpdateType() throws Exception{
		JspPage page = new JspPage(this, "products/FrmUpdateType.jsp");
		String fristNameId_ = this.getRequest().getParameter("fristNameId_");//一级分类ID
		String twoNameId_ = this.getRequest().getParameter("twoNameId_");//二级分类ID
		LocalService svr = new LocalService(this, "SvrProType.queryById");
		Record head = svr.getDataIn().getHead();
		head.setField("fristNameId_", fristNameId_);
		head.setField("twoNameId_", twoNameId_);
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		page.add("fristName_", svr.getDataOut().getCurrent().getString("fristName_"));
		page.add("twoName_", svr.getDataOut().getCurrent().getString("twoName_"));
		page.add("twoImgUrl_", svr.getDataOut().getCurrent().getString("twoImgUrl_"));
		page.add("fristNameId_", svr.getDataOut().getCurrent().getString("fristNameId_"));
		page.add("twoNameId_", svr.getDataOut().getCurrent().getString("twoNameId_"));
		page.add("twoImgUrl_", svr.getDataOut().getCurrent().getString("twoImgUrl_"));
		page.add("fristImgUrl_", svr.getDataOut().getCurrent().getString("fristImgUrl_"));
		if(twoNameId_!=null&&twoNameId_!=""){
			page.add("twoname", "sid");
		}
		return page;
	}
	
	/**
	 * 修改分类
	 * @Title: updateType 
	 * @Description: TODO 
	 * @author 乔晨光
	 * @param @return
	 * @param @throws Exception    
	 * @return IPage
	 */
	public IPage updateType() throws Exception{
		String fristName_ = this.getRequest().getParameter("fristName_");//一级分类名称
		String twoName_ = this.getRequest().getParameter("twoName_");//二级分类名称
		String twoNameId_ = this.getRequest().getParameter("twoNameId_");
		String fristNameId_ = this.getRequest().getParameter("fristNameId_");
		String fileKey = null;
		// 未见类型
		String partCode = getRequest().getParameter("partCode");
		// 处理文件上传
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 设置最大缓存
		factory.setSizeThreshold(5 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		// 获取所有文件列表
		List<FileItem> uploadFiles = upload.parseRequest(getRequest());
		OssSession oss = (OssSession) this.getHandle().getProperty(OssSession.sessionId);
		System.err.println(uploadFiles.size() + "--上传的文件个数-");
		// 取出上传的每一个文件
		for (int i = 0; i < uploadFiles.size(); i++) {
			FileItem fileItem = uploadFiles.get(i);
			if (!fileItem.isFormField()) {// 文件名
				if (fileItem.getSize() > 0) {
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
					} else {
						oss.upload("yqx" + partCode + fileUName, fileItem.getInputStream());
						fileKey = "yqx" + partCode + fileUName;
					}
				}
			} else {
				if ("partCode".equals(fileItem.getFieldName()))
					partCode = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("fristName_".equals(fileItem.getFieldName()))
					fristName_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("twoName_".equals(fileItem.getFieldName()))
					twoName_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("twoNameId_".equals(fileItem.getFieldName()))
					twoNameId_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("fristNameId_".equals(fileItem.getFieldName()))
					fristNameId_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
			}
		}
		ServerConfig config = new ServerConfig();
		String path = "http://" + config.getProperty("oss.bucket") + "." + config.getProperty("oss.endpoint") + "/"
				+ fileKey;
		if (fileKey == null) {
			path = "";
		}
		System.out.println("path12345235235"+path);
		JsonPage page =new JsonPage(this);
		LocalService svr = new LocalService(this, "SvrProType.updateType");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("fristName_", fristName_);
		headIn.setField("twoName_", twoName_);
		headIn.setField("twoNameId_", twoNameId_);
		headIn.setField("fristNameId_", fristNameId_);
		headIn.setField("path", path);
		System.out.println("svr.exec()0"+svr.exec());
		if (!svr.exec()) {
			throw new RuntimeException(svr.getMessage());
		}
		page.setData(true);
		return page;
		
	}
	/**
	 * 删除分类
	 * @Title: delType 
	 * @Description: TODO 
	 * @author 乔晨光
	 * @param @return
	 * @param @throws Exception    
	 * @return IPage
	 */
	public IPage delType() throws Exception{
		JsonPage page=new JsonPage(this);
		String twoNameId_ = this.getRequest().getParameter("twoNameId_");
		String fristNameId_ = this.getRequest().getParameter("fristNameId_");
		LocalService svr = new LocalService(this, "SvrProType.delType");
		Record head = svr.getDataIn().getHead();
		if(fristNameId_!=null&&fristNameId_!=""){
			head.setField("fristNameId_", fristNameId_);
		}
		if(twoNameId_!=null&&twoNameId_!=""){
			head.setField("twoNameId_", twoNameId_);
		}
		if(!svr.exec()){
			throw new RuntimeException();
		}
		return new RedirectPage(this, "FrmAdminProType");
		
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
