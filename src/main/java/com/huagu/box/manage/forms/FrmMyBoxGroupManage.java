package com.huagu.box.manage.forms;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.StringUtils;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.oss.OssSession;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.RedirectPage;
import cn.cerc.jpage.vcl.GroupBox;
import cn.cerc.jpage.vcl.Label;
import cn.cerc.jpage.vcl.RadioBox;

import com.huagu.common.enums.CabinetStatus;
import com.huagu.common.ui.ButtonEnum;
import com.huagu.common.ui.MyDateBox;
import com.huagu.common.ui.MyTextBox;
import com.huagu.common.ui.P004Browser;
import com.huagu.common.ui.P005Form;
import com.huagu.common.ui.SimpleGrid;
import com.huagu.common.ui.TextEnum;
import com.huagu.common.ui.UrlButton;
import com.huagu.common.ui.columns.IndexColumn;
import com.huagu.common.ui.columns.LinkColumn;
import com.huagu.common.ui.columns.LinksColumn;
import com.huagu.common.ui.columns.StringColumn;
import com.huagu.maintain.forms.FrmMyCabinet;

/**
 * @ClassName: FrmMyBoxGroupManage
 * @Description: 后台机柜管理
 * @author tj
 * @date 2018年3月12日 上午9:36:14
 */
public class FrmMyBoxGroupManage extends AbstractForm {

