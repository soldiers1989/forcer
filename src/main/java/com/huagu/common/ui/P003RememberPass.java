package com.huagu.common.ui;

import cn.cerc.jbean.form.IForm;
import cn.cerc.jmis.page.AbstractJspPage;
import cn.cerc.jpage.vcl.Label;

/**
 * 忘记密码模板
 * 
 * @author rick_zhou
 * @date 2016年11月10日 上午10:31:43
 */
public class P003RememberPass extends AbstractJspPage {
	private String title;
	/* 步骤 */
	private Label lblStep1;
	private Label lblStep2;
	private Label lblStep3;
	/* 验证身份 */
	private MyTextBox txtAuthentication;
	private MyTextBox txtVerification;
	private Label lblVerification;
	/* 重置密码 */
	private MyTextBox txtReSetPassword;
	private MyTextBox txtNewReSetPassword;
	/* 完成 */
	private Label lblSubject;
	private Label lblSubjectInfo;
	/* 登录 */
	private UrlButton btnLogin; 
	private Label lblLoginTip;
	private Label lblLogin;

	public P003RememberPass(IForm form) {
		super(form);
		this.setJspFile("ui/P003.jsp");
		title = "重置密码";
		this.add("title", title);
		lblStep1 = new Label("验证身份");
		this.add("lblStep1", lblStep1);

		lblStep2 = new Label("重置密码");
		this.add("lblStep2", lblStep2);

		lblStep3 = new Label("完成");
		this.add("lblStep3", lblStep3);

	}

	/**
	 * 设置头部步骤条
	 * 
	 * @author rick_zhou
	 * @param nowStep
	 *            当前步骤,只能是1/2/3
	 */
	public void setNowStep(int nowStep) {
		this.add("nowStep", nowStep);
		if (nowStep == 1) {// 验证身份
			txtAuthentication = new MyTextBox();
			txtAuthentication.getLabel().setCaption("用户名:");
			txtAuthentication.setId("userName");
			txtAuthentication.setName("userName");
			txtAuthentication.setPlaceholder("请输入用户名");
			this.add("txtAuthentication", txtAuthentication);

			txtVerification = new MyTextBox();
			txtVerification.getLabel().setCaption("手机验证码:");
			txtVerification.setId("mobileCode");
			txtVerification.setName("mobileCode");
			txtVerification.setPlaceholder("请输入手机收到的验证码");
			this.add("txtVerification", txtVerification);

			lblVerification = new Label("获取验证码");
			this.add("lblVerification", lblVerification);

			btnLogin =  new UrlButton();
			btnLogin.setId("btnLogin");
			btnLogin.setName("btnLogin");
			btnLogin.setValue("立即提交");
			this.add("btnLogin", btnLogin);
			
			lblLoginTip = new Label("已有账号?");
			this.add("lblLoginTip", lblLoginTip);
			lblLogin = new Label("登录", "#");
			this.add("lblLogin", lblLogin);
			return;
		}
		if (nowStep == 2) {// 重置密码
			txtReSetPassword = new MyTextBox();
			txtReSetPassword.getLabel().setCaption("新密码:");
			txtReSetPassword.setId("password");
			txtReSetPassword.setName("password");
			txtReSetPassword.setPlaceholder("请输入新密码");
			this.add("txtReSetPassword", txtReSetPassword);

			txtNewReSetPassword = new MyTextBox();
			txtNewReSetPassword.getLabel().setCaption("新密码:");
			txtNewReSetPassword.setId("newPassword");
			txtNewReSetPassword.setName("newPassword");
			txtNewReSetPassword.setPlaceholder("请再次输入您的密码");
			this.add("txtNewReSetPassword", txtNewReSetPassword);

			btnLogin =  new UrlButton();
			btnLogin.setId("btnLogin");
			btnLogin.setName("btnLogin");
			btnLogin.setValue("提交");
			this.add("btnLogin", btnLogin);

			lblLoginTip = new Label("已有账号?");
			this.add("lblLoginTip", lblLoginTip);
			lblLogin = new Label("登录", "#");
			this.add("lblLogin", lblLogin);

			return;
		}
		if (nowStep == 3) {// 完成
			lblSubject = new Label("尊敬的用户:");
			this.add("lblSubject", lblSubject);

			lblSubjectInfo = new Label("密码重置成功,请使用新的密码");
			this.add("lblSubjectInfo", lblSubjectInfo);

			lblLogin = new Label("登录", "#");
			this.add("lblLogin", lblLogin);
			return;
		}
		throw new RuntimeException("nowStep 只能是1或2或3");
	}

	public String getTitle() {
		return title;
	}

	public Label getStep1() {
		return lblStep1;
	}

	public Label getStep2() {
		return lblStep2;
	}

	public Label getStep3() {
		return lblStep3;
	}

	public MyTextBox getAuthentication() {
		return txtAuthentication;
	}

	public MyTextBox getTxtVerification() {
		return txtVerification;
	}

	public Label getLblVerification() {
		return lblVerification;
	}

	public MyTextBox getReSetPassword() {
		return txtReSetPassword;
	}

	public MyTextBox getNewReSetPassword() {
		return txtNewReSetPassword;
	}

	public Label getSubject() {
		return lblSubject;
	}

	public Label getSubjectInfo() {
		return lblSubjectInfo;
	}

	public UrlButton getBtnLogin() {
		return btnLogin;
	}

	public Label getLoginTip() {
		return lblLoginTip;
	}

	public Label getLogin() {
		return lblLogin;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}
