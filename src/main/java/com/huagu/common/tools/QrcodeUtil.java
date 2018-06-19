package com.huagu.common.tools;

import java.io.IOException;
import java.io.OutputStream;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jmis.form.AbstractForm;

/**
 *  @describe 二维码生成工具类
 *  @author 王姣
 *  @date   2018年3月12日上午10:56:21
 *  @return
 */
public class QrcodeUtil extends AbstractForm {

	private static int width = 100;
	private static int height = 100;
	private static String content = "----------------------------";
	private static String format = "png";
	
	/**
	 * 根据流将生成的二维码传递出去
	 * @param width
	 * 					二维码宽度
	 * @param height
	 * 					二维码高度
	 * @param content
	 * 					二维码内容
	 * @param os
	 * 					文件输出流
	 */
	public static void createStreamQrcode(int width, int height, String content, OutputStream os) {
		try {
			if (width <= 0) {
				width = QrcodeUtil.width;
			}
			if (height <= 0) {
				height = QrcodeUtil.height;
			}
			if (content == null || "".equals(content)) {
				content = QrcodeUtil.content;
			}
			content = new String(content.getBytes("UTF-8"), "ISO-8859-1");
			BitMatrix bm = new MultiFormatWriter().encode(content, BarcodeFormat.QR_CODE, width, height);
			MatrixToImageWriter.writeToStream(bm, format, os);
			os.close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if (os != null) {
					os.flush();
					os.close();
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/**
	 * 得到二维码
	 */
	public IPage execute() throws Exception {
		// TODO Auto-generated method stub
		String width = this.getRequest().getParameter("width");
		String height = this.getRequest().getParameter("height");
		String content = this.getRequest().getParameter("content");
		if (width == null || "".equals(width)) {
			width = "200";
		}
		if (height == null || "".equals(height)) {
			height = "200";
		}
		if (!content.contains("http://")) {
		   content = "http://" + new ServerConfig().getProperty("app.rootSite") + "/forms/" + content;
		}
		QrcodeUtil.createStreamQrcode(Integer.parseInt(width), Integer.parseInt(height), content, this.getResponse().getOutputStream());
		return null;
	}

}
