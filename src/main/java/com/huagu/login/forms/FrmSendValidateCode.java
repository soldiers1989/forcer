package com.huagu.login.forms;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

import cn.cerc.jbean.client.LocalService;
import cn.cerc.jbean.form.IPage;
import cn.cerc.jbean.other.BufferType;
import cn.cerc.jbean.other.MemoryBuffer;
import cn.cerc.jmis.form.AbstractForm;
import cn.cerc.jmis.page.JsonPage;
import cn.cerc.jmis.page.JspPage;

/**
 * 
 * @ClassName: SendValidateCode
 * @Description: 发送验证码
 * @author lxf
 * @date 2017年11月14日 下午16:34
 *
 */
public class FrmSendValidateCode extends AbstractForm {

	@Override
	public IPage execute() throws Exception {
		JspPage page = new JspPage(this, "public/send_validatecode.jsp");
		HttpServletRequest requets = this.getRequest();

		// 验证码验证通过后的URL
		page.add("url", requets.getParameter("url"));
		page.add("head", requets.getParameter("head"));
		page.add("sid", requets.getSession().getId());
		page.add("mobile", requets.getParameter("mobile"));
		page.add("money", requets.getParameter("money"));
		if (StringUtils.isNoneBlank(requets.getParameter("isChild")))
			try (MemoryBuffer buffer = new MemoryBuffer(BufferType.getGrid, "isChild")) {
				buffer.setField("isChild", requets.getParameter("isChild"));
			}
		return page;
	}

	/**
	 * H5页面发送验证码
	 * 
	 * @return
	 */
	/* 通过控制器查找SessionId,再发送验证码 */
	public IPage ajaxSendH5() throws Exception {
		JsonPage page = new JsonPage(this);
		LocalService svr = null;
		// 手机号
		String mobile = this.getRequest().getParameter("mobile");
		// 发送验证码类型
		String checkType = this.getRequest().getParameter("checkType");

		// 创建一个本地发送验证码服务
		if ((!StringUtils.isEmpty(checkType))) {
			svr = new LocalService(this, "SendValidateCodeService");
			if (!svr.exec("mobile", mobile)) {
				page.setData(svr.getMessage());
				return page;
			}
			page.setData(true);
			return page;
		}

		return page;
	}

	public IPage checkCode() {
		JsonPage page = new JsonPage(this);
		// 创建一个本地验证验证码服务
		HttpServletRequest requets = this.getRequest();
		LocalService svr = new LocalService(this, "CheckValidateCodeService");
		if (!svr.exec("sid", requets.getSession().getId(), "mobile", requets.getParameter("mobile"), "code",
				requets.getParameter("code"))) {
			page.setData("验证码错误");
			return page;
		}
		page.setData(true);
		return page;
	}

	@Override
	public boolean logon() {
		return true;
	}
}
