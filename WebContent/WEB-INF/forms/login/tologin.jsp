<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../jspf/head1.jspf"%>
<style>
.verificationCode {
	float: right;
	padding-right: .17rem;
	height: 98%;
}
</style>
<script>
	var browser = {
		versions : function() {
			var u = navigator.userAgent, app = navigator.appVersion;
			return {
				trident : u.indexOf('Trident') > -1, //IE内核
				presto : u.indexOf('Presto') > -1, //opera内核
				webKit : u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
				gecko : u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1,//火狐内核
				mobile : !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端
				ios : !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
				android : u.indexOf('Android') > -1 || u.indexOf('Adr') > -1, //android终端
				iPhone : u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
				iPad : u.indexOf('iPad') > -1, //是否iPad
				webApp : u.indexOf('Safari') == -1, //是否web应该程序，没有头部与底部
				weixin : u.indexOf('MicroMessenger') > -1, //是否微信 （2015-01-22新增）
				qq : u.match(/\sQQ/i) == " qq" //是否QQ
			};
		}(),
		language : (navigator.browserLanguage || navigator.language)
				.toLowerCase()
	}

	if (!(browser.versions.mobile || browser.versions.android
			|| browser.versions.ios || browser.versions.iPad || browser.versions.weixin)) {
		//不是移动端,跳转后台登录Form
		var loginMsg = "${loginMsg}";
		if (loginMsg != '') {
			window.location.href = "FrmAdminLogin?loginMsg=" + loginMsg;
		} else {
			window.location.href = "FrmAdminLogin";
		}
	} else if ((browser.versions.mobile || browser.versions.android
			|| browser.versions.ios || browser.versions.iPad)) {
		var local = window.location.pathname;//获取缓存失效时的forms
		var str = local.split("forms/");
		if (window.localStorage['CorpNo_'] == '727111') {
			window.localStorage.removeItem("local");
			window.localStorage['local'] = str[1];
			window.location.href = "LoginTech";
		}

	}

	function login() {
		var phnoeNub = $("#login_usr").val();
		var password = $("#login_pwd").val();
		var isCheckBox = document.getElementById("checkBox").checked;

		if (phnoeNub == "") {
			alert("请输入手机号");
			return;
		}
		if (password == "") {
			alert("请输入密码");
			return;
		}
		if(!isCheckBox){
			alert("请先阅读《运维服务协议》");
			return;
		}
		$.get("FrmLogin.checkCode", {
			"mobile" : phnoeNub,
			"CorpNo_" : "727111",
			"password" : password
		}, function(resp) {
			if (resp && resp == true) {
				alert("验证成功，登录中...");
				window.localStorage['LoginName'] = $("#login_usr").val();
				$("#form").submit();
			} else {
				alert(resp);
			}
		}, "json");
	}
	$(function() {
		var logmsg = '${requestScope.loginMsg }';
		if (logmsg && logmsg != '') {
			if (logmsg == '账户禁用') {
				$("#msg").text("您的账户已经被禁用,请拨打客户电话400-888-3198咨询")

			} else {
				alert(logmsg);
			}
		}
		
		/*  点击忘记密码按钮，此功能后期可能不要 */
		$("#register").on("click", function() {
			window.location.href = "FrmPhoneRegistered";
		});
	});
</script>
<div class="main_content" id="login_content">
	<div class="logo">
		<img src="${cdn }/img/logo.png" alt="">
	</div>
	<form method="post" id="form" class="loginMessage" action="FrmLogin.toLogin">
		<div class='ipt phone'>
			<img alt="" src="${cdn }/img/phone.png"> <input
				class="input phoneNum" type="text" id="login_usr" name="userName_"
				maxlength="11" placeholder="请输入账号"
				onkeyup="if(value.length>11)value=value.slice(0,11)" /> <input
				type="hidden" value="${users}" name="users" id="users">
		</div>
		<div class='ipt password mt_15'>
			<img alt="" src="${cdn }/img/verification.png"> <input
				class="input code phoneNum" type="password" id="login_pwd"
				name="password_" maxlength="12" placeholder="请输入密码" />
		</div>
		<div class="agreement">
			<%-- <img src="${cdn }/img/checkedA.png" alt=""> <img
				src="${cdn }/img/checkedB.png" alt="" class="listImg"> --%>
				 <input type="checkbox" checked="checked" id="checkBox">
				 <span class="font11">登录即表示阅读并同意</span> <span class="text-danger font11"><a href="FrmViewProtocol.Protocolcontent?type_=6">《运维服务协议》</a></span>
		</div>
		<div class="btn">
			<input type="button" onclick="login();" class="submit list_btn"
				value="登录" style="margin: .34rem 7.5% .17rem; width: 85%;">
		</div>
	<!-- 	<a href="">忘记密码？</a> -->
	</form>
</div>