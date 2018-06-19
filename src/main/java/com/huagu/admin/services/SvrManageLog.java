package com.huagu.admin.services;

import java.net.InetAddress;
import java.net.UnknownHostException;
import javax.servlet.http.HttpServletRequest;
import com.huagu.common.global.appdb;
import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.TDateTime;
import cn.cerc.jdb.mysql.SqlQuery;

/**
 * 后台日志添加
 * @author xiaofei-pc
 *
 */
public class SvrManageLog extends AbstractService {
	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut){
		try {
			InetAddress res = InetAddress.getLocalHost();
			SqlQuery ds = new SqlQuery(handle);
			ds.setMaximum(0);
			ds.add("select operateData_,operateUser_,corpNo_,operateType_,operate_,operateAdress_ from %s", appdb.MANAGE_LOGS);
			ds.append();
			ds.setField("operateData_", TDateTime.Now());
			ds.setField("operateUser_", getUserCode());
			ds.setField("corpNo_", getCorpNo());
			ds.setField("operateType_", dataIn.getHead().getSafeString("operateType_"));//操作类型
			ds.setField("operate_", dataIn.getHead().getSafeString("operate_"));//操作
			ds.setField("operateAdress_",  res.getHostAddress());
			ds.setField("operateDetail_", dataIn.getHead().getSafeString("operateDetail_"));//操作详情
			ds.post();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
		return success();
	}
	
	public static IStatus execute1(Object...objects) throws ServiceException{
		return null;
	}
	
	public String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}
}
