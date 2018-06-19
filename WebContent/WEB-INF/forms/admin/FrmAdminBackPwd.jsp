<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@include file="../jspf/head1.jspf"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" type="text/css" href="/admin/css/base.css">
<link rel="stylesheet" type="text/css" href="/admin/css/style.css">
<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
<script src="/admin/js/base.js"></script>
<script type="text/javascript" src="/admin/My97DatePicker/WdatePicker.js"></script><link href="http://localhost:8080/admin/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/admin/js/ajaxfileupload.js"></script>
<title>忘记密码-后台</title>
<style type="text/css">
html{
	background:url("/admin/images/icon-admin-ibg2.png") repeat;
}
body{
	background:url("/admin/images/icon-adming-ibg.png") center bottom no-repeat;
	background-size:100% auto;
}
.login-ground{
	background:url("/admin/images/icon-admin-Ibg.png") left top no-repeat;
}
li{
	list-style: none;
	margin-bottom: 15px;
}
input[type="text"],input[type="number"],input[type="tel"],input[type="password"] {
    width: 235px;
    height: 30px;
    margin-left: 5px;
    line-height: 30px;
    color: #666;
    text-indent: 10px;
    border: 1px solid #e6e6e6;
    -webkit-border-radius: 3px;
    -moz-border-radius: 3px;
    border-radius: 3px;
    outline: none;
    background: #fff;
}
#form{
	width: 350px;
    padding: 40px;
    background: white;
    -webkit-border-radius: 8px;
    box-shadow: 0px 0px 28px #ccc;
    -webkit-box-shadow: 0px 0px 28px #ccc;
    position: absolute;
    left: 64%;
    top: 25%;
}
#getCode{
	display: inline-block;
	margin-left: 10px;
    background-color: #48b3bd;
    padding: 5px;
    border-radius: 4px;
    color: white;
}
input[type="button"]{
	display: inline-block;
    background-color: #48b3bd;
    padding: 5px 10px;
    border-radius: 4px;
    color: white;
    border: 0;
    font-size: 14px;
}
</style>
</head>

<body>




<script type="text/javascript">

function getPhoneCode(){
	var obj1 = $("span.set_btn.ok");
	var obj2 = $("span.set_btn.no");
	var phoneNumber = $.trim($('#phoneNumber').val());
	var str = /^1[34578]\d{9}$/;console.log(phoneNumber)
	if(!phoneNumber){
		alert("请输入您的手机号");
		return false;
	}
	if(!(str.test(phoneNumber))){
		alert("您输入的手机号有误");
		return false;
		
	}else{
		$.ajax({
			url: '/forms/sendValidateCode.ajaxSend/',
			data:{"mobile":phoneNumber,"checkType":"exist"},
			timeout: 4000,
			dataType: 'json',
			type: 'get',
			cache: false,
			async:false,
			success: function (data) {
				if(data == true || data == 'true'){
					clickSetTime(obj1, obj2);
				}else{
					alert(data);	
				}
	        },
			error: function() {
				alert("网络异常");
			}
		});
	}
}
	
function findBackPassword(){
	var phoneNumber = $.trim($('#phoneNumber').val());
	var code = $('#code').val();
	var passWord = $.trim($('#passWord').val());
	var passWords = $.trim($('#passWords').val());
	var username = $.trim($('#username').val());
	var pattern=/^[a-zA-Z0-9]{6,12}$/;
	if(phoneNumber == null || phoneNumber == ''){
		alert("请输入手机号");
		return;
	}
	if(passWord == null || passWord == ''){
		alert("请输入密码");
		return;
	}else if(!pattern.test(passWord)){
		alert("密码为6-12位数字或字母或字母+数字组合");
		return;
	}
	if(passWords == null || passWords == ''){
		alert("请输入密码");
		return;
	}else if(!pattern.test(passWords)){
		alert("密码为6-12位数字或字母或字母+数字组合");
		return;
	}
	if(passWord != passWords){
		alert("两次密码输入不一致");
		return;
	}
	
	if(code == null || code == ''){
		alert("请输入验证码");
		return;
	}
	$.ajax({
		url: "/forms/FrmLossPassword.ajaxBackPwd",
		timeout: 4000,
		dataType: 'json',
		type: 'get',
		cache: false,
		data:{phoneNumber:phoneNumber,passWord:passWord,code:code,username:username},
		success: function (data) { 
			alert(data.msg)
			if(data.msg == "找回密码成功"){
				//成功之后跳转到首页
				setTimeout('window.location.href = "/forms/FrmAdminLogin"',2000);
			}
			
        },
		error: function() {
			alert("网络异常");
		}
	}); 
}
</script>

<%-- <c:if test="${sessionScope.device == 'weixin' }">
	<header id="header">
		<a href="javascript:;"><img
			src="${cdn}/img/icon/icon_arrow_left.png" class="arrow-left"></a>
		<h1 class="title">忘记密码</h1>
	</header>
</c:if> --%>
<div class="bartop min-bg" id="header" style="background: #f2f2f2">
    <div class="wrap">
		<h1 class="title" style="color:#48b2bd">一启享后台管理平台</h1>
	</div>
</div>
<div class="login-ground"> 
	<div class="head">
	    	<a class="fl" href="javascript:history.go(-1);"><img src="/img/prev2.png" style="height: 40px;"></a>
	    	<!-- <a href="javascript:void(0)" class="fr">youjian</a> -->
	    </div>
	    <div class="hg_43"></div>
	     <div class="hg_10"></div>
	<div class=" main_con setCode <c:if test="${ sessionScope.device != 'weixin'}">mtop0</c:if>">
		<form action="FrmModifyUserPassword.finish" method="post" id="form">
			<ul class=" cf listtw1-2-1">
				<li class="ph"><input autocomplete="off"
					type="text" id="username" name="username" placeholder="请输入用户名" maxlength="16" />
				</li>
				<li class="ph"><input autocomplete="off"
					type="number" id="phoneNumber" name="phoneNumber" placeholder="请输入手机号"
					maxlength="11"  oninput="if(value.length>11)value=value.slice(0,11)" /></li>
				<li class="code_con cf">
					<input type="tel" name="code" autocomplete="off" maxlength="6" id="code" 
					placeholder="请输入验证码" /> <span id="getCode"   onclick="getPhoneCode()" class="set_btn ok">获取验证码</span> 
				</li>
				<li class="ph"><input autocomplete="off"
					type="password" id="passWord" name="passWord" placeholder="请输入新密码" maxlength="12" />
				</li>
				<li class="ph"> <input autocomplete="off"
					type="password" id="passWords" name="passWords" placeholder="请输入新密码" maxlength="12" />
				</li>
			</ul>
			<section class="Card-buttom mr_10">
				<input type="button" class="button btn1" onclick="findBackPassword();" value=" 确认">
			</section>
		</form>
	</div>
</div>
 </body>
</html>
