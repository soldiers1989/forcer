<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="head1.jspf"%>
<div class="bartop min-bg" id="header">
	<div class="wrap">
		<h1 class="title">修改密码</h1>
		<div class="head-men">
			<a href="javascript:;"><i class="icon"><img
					src="${cdn }/admin/images/icon/icon_head.png" width="14"
					height="14"> </i></a> <a href="javascript:;" class="name">${jspFile.handle.handle.params.UserCode }</a>|
			<a href="javascript:Loginexit();">退出</a>
		</div>
	</div>
</div>
<div class="forget-box">
	<form id="formid" action="FrmEditPhonePaswd.editPwd">
		<h3 class="min-col f16 mb_10">修改密码</h3>
		<div class="mid-keytext" id="test" style="">
			<div class="mb_20 mt_20">
				<span class="lf-box">旧密码:</span> <input id="oldpwd" name="oldpwd" type="password"  class="text " placeholder="请输入您的旧密码">
			</div>
			<div class="mb_20 mt_20">
				<span class="lf-box">新密码:</span> <input id="newpwd1" type="password"  class="text " placeholder="请输入您的新密码">
			</div>
			<div class="mb_20 mt_20">
				<span class="lf-box">确认新密码:</span> <input id="newpwd" name="newpwd" type="password"  class="text " placeholder="确认您的新密码">
			</div>
			<div class="sumb mt_20 pt_20 btn">
				<input type="button" onclick = "checkUser()" class="for-btns" value="确定" style="display:inline-block;width:120px">
				<input type="button" onclick="javascript:window.history.go(-1);" class="for-btns" value="取消" style="display:inline-block;width:120px">
			</div>
		</div>
	</form>
</div>
<script src="${cdn}/admin/js/alertMsg.js"></script>
<script>
function checkUser(){
	var oldpwd = $("#oldpwd").val(), newpwd1 = $("#newpwd1").val(),newpwd = $("#newpwd").val();
	if(!oldpwd){ 
		alertMsg("请输入密码"); 
		return false;
	}
	if(!newpwd1){
		alertMsg("请输入新密码"); 
		return false;
	}
	if(newpwd1.length<8){
		alertMsg("密码长度为8-16位"); 
		return false;
	}
	if(!newpwd){
		alertMsg("请再次输入新密码"); 
		return false;
	}
	if(newpwd1 != newpwd){
		alertMsg("两次密码输入不一致"); 
		return false;
	}
	document.getElementById("formid").submit();
	alertMsg("密码修改成功"); 
}

</script>
</body>
</html>