    /**
     *  机柜管理列表展示
     */
    @Override public IPage execute() throws Exception {
        
        // 定义页面
        P004Browser page = new P004Browser(this);
        page.setTitle(getMenu().getTitle()); //页面标题
        page.setFormAction("FrmMyBoxGroupManage"); //条件查询表单的action属性
        page.addScriptFile("/js/FrmMyBoxGroupManage.js");
        /*
         * MyTextBox 文本框
         *  
         */
        MyTextBox cabinetName = new MyTextBox(page.getLeftSide());
        cabinetName.setName("cabinetName");
        cabinetName.getLabel().setCaption("机柜名称：");
        String paramCabinetName = getRequest().getParameter("cabinetName");
        cabinetName.setValue(paramCabinetName);
        
        MyTextBox communityName = new MyTextBox(page.getLeftSide());
        communityName.setName("communityName");
        communityName.getLabel().setCaption("挂靠社区简称：");
        String paramCommunityName = getRequest().getParameter("communityName");
        communityName.setValue(paramCommunityName);
        
        /*
         * MyDateBox 日期框
         */
        MyDateBox addTime = new MyDateBox(page.getLeftSide());
        addTime.setName("addTime");
        addTime.getLabel().setCaption("添加机柜时间：");
        String paramAddTime = getRequest().getParameter("addTime");
        addTime.setValue(paramAddTime);
        
        MyDateBox configTime = new MyDateBox(page.getLeftSide());
        configTime.setName("configName");
        configTime.getLabel().setCaption("机柜配置时间：");
        String paramConfigTime = getRequest().getParameter("configTime");
        configTime.setValue(paramConfigTime);
        
        MyTextBox managerPhone = new MyTextBox(page.getLeftSide());
        managerPhone.setName("managerPhone");
        managerPhone.getLabel().setCaption("运维人员电话：");
        String paramManagerPhone = getRequest().getParameter("managerPhone");
        managerPhone.setValue(paramManagerPhone);
        
        /*
         * radio 单选按钮
         * 需要设置相同的name属性 <=> setName()的值应该相同
         */
        GroupBox statusDIV = new GroupBox(page.getLeftSide());
        new Label(statusDIV).setCaption("机柜启停状态：");
        RadioBox QI = new RadioBox(statusDIV);
        QI.setName("STATUS");
        QI.getLabel().setCaption("启用");
        QI.setValue("1");
        RadioBox TING = new RadioBox(statusDIV);
        TING.setName("STATUS");
        TING.getLabel().setCaption("停用");
        TING.setValue("0");
        String paramStatus = getRequest().getParameter("STATUS");
        if (StringUtils.isNotEmpty(paramStatus)) {
            if ((CabinetStatus.JOINUP.ordinal()+"").equals(paramStatus)) {
                QI.setIsSelected(true);
            } else {
                TING.setIsSelected(true);
            }
        } else {
            TING.setIsSelected(true);
        }
        
        UrlButton submitButton = new UrlButton(statusDIV);
        submitButton.setType(ButtonEnum.submit);
        submitButton.setValue("搜索");
        	
        UrlButton addButton = new UrlButton(statusDIV);
        addButton.setType(ButtonEnum.button);
        addButton.setValue("添加柜组信息");
        addButton.setUrl("FrmMyBoxGroupManage.addBoxGroup");
        
        UrlButton cButton = new UrlButton(statusDIV);
        cButton.setType(ButtonEnum.button);
        cButton.setValue("待配置柜组列表");
        cButton.setUrl("FrmWaitAddToBox");
        
        LocalService svr = new LocalService(this, "SvrMyBoxGroupManage.list");
        if (!svr.exec("paramCabinetName",paramCabinetName,"paramCommunityName",paramCommunityName,"paramAddTime",paramAddTime,
                "paramConfigTime",paramConfigTime,"paramManagerPhone",paramManagerPhone,"paramStatus",paramStatus)) {
            throw new RuntimeException(svr.getMessage());
        }
        
        SimpleGrid grid = page.getGrid();
        grid.setDataSet(svr.getDataOut());
        
        new IndexColumn(grid, "序号");
        new StringColumn(grid, "name_", "机柜名称");
        new StringColumn(grid, "createDate_", "添加时间");
        new StringColumn(grid, "joinUpDate_", "最近接入系统的时间");
        new StringColumn(grid, "joinStatus_", "柜组是否接入系统（是否通电）");
        new StringColumn(grid, "communityName_", "柜组挂靠社区简称");
        new StringColumn(grid, "communityNum_", "社区编号");
        new StringColumn(grid, "lookQrcode", "查看柜组二维码");
        new StringColumn(grid, "cid_", "柜组编号（自动生成）");
        new StringColumn(grid, "gps_", "柜组GPS位置信息");
        new StringColumn(grid, "mobile_", "最近配置人员电话");
        new StringColumn(grid, "configDate_", "最近配置时间");
        new StringColumn(grid, "combinationInfo_", "柜组组合信息");
        new StringColumn(grid, "lookIntoDetail", "柜组箱子详细信息");
        new StringColumn(grid, "zlbig_", "箱子汇总租赁大箱个数");
        new StringColumn(grid, "zlmiddle_", "箱子汇总租赁中箱个数");
        new StringColumn(grid, "zlsmall_", "箱子汇总租赁小箱个数");
        new StringColumn(grid, "gy_", "箱子汇总公益箱个数");
        new StringColumn(grid, "mobiles_", "运维人员电话号码");
        new StringColumn(grid, "status_", "柜组是否启用");
        
        LinksColumn lcs = new LinksColumn(grid, "操作");
        new LinkColumn(lcs, "变更GPS位置信息", "#");
        new LinkColumn(lcs, "变更柜组挂靠社区信息", "#");
        new LinkColumn(lcs, "变更柜组启停状态", "#");
        new LinkColumn(lcs, "变更柜组名称", "#");
        
        // 设置分页
        grid.getPages().setPageSize(10);
        page.add("pages", grid.getPages());
        
        return page;
    }
    
