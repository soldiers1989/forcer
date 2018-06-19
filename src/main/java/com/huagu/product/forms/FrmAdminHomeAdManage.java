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

public class FrmAdminHomeAdManage extends AbstractForm {

    @Override
    public IPage execute() throws Exception {
        JspPage page = new JspPage(this, "products/FrmHomeLunBoMange.jsp");
        // 首页轮播图
        LocalService svrHomeLunBo = new LocalService(this, "SvrHomeAd.queryHomeAd");
        if (!svrHomeLunBo.exec()) {
            throw new RuntimeException();
        } else {
            List<Record> records = svrHomeLunBo.getDataOut().getRecords();
            if (records.size() != 0) {
                for (Record r : records) {
                    String imgPath_ = r.getSafeString("imgPath_");
                    imgPath_ = imgPath_.replace("[", "");
                    imgPath_ = imgPath_.replace("]", "");
                    r.setField("imgPath_", imgPath_);
                }
                page.add("values", svrHomeLunBo.getDataOut().getRecords());
            }
        }
        LocalService getHomeAd = new LocalService(this, "SvrHomeAd.getHomeAd");
        if (!getHomeAd.exec()) {
            throw new RuntimeException();
        } else {
            List<Record> records = getHomeAd.getDataOut().getRecords();
            if (records.size() != 0) {
                for (Record r : records) {
                    String vedioId_ = r.getSafeString("vedioId_");
                    vedioId_ = vedioId_.replace("[", "");
                    vedioId_ = vedioId_.replace("]", "");
                    r.setField("vedioId_", vedioId_);
                }
                page.add("video", getHomeAd.getDataOut().getRecords());
            }
        }
        // 查询所有的智能柜信息
        LocalService getCabinet = new LocalService(this, "SvrGetCabinetId");
        if(!getCabinet.exec())
        	throw new RuntimeException();
        page.add("cabinetId", this.setPage(page, getCabinet.getDataOut()));
        return page;
    }
    
    // 分页
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
    
    

    // 去添加首页轮播图
    public IPage toInsertHomeAd() throws Exception {
        JspPage page = new JspPage(this, "products/FrmInsertHomeAd.jsp");
        return page;
    }

