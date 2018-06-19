<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../jspf/head1.jspf"%>
<style>
.verificationCode{
	float: right;
    padding-right: .17rem;
    height: 98%;
}
</style>
	<script>
	function getPhoneCode() {
		var str = /^1[34578]\d{9}$/;
		var obj1 = $("span.set_btn.ok");
		var obj2 = $("span.set_btn.no");
		var phoneNumber = $('#login_usr').val();
		var code=document.getElementsByClassName("verificationCode")[0];

		if (phoneNumber == null || phoneNumber == '') {
			alert("请输入手机号");
			code.removeAttribute("onclick");
			return false;
		} else if (!str.test(phoneNumber)) {
			alert("您输入的手机号有误");
			return false;

		} else {
			$.ajax({
				url : 'FrmSendValidateCode.ajaxSendH5',
				data : {
					"mobile" : phoneNumber,
					"checkType" : "exist"
				},
				timeout : 4000,
				dataType : 'json',
				type : 'get',
				cache : false,
				async : false,
				success : function(data) {
					if (data == true || data == "true") {
						sendemail();
					} else {
						alert("网络异常");
					}
				},
				error : function() {
					alert("网络异常");
				}
			});
		}

	};
	
	function clickSetTime(obj1, obj2){
		var countdown=59;
		obj1.hide();
		obj2.show();
		var timer=setInterval(function(){
			if(countdown==0){
				obj1.show();
				obj2.hide();
				countdown=59;
				clearInterval(timer);
			}else{
				obj1.hide();
				obj2.show();
				obj2.find('strong').html(countdown);
				countdown--;
			}
		},1000)
		
	};
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

	if (browser.versions.weixin) {
		//后台获取静默跳转链接，请求获取code，重新执行登录
		$.ajax({
			type : "GET",
			url : "FrmWeixin.anewLogin",
			dataType : "json",
			async : false,
			success : function(loginUrl) {
				if (loginUrl) {
					window.location.href = loginUrl;
				}
			}
		});
	}else if (!(browser.versions.mobile || browser.versions.android
			|| browser.versions.ios || browser.versions.iPad || browser.versions.weixin)) {
		//不是移动端,跳转后台登录Form
		var loginMsg = "${loginMsg}";
		if (loginMsg != '') {
			window.location.href = "FrmAdminLogin?loginMsg=" + loginMsg;
		} else {
			window.location.href = "FrmAdminLogin";
		}
	}/* else if((browser.versions.mobile || browser.versions.android
			|| browser.versions.ios || browser.versions.iPad)){
		var local=window.location.pathname;//获取缓存失效时的forms
		var str=local.split("forms/");
		 if(window.localStorage['CorpNo_']=='727111'){
			 window.localStorage.removeItem("local");  
			window.localStorage['local']=str[1];
			window.location.href = "LoginTech";
		} 
		
	} */

	function login() {
		var phnoeNub = $("#login_usr").val();
		var password = $("input[name='login_pwd']").val();
		var isCheckBox = document.getElementById("checkBox").checked;

		if (phnoeNub == "") {
			alert("请输入手机号");
			return;
		}
		if (password == "") {
			alert("请输入验证码");
			return;
		}
		if(!isCheckBox){
			alert("请先阅读《用户租赁协议》");
			return;
		}
		$.get("FrmLogin.checkCode", {
			"mobile" : phnoeNub,
			"CorpNo_" : "727000",
			"password" : password
		}, function(resp) {
			if (resp && resp == true) {
				window.localStorage['LoginName'] = $("#login_usr").val(); 
				if ("${qrcodeIn}" == "true") {
					window.location.href="FrmLogin?userPhone="+phnoeNub+"&userId="+'${userId}';
				} else {
					$("#form").submit();					
				}
				/* alert("登录成功！"); */
				
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

		$("#register").on("click", function() {
			window.location.href = "FrmPhoneRegistered";
		});
	});
	
	var countdown=60; 
	function sendemail(){
		var obj1 = $("span.ok");
		var obj2 = $("span.no");
		var countdown=59;
		obj1.hide();
		obj2.show();
		var timer=setInterval(function(){
			if(countdown==0){
				obj1.show();
				obj2.hide();
				countdown=59;
				clearInterval(timer);
			}else{
				obj1.hide();
				obj2.show();
				obj2.find('strong').html(countdown);
				countdown--;
			}
		},1000);
	}
</script>
	<div class="main_content" id="login_content">
    <div class="logo">
        <img src="${cdn }/img/logo.png" alt="">
    </div>
    <form method="post" id="form" class="loginMessage" action="FrmLogin.userLogin">
        <div class='ipt phone'>
            <img alt="" src="${cdn }/img/phone.png">
           <!--  <input type="text" class="phoneNum" name="login_usr" placeholder="请输入账号"> -->
            <input class="input phoneNum" type="number" id="login_usr" name="login_usr" maxlength="11" placeholder="请输入账号" onkeyup="if(value.length>11)value=value.slice(0,11)"/>
			<input type="hidden" value="${users}" name="users" id ="users">
        </div>
        <div class='ipt password mt_15'>
            <img alt="" src="${cdn }/img/verification.png">
            <!-- <input type="text" class="phoneNum" name="login_pwd" placeholder="请输入密码"> -->
            <input class="input code phoneNum" type="password" id="login_pwd" name="login_pwd" maxlength="12" placeholder="请输入验证码" style="width: 47%;"/>
            <div class="verificationCode">
				<span id="getCode" class="yanzhenma set_btn ok text-danger" onclick="getPhoneCode();">验证码</span> 
				<span id="getCode" class="yanzhenma set_btn no text-danger" style="display: none"><strong>60</strong>秒后重新发送</span>
			</div>
        </div>
        <div class="agreement">
           <%--  <img src="${cdn }/img/checkedA.png" alt="">  --%>
           <%--  <img src="${cdn }/img/checkedB.png" alt="" class="listImg"> --%>
            <input type="checkbox" checked="checked" id="checkBox">
            <span class="font11"><!-- 阅读 -->登录即同意</span>
            <span class="text-danger font11"><a href="FrmViewProtocol.Protocolcontent?type_=5">《用户租赁协议》</a></span>
        </div>
        <div class="btn">
            <input type="button" onclick="login();" class="submit list_btn" value="登录" style="margin: .34rem 7.5% .17rem;width:85%;">
        </div>
        <!-- <div class="otherOperations flexLayout">
            <a class="rightNow font12" href="#">立即注册</a>
            <a class="forget font12 text-gold" href="#">忘记密码？</a>
        </div> -->
    </form>
    </div>
	<%-- <div style="text-align: center; padding-top: 2em;">
		<div>一启享 欢迎登录.</div><br/><br/>
		<form method="post" id="form">
			<input class="input" type="number" id="login_usr" name="login_usr" maxlength="11" placeholder="请输入账号"
						onkeyup="if(value.length>11)value=value.slice(0,11)" />
						<input type="hidden" value="${users}" name="users" id ="users"> 
			<br/>
			<input class="input code" type="password" id="login_pwd" name="login_pwd" maxlength="12" placeholder="请输入验证码" />
			<div class="verificationCode">
				<span id="getCode" class="yanzhenma set_btn ok" onclick="getPhoneCode();">验证码</span> 
				<span id="getCode" class="yanzhenma set_btn no" style="display: none"><em>60</em>秒后重新发送</span>
			</div>
			<input type="hidden" value="727000" name="CorpNo_" id="CorpNo_">
			<span class="submit" onclick="login();">登录</span>
		</form>
	</div> --%>