<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@include file="../jspf/head1.jspf"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>提示</title>

<link rel="stylesheet" type="text/css" href="${cdn}/css/base.css"/>
<link rel="stylesheet" type="text/css" href="${cdn}/css/public.css"/>
<link rel="stylesheet" href="${cdn}/font-awesome/css/font-awesome.min.css" />

<script type="text/javascript" src="${cdn}/js/fastclick.js"></script>
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/js/rem.js" ></script>
<script type="text/javascript" src="${cdn}/js/public.js"></script>
<script type="text/javascript">
/* 解决移动端点击事件延迟300ms */
$(function() {  
    FastClick.attach(document.body);  
    $("header img.arrow-left").on("click", function() {
    	ReturnBtnClick();
	});
});
function ReturnBtnClick(){
	var parentPage = '${jspPage.form.menu.params.parentId }';
	window.location.href =(parentPage&&parentPage!="hidden")?parentPage:"javascript:window.location.history.go(-1)";
}
</script>
<link rel="stylesheet" type="text/css"
	href="${cdn }/css/FrmHealthMessage/FrmHealthMessage.css">

<style>
section {
	text-align: center;
	margin-top: 1rem;
}

section img {
	width: 2.8rem;
	margin: 0 auto;
	margin-top:
}

section p {
	text-align: center;
	margin-top: 0.2rem;
	color: #999;
}
</style>

<%@include file="../jspf/head2.jspf"%>
<c:if test="${sessionScope.device == 'weixin' }">
	<header id="header">
		<a><img src="${cdn }/img/icon/icon_arrow_left.png"
			class="arrow-left"></a>
		<h1 class="title">网络异常，请稍后重试</h1>
	</header>
</c:if>
<div
	class="main_con <c:if test="${ sessionScope.device != 'weixin'}">mtop0</c:if>">
	<section>
		<img src="${cdn}/img/small/error.png" />
		<p>出错了</p>
	</section>
</div>
</body>
</html>