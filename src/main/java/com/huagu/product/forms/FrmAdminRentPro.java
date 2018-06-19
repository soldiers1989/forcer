package com.huagu.product.forms;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.oss.OssSession;
import cn.cerc.jimport.excel.ColumnValidateException;
import cn.cerc.jimport.excel.ImportExcel;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
import cn.cerc.jpage.grid.MutiPage;

public class FrmAdminRentPro extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "products/FrmRentProDetail.jsp");
		String proName_ = this.getRequest().getParameter("proName_");
		String zhuCode_ = this.getRequest().getParameter("zhuCode_");
		String fristNameId_ = this.getRequest().getParameter("fristNameId_");
		String twoNameId_ = this.getRequest().getParameter("twoNameId_");
		LocalService svr = new LocalService(this, "SvrAdminRentPro.queryRentProList"); 
		Record head=svr.getDataIn().getHead();
		head.setField("proName_", proName_);
		head.setField("zhuCode_", zhuCode_);
		head.setField("fristNameId_", fristNameId_);
		head.setField("twoNameId_", twoNameId_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
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
		page.add("proName_", proName_);
		page.add("zhuCode_", zhuCode_);
		page.add("values", this.setPage(page, svr.getDataOut()));
		return page;
	}
	
	//添加和变更电子条码信息详情
	public IPage queryNodeList() throws Exception{
		JspPage page = new JspPage(this, "products/FrmInsertNodeDetail.jsp");
		String proId_ = this.getRequest().getParameter("proId_");
		System.out.println("proId_"+proId_);
		String zhuCode_ = this.getRequest().getParameter("zhuCode_");
		LocalService svr = new LocalService(this, "SvrAdminRentPro.queryNodeList"); 
		Record head=svr.getDataIn().getHead();
		head.setField("proId_", proId_);
		head.setField("zhuCode_", zhuCode_);
		if (!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		if(!svr.getDataOut().eof()){
			page.add("proId_", svr.getDataOut().getString("proId_"));
			page.add("proName_", svr.getDataOut().getString("proName_"));
			page.add("fristName_", svr.getDataOut().getString("fristName_"));
			page.add("twoName_", svr.getDataOut().getString("twoName_"));
			page.add("proSaleCount_", svr.getDataOut().getString("proSaleCount_"));
			page.add("proRentCount_", svr.getDataOut().getString("proRentCount_"));
			page.add("zhuCode_", zhuCode_);
		}
		page.add("values", this.setPage(page, svr.getDataOut()));
		return page;	
		}
	
	//添加电子条码信息
	public IPage toInsertProNode() throws Exception{
		JspPage page = new JspPage(this, "products/FrmInsertZhuNode.jsp");
		String proId_ = this.getRequest().getParameter("proId_");
		LocalService svr = new LocalService(this, "SvrAdminRentPro.queryById"); 
		Record head=svr.getDataIn().getHead();
		head.setField("proId_", proId_);
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		page.add("proId_", svr.getDataOut().getString("proId_"));
		page.add("proRentCount_", svr.getDataOut().getString("proRentCount_"));
		page.add("proSaleCount_", svr.getDataOut().getString("proSaleCount_"));
		page.add("proName_", svr.getDataOut().getString("proName_"));
		page.add("fristName_", svr.getDataOut().getString("fristName_"));
		page.add("twoName_", svr.getDataOut().getString("twoName_"));
		LocalService svrSupply = new LocalService(this, "SvrAdminSupply.queryListSupply"); 
		if(!svrSupply.exec()){
			throw new RuntimeException(svrSupply.getMessage());
		}
		page.add("value", svrSupply.getDataOut().getRecords());
		LocalService svrCom = new LocalService(this, "SvrAgentQuery");
		if(!svrCom.exec())
			throw new Exception(svrCom.getMessage());
		page.add("agents", svrCom.getDataOut().getRecords());
		return page;
	}
	
	//添加电子条码信息
	public IPage insertProNode() throws Exception{
		JsonPage page=new JsonPage(this);
		List<String> code = new ArrayList<String>();
		List<String> codeName = new ArrayList<String>();
		String proId_ = this.getRequest().getParameter("proId_");
		String zhuCode_ = this.getRequest().getParameter("zhuCode_");
		String homeAgency_ = this.getRequest().getParameter("homeAgency_");
		String supplyUser_ = this.getRequest().getParameter("supplyUser_");
		String proCostPrice_ = this.getRequest().getParameter("proCostPrice_");
		String serverDeadTime_ = this.getRequest().getParameter("serverDeadTime_");
		String enterKu_ = this.getRequest().getParameter("enterKu_");
		String scrapState_ = this.getRequest().getParameter("scrapState_");
		String state_ = this.getRequest().getParameter("state_");
		String remark_ = this.getRequest().getParameter("remark_");
		DiskFileItemFactory factory = new DiskFileItemFactory();
		//设置最大缓存
		factory.setSizeThreshold(10 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		//获取所有文件列表
		List<FileItem> uploadFiles = upload.parseRequest(this.getRequest());
		for (int i = 0; i < uploadFiles.size(); i++) {
			FileItem fileItem  = uploadFiles.get(i);
			if (fileItem.isFormField()) {
				//表单元素
				//String fieldName = fileItem.getFieldName();
			
				if("ciCode_".equals(fileItem.getFieldName())){
					code.add(new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8"));
				}
				if("ciCodeName_".equals(fileItem.getFieldName())){
					codeName.add(new String(fileItem.getString().getBytes("ISO-8859-1"),"UTF-8"));
				}
				
				if ("proId_".equals(fileItem.getFieldName()))
					proId_ = new String(fileItem.getString().getBytes("ISO-8859-1"),"UTF-8");
				if ("zhuCode_".equals(fileItem.getFieldName()))
					zhuCode_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("homeAgency_".equals(fileItem.getFieldName()))
					homeAgency_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("supplyUser_".equals(fileItem.getFieldName()))
					supplyUser_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("proCostPrice_".equals(fileItem.getFieldName()))
					proCostPrice_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("serverDeadTime_".equals(fileItem.getFieldName()))
					serverDeadTime_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("enterKu_".equals(fileItem.getFieldName()))
					enterKu_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("scrapState_".equals(fileItem.getFieldName()))
					scrapState_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("state_".equals(fileItem.getFieldName()))
					state_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("remark_".equals(fileItem.getFieldName()))
					remark_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
			}
		}
		String scrapStateNew_=scrapState_+"%";
		LocalService svr = new LocalService(this, "SvrAdminRentPro.insertProNode"); 
		if (!svr.exec("proId_", proId_,"zhuCode_",zhuCode_, "homeAgency_", homeAgency_, "supplyUser_", supplyUser_, 
				"code", code, "codeName", codeName, "proCostPrice_", proCostPrice_, "serverDeadTime_", serverDeadTime_, 
				"state_", state_, "remark_", remark_
				, "enterKu_", enterKu_, "scrapState_", scrapStateNew_)) {
			page.setData(false);
		}else{
			page.setData(true);
		}
		return page;
	}
	
	//修改电子条码信息
	public IPage updateProNode() throws Exception{
		JsonPage page=new JsonPage(this);
		List<String> code = new ArrayList<String>();
		List<String> codeName = new ArrayList<String>();
		String proId_ = this.getRequest().getParameter("proId_");
		String zhuCode_ = this.getRequest().getParameter("zhuCode_");
		String homeAgency_ = this.getRequest().getParameter("homeAgency_");
		String supplyUser_ = this.getRequest().getParameter("supplyUser_");
		String proCostPrice_ = this.getRequest().getParameter("proCostPrice_");
		String serverDeadTime_ = this.getRequest().getParameter("serverDeadTime_");
		String enterKu_ = this.getRequest().getParameter("enterKu_");
		String scrapState_ = this.getRequest().getParameter("scrapState_");
		String state_ = this.getRequest().getParameter("state_");
		String remark_ = this.getRequest().getParameter("remark_");
		DiskFileItemFactory factory = new DiskFileItemFactory();
		//设置最大缓存
		factory.setSizeThreshold(10 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		//获取所有文件列表
		List<FileItem> uploadFiles = upload.parseRequest(this.getRequest());
		for (int i = 0; i < uploadFiles.size(); i++) {
			FileItem fileItem  = uploadFiles.get(i);
			if (fileItem.isFormField()) {
				//表单元素
				//String fieldName = fileItem.getFieldName();
			
				if("ciCode_".equals(fileItem.getFieldName())){
					code.add(new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8"));
				}
				if("ciCodeName_".equals(fileItem.getFieldName())){
					codeName.add(new String(fileItem.getString().getBytes("ISO-8859-1"),"UTF-8"));
				}
				
				if ("proId_".equals(fileItem.getFieldName()))
					proId_ = new String(fileItem.getString().getBytes("ISO-8859-1"),"UTF-8");
				if ("zhuCode_".equals(fileItem.getFieldName()))
					zhuCode_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("homeAgency_".equals(fileItem.getFieldName()))
					homeAgency_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("supplyUser_".equals(fileItem.getFieldName()))
					supplyUser_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("proCostPrice_".equals(fileItem.getFieldName()))
					proCostPrice_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("serverDeadTime_".equals(fileItem.getFieldName()))
					serverDeadTime_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("enterKu_".equals(fileItem.getFieldName()))
					enterKu_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("scrapState_".equals(fileItem.getFieldName()))
					scrapState_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("state_".equals(fileItem.getFieldName()))
					state_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("remark_".equals(fileItem.getFieldName()))
					remark_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
			}
		}
		LocalService svr = new LocalService(this, "SvrAdminRentPro.updateProNode"); 
		if (!svr.exec("proId_", proId_,"zhuCode_",zhuCode_, "homeAgency_", homeAgency_, "supplyUser_", supplyUser_, 
				"code", code, "codeName", codeName, "proCostPrice_", proCostPrice_, "serverDeadTime_", serverDeadTime_, 
				"state_", state_, "remark_", remark_
				, "enterKu_", enterKu_, "scrapState_", scrapState_)) {
			page.setData(false);
		}else{
			page.setData(true);
		}
		return page;
	}
		
	//导入电子条码信息
	public IPage importNode() throws Exception{
		JspPage page = new JspPage(this, "products/FrmImportNode.jsp");
		String zhuCode_ = this.getRequest().getParameter("zhuCode_");
		LocalService svr = new LocalService(this, "SvrAdminRentPro.queryNodeState"); 
		Record head=svr.getDataIn().getHead();
		head.setField("zhuCode_", zhuCode_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("zhuCode_", zhuCode_);
		page.add("values", this.setPage(page, svr.getDataOut()));
		// 缓存查询条件用做导出
        try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, this.getUserCode(), "SvrAdminRentPro.queryNodeState")) {
            buff.setField("data", svr.getDataIn().getJSON());
        }
        page.add("msg", getRequest().getParameter("msg"));
		return page;
	}
	
	//导入(添加)电子条码信息
	public IPage importInsertNode() throws Exception{
		//JspPage page = new JspPage(this, "products/FrmImportNode.jsp");
		LocalService svr = new LocalService(this, "SvrAdminRentPro.queryNodeState"); 
		String zhuCode_ = this.getRequest().getParameter("zhuCode_");
		Record head=svr.getDataIn().getHead();
		head.setField("zhuCode_", zhuCode_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		DataSet ds = new DataSet();
		List<Record> li = svr.getDataOut().getRecords();
		for(int i=0;i<li.size();i++){
			String nodeState_ = li.get(i).getString("nodeState_");
			if(nodeState_==""||nodeState_==null){
				if(nodeState_.equals("2")||nodeState_.equals("3")||nodeState_.equals("4")||nodeState_.equals("")){
					ds.getRecords().add(li.get(i));
				}
			}
		}
		LocalService svr1 = new LocalService(this, "SvrAdminRentPro.insertNode"); 
		svr1.getDataIn().appendDataSet(ds);
		if(!svr1.exec()){
			throw new RuntimeException(svr1.getMessage());
		}
		return new RedirectPage(this, "FrmAdminRentPro.importNode");
	}
	//查询供应商
	public IPage querySupply() throws Exception{
		JsonPage page =new JsonPage(this);
		String companyJc_ = this.getRequest().getParameter("companyJc_");
		LocalService svr = new LocalService(this, "SvrAdminSupply.queryListSupply"); 
		Record head=svr.getDataIn().getHead();
		head.setField("supplyShortName_", companyJc_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		JspPage jPage=new JspPage(this,"products/FrmInsertZhuNode.jsp");
		jPage.add("value",svr.getDataOut().getRecords());
		return page;
		
		
	}
	//删除电子条码信息
	public IPage delProNode() throws Exception{
		JspPage page = new JspPage(this, "products/FrmUpdateZhuNode.jsp");
		String zhuCode_ = this.getRequest().getParameter("zhuCode_");
		LocalService svr = new LocalService(this, "SvrAdminRentPro.delProNode"); 
		Record head=svr.getDataIn().getHead();
		head.setField("zhuCode_", zhuCode_);
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		return new RedirectPage(this, "FrmAdminRentPro.importNode");
	}
			
	//修改电子条码信息
	public IPage toUpdateProNode() throws Exception{
		JspPage page = new JspPage(this, "products/FrmUpdateZhuNode.jsp");
		String proId_ = this.getRequest().getParameter("proId_");
		LocalService svr = new LocalService(this, "SvrAdminRentPro.queryNodeList"); 
		Record head=svr.getDataIn().getHead();
		head.setField("proId_", proId_);
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		page.add("proRentCount_", svr.getDataOut().getString("proRentCount_"));
		page.add("proSaleCount_", svr.getDataOut().getString("proSaleCount_"));
		page.add("proId_", svr.getDataOut().getString("proId_"));
		page.add("proName_", svr.getDataOut().getString("proName_"));
		page.add("fristName_", svr.getDataOut().getString("fristName_"));
		page.add("twoName_", svr.getDataOut().getString("twoName_"));
		page.add("value", svr.getDataOut().getCurrent());
		return page;
	}
	
	//添加和变更物品属性
	public IPage toInsertProAttr() throws Exception{
		JspPage page = new JspPage(this, "products/FrmInsertProAttr.jsp");
		page.add("msg", this.getRequest().getParameter("msg"));
		String proId_ = this.getRequest().getParameter("proId_");
		LocalService svr = new LocalService(this, "SvrAdminRentPro.queryById"); 
		Record head=svr.getDataIn().getHead();
		head.setField("proId_", proId_);
		if(!svr.exec()){
			page.add("msg", svr.getMessage());
			return page;
		}
		page.add("value", svr.getDataOut().getCurrent());
		page.add("price_", svr.getDataOut().getString("price_"));
		page.add("proName_", svr.getDataOut().getString("proName_"));
		page.add("fristName_", svr.getDataOut().getString("fristName_"));
		page.add("twoName_", svr.getDataOut().getString("twoName_"));
		page.add("proId_", svr.getDataOut().getString("proId_"));
		page.add("cashPledge_", svr.getDataOut().getString("cashPledge_"));
		page.add("scrapTime_", svr.getDataOut().getString("scrapTime_"));
		page.add("discountPrice_", svr.getDataOut().getString("discountPrice_"));
		page.add("proCostPrice_", svr.getDataOut().getString("proCostPrice_"));
		page.add("jifen_", svr.getDataOut().getString("jifen_"));
		page.add("proSize_", svr.getDataOut().getString("proSize_"));
		page.add("proWeight_", svr.getDataOut().getString("proWeight_"));
		page.add("proDesc_", svr.getDataOut().getString("proDesc_"));
		page.add("posTage_", svr.getDataOut().getString("posTage_"));
		page.add("proRentCount_", svr.getDataOut().getString("proRentCount_"));
		page.add("proSaleCount_", svr.getDataOut().getString("proSaleCount_"));
		return page;
	}
	
	//添加和变更物品属性
	public IPage insertProAttr() throws Exception{
		String proId_ = this.getRequest().getParameter("proId_");
		String price_ = this.getRequest().getParameter("price_");
		String cashPledge_ = this.getRequest().getParameter("cashPledge_");
//		String scrapTime_ = this.getRequest().getParameter("scrapTime_");
		String dayRentMoney_ = this.getRequest().getParameter("dayRentMoney_");
		String discountPrice_ = this.getRequest().getParameter("discountPrice_");
		String jifen_ = this.getRequest().getParameter("jifen_");
		String proSize_ = this.getRequest().getParameter("proSize_");
		String isDiscount_ = this.getRequest().getParameter("isDiscount_");
		String proWeight_ = this.getRequest().getParameter("proWeight_");
		String proDesc_ = this.getRequest().getParameter("proDesc_");
		String posTage_ = this.getRequest().getParameter("posTage_");
		LocalService svr = new LocalService(this, "SvrAdminRentPro.insertProAttr"); 
		Record head=svr.getDataIn().getHead();
		head.setField("proId_", proId_);
		head.setField("price_", price_);
		head.setField("cashPledge_", cashPledge_);
		head.setField("dayRentMoney_", dayRentMoney_);
//		head.setField("scrapTime_", scrapTime_);
		head.setField("discountPrice_", discountPrice_);
		head.setField("posTage_", posTage_);
		head.setField("jifen_", jifen_);
		head.setField("proSize_", proSize_);
		head.setField("proWeight_", proWeight_);
		head.setField("proDesc_", proDesc_);
		head.setField("isDiscount_", isDiscount_);
		//上传商品图片
		ArrayList<String> file = new ArrayList<>();
    	String[] str = this.getRequest().getParameterValues("image");
    	System.out.println("str"+str);
    	if(str==null||str.equals("")){
    		
    	}else{
	    	for(int i=0;i<str.length;i++){
	    		String data = str[i];
	    		file.add(data);
	    	}
    	}
    	LocalService svr1 = new LocalService(this, "SvrAdminRentPro.ajaxData");
    	Record headIn = svr1.getDataIn().getHead();
		headIn.setField("imgUrl", file);
		headIn.setField("proId_", proId_);
		if(!svr1.exec()){
		    String url = String.format("FrmAdminRentPro.toInsertProAttr?proId_=%s&msg=%s", proId_,svr1.getMessage());
			return new RedirectPage(this, url);
		}
		if(!svr.exec()){
		    String url = String.format("FrmAdminRentPro.toInsertProAttr?proId_=%s&msg=%s", proId_,svr.getMessage());
            return new RedirectPage(this, url);
		}
		return new RedirectPage(this, "FrmAdminRentPro");
	}
	
	//变更物品属性
	public IPage toUpdateProAttr() throws Exception{
		JspPage page = new JspPage(this, "products/FrmUpdateProAttr.jsp");
		page.add("msg", this.getRequest().getParameter("msg"));
		String proId_ = this.getRequest().getParameter("proId_");
		LocalService svr = new LocalService(this, "SvrAdminRentPro.queryById"); 
		Record head=svr.getDataIn().getHead();
		head.setField("proId_", proId_);
		if(!svr.exec()){
			page.add("msg", svr.getMessage());
			return page;
		}
		page.add("value", svr.getDataOut().getCurrent());
		page.add("price_", svr.getDataOut().getString("price_"));
		page.add("proName_", svr.getDataOut().getString("proName_"));
		page.add("fristName_", svr.getDataOut().getString("fristName_"));
		page.add("twoName_", svr.getDataOut().getString("twoName_"));
		page.add("proId_", svr.getDataOut().getString("proId_"));
		page.add("cashPledge_", svr.getDataOut().getString("cashPledge_"));
		page.add("scrapTime_", svr.getDataOut().getString("scrapTime_"));
		page.add("discountPrice_", svr.getDataOut().getString("discountPrice_"));
		page.add("proCostPrice_", svr.getDataOut().getString("proCostPrice_"));
		page.add("jifen_", svr.getDataOut().getString("jifen_"));
		page.add("proSize_", svr.getDataOut().getString("proSize_"));
		page.add("proWeight_", svr.getDataOut().getString("proWeight_"));
		page.add("proDesc_", svr.getDataOut().getString("proDesc_"));
		page.add("posTage_", svr.getDataOut().getString("posTage_"));
		page.add("proRentCount_", svr.getDataOut().getString("proRentCount_"));
		page.add("proSaleCount_", svr.getDataOut().getString("proSaleCount_"));
		LocalService svrImg = new LocalService(this, "SvrAdminRentPro.queryImg"); 
		Record headIn=svrImg.getDataIn().getHead();
		headIn.setField("proId_", proId_);
		if(!svrImg.exec()){
			page.add("msg", svrImg.getMessage());
			return page;
		}
		page.add("detailImg", svrImg.getDataOut().getRecords());
		return page;
	}
	
	//变更物品属性
	public IPage updateProAttr() throws Exception{
		String proId_ = this.getRequest().getParameter("proId_");
		String price_ = this.getRequest().getParameter("price_");
		String cashPledge_ = this.getRequest().getParameter("cashPledge_");
//		String scrapTime_ = this.getRequest().getParameter("scrapTime_");
		String dayRentMoney_ = this.getRequest().getParameter("dayRentMoney_");
		String discountPrice_ = this.getRequest().getParameter("discountPrice_");
		String jifen_ = this.getRequest().getParameter("jifen_");
		String proSize_ = this.getRequest().getParameter("proSize_");
		String isDiscount_ = this.getRequest().getParameter("isDiscount_");
		String proWeight_ = this.getRequest().getParameter("proWeight_");
		String proDesc_ = this.getRequest().getParameter("proDesc_");
		String posTage_ = this.getRequest().getParameter("posTage_");
		String[] str = this.getRequest().getParameterValues("img");
		LocalService svr = new LocalService(this, "SvrAdminRentPro.insertProAttr"); 
		Record head=svr.getDataIn().getHead();
		head.setField("proId_", proId_);
		head.setField("price_", price_);
		head.setField("cashPledge_", cashPledge_);
		head.setField("dayRentMoney_", dayRentMoney_);
//		head.setField("scrapTime_", scrapTime_);
		head.setField("discountPrice_", discountPrice_);
		head.setField("posTage_", posTage_);
		head.setField("jifen_", jifen_);
		head.setField("proSize_", proSize_);
		head.setField("proWeight_", proWeight_);
		head.setField("proDesc_", proDesc_);
		head.setField("isDiscount_", isDiscount_);
		//上传商品图片
		ArrayList<String> file = new ArrayList<>();
    	
    	System.out.println("str"+str);
    	if(str==null||str.equals("")){
    		
    	}else{
	    	for(int i=0;i<str.length;i++){
	    		String data = str[i];
	    		file.add(data);
	    	}
    	}
    	LocalService svr1 = new LocalService(this, "SvrAdminRentPro.ajaxData");
    	Record headIn = svr1.getDataIn().getHead();
		headIn.setField("imgUrl", file);
		headIn.setField("proId_", proId_);
		if(!svr1.exec()){
			 String url = String.format("FrmAdminRentPro.updateProAttr?proId_=%s&msg=%s", proId_,svr1.getMessage());
				return new RedirectPage(this, url);
		}
		if(!svr.exec()){
			 String url = String.format("FrmAdminRentPro.updateProAttr?proId_=%s&msg=%s", proId_,svr.getMessage());
				return new RedirectPage(this, url);
		}
		return new RedirectPage(this, "FrmAdminRentPro");
	}
	
	//上传商品图片
	public IPage ajaxText() throws Exception{
    	JsonPage page=new JsonPage(this);
    	String fileKey = null;
		String upload1 = "";
		String upload2 = "";
		String upload3 = "";
		// 处理文件上传
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 设置最大缓存
		factory.setSizeThreshold(20 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		// 获取所有文件列表
		List<FileItem> uploadFiles = upload.parseRequest(getRequest());
		ServerConfig config = new ServerConfig();
		ArrayList<String> file = new ArrayList<>();
		Object str = getProperty(OssSession.sessionId);
		OssSession oss = (OssSession) str;
		String path = "";
		// 取出上传的每一个文件
		System.out.println(uploadFiles.size());
		for (int i = 0; i < uploadFiles.size(); i++) {
			FileItem fileItem = uploadFiles.get(i);
			if (!fileItem.isFormField()) {// 文件名
				if (fileItem.getSize() > 0) {
					String fileName = fileItem.getName().toLowerCase();
					String fileUName = UUID.randomUUID().toString();
					if (fileName.endsWith(".jpg") || fileName.endsWith(".png") || fileName.endsWith(".gif")
							|| fileName.endsWith(".zip") || fileName.endsWith(".rar")) { // 图片上传
						if (fileName.endsWith(".jpg"))
							fileUName += ".jpg";
						if (fileName.endsWith("png"))
							fileUName += ".png";
						if (fileName.endsWith(".gif"))
							fileUName += ".gif";
						if (fileName.endsWith(".zip"))
							fileUName += ".zip";
						if (fileName.endsWith(".rar"))
							fileUName += ".rar";
						oss.upload("yqx" + "/img/" + fileUName, fileItem.getInputStream());
						fileKey = "yqx" + "/img/" + fileUName;
						if("upload1".equals(fileItem.getFieldName())){
							upload1="http://" + config.getProperty("oss.bucket") + "."
									+ config.getProperty("oss.endpoint") + "/" + fileKey;
						}else if("upload2".equals(fileItem.getFieldName())){
							upload2="http://" + config.getProperty("oss.bucket") + "."
									+ config.getProperty("oss.endpoint") + "/" + fileKey;
						}else if("upload3".equals(fileItem.getFieldName())) {
							String tuPianImg="http://" + config.getProperty("oss.bucket") + "."
									+ config.getProperty("oss.endpoint") + "/" + fileKey;
						}else{
							path = "http://" + config.getProperty("oss.bucket") + "."
									+ config.getProperty("oss.endpoint") + "/" + fileKey;
							System.out.println(path);
						}
					}
				}
			} 
		}
		page.setData(path);
		return page;
    }
	  
	public IPage ajaxData(){
    	ArrayList<String> file = new ArrayList<>();
    	String proId_ = this.getRequest().getParameter("proId_");
    	String[]  str = this.getRequest().getParameterValues("strData");
    	for(int i=0;i<str.length;i++){
    		String data = str[i];
    		file.add(data);
    	}
    	LocalService svr = new LocalService(this, "SvrAdminRentPro.ajaxData");
    	Record headIn = svr.getDataIn().getHead();
		headIn.setField("imgUrl", file);
		headIn.setField("proId_", proId_);
		if (!svr.exec()) {
			new RuntimeException(svr.getMessage());
		}
		return new RedirectPage(this, "FrmAdminRentPro.toInsertProAttr?proId_="+proId_);
    }
	
	//返回服务器地址
	public String returnUrl(HttpServletRequest request) throws FileUploadException, IOException{
		String fileKey = null;
		// 处理文件上传
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 设置最大缓存
		factory.setSizeThreshold(20 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		// 获取所有文件列表
		List<FileItem> uploadFiles = upload.parseRequest(request);
		ServerConfig config = new ServerConfig();
		ArrayList<String> file = new ArrayList<>();
		Object str = getProperty(OssSession.sessionId);
		OssSession oss = (OssSession) str;
		String path = "";
		// 取出上传的每一个文件
		for (int i = 0; i < uploadFiles.size(); i++) {
			FileItem fileItem = uploadFiles.get(i);
			String fileName = fileItem.getName().toLowerCase();
			String fileUName = UUID.randomUUID().toString();
			if (fileName.endsWith(".xlsx")) { // 图片上传
				if (fileName.endsWith(".xlsx"))
					fileUName += ".xlsx";
				oss.upload("yqx" + "/xlsx/" + fileUName, fileItem.getInputStream());
				fileKey = "yqx" + "/xlsx/" + fileUName;
				path = "http://" + config.getProperty("oss.bucket") + "."
						+ config.getProperty("oss.endpoint") + "/" + fileKey;
			}
		}
		return path;
	}
		
	//导入excel表格
	public IPage importExcel() throws IOException, FileUploadException{
		JspPage page = new JspPage(this, "products/FrmImportNode.jsp");
		String returnUrl = returnUrl(getRequest());
		System.out.println("returnUrl222"+returnUrl);
	    List<String> temp = new ArrayList<String>();
		if(!returnUrl.equals("")){
		    URL url = new URL(returnUrl);
		    HttpURLConnection conn = (HttpURLConnection)url.openConnection();  
		    conn.setConnectTimeout(5*1000);  //设置超时间为5秒 
		    conn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");  //防止屏蔽程序抓取而返回403错误 
		    //得到输入流 
		    InputStream fileIn = conn.getInputStream();  
			//根据指定的文件输入流导入Excel从而产生Workbook对象
			XSSFWorkbook wb0 = new XSSFWorkbook(fileIn);
			//获取Excel文档中的第一个表单
			XSSFSheet sht0 = wb0.getSheetAt(0);
//			int number = sht0.getPhysicalNumberOfRows();
			//对Sheet中的每一行进行迭代
			for (Row r : sht0) {
			        //如果当前行的行号（从0开始）未达到2（第三行）则从新循环
				if(r.getRowNum()<1){
				continue;
				}
				Cell cell = r.getCell(0);
				cell.setCellType(CellType.STRING);
				String cellValue = cell.getStringCellValue();
				//long nume = (long)r.getCell(0).getNumericCellValue();
				temp.add(cellValue);
		    }
	        fileIn.close();    
	        LocalService svr = new LocalService(this, "SvrAdminRentPro.queryImportData");
	        Record head=svr.getDataIn().getHead();
	    	head.setField("temp", temp);
			if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
			page.add("values", this.setPage(page, svr.getDataOut()));

		}else{
			LocalService svr = new LocalService(this, "SvrAdminRentPro.queryImportData");
			 Record head=svr.getDataIn().getHead();
		    head.setField("temp", temp);
			if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
			page.add("values", this.setPage(page, svr.getDataOut()));
		}
        return page;    
    }
	
	/** 
	   * 从输入流中获取字节数组 
	   * @param inputStream 
	   * @return 
	   * @throws IOException 
	   */
	  /*public static byte[] readInputStream(InputStream inputStream) throws IOException {  
	    byte[] buffer = new byte[1024];  
	    int len = 0;  
	    ByteArrayOutputStream bos = new ByteArrayOutputStream();  
	    while((len = inputStream.read(buffer)) != -1) {  
	      bos.write(buffer, 0, len);  
	    }  
	    bos.close();  
	    return bos.toByteArray();  
	  }*/
	  
	//导出excel
	public IPage exportExcel() throws Exception{
		//JspPage page = new JspPage(this, "products/FrmImportNode.jsp");
		 //获取导出的数据
	    LocalService svr = new LocalService(this, "SvrAdminRentPro.queryNodeState"); 
			if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		List<Record> records = svr.getDataOut().getRecords();
		List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
		Map<String, Object> map = new HashMap<>();
		for(int i=0;i<records.size();i++){
			map.put("物品名称", records.get(i).getString("proName_"));
			map.put("主电子条码", records.get(i).getString("zhuCode_"));
			map.put("添加时间", records.get(i).getString("createDate_"));
			map.put("配件电子条码", records.get(i).getString("ciCode_"));
			dataList.add(map);
			map = new HashMap<>();
		}
		String[] headers = {"物品名称","添加时间","配件电子条码","主电子条码"};
		String sheetName = "商品信息状态表";
		String exportExcelName = "products";
		// 声明一个工作薄
		XSSFWorkbook  workbook = new XSSFWorkbook();
		// 生成一个表格
		XSSFSheet sheet = workbook.createSheet(sheetName);
		// 设置表格默认列宽度为15个字节
		sheet.setDefaultColumnWidth(20);
		
		// 生成表格中非标题栏的样式
		XSSFCellStyle style = workbook.createCellStyle();
		// 设置这些样式
		style.setFillForegroundColor(HSSFColor.WHITE.index);//背景色
		style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		style.setBorderBottom(BorderStyle.THIN);
		style.setBorderLeft(BorderStyle.THIN);
		style.setBorderRight(BorderStyle.THIN);
		style.setBorderTop(BorderStyle.THIN);
		style.setAlignment(HorizontalAlignment.CENTER);
		// 生成表格中非标题栏的字体
		XSSFFont font = workbook.createFont();
		font.setColor(HSSFColor.BLACK.index);
		font.setFontHeightInPoints((short) 12);
		font.setBold(true);
		// 把字体应用到当前的样式
		style.setFont(font);
		// 设置表格标题栏的样式
		XSSFCellStyle titleStyle = workbook.createCellStyle();
		titleStyle.setFillForegroundColor(HSSFColor.BLUE_GREY.index);
		titleStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		titleStyle.setBorderBottom(BorderStyle.THIN);
		titleStyle.setBorderLeft(BorderStyle.THIN);
		titleStyle.setBorderRight(BorderStyle.THIN);
		titleStyle.setBorderTop(BorderStyle.THIN);
		titleStyle.setAlignment(HorizontalAlignment.CENTER);
		titleStyle.setVerticalAlignment(VerticalAlignment.CENTER);
		// 设置标题栏字体
		XSSFFont titleFont = workbook.createFont();
		titleFont.setColor(HSSFColor.WHITE.index);
		titleFont.setFontHeightInPoints((short) 12);
		titleFont.setBold(true);
		// 把字体应用到当前的样式
		titleStyle.setFont(titleFont);
		
		// 产生表格标题行
		XSSFRow row = sheet.createRow(0);
		for (short i = 0; i < headers.length; i++) {
			XSSFCell cell = row.createCell(i);
			cell.setCellStyle(titleStyle);
			XSSFRichTextString text = new XSSFRichTextString(headers[i]);
			cell.setCellValue(text);
		}
		
      // 遍历集合数据，产生数据行
		Iterator<Map<String, Object>> it = dataList.iterator();
		int index = 0;
		while (it.hasNext()) {
			index++;
			row = sheet.createRow(index);
			Map<String, Object> data = it.next();
			int i = 0;
			for(String key : data.keySet()){
				XSSFCell cell = row.createCell(i);
				cell.setCellStyle(style);
				XSSFRichTextString text = new XSSFRichTextString(data.get(key)+"");
				cell.setCellValue(text);
				i++;
			}
		}
		OutputStream out = null;	
		try {
			String tmpPath = "E:\\datas\\" + exportExcelName + ".xlsx";
			out = new FileOutputStream(tmpPath);
			workbook.write(out);
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(workbook != null){
				try {
					workbook.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(out != null){
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return new RedirectPage(this, "FrmAdminRentPro.importNode");
	}
	
	/**
     * 导入电子标签excel
     */
    public IPage importNodeExcel() throws InstantiationException, IllegalAccessException, UnsupportedEncodingException,
            IllegalArgumentException, InvocationTargetException, NoSuchMethodException, SecurityException {
        String msg = null;
        try {
            ImportExcel imp = new ImportExcel(getRequest(), getResponse());
            imp.setTemplateId("FrmNodeIn");
            imp.init();
            DataSet dataSrc = imp.getDataSet();
            if (dataSrc.eof()) {
                msg = "请先选择需要文件！";
            } else {
                while (dataSrc.fetch()) {
                    DataSet dataSet = imp.readFileData(dataSrc.getCurrent());
                    excelImportNode(dataSet);
                }
                msg="导入成功！";
            }
        } catch (ColumnValidateException err) {
            msg=String.format("第%d行第%d列：%s", err.getRow(), err.getCol() + 1, err.getMessage());
        } catch (Exception e) {
            msg=e.getMessage();
        }
        return new RedirectPage(this, "FrmAdminRentPro.importNode?msg="+URLEncoder.encode(msg,"UTF-8"));
    }
    private void excelImportNode(DataSet dataSet) {
        LocalService svr = new LocalService(this);
        svr.setService("SvrAdminRentPro.importInsertNode");

        DataSet dataIn = svr.getDataIn();
        dataSet.first();
        while (dataSet.fetch()) {
            dataIn.append();
            dataIn.setField("zhuCode_", dataSet.getString("zhuCode_"));
            dataIn.post();
        }
        if (!svr.exec()) {
            throw new RuntimeException(svr.getMessage());
        }
    }
    
	/**
	 * 分页
	 * 
	 * @param page
	 * @param dataSet
	 * @return
	 */
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
