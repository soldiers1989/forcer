package com.huagu.maintain.forms;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.lang3.tuple.MutablePair;
import org.apache.commons.lang3.tuple.Pair;
import org.apache.log4j.Logger;

import com.huagu.common.util.HttpClientUtil;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jdb.oss.OssSession;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;
import cn.cerc.jmis.page.RedirectPage;
import cn.jiguang.common.utils.StringUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class FrmMyCabinet extends AbstractForm {
	private static final String KEY = "9cf7f413ad4b10941a4f2e78b25f52de";
	private static final String OUTPUT = "JSON";
	private static final String GET_LNG_LAT_URL = "http://restapi.amap.com/v3/geocode/geo";

	private static final Logger LOGGER = Logger.getLogger(FrmMyCabinet.class);

	/**
	 * 运维端-运维人员自己柜组展示
	 */
	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "cabinet/myCabinet.jsp");
		LocalService getUserCabinet = new LocalService(this, "SvrMyCabinet");
		if(!getUserCabinet.exec())
			throw new RuntimeException(getUserCabinet.getMessage());
		
		page.add("cabinet", getUserCabinet.getDataOut().getRecords());
		return page;
	}
	
	/**
	 * 跳转待配置柜组
	 * @return
	 * @throws Exception
	 */
	public IPage deployCabinetList() throws Exception {
		JspPage page = new JspPage(this, "cabinet/deployCabinetList.jsp");
		// 后期查询该管理员下的所有待配置柜组展示
		LocalService getUserCabinet = new LocalService(this, "SvrMyCabinet");
		if(!getUserCabinet.exec())
			throw new RuntimeException(getUserCabinet.getMessage());
		
		page.add("cabinet", getUserCabinet.getDataOut().getRecords());
		return page;
	}
	
	/**
	 * 配置柜组
	 * @return
	 * @throws Exception
	 */
	public IPage deployCabinet() throws Exception {
		JspPage page = new JspPage(this, "cabinet/deployCabinet.jsp");
		String id = this.getRequest().getParameter("id");
		// 后期查询该管理员下的所有待配置柜组展示
		LocalService getDepolyCabinetInfo = new LocalService(this, "SvrDepolyCabinet");
		if(!getDepolyCabinetInfo.exec("id_", id))
			throw new RuntimeException(getDepolyCabinetInfo.getMessage());
		
		// 查询该柜子下有多少箱子
		LocalService getBox = new LocalService(this, "SvrGetCabinetBox");
		if(!getBox.exec("id_",id))
			throw new RuntimeException(getBox.getMessage());

		page.add("boxCount", getBox.getDataOut().getRecords());
		page.add("cabinet", getDepolyCabinetInfo.getDataOut().getCurrent());
		return page;
	}
	
	/**
	 * 柜组物品
	 * @return
	 * @throws Exception
	 */
	public IPage cabinetrRes() throws Exception {
		JspPage page = new JspPage(this, "cabinet/cabinetRes.jsp");
		String id_ = this.getRequest().getParameter("id_");
		
		// 查询该柜子下有多少箱子
		LocalService getBox = new LocalService(this, "SvrGetCabinetPzBox");
		if(!getBox.exec("id_", id_))
			throw new RuntimeException(getBox.getMessage());

		page.add("boxCount", getBox.getDataOut().getRecords());
		page.add("id_", this.getRequest().getParameter("id_"));
		return page;
	}
	
	/**
	 * 配置新增柜组箱子
	 * @return
	 * @throws Exception
	 */
	public IPage addDeployCabinetBox() throws Exception {
		/*JspPage page = new JspPage(this, "cabinet/deployCabinet.jsp");*/
		JsonPage json = new JsonPage();
		
		String id_ = this.getRequest().getParameter("id_");  //添加箱子所属的柜子ID
		String num_ = this.getRequest().getParameter("num_"); //添加箱子的编号
		String type_ = this.getRequest().getParameter("type_"); //添加箱子的类型
		String size_ = this.getRequest().getParameter("size_"); //添加箱子的大小
		String managerId_ = this.getRequest().getParameter("managerId_"); //添加箱子的管理员
		
		// 后期查询该管理员下的所有待配置柜组展示
		LocalService getDepolyCabinetInfo = new LocalService(this, "SvrAddDepolyCabinetBox");
		if(!getDepolyCabinetInfo.exec("id_", id_, "num_", num_, "type_", type_, "size_", size_, "managerId_",managerId_))
			throw new RuntimeException(getDepolyCabinetInfo.getMessage());
		
		json.setData("true");
		return json;
	}
	
	/**
	 * 测试坐标范围
	 * @param address
	 * @return
	 */
	public static Pair getLngLatFromOneAddr(String address) {
		if (StringUtils.isEmpty(address)) {
			LOGGER.error("地址（" + address + "）为null或者空");
			return null;
		}
		Map params = new HashMap();
		params.put("address", address);
		params.put("output", OUTPUT);
		params.put("key", KEY);
		String result = HttpClientUtil.doPost(GET_LNG_LAT_URL, params);
		Pair pair = null;
		JSONObject jsonObject = JSONObject.fromObject(result);
		// 拿到返回报文的status值，高德的该接口返回值有两个：0-请求失败，1-请求成功；
		int status = Integer.valueOf(jsonObject.getString("status"));
		if (status == 1) {
			JSONArray jsonArray = jsonObject.getJSONArray("geocodes");
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject json = jsonArray.getJSONObject(i);
				String lngLat = json.getString("location");
				String[] lngLatArr = lngLat.split(",");
				// 经度
				BigDecimal longitude = new BigDecimal(lngLatArr[0]);
				// System.out.println("经度" + longitude);
				// 纬度
				BigDecimal latitude = new BigDecimal(lngLatArr[1]);
				// System.out.println("纬度" + latitude);
				pair = new MutablePair(longitude, latitude);
			}
		} else {
			String errorMsg = jsonObject.getString("info");
			LOGGER.error("地址（" + address + "）" + errorMsg);
		}
		LOGGER.info("地址经纬度坐标为：" + pair);
		return pair;
	}
	
	/**
	 *   查询在租订单
	 *  @author wj  
	 *  @date 2018年6月6日  
	 */  
	public IPage onRentingOrders() throws Exception{
		JspPage jsp = new JspPage(this, "cabinet/rentorders.jsp");
		LocalService svr = new LocalService(this, "SvrQueryRentigOrders");
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		jsp.add("rentOrders", svr.getDataOut().getRecords());
		return jsp;
	}
	
	/***
	 *  转赔付页面
	 *  @author wj  
	 *  @date 2018年6月6日
	 */
	public IPage toIndemnity() throws Exception{
		JspPage jsp = new JspPage(this , "cabinet/toIndemnity.jsp");
		LocalService svr = new LocalService(this ,"SvrGetRemrOrder");
		Record head = svr.getDataIn().getHead();
		head.setField("orderId_", this.getRequest().getParameter("orderId_"));
		if(!svr.exec()){
			throw new RuntimeException(svr.getMessage());
		}
		jsp.add("rent", svr.getDataOut().getCurrent());
		return jsp;
	}
	
	/**
	 *   转赔付
	 *  @author wj  
	 *  @date 2018年6月6日
	 */
	public IPage addIndemnity() throws Exception{
		String payDesc_ = this.getRequest().getParameter("payDesc_"); 
		String orderId_ = this.getRequest().getParameter("orderId_"); 
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
				if ("payDesc_".equals(fileItem.getFieldName()))
					payDesc_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
				if ("orderId_".equals(fileItem.getFieldName()))
					orderId_ = new String(fileItem.getString().getBytes("ISO-8859-1"), "UTF-8");
			}
		}
		ServerConfig config = new ServerConfig();
		String path = "http://" + config.getProperty("oss.bucket") + "." + config.getProperty("oss.endpoint") + "/"
				+ fileKey;
		if (fileKey == null) {
			path = "";
		}
		LocalService svr = new LocalService(this, "SvrAddIndemuity");
		Record headIn = svr.getDataIn().getHead();
		headIn.setField("payDesc_", payDesc_);
		headIn.setField("orderId_", orderId_);
		headIn.setField("path", path);
		if (!svr.exec()) {
			throw new RuntimeException();
		}
		return new RedirectPage(this, "FrmMyCabinet.onRentingOrders");
	}

	public static void main(String[] args) {
		Pair pair = getLngLatFromOneAddr("广东省深圳市宝安区西乡街道金海路金港华庭");
		System.out.println(pair);
	}

	public boolean logon() {
		return true;
	}

}
