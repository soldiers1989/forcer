package com.huagu.coupon.forms;

import java.util.List;
import java.util.UUID;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.huagu.common.util.ParamUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.oss.OssSession;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;

public class FrmReleaseCoupon extends AbstractForm {

	/**
	 * @describe 跳转发布优惠券
	 * @author 李佳炫
	 * @date 2018年3月16日
	 * @return
	 */
	public IPage execute() throws Exception {
		JspPage jsp = new JspPage(this, "coupon/ReleaseCoupon.jsp");
		return jsp;
	}

	/**
	 * @describe 优惠券发布
	 * @author 李佳炫
	 * @date 2018年3月16日
	 * @return
	 */
	public IPage insert() throws Exception {
		String fileKey = null;
		// 未见类型
		String partCode = getRequest().getParameter("partCode");
		String couponname_ = this.getRequest().getParameter("couponname_");// 优惠券名称
		String type_ = this.getRequest().getParameter("type_");// 优惠券类型
		String receive_ = this.getRequest().getParameter("receive_");// 优惠券接收人群
		String total_ = this.getRequest().getParameter("total_");// 优惠券发送总数
		String grantdate_ = this.getRequest().getParameter("grantdate_");// 优惠券可领取时间段
		String grantdate1_ = this.getRequest().getParameter("grantdate1_");// 优惠券可领取时间段
		String enddate_ = this.getRequest().getParameter("enddate_");// 优惠券有效起始时间
		String enddate1_ = this.getRequest().getParameter("enddate1_");// 优惠券有效最後的时间
		String Denomination_ = this.getRequest().getParameter("Denomination_");// 优惠券面额（元）
		String range_ = this.getRequest().getParameter("range_");// 优惠券使用范围
		String couponcontent_ = this.getRequest().getParameter("couponcontent_");// 优惠券说明内容
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
						oss.upload("zsf" + partCode + fileUName, fileItem.getInputStream());
						fileKey = "zsf" + partCode + fileUName;
					}
				}
			} else {
				if ("partCode".equals(fileItem.getFieldName()))
					partCode = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");

				if ("couponname_".equals(fileItem.getFieldName()))
					couponname_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");

				if ("couponcontent_".equals(fileItem.getFieldName()))
					couponcontent_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");

				if ("type_".equals(fileItem.getFieldName()))
					type_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");

				if ("receive_".equals(fileItem.getFieldName()))
					receive_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");

				if ("total_".equals(fileItem.getFieldName()))
					total_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");

				if ("grantdate_".equals(fileItem.getFieldName()))
					grantdate_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");

				if ("grantdate1_".equals(fileItem.getFieldName()))
					grantdate1_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");

				if ("enddate_".equals(fileItem.getFieldName()))
					enddate_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");

				if ("enddate1_".equals(fileItem.getFieldName()))
					enddate1_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");

				if ("Denomination_".equals(fileItem.getFieldName()))
					Denomination_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");

				if ("range_".equals(fileItem.getFieldName()))
					range_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
			}

		}

		ServerConfig config = new ServerConfig();
		String path = "http://" + config.getProperty("oss.bucket") + "." + config.getProperty("oss.endpoint") + "/"
				+ fileKey;
		// 执行服务
		LocalService svr = new LocalService(this, "SvrReleaseCoupon");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("couponname_", couponname_);// 优惠券名称
		headIn.setField("type_", type_);// 优惠券类型
		headIn.setField("receive_", receive_);// 优惠券接收人群
		headIn.setField("total_", total_);// 优惠券发送总数
		headIn.setField("grantdate_", grantdate_);// 优惠券可领取时间段
		headIn.setField("grantdate1_", grantdate1_);// 优惠券可领取时间段
		headIn.setField("enddate_", enddate_);// 优惠券有效使用时间
		headIn.setField("enddate1_", enddate1_);// 优惠券有效使用时间
		headIn.setField("Denomination_", Denomination_);// 优惠券面额（元）
		headIn.setField("range_", range_);// 优惠券使用范围
		headIn.setField("couponcontent_", couponcontent_);// 优惠券说明内容
		headIn.setField("imgUrl_", path);// 文章图片
		if (!svr.exec()) {
			throw new RuntimeException(svr.getMessage());
		}

		ParamUtil.addLog(this, "查询", "后台发布优惠卷", "后台发布"+Denomination_+"元优惠卷");
		return new RedirectPage(this, "FrmCouponDetails");
	}

	@Override
	public boolean logon() {
		return true;
	}
}
