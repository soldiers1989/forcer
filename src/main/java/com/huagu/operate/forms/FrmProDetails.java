package com.huagu.operate.forms;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.oss.OssSession;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;

public class FrmProDetails extends AbstractForm {
	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "operate/proDetails.jsp");
		page.add("zhuCode_", "123456");
		return page;

	}
	
	/**
	 * 跳转运维管理
	 * @return
	 * @throws Exception
	 */
	public IPage management() throws Exception {
		JspPage page = new JspPage(this, "operate/managementIndex.jsp");
		return page;

	}

	/**
	 * 跳转立即运维
	 * @return
	 * @throws Exception
	 */
	public IPage goProDetails() throws Exception {
		JspPage page = null;

		String falg = this.getRequest().getParameter("falg");// 运维类型
																// wh:维护/dh:调货/bh:补货
		if (falg.equals("wh")) {
			page = new JspPage(this, "operate/maintain.jsp");
		}
		if (falg.equals("dh")) {
			page = new JspPage(this, "operate/transferGoods.jsp");
		}
		if (falg.equals("bh")) {
			page = new JspPage(this, "operate/replenishment.jsp");
		}
		String zhuCode_ = this.getRequest().getParameter("zhuCode_");// 主电子条码

		// 根据注电子条码获取获取订单信息
		LocalService svr = new LocalService(this, "SvrDeliveryorder.findOrd");
		Record head = svr.getDataIn().getHead();
		head.setField("zhuCode_", zhuCode_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		if (!svr.getDataOut().bof()) {
			page.add("ord", svr.getDataOut().getCurrent());
		}

		// 获取商品信息,根据注电子条码获取
		LocalService svr2 = new LocalService(this, "SvrAdminPro.findPro");
		Record head2 = svr2.getDataIn().getHead();
		head2.setField("zhuCode_", zhuCode_);
		if (!svr2.exec())
			throw new RuntimeException(svr2.getMessage());
		if (!svr2.getDataOut().bof()) {
			page.add("pro", svr2.getDataOut().getCurrent());
		}

		// 根据注电子条码获取获取历史运维信息
		LocalService svr3 = new LocalService(this, "SvrProDetails.findOpe");
		Record head3 = svr3.getDataIn().getHead();
		head3.setField("zhuCode_", zhuCode_);
		if (!svr3.exec())
			throw new RuntimeException(svr3.getMessage());
		if (!svr3.getDataOut().bof()) {
			page.add("ope", svr3.getDataOut().getCurrent());
		}
		page.add("zhuCode_", zhuCode_);
		page.add("id_", this.getRequest().getParameter("id_"));
		page.add("cid_" ,this.getRequest().getParameter("cid_"));
		return page;
	}

	/**
	 * 根据主电子条码查询订单的历史租凭记录信息
	 * @return
	 * @throws Exception
	 */
	public IPage goOrder() throws Exception {
		JspPage page = new JspPage(this, "operate/orderDetails.jsp");
		String zhuCode_ = this.getRequest().getParameter("zhuCode_");// 主电子条码
		LocalService svr = new LocalService(this, "SvrProDetails.findOrdList");
		Record head = svr.getDataIn().getHead();
		head.setField("zhuCode_", zhuCode_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		if (!svr.getDataOut().bof()) {
			List<Record> records = svr.getDataOut().getRecords();
			for (Record r : records) {
				String imgPath_ = r.getString("imgPath_");
				imgPath_ = imgPath_.replace("[", "");
				imgPath_ = imgPath_.replace("]", "");
				r.setField("imgPath_", imgPath_);
			}
			page.add("orders", records);
		}
		return page;
	}

	/**
	 * 运维提交
	 * @return
	 * @throws Exception
	 */
	public IPage addOperate() throws Exception {
		String fileKey = null;
		String nowLoss_ = "";
		String OpenBoxTime_ = "";
		String closeBoxTime_ = "";
		String leaveMess_ = "";
		String orderId_ = "";
		String zhuCode_ = "";
		String operateManId_ = this.getUserCode();
		if("".equals(operateManId_)){
			operateManId_ = "17620458925";
		}
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
				if ("nowLoss_".equals(fileItem.getFieldName()))
					nowLoss_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("OpenBoxTime_".equals(fileItem.getFieldName()))
					OpenBoxTime_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("closeBoxTime_".equals(fileItem.getFieldName()))
					closeBoxTime_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("leaveMess_".equals(fileItem.getFieldName()))
					leaveMess_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("orderId_".equals(fileItem.getFieldName()))
					orderId_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("zhuCode_".equals(fileItem.getFieldName()))
					zhuCode_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
			}
		}
		LocalService svr = new LocalService(this, "SvrProDetails.addOperate");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("file",file);
		headIn.setField("nowLoss_",nowLoss_);
		headIn.setField("OpenBoxTime_",OpenBoxTime_);
		headIn.setField("closeBoxTime_",closeBoxTime_);
		headIn.setField("leaveMess_",leaveMess_);
		headIn.setField("orderId_",orderId_);
		headIn.setField("zhuCode_",zhuCode_);
		headIn.setField("operateManId_",  operateManId_);//运维人员ID
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return new RedirectPage(this,"FrmMyCabinet");
	}

	/**
	 * 获取用户订单信息
	 * @return
	 * @throws Exception
	 */
	public IPage findHisOrd() throws Exception {
		JspPage page = new JspPage(this, "operate/hisOrd.jsp");
		// 获取订单信息
		String userId_ = this.getRequest().getParameter("userId_");// 用户Id
		LocalService svr = new LocalService(this, "SvrProDetails.findHisOrd");
		Record head = svr.getDataIn().getHead();
		head.setField("userId_", userId_);
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		if (!svr.getDataOut().bof()) {

			List<Record> records = svr.getDataOut().getRecords();
			records = getRecord(records);
			page.add("orders", records);
		}
		// 获取用户信息
		LocalService svr2 = new LocalService(this, "SvrProDetails.finduser");
		Record head2 = svr2.getDataIn().getHead();
		head2.setField("userId_", userId_);
		if (!svr2.exec())
			throw new RuntimeException(svr2.getMessage());
		if (!svr2.getDataOut().bof()) {
			page.add("user", svr2.getDataOut().getCurrent());
		}

		return page;
	}

	/**
	 * 调货提交
	 * @return
	 * @throws Exception
	 */
	public IPage addTransfer() throws Exception {
		String operateManId_ = this.getUserCode();
		if ("".equals(operateManId_)) {
			operateManId_ = "17620458925";
		}
		LocalService svr = new LocalService(this, "SvrProDetails.addOperate");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("nowLoss_", this.getRequest().getParameter("nowLoss_"));
		headIn.setField("OpenBoxTime_", this.getRequest().getParameter("OpenBoxTime_"));
		headIn.setField("closeBoxTime_", this.getRequest().getParameter("closeBoxTime_"));
		headIn.setField("leaveMess_", this.getRequest().getParameter("leaveMess_"));
		headIn.setField("orderId_", this.getRequest().getParameter("orderId_"));
		headIn.setField("zhuCode_", this.getRequest().getParameter("zhuCode_"));
		headIn.setField("falg", this.getRequest().getParameter("falg"));
		headIn.setField("operateManId_", operateManId_);// 运维人员ID
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return execute();
	}

	/**
	 * 补货提交
	 * @return
	 * @throws Exception
	 */
	public IPage replenishment() throws Exception {
		String fileKey = null;
		String nowLoss_ = "";
		String OpenBoxTime_ = "";
		String closeBoxTime_ = "";
		String leaveMess_ = "";
		String orderId_ = "";
		String zhuCode_ = "";
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
				if ("nowLoss_".equals(fileItem.getFieldName()))
					nowLoss_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("OpenBoxTime_".equals(fileItem.getFieldName()))
					OpenBoxTime_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("closeBoxTime_".equals(fileItem.getFieldName()))
					closeBoxTime_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("leaveMess_".equals(fileItem.getFieldName()))
					leaveMess_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("orderId_".equals(fileItem.getFieldName()))
					orderId_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("zhuCode_".equals(fileItem.getFieldName()))
					zhuCode_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
			}
		}
		LocalService svr = new LocalService(this, "SvrProDetails.addOperate");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("file", file);
		headIn.setField("nowLoss_", nowLoss_);
		headIn.setField("OpenBoxTime_", OpenBoxTime_);
		headIn.setField("closeBoxTime_", closeBoxTime_);
		headIn.setField("leaveMess_", leaveMess_);
		headIn.setField("orderId_", orderId_);
		headIn.setField("zhuCode_", zhuCode_);
		headIn.setField("operateManId_", "15071506306");// 运维人员ID
		if (!svr.exec())
			throw new RuntimeException(svr.getMessage());
		return execute();
	}

	public List<Record> getRecord(List<Record> records) {
		for (Record r : records) {
			String overdueDay_ = r.getString("overdueDay_");
			String rentTime_ = r.getString("rentTime_");
			if (overdueDay_ == "" || overdueDay_ == null) {
				overdueDay_ = "0";
			}
			if (rentTime_ == "" || rentTime_ == null) {
				rentTime_ = "0";
			}
			int totDay_ = Integer.parseInt(overdueDay_) + Integer.parseInt(rentTime_);
			r.setField("totDay_", totDay_);
			String isDiscount_ = r.getString("isDiscount_");
			String dayRentMoney_ = "";
			if (isDiscount_.equals("0") && isDiscount_ != null) {
				dayRentMoney_ = r.getString("dayRentMoney_");

			}
			if (isDiscount_.equals("1") && isDiscount_ != null) {
				dayRentMoney_ = r.getString("discountPrice_");
			}
			if (dayRentMoney_ == "" || dayRentMoney_ == null) {
				dayRentMoney_ = "0";
			}
			Double totMoney = Double.parseDouble(dayRentMoney_) * totDay_;
			r.setField("totMoney_", totMoney);
			String sumOverMoney_ = r.getString("sumOverMoney_");
			String sumMoney_ = r.getString("sumMoney_");

			if (sumOverMoney_ == "" || sumOverMoney_ == null) {
				sumOverMoney_ = "0";
			}
			if (sumMoney_ == "" || sumMoney_ == null) {
				sumMoney_ = "0";
			}
			Double OverMoney = Double.parseDouble(sumOverMoney_) + Double.parseDouble(sumMoney_);

			r.setField("OverMoney_", OverMoney);
			String reliefDeposit_ = r.getString("reliefDeposit_");
			String cashPledge_ = r.getString("cashPledge_");
			if (reliefDeposit_ == "" || reliefDeposit_ == null) {
				reliefDeposit_ = "0";
			}
			if (cashPledge_ == "" || cashPledge_ == null) {
				cashPledge_ = "0";
			}
			Double cashMoney = Double.parseDouble(cashPledge_) - Double.parseDouble(reliefDeposit_);
			r.setField("cashMoney_", cashMoney);
		}
		return records;
	}
	
	@Override
	public boolean logon() {
		return true;
	}

}
