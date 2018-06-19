<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../jspf/head1.jspf"%>
<link rel="stylesheet" type="text/css" href="${cdn}/forms/jui/phone/phone-block.css" />
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/forms/jui/phone/phone-block.js"></script>
<style>
body{
	background: #fff;
}
.accout_con .item {
	background: #fff;
	border-bottom: 1px solid #e6e6e6;
	padding: .625em;
}

.accout_con .item:last-child {
	border: 0;
}

.accout_con .item span {
	display: inline-block;
	width: 30%;
	color: #666;
}

.accout_con .item .modifily {
	float: right;
	background: #48b2bd;
	color: #fff;
	padding: 0 3px;
	font-size: .875em;
	border-radius: 3px;
	-webkit-border-radius: 3px;
}

.coumt_btn {
	padding: 0 .625em;
	margin-top: 3.25em;
}

.coumt_btn .btn {
	background: #48b2bd;
	text-align: center;
	width: 100%;
	padding: .875em 0;
	outline: none;
	border: 0;
	color: #fff;
}

.login-box li {
 	position: relative;
    padding: 0 .625em;
    padding-left: 2.38em;
    background: #fff;
    border-bottom: 1px solid #e6e6e6;
    border-top: 1px solid #e6e6e6;
}

.login-box li:nth-of-type(2){
 	position: relative;
    padding: 0 .625em;
    padding-left: 0.625em;
    background: #fff;
    border-top: 0px;
}

.login-box li img {
	position: absolute;
    left: .625em;
    top: 50%;
    width: 1em;
    transform: translateY(-50%);
    -webkit-transform: translateY(-50%);
}

.login-box ul{
	overflow: hidden;
}

.login-box li input {
	width: 100%;
	outline: none;
	height:3.5em;
	background: #fff;
	font-size: .875em;
	cursor: pointer; 
	-webkit-appearance: none; 
}

.login-box li.code {
	padding-right: 6.25em;
}

.login-box li.code .code-btn {
	display: inline-block;
	width: 6.25em;
	position: absolute;
	top: 0;
	right: 0;
	height: 100%;
	background: #48b2bd;
	color: #fff;
	font-size: .875em;
	cursor: pointer; 
	-webkit-appearance: none; 
}
</style>
<%@include file="../jspf/head2.jspf"%>
<body>
	<div class="main" style="margin-top:0em;top:0em" >
		<form action="FrmBindPhone" id="LoginFrm" method="post" >
		<input type="hidden" value="${openid }" name="openid">
			<div class="login-box">
				<ul>
					<li><img src="${cdn}/img/icon/icon_phone.png"> <input
						type="number" name="phone" id="txtPhone" placeholder="请输入手机号"></li>
					<li class="code"><%-- <img src="${cdn}/img/icon/icon_psw.png"> --%>
						<input type="text" name="code" id="txtCode" placeholder="请输入验证码"> <input
						type="button" class="code-btn" id="btn" value="获取验证码"></li>
				</ul>
			</div>
			<div class="coumt_btn">
				<input type="button" onclick="toVaild()" class="btn" value="绑定">
			</div>
		</form>
	</div>
	<script>
		//倒计时
		var wait = 60;
		function getPassCode(o) {
			if (wait == 0) {
				o.removeAttribute("disabled");
				o.style.cursor = "pointer";
				o.style.background = "#48b2bd";
				o.value = "获得验证码";
				wait = 60;
			} else {
				o.setAttribute("disabled", true);
				o.style.cursor = "no-drop";
				o.style.background = "#ccc";
				o.value = "重新发送" + wait;
				wait--;
				setTimeout(function() {
					getPassCode(o)
				}, 1000)
			}
		}
		document.getElementById("btn").onclick = function() {
			var phone=$("#txtPhone").val();
			if(!phone){
				winBox("请输入手机号！");
				return false;
			}
			$.ajax({
				type: 'get',
				url: 'sendValidateCode.ajaxSend',
				data:{"mobile" : phone,"checkType":"register"},
				cache: false,
				async:false,
				dataType: 'json',
				success: function(resp) {
					if (resp && resp == true) {
						getPassCode(document.getElementById("btn"));
					} else if(resp=="您输入的手机号码已注册，请登录！"){
						winBox("此手机号已被其它用户绑定!");
					}else{
						winBox("发送失败!");
					}
				}
			})
		}
		$(function(){
			var msg='${message}';
			if(msg)winBox(msg);
		})
		function toVaild(){
			var phone=$("#txtPhone").val();
			var code=$("#txtCode").val();
			if(!phone){
				winBox("请输入手机号！");
				return false;
			}
			if(!code){
				winBox("请输入验证码！");
				return false;
			}
			$.ajax({
				type: 'get',
				url: 'sendValidateCode.checkCode',
				data:{"mobile" : phone,"code":code},
				cache: false,
				async:false,
				dataType: 'json',
				success: function(resp) {
					if (resp && resp == true) {
						$("#LoginFrm").submit();
					} else {
						winBox("验证码错误!");
					}
				}
			})
		}
	</script>
</body>
</html>