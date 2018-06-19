package com.huagu.control.forms;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.google.gson.Gson;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jdb.core.Record;
import cn.cerc.jmis.form.AbstractForm;
import net.sf.json.JSONObject;

/**
 * 中控屏所有展示接口
 * 
 * @author xiaofei-pc
 *
 */
public class FrmControlImpl extends AbstractForm {
	public Logger log = Logger.getLogger(this.getClass());

	private String cobId_;
	private String Previous_;
	private String next_;

	@Override
	public IPage execute() throws Exception {

		return null;
	}

	// 得到当前柜子下所有箱子的信息
	public void getControlImg() throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		int count_;
		cobId_ = this.getRequest().getParameter("cobId_");
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> data = new ArrayList<Map<String, String>>();

		LocalService getAllControl = new LocalService(this, "SvrGetControl");
		if (!getAllControl.exec("cobId_", cobId_)) {
			result.put("status", "false");
			result.put("message", "查询箱子失败！");
			result.put("data", "");
		} else {
			result.put("status", "true");
			result.put("message", "查询箱子成功！");
			List<Record> list = getAllControl.getDataOut().getRecords();
			count_ = list.size() / 8;
			
			if(count_ <= 0)
				count_ = 1;
			
			if (list.size() > 0) {
				for (Record r : list) {
					Map<String, String> map = new HashMap<String, String>();
					map.put("proId_", r.getString("proId_"));
					map.put("proName_", r.getString("proName_"));
					map.put("sumMoney_", r.getString("sumMoney_"));
					map.put("dayRentMoney_", r.getString("dayRentMoney_"));
					map.put("beginTime_", r.getString("beginTime_"));
					map.put("returnTime_", r.getString("returnTime_"));
					Date begin_ = sdf.parse(r.getString("beginTime_"));
					Date returnTime_ = sdf.parse(r.getString("returnTime_"));
					map.put("dayNum_", differentDaysByMillisecond(begin_, returnTime_) + "");
					map.put("proZsImges_", r.getString("proZsImges_"));
					data.add(map);
				}
				result.put("data", data);
				result.put("count", count_);
			} else
				result.put("data", "");
		}
		log.info("获取箱子成功：" + new Gson().toJson(result));
		this.getResponse().getWriter().print(new Gson().toJson(result));
	}
	
	/**
	 * 获取柜子首页所有展示信息
	 * 1、轮播图 2、播放视频
	 * 传入 cobId_ 
	 * @throws Exception
	 * @return 轮播json 视频 json 
	 */
	public void getControlHomeImg() throws Exception {
		cobId_ = this.getRequest().getParameter("cobId_");
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> imgData = new ArrayList<Map<String, String>>();
		List<Map<String, String>> MsgData = new ArrayList<Map<String, String>>();

		LocalService getAllControl = new LocalService(this, "SvrGetControlHome");
		if (!getAllControl.exec("cobId_", cobId_)) {
			result.put("status", "false");
			result.put("message", "查询柜子基本信息失败！");
			result.put("imgData", "");
		} else {
			result.put("status", "true");
			result.put("message", "查询柜子基本信息成功！");
			List<Record> list = getAllControl.getDataOut().getRecords();
			if (list.size() > 0) {
				for (Record r : list) {
					Map<String, String> map = new HashMap<String, String>();
					map.put("UID_", r.getString("UID_"));
					map.put("id_", r.getString("id_"));
					map.put("imgPath_", r.getString("imgPath_"));
					imgData.add(map);
				}
				result.put("imgData", imgData);
			} else
				result.put("imgData", "");
		}
		
		LocalService getMsgList = new LocalService(this, "SvrGetControlMsg");
		if (!getMsgList.exec()) {
			result.put("status", "false");
			result.put("message", "查询系统公告消息失败！");
			result.put("imgData", "");
		} else {
			List<Record> list = getMsgList.getDataOut().getRecords();
			if (list.size() > 0) {
				for (Record r : list) {
					Map<String, String> map = new HashMap<String, String>();
					map.put("UID_", r.getString("UID_"));
					map.put("title_", r.getString("title_"));
					map.put("content_", r.getString("content_"));
					MsgData.add(map);
				}
				result.put("MsgData", MsgData);
			} else
				result.put("MsgData", "");
		}
		
		log.info("获取柜子基本信息成功：" + new Gson().toJson(result));
		this.getResponse().getWriter().print(new Gson().toJson(result));
	}

	/**
	 * 社区服务接口
	 * @throws Exception
	 */
	public void getShequService() throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> data = new ArrayList<Map<String, String>>();

		LocalService getAllControl = new LocalService(this, "SvrGetControlShequService");
		if (!getAllControl.exec()) {
			result.put("status", "false");
			result.put("message", "查询社区服务失败！");
			result.put("data", "");
		} else {
			result.put("status", "true");
			result.put("message", "查询社区服务成功！");
			List<Record> list = getAllControl.getDataOut().getRecords();
			if (list.size() > 0) {
				for (Record r : list) {
					Map<String, String> map = new HashMap<String, String>();
					map.put("UID_", r.getString("UID_"));
					map.put("title_", r.getString("title_"));
					map.put("content_", r.getString("content_"));
					map.put("createDate_", r.getString("createDate_"));
					map.put("Previous_", "上一篇:" + r.getString("shang_"));
					map.put("next_", "下一篇:" + r.getString("xia_"));
					data.add(map);
				}
				result.put("data", data);
			} else
				result.put("data", "");
		}
		log.info("获取社区服务信息成功：" + new Gson().toJson(result));
		this.getResponse().getWriter().print(new Gson().toJson(result));
	}
	
	/**
	 * 疑难解答接口
	 * @throws Exception
	 */
	public void getYiNanAnswer() throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> data = new ArrayList<Map<String, String>>();

		LocalService getAllControl = new LocalService(this, "SvrGetControlAnswer");
		if (!getAllControl.exec()) {
			result.put("status", "false");
			result.put("message", "查询疑难解答失败！");
			result.put("data", "");
		} else {
			result.put("status", "true");
			result.put("message", "查询疑难解答成功！");
			List<Record> list = getAllControl.getDataOut().getRecords();
			if (list.size() > 0) {
				for (Record r : list) {
					Map<String, String> map = new HashMap<String, String>();
					map.put("UID_", r.getString("UID_"));
					map.put("title_", r.getString("title_"));
					map.put("content_", r.getString("content_"));
					map.put("createDate_", r.getString("createDate_"));
					map.put("Previous_", "上一篇:" + r.getString("shang_"));
					map.put("next_", "下一篇:" + r.getString("xia_"));
					data.add(map);
				}
				result.put("data", data);
			} else
				result.put("data", "");
		}
		log.info("获取疑难解答信息成功：" + new Gson().toJson(result));
		this.getResponse().getWriter().print(new Gson().toJson(result));
	}
	
	/**
	 * 管理员登录接口
	 * @throws Exception
	 */
	public void adminLoginImpl() throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		String userName_ = this.getRequest().getParameter("userName_");
		String passWord_ = this.getRequest().getParameter("passWord_");
		
		LocalService adminLogin = new LocalService(this, "SvrControlAdminLogin");
		if (!adminLogin.exec("userName_", userName_, "passWord_", passWord_)) {
			result.put("status", "false");
			result.put("message", "身份验证失败！"+ adminLogin.getMessage());
		} else {
			result.put("status", "true");
			result.put("message", "身份验证成功！");
		}
		log.info("获取疑难解答信息成功：" + new Gson().toJson(result));
		this.getResponse().getWriter().print(new Gson().toJson(result));
	}
	
	/**
	 * 管理员登录柜子同步箱子
	 * @throws Exception
	 * @return true 同步成功   fales 同步失败
	 * 
	 */
	public void addControl() throws Exception {
		cobId_ = this.getRequest().getParameter("cobId_");
		System.err.println(cobId_);
		if("".equals(cobId_) || cobId_ == null) {
	        Date date = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
			// 柜子编码
			cobId_ = "ZNG" + sdf.format(date);
		}
		// 柜子箱子数量
		/*String labelInfo = "[{\"childAnt\":1,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":1,\"numOrder\":1,\"press\":false},{\"childAnt\":2,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":2,\"numOrder\":2,\"press\":false},{\"childAnt\":3,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":3,\"numOrder\":3,\"press\":false},{\"childAnt\":4,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":4,\"numOrder\":4,\"press\":false},{\"childAnt\":5,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":5,\"numOrder\":5,\"press\":false},{\"childAnt\":6,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":6,\"numOrder\":6,\"press\":false},{\"childAnt\":7,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":7,\"numOrder\":7,\"press\":false},{\"childAnt\":8,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":8,\"numOrder\":8,\"press\":false},{\"childAnt\":9,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":9,\"numOrder\":9,\"press\":false},{\"childAnt\":10,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":10,\"numOrder\":10,\"press\":false},{\"childAnt\":11,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":11,\"numOrder\":11,\"press\":false},{\"childAnt\":12,\"goodsLab\":\"E28011606000020715D4B37D\",\"hostAnt\":1,\"lockNumber\":12,\"numOrder\":12,\"press\":false}]";*/
		
		String labelInfo = this.getRequest().getParameter("labelInfo");
		String userCode = this.getRequest().getParameter("userCode");
				
		Map<String, Object> result = new HashMap<String, Object>();
		
		LocalService syncBox = new LocalService(this, "SvrControlSyncLabelInfo");
		if (!syncBox.exec("cabinetId", cobId_, "labelInfo", labelInfo, "userCode", userCode)) {
			result.put("status", "false");
			result.put("message", "智能柜同步失败！"+ syncBox.getMessage());
		} else {
			result.put("cobId_", cobId_);
			result.put("status", "true");
			result.put("message", "智能柜同步完毕，请关闭窗口！");
		}
		log.info("箱子信息同步成功：" + new Gson().toJson(result));
		this.getResponse().getWriter().print(new Gson().toJson(result));
	}

	/**
	 * 智能柜异常上报
	 * @throws Exception
	 * 
	 */
	public void abnormalReported() throws Exception {
		// 柜子编码
		cobId_ = this.getRequest().getParameter("cobId_");
		String boxId = this.getRequest().getParameter("boxId");
		String userCode = this.getRequest().getParameter("userCode");
		Map<String, Object> result = new HashMap<String, Object>();
		
		HashMap<String, String> hashMap = new HashMap<String, String>();
		hashMap.put("phone", userCode);
		hashMap.put("orderId", cobId_);
		hashMap.put("boxId", boxId);
		System.out.println("hashMapjson:" + JSON.toJSONString(hashMap));
		
		LocalService syncBox = new LocalService(this, "SvrSendAbnormalSMS");
		if (!syncBox.exec("mobile", userCode, "params", JSON.toJSONString(hashMap))) {
			result.put("status", "false");
			result.put("message", "异常上报失败！"+ syncBox.getMessage());
		}else {
			result.put("cobId_", cobId_);
			result.put("status", "true");
			result.put("message", "异常上报完毕，请关闭窗口！");
		}
		
		log.info("异常上报完成：" + new Gson().toJson(result));
		this.getResponse().getWriter().print(new Gson().toJson(result));
	}
	
	/**
	 * 版本更新比对接口
	 * @throws Exception
	 * @return true 成功   false 失败
	 * 
	 */
	public void versionUpdate() throws Exception {
		Map<String, Object> result = new HashMap<String, Object>();
		LocalService version = new LocalService(this, "SvrVersionUpdate");
		
		if (!version.exec()) {
			result.put("status", "false");
			result.put("message", "最新版本查询失败"+ version.getMessage());
		} else {
			result.put("versionNum_", version.getDataOut().getRecords().get(0).getString("versionNum_"));
			result.put("versionFile_", version.getDataOut().getRecords().get(0).getString("versionFile_"));
			result.put("status", "true");
			result.put("message", "最新版本查询成功");
		}
		log.info("箱子信息同步成功：" + new Gson().toJson(result));
		this.getResponse().getWriter().print(new Gson().toJson(result));
	}
	
	/**
	 * 通过时间秒毫秒数判断两个时间的间隔
	 * 
	 * @param date1
	 * @param date2
	 * @return
	 */
	public static int differentDaysByMillisecond(Date date1, Date date2) {
		int days = (int) ((date2.getTime() - date1.getTime()) / (1000 * 3600 * 24));
		return days;
	}

	public static void main(String[] args) throws Exception {
		FrmControlImpl i = new FrmControlImpl();
		i.addControl();
	}
	
	@Override
	public boolean logon() {
		return true;
	}
}