    /*
     * 柜组详情，展示柜组中的箱子信息
     */
    public IPage cabinetDetail() throws Exception {
        String cabId = getRequest().getParameter("cabId");
        if (cabId == null || "".equals(cabId)) {
            return execute();
        }
        P004Browser page = new P004Browser(this);
        page.setTitle(getParam("", "箱子信息列表"));
        page.add("backbutton", "true");
        LocalService svr = new LocalService(this, "SvrMyBoxGroupManage.cabinetDetail");
        if (!svr.exec("cabId", cabId)) {
            throw new RuntimeException(svr.getMessage());
        }
        DataSet result = svr.getDataOut();
        /*if (result.eof()) {
            return execute();
        }*/
        
        /*
         * 
         * select RIGHT(b.cabId_,6) as 'cabId_',b.boxLockUD_,b.boxStatus_,b.lockDate_,RIGHT(b.boxId_,6) as 'boxId_',
         * b.boxType_,b.boxVolume_,b.emptyStatus_,b.boxOrderLock_,g.name_,g.mBarcode_,g.pBarcode_
         * 
         */
        SimpleGrid grid = page.getGrid();
        grid.setDataSet(result);
        new IndexColumn(grid, "序号");
        new StringColumn(grid, "cabId_", "当前柜组编号");
        new StringColumn(grid, "boxLockUD_", "箱锁UD（自动 主键）");
        new StringColumn(grid, "boxStatus_", "箱锁闭启状态");
        new StringColumn(grid, "lockDate_", "最近箱锁关闭时间");
        new StringColumn(grid, "boxId_", "箱锁编号");
        new StringColumn(grid, "boxType_", "箱锁用途");
        new StringColumn(grid, "boxVolume_", "箱子型号");
        new StringColumn(grid, "emptyStatus_", "箱锁内空箱状态");
        new StringColumn(grid, "boxOrderLock_", "箱锁内是否订单锁定状态");
        new StringColumn(grid, "name_", "箱锁内存放物品名称");
        new StringColumn(grid, "mBarcode_", "箱锁内存放物品主电子条码");
        new StringColumn(grid, "pBarcode_", "箱锁内存放物品配件电子条码");
        
        grid.getPages().setPageSize(10);
        getRequest().setAttribute("pages", grid.getPages());
        return page;
    }
    
    /*
     * 添加柜组信息
     */
    public IPage addBoxGroup() throws Exception {
        P005Form page = new P005Form(this);
        page.setTitle(getParam("", "添加柜组信息"));
        page.setAction("FrmMyBoxGroupManage.addBoxGroupImpl");
        page.getContent().setEnctype("multipart/form-data");

        MyTextBox cabinetName = new MyTextBox(page.addLine());
        cabinetName.getLabel().setCaption("柜子名称：");
        cabinetName.setName("cabinetName");
        cabinetName.setRequired("required");
        
        MyTextBox communityNum = new MyTextBox(page.addLine());
        communityNum.getLabel().setCaption("社区编号：");
        communityNum.setName("communityNum");
        communityNum.setRequired("required");
        
        MyTextBox communityName = new MyTextBox(page.addLine());
        communityName.getLabel().setCaption("社区名称：");
        communityName.setName("communityName");
        communityName.setRequired("required");
        
        MyTextBox image = new MyTextBox(page.addLine());
        image.setType(TextEnum.file);
        image.getLabel().setCaption("柜组图片：");
        image.setName("image");
        image.setRequired("required");
        
        MyTextBox image2 = new MyTextBox(page.addLine());
        image2.setType(TextEnum.file);
        image2.getLabel().setCaption("柜组图片：");
        image2.setName("image");
        image2.setRequired("required");
        
        MyTextBox image3 = new MyTextBox(page.addLine());
        image3.setType(TextEnum.file);
        image3.getLabel().setCaption("柜组图片：");
        image3.setName("image");
        image3.setRequired("required");
        
        UrlButton submit = new UrlButton(page.addLine());
        submit.setType(ButtonEnum.submit);
        submit.setValue("添加");
        
        return page;
    }
    
