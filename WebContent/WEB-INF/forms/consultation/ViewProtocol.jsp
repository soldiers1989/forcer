<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
</head>
<body>
	<div class="header2">
		<a href="javascript:history.go(-1);" class="prev"></a>
		<div class="head_title font18">
			<c:if test="${values.items.type_ ==1 }">使用流程</c:if>
			<c:if test="${values.items.type_ ==2 }">商务合作说明</c:if>
			<c:if test="${values.items.type_ ==3 }">联系客服</c:if>
			<c:if test="${values.items.type_ ==4 }">关于我们</c:if>
			<c:if test="${values.items.type_ ==5 }">用户租赁</c:if>
			<c:if test="${values.items.type_ ==6 }">运维服务</c:if>
			<c:if test="${values.items.type_ ==7 }">银行卡绑定</c:if>
			<c:if test="${values.items.type_ ==8 }">积分规则说明</c:if>
			<c:if test="${values.items.type_ ==9 }">公益捐款说明</c:if>
			<c:if test="${values.items.type_ ==10 }">优惠券使用规则</c:if>
			<c:if test="${values.items.type_ ==11 }">签到规则</c:if>
			<c:if test="${values.items.type_ ==12 }">用户等级规则说明</c:if>
			<c:if test="${values.items.type_ ==13 }">快递至启享柜说明</c:if>
			<c:if test="${values.items.type_ ==14 }">芝麻信用减免规则说明</c:if>
			<c:if test="${values.items.type_ ==15 }">活体影像减免规则说明</c:if>
			<c:if test="${values.items.type_ ==16 }">手机号减免押金规则说明</c:if>
			<c:if test="${values.items.type_ ==17 }">邀请好友规则说明</c:if>
		</div>
	</div>
	<!-- 公益捐赠 -->
	<div class="main_content" id="benefit_donate">
	    <div id="mat"></div>
	    <c:if test="${empty values}"><img src="../../img/zwsj.png"></c:if>
        <c:if test="${not empty values}"></c:if>
	    <input type="hidden" name="type_" value="${values.items.type_ }">
		<p>
		<label>${values.items.content_ }</label>
	</p>
	</div>
	<%-- <br>
	<input type="hidden" name="type_" value="${values.items.type_ }">
	<p>
		<label>${values.items.content_ }</label>
	</p> --%>
</body>
</html>