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
	<form id="formid" action="FrmForgetPassword.step3">
		<h3 class="min-col f16 mb_10">重置密码</h3>
		<div class="tip">
			<ul>
				<li class="curr"><i class="one icon"></i>
					<p>验证身份</p></li>
				<li class="tc curr "><i class="two icon"></i>
					<p>重置密码</p></li>
				<li class="tr "><i class="over icon"></i>
					<p>完成</p></li>
			</ul>
		</div>
		<div class="mid-keytext" id="test" style="">
			<div class="mb_20 mt_20">
				<span class="lf-box">新密码:</span> <input  name="newPassword" id="newPassword" type="password" class="text " placeholder="请输入您的新密码">
			</div>
			<div class="mb_20 mt_20">
				<span class="lf-box">确认密码:</span> <input  id="repeatPassword" type="password"  class="text " placeholder="请再次输入您的新密码">
			</div>
			
			<div class="sumb mt_20 pt_20 btn">
				<input type="button" onclick = "checkUser()" class="for-btns" value="确定">
			</div>
			<div class="tr mt_20" style="padding-right: 100px">
				已有账号?<a href="FrmAdminLogin" class="min-col">登录></a>
			</div>
		</div>
	</form>
</div>
<script src="${cdn}/admin/js/alertMsg.js"></script>
<script>
function checkUser(){
	var pass1 = $("input#newPassword").val(),pass2=$("input#repeatPassword").val();
	if(!pass1 || !pass2){ 
		alertMsg("请输入密码"); 
		return false;
	}
	if(pass1!=pass2){
		alertMsg("密码输入不一致");
		return false;
	}
	if(pass1.length<8 || pass2.length<8){
		alertMsg("密码长度为8-16位");
		return false;
	}
	document.getElementById("formid").submit();
}
</script>
</body>
</html>