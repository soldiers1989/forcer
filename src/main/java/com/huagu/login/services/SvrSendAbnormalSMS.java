package com.huagu.login.services;

import com.huagu.common.aliyun.send.SingleSendSms;
import com.huagu.common.util.RandomGeneratorUtil;

import cn.cerc.jbean.core.AbstractService;
import cn.cerc.jbean.core.DataValidateException;
import cn.cerc.jbean.core.IStatus;
import cn.cerc.jbean.core.ServerConfig;
import cn.cerc.jbean.core.ServiceException;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jdb.core.DataSet;
import cn.cerc.jdb.core.IHandle;
import cn.cerc.jdb.core.Record;

/**
 * 发送异常上报短信
 * 
 * @author lxf
 * @time 2017-11-20 14:12
 */
public class SvrSendAbnormalSMS extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		DataValidateException.stopRun("参数错误", !headIn.hasValue("mobile"));
		String mobile = headIn.getSafeString("mobile");
		String params = headIn.getSafeString("params");
		/*String phone = headIn.getSafeString("phone");
		String orderId = headIn.getSafeString("orderId");
		String boxId = headIn.getSafeString("boxId");*/
		SingleSendSms sms = new SingleSendSms(new ServerConfig());

		sms.setTEMPLATE_CODE("SMS_136871218");

		boolean ok = false;
		try {
			ok = sms.sendMsgs(mobile, params, "SMS_136871218");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (ok) {
			return success("发送成功");
		}
		
		return fail("网络超时");
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}

}
