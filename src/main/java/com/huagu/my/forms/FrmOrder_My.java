package com.huagu.my.forms;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.huagu.common.util.LogisticsUtil;

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
 * 
 * 
 * @author 张俊森
 * @Time 
 */
public class FrmOrder_My extends AbstractForm {

	@Override
	//查询订单列表
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "my/myOrder.jsp");
		String falg = this.getRequest().getParameter("falg");
		String userId_ = this.getUserCode();
		if(userId_ == "" || userId_ == null){
			userId_ = "17620458925";
		}
		if(falg == "" || falg == null){
			falg="10";
		}
		LocalService svr = new LocalService(this, "SvrOrder_My.findOrderList");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("userId_",userId_);//用户ID
		headIn.setField("falg", falg);//用户ID
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		if(!svr.getDataOut().bof()){
			List<Record> Records = svr.getDataOut().getRecords();
			getDifTime(Records);//获取时间差
			page.add("orders", svr.getDataOut().getRecords());
		}
		page.add("userId_", userId_);
		page.add("falg", falg);
		return page;
	}
	
	//订单详情
	public IPage findOrder() throws Exception {
		String falg = this.getRequest().getParameter("falg");
		LocalService svr = new LocalService(this, "SvrOrder_My.findOrder");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("orderId_",this.getRequest().getParameter("orderId"));//用户ID
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		if(falg == null || falg ==""){
			JspPage page = new JspPage(this, "my/orderDetails.jsp");
			if(!svr.getDataOut().bof()){
				page.add("order", svr.getDataOut().getCurrent());
			}
			return page;
		}
		if(falg.equals("ajax") && falg != null){
			JsonPage page = new JsonPage(this);
			Map<String, String> returnJson = new HashMap<>();
			returnJson.put("order",  svr.getDataOut().getCurrent().toString());
			page.setData(returnJson);
			return page;
		}
		if(falg.equals("goOverdue") && falg != null){
			JspPage page = new JspPage(this, "my/overduePayment.jsp");
			if(!svr.getDataOut().bof()){
				page.add("order", svr.getDataOut().getCurrent());
				page.add("orderId_", this.getRequest().getParameter("orderId"));
				page.add("type", this.getRequest().getParameter("type"));
			}
			return page;
		}
		
		return null;
	}
	
	//进入订单搜索页面
	public IPage goOrderSearch() throws Exception {
		JspPage page = new JspPage(this, "my/orderSearch.jsp");
		page.add("userId", this.getRequest().getParameter("userId"));
		return page;
	}
	
	//模糊查询订单列表
	public IPage orderSearch() throws Exception {
		JspPage page = new JspPage(this, "my/orderSearch.jsp");
		String da = this.getRequest().getParameter("da");
		String userId = this.getRequest().getParameter("userId");
		LocalService svr = new LocalService(this, "SvrOrder_My.findOrderList");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("data",da);
		headIn.setField("userId_",userId);
		headIn.setField("falg","mhss");
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("orders", svr.getDataOut().getRecords());
		page.add("userId", userId);
		return page;
	}
	
	//修改订单状态
	public IPage updateOrder() throws Exception {
		JsonPage page = new JsonPage(this);
		String orderId_ = this.getRequest().getParameter("orderId");
		String orderState_ = this.getRequest().getParameter("orderState");
		LocalService svr = new LocalService(this, "SvrOrder_My.updateOrder");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("orderId_", orderId_);
		headIn.setField("orderState_", orderState_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return page;
	}
	
	//订单有损归还
	public IPage upOrderRepair() throws Exception {
		String orderId_ = this.getRequest().getParameter("orderId_");
		String returnType_ = this.getRequest().getParameter("returnType_");//归还类型
		String returnMethod_ = this.getRequest().getParameter("returnMethod_");//归还方式
		LocalService svr = new LocalService(this, "SvrOrder_My.upOrderRepair");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("orderId_", orderId_);
		headIn.setField("returnType_", returnType_);
		if(returnType_.equals("1")){
			headIn.setField("repairType_", this.getRequest().getParameter("repairType_"));
		}
		if(returnMethod_.equals("1")){//快递归还获取物流信息
			headIn.setField("returnLogisticsName_",this.getRequest().getParameter("returnLogisticsName_"));
			headIn.setField("retuenLogisticsId_",this.getRequest().getParameter("retuenLogisticsId_"));
		}
		headIn.setField("overdueDay_",this.getRequest().getParameter("overdueDay_"));//超期天数
		headIn.setField("sumOverMoney_",this.getRequest().getParameter("sumOverMoney_"));//超期付款金额
		headIn.setField("returnMethod_", returnMethod_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return new RedirectPage(this, "FrmOrder_My.execute?userId="+this.getRequest().getParameter("userId"));
	}
	
	//去物流归还页面
	public IPage goExpressReturn() throws Exception {
		JspPage page = new JspPage(this, "my/expressReturn.jsp");
		LocalService svr = new LocalService(this, "SvrOrder_My.findOrder");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("orderId_",this.getRequest().getParameter("orderId"));//订单ID
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		if(!svr.getDataOut().bof()){
			page.add("order", svr.getDataOut().getCurrent());
		}
		return page;
	}
	
	//保存归还物流信息
//	public IPage seaExpReturn() throws Exception {
//		JsonPage page = new JsonPage(this);
//		LocalService svr = new LocalService(this, "SvrOrder_My.seaExpReturn");
//		Record headIn = svr.getDataIn().getHead();
//		headIn.setField("orderId_",this.getRequest().getParameter("orderId_"));//订单ID
//		headIn.setField("returnLogisticsName_",this.getRequest().getParameter("returnLogisticsName_"));
//		headIn.setField("retuenLogisticsId_",this.getRequest().getParameter("retuenLogisticsId_"));
//		if (!svr.exec())
//			throw new RuntimeException(svr.getMessage());
//		page.setData(true);
//		return page;
//		
//	}
	
	//前往订单评价页面goEvaluate
	public IPage goEvaluate() throws Exception {
		JspPage page = new JspPage(this, "my/evaluate.jsp");
		page.add("orderId_", this.getRequest().getParameter("orderId_"));
		page.add("userId_", this.getRequest().getParameter("userId_"));
		page.add("orderType_", this.getRequest().getParameter("orderType_"));
		return page;
	}
	
	//查看物流信息
	public IPage findLogistics() throws Exception {
		JspPage page = new JspPage(this, "my/LogisticsXX.jsp");
		LocalService svr = new LocalService(this, "SvrOrder_My.findOrder");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("orderId_",this.getRequest().getParameter("orderId_"));//订单ID
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		Record r = svr.getDataOut().getCurrent();
		String n = r.getString("recLogisticsId_");
		String t = r.getString("recLogisticsName_");
		String str = LogisticsUtil.getLogistics(n, t);
//		String str = "{'LogisticCode':'888731354466214400','ShipperCode':'YTO','Traces':[{'AcceptStation':'【浙江省杭州市钱江新城公司】 取件人: 李晓军 已收件','AcceptTime':'2018-03-19 19:04:33'},{'AcceptStation':'【浙江省杭州市钱江新城公司】 已收件','AcceptTime':'2018-03-19 19:09:52'},{'AcceptStation':'【浙江省杭州市钱江新城公司】 已打包','AcceptTime':'2018-03-19 19:09:52'},{'AcceptStation':'【深圳转运中心】 已发出 下一站 【广东省深圳市宝安区固戍公司】','AcceptTime':'2018-03-21 01:01:34'},{'AcceptStation':'【广东省深圳市宝安区固戍碧海湾分部公司】 已收入','AcceptTime':'2018-03-21 05:19:18'},{'AcceptStation':'【广东省深圳市宝安区固戍碧海湾分部公司】 派件人: 宫源 派件中 派件员电话13955759921','AcceptTime':'2018-03-21 06:12:20'},{'AcceptStation':'客户 签收人: 签收人 已签收 感谢使用圆通速递，期待再次为您服务','AcceptTime':'2018-03-21 11:35:29'}],'State':'3','Success':true}";
		page.add("str",str);
		page.add("order",svr.getDataOut().getCurrent());
		return page;
	}
	
	//根据用户ID获取用户租金明细
	public IPage getCashPledge() throws Exception {
		JspPage page = new JspPage(this, "order/CashPledge.jsp");
		LocalService svr = new LocalService(this, "SvrOrder_My.getCashPledge");
		String userId_ = this.getUserCode();
		if(userId_ == "" || userId_ == null){
			userId_ = "17620458925";
		}
		if(!svr.exec("userId_",userId_))
			throw new RuntimeException();
		page.add("totCashPledge_",this.getRequest().getParameter("totCashPledge_"));
		page.add("orders", svr.getDataOut().getRecords());
		return page;
	}
	
	//前往退款页面
	public IPage goRefund() throws Exception {
		JspPage page = new JspPage(this, "order/Refund.jsp");
		LocalService svr = new LocalService(this, "SvrOrder_My.findOrder");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("orderId_",this.getRequest().getParameter("orderId_"));//订单ID
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		page.add("order",svr.getDataOut().getCurrent());
		return page;
	}
	
	//退款提交
	public IPage refund() throws Exception {
		JspPage page = new JspPage(this, "order/RefundEnd.jsp");
		LocalService svr = new LocalService(this, "SvrOrder_My.refund");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("orderId_",this.getRequest().getParameter("orderId_"));//订单ID
		headIn.setField("returnReason_",this.getRequest().getParameter("returnReason_"));//退款原因
		headIn.setField("returnMoney_",this.getRequest().getParameter("returnMoney_"));//退款金额
		headIn.setField("zhuCode_",this.getRequest().getParameter("zhuCode_"));//主电子条码
		if (!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		page.add("err", headIn.getField("err"));
		return page;
	}
	
	//评论提交
	public IPage addEvaluate() throws Exception {
		String fileKey = null;
		String evaLevel_ = "";
		String evaContent_ = "";
		String evaState_ = "";
		String userId_ = "";
		String orderId_ = "";
		String orderType_ = "";
		// 处理文件上传
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 设置最大缓存
		factory.setSizeThreshold(20 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		// 获取所有文件列表
		List<FileItem> uploadFiles = upload.parseRequest(getRequest());
		ArrayList<String> file = new ArrayList<>();
		ServerConfig config = new ServerConfig();
		Object str = getProperty(OssSession.sessionId);
		OssSession oss = (OssSession) str;
		// 取出上传的每一个文件
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
						oss.upload("zxa" + "/img/" + fileUName, fileItem.getInputStream());
						fileKey = "zxa" + "/img/" + fileUName;
						String path = "http://" + config.getProperty("oss.bucket") + "."
								+ config.getProperty("oss.endpoint") + "/" + fileKey;
						file.add(path);
					}
				}
			} else {
				// 非文件流
				if ("evaLevel_".equals(fileItem.getFieldName()))
					evaLevel_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("evaContent_".equals(fileItem.getFieldName()))
					evaContent_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("evaState_".equals(fileItem.getFieldName()))
					evaState_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("userId_".equals(fileItem.getFieldName()))
					userId_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("orderId_".equals(fileItem.getFieldName()))
					orderId_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("orderType_".equals(fileItem.getFieldName()))
					orderType_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
			}
		}
		LocalService svr = new LocalService(this, "SvrOrder_My.addEvaluate");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("file",file);
		headIn.setField("evaLevel_",evaLevel_);
		headIn.setField("evaContent_",evaContent_);
		headIn.setField("evaState_",evaState_);
		headIn.setField("userId_",userId_);
		headIn.setField("orderId_",orderId_);
		headIn.setField("orderType_",orderType_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return new RedirectPage(this, "FrmOrder_My.execute?userId="+userId_);
	}
	
	//获取时间差
	public void getDifTime(List<Record> records){
		for(Record r:records){
			String returnTime_ = r.getSafeString("returnTime_");
			if(returnTime_ != "" && returnTime_ != null){
				Date now = new Date();
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			    Date date = null;
			    try {
			        date = format.parse(returnTime_);
			        Long sumSec = (date.getTime()-now.getTime())/1000;
			        if(r.getSafeString("orderState_").equals("4") && r.getSafeString("orderState_") != null){//该订单是“租用中”的状态
			        	 if(sumSec >= 0){
					        	long day = sumSec/(24*60*60);
						        long hours = (sumSec-(day*24*60*60))/(60*60);
						        long min = (sumSec-(day*24*60*60)-(hours*60*60))/60;
						        long sec =sumSec%60;
						        String str = "倒计时："+day+"天"+hours+"小时"+min+"分"+sec+"秒";
						        r.setField("difTime_", str);
					        }
			        	 if(sumSec < 0){
			        		 sumSec = (now.getTime() - date.getTime())/1000;
			        		 long day = sumSec/(24*60*60);
					         long hours = (sumSec-(day*24*60*60))/(60*60);
					         long min = (sumSec-(day*24*60*60)-(hours*60*60))/60;
					         long sec =sumSec%60;
					         String str = "您已超过应还期："+day+"天"+hours+"小时"+min+"分"+sec+"秒";
					         r.setField("difTime_", str);
			        	 }
					        /*if(sumSec < 0){//如果时间小于0 则租期已过，修改订单状态为“待归还”
					        	LocalService svr = new LocalService(this, "SvrOrder_My.updateOrder");
					    		Record headIn = svr.getDataIn().getHead();
					    		headIn.setField("orderId_", r.getSafeString("orderId_"));
					    		headIn.setField("orderState_", "5");
					    		if (!svr.exec())
					    			throw new RuntimeException(svr.getMessage());
					        }*/
			        }
			       
			       
			    } catch (ParseException e) {
			        e.printStackTrace();
			    }
			}
			
		}
	}
	
	
	public boolean logon() {
		return true;
	}

}
