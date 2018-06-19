<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="head1.jspf"%>
    <div class="bartop min-bg" id="header" style="background: #f2f2f2">
    	<div class="wrap">
	        <h1 class="title" style="color:#48b2bd">一启享后台管理平台</h1>
	        <div class="head-men" style="display: none">
	            <a href="javascript:;"><i class="icon"><img src="${cdn }/admin/images/icon/icon_head.png" width="14" height="14"> </i></a>
	            <a href="javascript:;" class="name">${jspFile.handle.handle.params.UserCode }</a>|
	            <c:if test="${jspFile.handle.handle.params.UserCode == null }"><a href="#">登录</a></c:if>
	            <c:if test="${jspFile.handle.handle.params.UserCode != null  }"> <a href="javascript:Loginexit();">退出</a></c:if>
	        </div>
        </div>
    </div>
<style>
html{
	background:url("${cdn}/admin/images/icon-admin-ibg2.png") repeat;
}
body{
	background:url("${cdn}/admin/images/icon-adming-Ibg.png") center bottom no-repeat;
}
.login-ground{
	background:url("${cdn}/admin/images/icon-admin-Ibg.png") left top no-repeat;
}
.cb input{
	margin-left:5px;
}
.cb{
	padding-right:15px;
}
</style>
<div class="login-ground">
	<div class="wrap clear ">
		<div class="login-box  fr">
			<form id="loginForm" action="FrmAdminLogin" method="post">
			<input type="hidden" id="loginType" name="loginType" value="common">
				<h3 class="til min-col f16 mb_20">${lblTitle}</h3>
				<div class="init-box">
					${txtUserName}
				</div>
				<p class="f12 cl-999 ml_20 pl_20 mb_10 pt_10">${lblUserTip}</p>
				<div class="init-box">
					${txtPassword}
				</div>
				<div class="tr pt_10 f12 pb_20 cb">
					${chkRemember}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="FrmForgetPassword">${lblForgetPassword}</a>
				</div>
				<c:if test="${loginMess != null}">
					<div class="tr f12 pb_20" style="color:red;">
						${loginMess }
					</div>
				</c:if>
				<div class="btn pt_10">
					${btnLogin}
				</div>
				<!-- <div class="tc pt_20" >
					<a href="javascript:firstLogin();" class="f16 cl-333">首次登录</a>
				</div>  -->
			</form>
		</div>
	</div>
</div>
 
<script>
	$(function(){
		var obj ={
				form:$("#loginForm"),
				fristLogin:$("#fristLogin"),
				loginType:$("#loginType")
		}
		
		obj.fristLogin.on("click",function(){
			
			obj.loginType.prop("value","fr");
			obj.form.submit();
		});
	});
	
	function firstLogin(){
		$("#loginType").val("first");
		$("#loginForm").submit();
	}
</script>
</body>
</html>