    /*
     * 上传文件
     */
    public IPage addBoxGroupImpl() throws Exception {
        String communityNum = "";
        String communityName = "";
        String cabinetName = "";
        List<String> paths = new ArrayList<String>();
        // 上传文件临时缓冲目录
        String tempPath = getRequest().getServletContext().getRealPath("/WEB-INF/temp");
        File tempFile = new File(tempPath);
        if (!tempFile.exists()) {
            tempFile.mkdir();
        }
        
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(1024 * 100);
        factory.setRepository(tempFile);
        
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setProgressListener(new ProgressListener() {
            public void update(long pBytesRead, long pContentLength, int pItems) {
                System.out.println("文件大小为：" + pContentLength + "当前已经处理了：" + pBytesRead);
            }
        });
        upload.setHeaderEncoding("UTF-8");
        if (!ServletFileUpload.isMultipartContent(getRequest())) {
            return new RedirectPage(this, "FrmMyBoxGroupManage.addBoxGroup");
        }
        upload.setFileSizeMax(1024*1024*5);
        upload.setSizeMax(1024*1024*20);
        List<FileItem> list = upload.parseRequest(getRequest());
        
        for (FileItem fileItem : list) {
            String eleName = fileItem.getFieldName(); //表单元素的name属性
            if (fileItem.isFormField()) {
                //  表单元素
                if ("cabinetName".equals(eleName)) {
                	cabinetName = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
                }
                if ("communityNum".equals(eleName)) {
                    communityNum = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
                }
                if ("communityName".equals(eleName)) {
                    communityName = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
                    if (null == FrmMyCabinet.getLngLatFromOneAddr(communityName)) {
                        return new RedirectPage(this, "FrmMyBoxGroupManage.addBoxGroup");
                    }
                }
            } else {
                if (fileItem.getSize() > 0) {
                    String fName = fileItem.getName().toLowerCase();
                    String newFName = UUID.randomUUID().toString();
                    if (fName.endsWith(".jpg") || fName.endsWith(".png") || fName.endsWith(".jpeg") || fName.endsWith(".gif")) {
                        OssSession oss = (OssSession) getProperty(OssSession.sessionId);
                        if (fName.endsWith(".jpg")) {
                            newFName += ".jpg";
                        }
                        if (fName.endsWith(".png")) {
                            newFName += ".png";
                        }
                        if (fName.endsWith("jpeg")) {
                            newFName += ".jpeg";
                        }
                        if (fName.endsWith(".gif")) {
                            newFName += ".gif";
                        }
                        String path = "forcer/img/" + newFName;
                        oss.upload(path, fileItem.getInputStream());
                        ServerConfig sc = new ServerConfig();
                        path = "http://" + sc.getProperty("oss.bucket") + "." + sc.getProperty("oss.endpoint") + "/" + path;
                        paths.add(path);
                    }
                }
            }
        }
        LocalService svr = new LocalService(this, "SvrMyBoxGroupManage.addBox");
        if (!svr.exec("communityName", communityName, "communityNum", communityNum,"cabinetName", cabinetName, "paths", paths)) {
            throw new RuntimeException(svr.getMessage());
        }
        
        return new RedirectPage(this, "FrmMyBoxGroupManage");
    }
    
    /*
     * 待配置柜组列表
     */
    public IPage checkBox() throws Exception {
        P004Browser page = new P004Browser(this);
        page.setTitle("待配置柜组");
        page.add("backbutton", "1");
        LocalService svr = new LocalService(this, "SvrMyBoxGroupManage.checkBox");
        if (!svr.exec()) {
            throw new RuntimeException(svr.getMessage());
        }
        
        DataSet result = svr.getDataOut();
        SimpleGrid grid = page.getGrid();
        grid.setDataSet(result);
        
        new IndexColumn(grid, "序号");
        new StringColumn(grid, "cabId_", "柜组编号");
        new StringColumn(grid, "joinUpDate_", "最近接入系统的时间");
        new StringColumn(grid, "wstr_", "柜组配置状态");
        grid.getPages().setPageSize(10);
        page.add("pages", grid.getPages());
        return page;
    }
    
    /**
     * 删除柜组
     */
    public IPage delCabinet() throws Exception {
        JsonPage json = new JsonPage(this);
        LocalService delCab = new LocalService(this, "SvrDelCabinet");
        if(!delCab.exec("cabId_", this.getRequest().getParameter("cabId_"))){
        	json.setData(false);
            throw new RuntimeException(delCab.getMessage());
        }else{
        	json.setData(true);
        }
    	
        return json;
    }
    
}
