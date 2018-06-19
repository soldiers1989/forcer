package com.huagu.product.forms;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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

public class FrmSale_proManage extends AbstractForm {
	
	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "products/FrmSale_proManage.jsp");
		String proName_ = this.getRequest().getParameter("proName_");
		String fristNameId_ = this.getRequest().getParameter("fristNameId_");
		String twoNameId_ = this.getRequest().getParameter("twoNameId_");
		LocalService ls=new LocalService(this,"SvrSaleProManage.querySaleProList");
		Record head = ls.getDataIn().getHead();
		head.setField("proName_", proName_);
		head.setField("fristNameId_", fristNameId_);
		head.setField("twoNameId_", twoNameId_);
		if(!ls.exec()){
			throw new Exception(ls.getMessage());
		}
		if(twoNameId_!=""&&twoNameId_!=null){
			if(!twoNameId_.equals("请选择")){
				if(!ls.getDataOut().eof()){
					page.add("twoName_",ls.getDataOut().getCurrent().getString("twoName_"));
					page.add("twoNameId_", twoNameId_);
					page.add("fristName_",ls.getDataOut().getCurrent().getString("fristName_"));
					page.add("fristNameId_", fristNameId_);
				}
			}
		}else{
			if(fristNameId_!=""&&fristNameId_!=null){
				if(!fristNameId_.equals("请选择")){
					page.add("fristName_",ls.getDataOut().getCurrent().getString("fristName_"));
					page.add("fristNameId_", fristNameId_);
				}
			}
		}
		page.add("proName_", proName_);
		page.add("value",  this.setPage(page, ls.getDataOut()));
		return page;
	}
	
	//添加售卖物品属性
	public IPage toInsertSaleProAttr() throws Exception{
		JspPage page = new JspPage(this, "products/FrmInsert_saleProAttr.jsp");
		page.add("msg", this.getRequest().getParameter("msg"));
		String proId_ = this.getRequest().getParameter("proId_");
		LocalService svr = new LocalService(this, "SvrSaleProManage.queryById"); 
		Record head=svr.getDataIn().getHead();
		head.setField("proId_", proId_);
		if(!svr.exec()){
			page.add("msg", svr.getMessage());
			return page;
		}
		LocalService svr1 = new LocalService(this, "SvrSaleProManage.queryProDetail"); 
		Record head1=svr1.getDataIn().getHead();
		head1.setField("proId_", proId_);
		if(!svr1.exec()){
			page.add("msg", svr1.getMessage());
			return page;
		}
		if(!svr1.getDataOut().bof()){
			page.add("proId_", svr1.getDataOut().getString("proId_"));
			page.add("proName_", svr1.getDataOut().getString("proName_"));
			page.add("fristName_", svr1.getDataOut().getString("fristName_"));
			page.add("twoName_", svr1.getDataOut().getString("twoName_"));
			page.add("proRentCount_", svr1.getDataOut().getString("proRentCount_"));
			page.add("proSaleCount_", svr1.getDataOut().getString("proSaleCount_"));
		}
		if(!svr.getDataOut().bof()){
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
		}
		return page;
		
	}

	//添加售卖物品属性
	public IPage insertSaleProAttr() throws Exception{
		String proId_ = this.getRequest().getParameter("proId_");
		String salePrice_ = this.getRequest().getParameter("salePrice_");//售卖物品的原价
		String saleMemPrice_ = this.getRequest().getParameter("saleMemPrice_");//售卖物品的会员价
		String offerCount_ = this.getRequest().getParameter("offerCount_");//优惠数量
		String offerPrice_ = this.getRequest().getParameter("offerPrice_");//优惠价
		String proNumber_ = this.getRequest().getParameter("proNumber_");//货号
		String barCode_ = this.getRequest().getParameter("barCode_");//条形码
		String proColor_ = this.getRequest().getParameter("proColor_");////积分
		String proDesc_ = this.getRequest().getParameter("proDesc_");//物品描述
		String posTage_ = this.getRequest().getParameter("posTage_");//物品邮费
		String saleJiFen_ = this.getRequest().getParameter("saleJiFen_");////积分
		LocalService svr = new LocalService(this, "SvrSaleProManage.insertSaleProAttr"); 
		Record head=svr.getDataIn().getHead();
		head.setField("proId_", proId_);
		head.setField("salePrice_", salePrice_);
		head.setField("saleMemPrice_", saleMemPrice_);
		head.setField("offerCount_", offerCount_);
		head.setField("offerPrice_", offerPrice_);
		head.setField("proNumber_", proNumber_);
		head.setField("barCode_", barCode_);
		head.setField("proDesc_", proDesc_);
		head.setField("saleJiFen_", saleJiFen_);
		head.setField("posTage_", posTage_);
		head.setField("proColor_", proColor_);
		//上传商品图片
		ArrayList<String> file = new ArrayList<>();
    	String[] str = this.getRequest().getParameterValues("img");
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
		    String url = String.format("FrmSale_proManage.toInsertSaleProAttr?proId_=%s&msg=%s", proId_,svr1.getMessage());
			return new RedirectPage(this, url);
		}
		if(!svr.exec()){
		    String url = String.format("FrmSale_proManage.toInsertSaleProAttr?proId_=%s&msg=%s", proId_,svr.getMessage());
            return new RedirectPage(this, url);
		}
		return new RedirectPage(this, "FrmSale_proManage");
		
	}
	
	//修改售卖物品属性
	public IPage toUpdateSaleProAttr() throws Exception{
		JspPage page = new JspPage(this, "products/FrmUpdate_saleProAttr.jsp");
		page.add("msg", this.getRequest().getParameter("msg"));
		String proId_ = this.getRequest().getParameter("proId_");
		LocalService svr = new LocalService(this, "SvrSaleProManage.queryById"); 
		Record head=svr.getDataIn().getHead();
		head.setField("proId_", proId_);
		if(!svr.exec()){
			page.add("msg", svr.getMessage());
			return page;
		}
		if(!svr.getDataOut().bof()){
			page.add("value", svr.getDataOut().getCurrent());
		}
		LocalService updateImg = new LocalService(this, "SvrAdminRentPro.queryImg"); 
		Record headIn=updateImg.getDataIn().getHead();
		headIn.setField("proId_", proId_);
		if(!updateImg.exec()){
			page.add("msg", updateImg.getMessage());
			return page;
		}
		page.add("updateImg", updateImg.getDataOut().getRecords());
		LocalService svr1 = new LocalService(this, "SvrSaleProManage.queryProDetail"); 
		Record head1=svr1.getDataIn().getHead();
		head1.setField("proId_", proId_);
		if(!svr1.exec()){
			page.add("msg", svr1.getMessage());
			return page;
		}
		if(!svr1.getDataOut().bof()){
			page.add("val", svr1.getDataOut().getCurrent());
		}
		return page;
		
	}
	
	//修改售卖物品属性
	public IPage updateSaleProAttr() throws Exception{
		String proId_ = this.getRequest().getParameter("proId_");
		String salePrice_ = this.getRequest().getParameter("salePrice_");//售卖原价
		String saleMemPrice_ = this.getRequest().getParameter("saleMemPrice_");//售卖会员价
		String offerCount_ = this.getRequest().getParameter("offerCount_");//优惠数量
		String offerPrice_ = this.getRequest().getParameter("offerPrice_");//优惠价
		String barCode_ = this.getRequest().getParameter("barCode_");//条形码
		String saleJiFen_ = this.getRequest().getParameter("saleJiFen_");//售卖积分
		String proNumber_ = this.getRequest().getParameter("proNumber_");//货号
		String proColor_ = this.getRequest().getParameter("proColor_");//颜色
		String posTage_ = this.getRequest().getParameter("posTage_");//邮费
		String proDesc_ = this.getRequest().getParameter("proDesc_");//描述
		String[] str = this.getRequest().getParameterValues("img");//图片
		LocalService svr = new LocalService(this, "SvrSaleProManage.insertSaleProAttr"); 
		Record head=svr.getDataIn().getHead();
		head.setField("proId_", proId_);
		head.setField("salePrice_", salePrice_);
		head.setField("saleMemPrice_", saleMemPrice_);
		head.setField("offerCount_", offerCount_);
		head.setField("offerPrice_", offerPrice_);
		head.setField("barCode_", barCode_);
		head.setField("saleJiFen_", saleJiFen_);
		head.setField("proNumber_", proNumber_);
		head.setField("proColor_", proColor_);
		head.setField("posTage_", posTage_);
		head.setField("proDesc_", proDesc_);
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
			 String url = String.format("FrmSale_proManage.updateSaleProAttr?proId_=%s&msg=%s", proId_,svr1.getMessage());
				return new RedirectPage(this, url);
		}
		if(!svr.exec()){
			 String url = String.format("FrmSale_proManage.updateSaleProAttr?proId_=%s&msg=%s", proId_,svr.getMessage());
				return new RedirectPage(this, url);
		}
		return new RedirectPage(this, "FrmSale_proManage");
	}

	//商品入库
	public IPage toEnterKuSale() throws Exception{
		JspPage page = new JspPage(this, "products/FrmSale_enterKu.jsp");
		page.add("msg", this.getRequest().getParameter("msg"));
		String proId_ = this.getRequest().getParameter("proId_");
		LocalService svr = new LocalService(this, "SvrSaleProManage.queryRuKuById"); 
		Record head=svr.getDataIn().getHead();
		head.setField("proId_", proId_);
		if(!svr.exec()){
			page.add("msg", svr.getMessage());
			return page;
		}
		//进入页面就产生赔付单号
	    String  date = new SimpleDateFormat("yyyyMMdd").format(new Date());   
	    String  ruKuId_ = new String();
	    String random = getRandom();
	    ruKuId_="RK"+date+"112233"+random;
	    page.add("ruKuId_", ruKuId_);
		
		page.add("value", svr.getDataOut().getCurrent());
		LocalService svrSupply = new LocalService(this, "SvrAdminSupply.queryListSupply"); 
		if(!svrSupply.exec()){
			throw new RuntimeException(svrSupply.getMessage());
		}
		page.add("supply", this.setPage(page, svrSupply.getDataOut()));
		LocalService svrCom = new LocalService(this, "SvrAgentQuery");
		if(!svrCom.exec())
			throw new Exception(svrCom.getMessage());
		page.add("agents", this.setPage(page, svrCom.getDataOut()));
		return page;
	}
	
	/***
	 *   分页查询代理商
	 *  @author wj  
	 *  @date 2018年6月13日
	 */
	public IPage search() throws Exception{
		JspPage page = new JspPage(this, "products/FrmSale_enterKu.jsp");
		LocalService svrCom = new LocalService(this, "SvrAgentQuery");
		if(!svrCom.exec())
			throw new Exception(svrCom.getMessage());
		page.add("agents", this.setPage(page, svrCom.getDataOut()));
		return page;
	}
	
	/***
	 *  分页查询供应商
	 *  @author wj  
	 *  @date 2018年6月13日
	 */
	public IPage searchSupply()  throws Exception{
		JspPage page = new JspPage(this, "products/FrmSale_enterKu.jsp");
		LocalService svrSupply = new LocalService(this, "SvrAdminSupply.queryListSupply"); 
		if(!svrSupply.exec()){
			throw new RuntimeException(svrSupply.getMessage());
		}
		page.add("supply", this.setPage(page, svrSupply.getDataOut()));
		return page;
		
	}
	
	
	//商品入库
	public IPage enterKuSale() throws Exception{
		JsonPage page =new JsonPage(this);
		String proId_ = this.getRequest().getParameter("proId_");
		String saleHomeAgency_ = this.getRequest().getParameter("saleHomeAgency_");//归属机构
		String saleSupply_ = this.getRequest().getParameter("saleSupply_");//供应商
		String ruKuId_ = this.getRequest().getParameter("ruKuId_");//入库单号
		String jinPrice_ = this.getRequest().getParameter("jinPrice_");//售卖商品进价
		String ruKuCount_ = this.getRequest().getParameter("ruKuCount_");//入库数量
		String jinSum_ = this.getRequest().getParameter("jinSum_");//进价总额
		String saleServerDeadTime_ = this.getRequest().getParameter("saleServerDeadTime_");//保修截止日期
		String saleRuKuTime_ = this.getRequest().getParameter("saleRuKuTime_");//入库时间
		String pici_ = this.getRequest().getParameter("pici_");//批次
		LocalService svr = new LocalService(this, "SvrSaleProManage.saleProRuKu"); 
		Record head=svr.getDataIn().getHead();
		head.setField("proId_", proId_);
		head.setField("saleHomeAgency_", saleHomeAgency_);
		head.setField("saleSupply_", saleSupply_);
		head.setField("ruKuId_", ruKuId_);
		head.setField("jinPrice_", jinPrice_);
		head.setField("ruKuCount_", ruKuCount_);
		head.setField("jinSum_", jinSum_);
		head.setField("saleServerDeadTime_", saleServerDeadTime_);
		head.setField("saleRuKuTime_", saleRuKuTime_);
		head.setField("pici_", pici_);
		
		if(!svr.exec()){
			page.setData(svr.getMessage());
			return page;
		}
		return new RedirectPage(this, "FrmSale_proManage");
		
	}
		
	//上传商品图片
	public IPage ajaxText() throws Exception{
    	JsonPage page=new JsonPage(this);
    	String fileKey = null;
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
							path = "http://" + config.getProperty("oss.bucket") + "."
									+ config.getProperty("oss.endpoint") + "/" + fileKey;
							System.out.println(path);
					}
				}
			} 
		}
		page.setData(path);
		return page;
    }
	
	//随机产生赔付单号后四位
	  public String getRandom() throws Exception{
	    //查询最近一次的入库单号
	    LocalService svr = new LocalService(this, "SvrGetLastRuKuId");
	    if(!svr.exec()){
	      throw new RuntimeException(svr.getMessage());
	    }
	    String ruKuId_="";
	    String lastRuKuId_ = svr.getDataOut().getHead().getString("ruKuId_");
	    if(lastRuKuId_ == null || lastRuKuId_ == ""){
	    	ruKuId_ = "0000";
	    }else{ 
	      String id = lastRuKuId_.substring(16, 20);
	      long str = Long.parseLong(id);
	      long payID=str+1;
	      if(str<=999){
	    	  ruKuId_=String.valueOf(payID);
	        //拼接0
	        String aa="";
	        for(int i = ruKuId_.length();i<4;i++){
	          aa += "0" ;
	        }
	        ruKuId_=aa+payID;
	      }else{
	        return "ruKuId_";
	      }
	    }
	    return ruKuId_;
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
		pages.setPageSize(2);
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
