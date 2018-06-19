<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="head1.jspf"%>
<div class="bartop min-bg" id="header">
	<div class="wrap">
		<h1 class="title">百姓健康信息服务平台</h1>
		<div class="head-men">
			<a href="javascript:;"><i class="icon"><img
					src="${cdn }/admin/images/icon/icon_head.png" width="14"
					height="14"> </i></a> <a href="javascript:;" class="name">${jspFile.handle.handle.params.UserCode }</a>|
			<a href="javascript:Loginexit();">退出</a>
		</div>
	</div>
</div>
<div class="forget-box">
	<form action="FrmForgetPassword.confirmValidate" method="post" id="formid">
		<h3 class="min-col f16 mb_10">重置密码</h3>
		<div class="tip">
			<ul>
				<li class="curr"><i class="one icon"></i>
					<p>验证身份</p></li>
				<li class="tc "><i class="two icon"></i>
					<p>重置密码</p></li>
				<li class="tr "><i class="over icon"></i>
					<p>完成</p></li>
			</ul>
		</div>
		<div class="mid-keytext" id="test" >
			<div class="mb_20 mt_20">
				<span class="lf-box">用户名:</span> 
				<input  name="userName" id="userName" class="text " placeholder="请输入用户名">
			</div>
			<div>
                <span class="lf-box">手机验证码</span>
                <input name="validateCode" id="validateCode"  type="text" class="text wt-168" placeholder="输入验证码">
                <input  class="min-col get-scroe" onclick="getValidate()" type="button" id="btn" value="获得验证码" />
            </div>
			<div class="sumb mt_20 pt_20 btn">
				<input type="button" onclick="checkUser()" class="for-btns" value="立即提交">
			</div>
			<div class="tr mt_20" style="padding-right: 100px">
				已有账号?<a href="FrmAdminLogin" class="min-col"> 登录></a>
			</div>
		</div>
	</form>
</div>
<script src="${cdn}/admin/js/alertMsg.js"></script>
<script type="text/javascript">
function getValidate(){
	var _this = $(this);
	var userName = $('#userName').val();
	var phonetest = /^1\d{10}$/;
	if(!userName){
		alertMsg("请输入你的用户名");
		return false;
	}
	$.ajax({
		url: 'FrmForgetPassword.getValidateByUserName',
		dataType: 'json',
		type: 'post',
		cache: false,
		data: {userName:userName},
		success: function (data) {
			getPassCode(document.getElementById("btn"))
        },
		error: function() {
			alertMsg("网络异常");
		}
	});
}
//倒计时
var wait=60; 
function getPassCode(o) {  
       if (wait == 0) {  
           o.removeAttribute("disabled");      
           o.style.cursor = "pointer";
           o.value="获得验证码";  
           wait = 60;  
       } else {  
           o.setAttribute("disabled", true);
           o.style.cursor = "no-drop";
           o.value="重新发送(" + wait + ")";  
           wait--;  
           setTimeout(function() {  
        	   getPassCode(o)  
           },  
           1000)  
       }  
} 


function checkUser(){
	var userName = $("input#userName").val(),code=$("input#validateCode").val();
	if(!userName){ 
		alertMsg("请输入用户名"); 
		return false;
	}
	if(!code){
		alertMsg("请输入验证码");
		return false;
	}
	document.getElementById("formid").submit();
}

</script>
</body>
</html>