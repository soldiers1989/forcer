package com.huagu.common.ui;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import javax.servlet.http.Cookie;

import cn.cerc.jbean.form.IForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jpage.vcl.Label;

public class P002Login extends AbstractJspPage {
	private String action;
	private Label lblTitle;
	private MyTextBox txtUserName;
	private Label lblUserTip;
	private MyTextBox txtPassword;
	private LabelCheckBox chkRemember;
	private MyTextBox btnLogin;
	private Label lblForgetPassword;
	private String myCode = "";
	private String myPwd = "";

	public P002Login(IForm form) throws UnsupportedEncodingException {
		super(form);
		Cookie[] cookies = this.getRequest().getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if ("userCode_".equals(cookies[i].getName()) && cookies[i].getValue() != null) {
					myCode = URLDecoder.decode(cookies[i].getValue(),"UTF-8");
				} else if ("userPwd_".equals(cookies[i].getName()) && cookies[i].getValue() != null) {
					myPwd = cookies[i].getValue();
				}
			}
		}
		this.setJspFile("ui/P002.jsp");
		this.setAction("");
		lblTitle = new Label();
		lblTitle.setCaption("用户登录");
		add("lblTitle", lblTitle);

		txtUserName = new MyTextBox();
		txtUserName.getLabel().setCaption("账号:");
		txtUserName.setPlaceholder("请输入账号");
		txtUserName.setName("login_usr");
		txtUserName.setValue(myCode);
		add("txtUserName", txtUserName);

		txtPassword = new MyTextBox();
		txtPassword.getLabel().setCaption("密码:");
		txtPassword.setPlaceholder("请输入密码");
		txtPassword.setType(TextEnum.password);
		txtPassword.setName("login_pwd");
		txtPassword.setValue(myPwd);
		add("txtPassword", txtPassword);

		chkRemember = new LabelCheckBox();
		chkRemember.getLabel().setCaption("记住密码");
		chkRemember.setName("checkName");
		chkRemember.setValue("remember");
		if (!myPwd.equals("")) {
			chkRemember.setChecked(true);
		}
		add("chkRemember", chkRemember);

		btnLogin = new MyTextBox();
		btnLogin.setValue("登录");
		btnLogin.setType(TextEnum.submit);
		add("btnLogin", btnLogin);

		lblForgetPassword = new Label();
		lblForgetPassword.setCaption("忘记密码了?");
		add("lblForgetPassword", lblForgetPassword);
	}

	public MyTextBox getTxtUserName() {
		return txtUserName;
	}

	public Label getUserTip() {
		return lblUserTip;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public Label getTitle() {
		return lblTitle;
	}

	public LabelCheckBox getRemember() {
		return chkRemember;
	}

	public Label getForgetPassword() {
		return lblForgetPassword;
	}

	public MyTextBox getPassword() {
		return txtPassword;
	}

	public String getMyCode() {
		return myCode;
	}

	public void setMyCode(String myCode) {
		this.myCode = myCode;
	}

	public String getMyPwd() {
		return myPwd;
	}

	public void setMyPwd(String myPwd) {
		this.myPwd = myPwd;
	}

}
