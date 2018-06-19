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
 * 发送手机验证码
 * 
 * @author lxf
 * @time 2017-11-20 14:12
 */
public class SvrSendValidateCode extends AbstractService {

	@Override
	public IStatus execute(DataSet dataIn, DataSet dataOut) throws ServiceException {
		Record headIn = dataIn.getHead();
		DataValidateException.stopRun("参数错误", !headIn.hasValue("mobile"));
		String mobile = headIn.getSafeString("mobile");
		String code_ = RandomGeneratorUtil.createRandomNum(6);
		SingleSendSms sms = new SingleSendSms(new ServerConfig());

		sms.setTEMPLATE_CODE("SMS_127153250");// 修改手机号

		boolean ok = false;
		try {
			ok = sms.sendMsgs(mobile, "{'code':'" + code_ + "'}", "SMS_127153250");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/* 重新获取验证码时，清除之前的验证码 */
		try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, mobile, "code_")) {
			buff.clear();
		}
		if (ok) {
			try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, mobile, "code_")) {
				buff.setField("code_", code_);
				System.out.println("发送验证码："+ code_);
			}
			try (MemoryBuffer buff = new MemoryBuffer(BufferType.getExportKey, mobile, "code_")) {
				String codes_ = (String) buff.getField("code_");
				System.out.println("获取验证码：" + codes_);
			}
			
			return success("发送成功");
		}
			// mobile,sessionId,code 入库
		/*	SqlQuery sqlQuery = new SqlQuery(this);
			sqlQuery.add("select UID_,sessionId_,mobile_,sendTime_,code_,corpNo_,status_ from %s",
					appdb.get(this, appdb.MOBILE_CODE));
			sqlQuery.open();
			sqlQuery.append();
			sqlQuery.setField("sessionId_", headIn.getSafeString("sid"));
			sqlQuery.setField("mobile_", mobile);
			sqlQuery.setField("code_", code);
			sqlQuery.setField("sendTime_", new Date()); sqlQuery.post();
		 */
		return fail("网络超时");
	}

	@Override
	public boolean checkSecurity(IHandle handle) {
		return true;
	}

}
