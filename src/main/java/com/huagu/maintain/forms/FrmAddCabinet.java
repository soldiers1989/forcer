package com.huagu.maintain.forms;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.netbeans.lib.cvsclient.commandLine.command.add;

import com.google.gson.JsonArray;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JspPage;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class FrmAddCabinet extends AbstractForm {
	private static final Logger LOGGER = Logger.getLogger(FrmAddCabinet.class);

	/**
	 *  接收终端传入数据箱子数，并添加柜子和箱子；
	 */
	@Override
	public IPage execute() throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> data = new ArrayList<Map<String, String>>();
		Map<String, String> map = new HashMap<String, String>();
		
		String jsonString_ = this.getRequest().getParameter("jsonString_");

		LocalService svr = new LocalService(this, "SvrGetNewCount");
		// 处理文件上传
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// 设置最大缓存
		factory.setSizeThreshold(5 * 1024);
		ServletFileUpload upload = new ServletFileUpload(factory);
		// 获取所有文件列表
		List<FileItem> uploadFiles = upload.parseRequest(getRequest());
		// 取出上传的每一个文件
		for (int i = 0; i < uploadFiles.size(); i++) {
			FileItem fileItem = uploadFiles.get(i);
			if ("jsonString_".equals(fileItem.getFieldName()))
				jsonString_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
		}
		//String对象转json对象  ----> json取后转String  -----> String 再转json取值
		JSONObject json = JSONObject.fromObject(jsonString_);
		if (json.has("boxJson_")) {
			System.out.println("boxJson_:" + json.getString("boxJson_"));
			JSONObject jsons =  JSONObject.fromObject("boxJson_");
			for (int i = 0; i < jsons.size(); i++) {
				jsons.get(i);
				LocalService addBox = new LocalService(this, "SvrAddDepolyCabinetBox");
				if(!addBox.exec())
					throw new RuntimeException(addBox.getMessage());
			}
			
			
			for (int i = 1; i < json.getInt("boxJson_"); i++) {
				// 后期查询该管理员下的所有待配置柜组展示
				LocalService getDepolyCabinetInfo = new LocalService(this, "SvrAddDepolyCabinetBox");
				if(!getDepolyCabinetInfo.exec("types_", "insert"))
					throw new RuntimeException(getDepolyCabinetInfo.getMessage());
			}
		}
		return null;
	}
	
	/**
	 * 跳转待配置柜组
	 * @return
	 * @throws Exception
	 */
	public IPage deployCabinetList() throws Exception {
		return new JspPage(this, "cabinet/deployCabinetList.jsp");
	}
	
	public boolean logon() {
		return true;
	}

}
