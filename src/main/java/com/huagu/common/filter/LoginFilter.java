package com.huagu.common.filter;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.huagu.common.util.LoginUtil;

import cn.cerc.jbean.core.AppConfig;
import cn.cerc.jbean.core.Application;
import cn.cerc.jbean.form.IForm;
import cn.cerc.jmis.core.ClientDevice;
import cn.cerc.jmis.core.RequestData;

public class LoginFilter implements Filter {
	private Logger log = Logger.getLogger(LoginFilter.class);

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;
		try {
			String childCode = getRequestForm(req);
			String formId = childCode.split("\\.")[0];
			IForm form = Application.getForm(req, resp, formId);

			ClientDevice info = new ClientDevice(form);
			log.info("device:" + info.getDevice() + "====sId:" + info.getSid());
			
			// 需要验证登录的页面
			if (form != null && !form.logon()) {
				String userCode = (String) req.getSession().getAttribute("userCode");
				boolean result = LoginUtil.vaildateLogin(userCode, req.getSession());
				if (!result) {
					req.getSession().setAttribute(RequestData.appSession_Key, null);
					resp.sendRedirect("FrmLogin?loginMsg=" + URLEncoder.encode("该账号在其他设备上进行了登录", "utf-8"));
					return;
				}
			} else if ("FrmLogin".equals(formId)) {
				String loginMsg = req.getParameter("loginMsg");
				if (StringUtils.isNotEmpty(loginMsg)) {
					req.setAttribute("loginMsg", URLDecoder.decode(loginMsg, "utf-8"));
				}
			}
		} catch (Exception e) {
		}

		chain.doFilter(req, resp);
	}

	private String getRequestForm(HttpServletRequest req) {
		String url = null;
		String args[] = req.getServletPath().split("/");
		if (args.length == 2 || args.length == 3) {
			if (args[0].equals("") && !args[1].equals("")) {
				if (args.length == 3)
					url = args[2];
				else {
					String sid = (String) req.getAttribute(RequestData.appSession_Key);
					AppConfig conf = Application.getConfig();
					if (sid != null && !"".equals(sid))
						url = conf.getFormDefault();
					else
						url = conf.getFormWelcome();
				}
			}
		}
		return url;
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
	}

	@Override
	public void destroy() {
	}

}