    // 去添加首页轮播图
    public IPage insertHomeAd() throws Exception {
        JsonPage page = new JsonPage(this);
        // 处理文件上传
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // 设置最大缓存
        factory.setSizeThreshold(5 * 1024);
        ServletFileUpload upload = new ServletFileUpload(factory);
        // 获取所有文件列表
        List<FileItem> uploadFiles = upload.parseRequest(getRequest());
        OssSession oss = (OssSession) this.getHandle().getProperty(OssSession.sessionId);
        List<String> list = new ArrayList<String>();
        ServerConfig config = new ServerConfig();
        String fileKey = null;
        String path = "http://" + config.getProperty("oss.bucket") + "." + config.getProperty("oss.endpoint") + "/";
        // String sampleImg_="";
        // 取出上传的每一个文件
        for (int i = 0; i < uploadFiles.size(); i++) {
            FileItem fileItem = uploadFiles.get(i);
            if (!fileItem.isFormField()) {// 文件名
                if (fileItem.getSize() > 0) {
                    String formName = fileItem.getFieldName();
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
                        fileKey = "yqx/IMG/" + fileUName;
                        oss.upload(fileKey, fileItem.getInputStream());
                        if (formName.contains("Img_")) {
                            list.add(path + fileKey);
                        }
                    }
                }
            }
        }
        LocalService svr = new LocalService(this, "SvrHomeAd.insertHomeAd");
        Record headIn = svr.getDataIn().getHead();
        headIn.setField("Img_", list);
        if (!svr.exec()) {
            throw new RuntimeException();
        }
        page.setData(true);
        return page;
    }

    // 删除首页轮播图
    public IPage delHomeAd() throws Exception {
        String imgId_ = this.getRequest().getParameter("imgId_");
        LocalService svr = new LocalService(this, "SvrHomeAd.delHomeAd");
        Record headIn = svr.getDataIn().getHead();
        headIn.setField("imgId_", imgId_);
        if (!svr.exec()) {
            throw new RuntimeException();
        }
        return new RedirectPage(this, "FrmAdminHomeAdManage");
    }
    
    // 去修改首页视频
    public IPage toupdateHomeAd() throws Exception { 
        JspPage page = new JspPage(this, "products/FrmupdateHomeAd.jsp"); 
        LocalService svrgetHomeAd = new LocalService(this, "SvrHomeAd.selectAd"); 
        Record head =svrgetHomeAd.getDataIn().getHead();
        head.setField("UID_", this.getRequest().getParameter("UID_"));
        System.out.println("11111111111111"+this.getRequest().getParameter("UID_"));
        if (!svrgetHomeAd.exec())
            throw new RuntimeException(svrgetHomeAd.getMessage());
        page.add("video", svrgetHomeAd.getDataOut().getCurrent());
        return page;
    }

    // 修改视频
    public IPage updateHomeAd() throws Exception {   
    	JsonPage page = new JsonPage(this);  
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // 设置最大缓存
        factory.setSizeThreshold(5 * 1024);
        ServletFileUpload upload = new ServletFileUpload(factory);
        // 获取所有文件列表
        List<FileItem> uploadFiles = upload.parseRequest(getRequest());
        OssSession oss = (OssSession) this.getHandle().getProperty(OssSession.sessionId);
        List<String> list = new ArrayList<String>();
        ServerConfig config = new ServerConfig();
        String fileKey = null;
        String path = "http://" + config.getProperty("oss.bucket") + "." + config.getProperty("oss.endpoint") + "/";
        // String sampleImg_="";
        // 取出上传的每一个文件
        for (int i = 0; i < uploadFiles.size(); i++) {
            FileItem fileItem = uploadFiles.get(i);
            if (!fileItem.isFormField()) {// 文件名
                if (fileItem.getSize() > 0) {
                    String formName = fileItem.getFieldName();
                    String fileName = fileItem.getName().toLowerCase();
                    String fileUName = UUID.randomUUID().toString();
                    if (fileName.endsWith(".mp4") || fileName.endsWith(".amw") || fileName.endsWith(".avi")
                            || fileName.endsWith(".rmvb") || fileName.endsWith(".mov")) {// 视频上传
                        if (fileName.endsWith(".mp4"))
                            fileUName += ".mp4";
                        if (fileName.endsWith(".amw"))
                            fileUName += ".amw";
                        if (fileName.endsWith("avi"))
                            fileUName += ".avi";
                        if (fileName.endsWith(".rmvb"))
                            fileUName += ".rmvb";
                        if (fileName.endsWith(".mov"))
                            fileUName += ".mov";
                        fileKey = "yqx/Vedio/" + fileUName;
                        oss.upload(fileKey, fileItem.getInputStream());
                        if (formName.contains("vedio")) {
                            list.add(path + fileKey);
                        }
                    }
                }
            }
        }
        LocalService svr = new LocalService(this, "SvrHomeAd.upHomeAd");
        Record headIn = svr.getDataIn().getHead();
        headIn.setField("UID_", this.getRequest().getParameter("UID_"));
        System.out.println("获取的UID_ "+this.getRequest().getParameter("UID_"));
        headIn.setField("vedioId_", list);
        if (!svr.exec())
            throw new RuntimeException(svr.getMessage());
        page.setData(true);
        return page;
         
    }

    //修改链接路径
    public IPage upLunBoAd() throws Exception{ 
    	String up =this.getRequest().getParameter("up"); 
    	if(up!=null && up.equals("up"))
		{
    	String UID_ =this.getRequest().getParameter("UID_");
    	String imgSrc_ =this.getRequest().getParameter("imgSrc_");
    	LocalService svr =new LocalService(this, "SvrHomeAd.upLunBoAd");
    	Record head =svr.getDataIn().getHead();
    	head.setField("imgSrc_",imgSrc_);
    	head.setField("UID_", UID_);
    	if (!svr.exec())
			throw new RuntimeException(svr.getMessage()); 
		return execute();
		}else{
			JspPage jsp =new JspPage(this,"products/FrmHomeLunUpdateImg.jsp"); 
			LocalService svr =new LocalService(this,"SvrHomeAd.selectLunBo");
			Record head =svr.getDataIn().getHead();
			head.setField("UID_",this.getRequest().getParameter("UID_"));
			if(!svr.exec())
				throw new RuntimeException();
			jsp.add("value_selId",svr.getDataOut().getCurrent());   
			return jsp;
		} 
    }

    public boolean logon() {
        return true;
    }
}
