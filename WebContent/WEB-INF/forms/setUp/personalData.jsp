<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
     <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人资料</title>
</head>
<body>
<div class="header2">
    <a href="javascript:history.back(-1)" class="prev"></a>
    <div class="head_title font18">个人资料</div>
</div>
<div class="main_content" id="personlData">
	 <div id="mat"></div>
     <c:if test="${empty values}"><img src="../../img/zwsj.png"></c:if>
     <c:if test="${not empty values}"></c:if>
  <%--   <c:forEach items="${values }" var="value" varStatus="status"> --%>
        <div class="flexLayout personlData_img border_b">
            <div class="list_left font15">头像：</div>
            <div class="list_right"><img alt="" src="${values.items.imgUrl_}"></div>
        </div>
        <div class="flexLayout personlData_number border_b">
            <div class="list_left font15">手机号：</div>
            <div class="list_right">
            ${values.items.mobile_}</div>
        </div>
        <div class="flexLayout personlData_level border_0">
            <div class="list_left font15">会员等级：</div>
            <div class="list_right">${empty values.items.userVIP_ ? "V2" : "V${values.items.userVIP_}"}</div>
        </div>
   <%--  </c:forEach> --%>
</div>
<%-- <a href="javascript:history.back(-1)">返回</a>
<c:forEach items="${values }" var="value" varStatus="status">
    <P>头像:${value.items.imgUrl_}</P>
    <P>手机号:${value.items.mobile_}</P>
    <P>会员等级:${value.items.userVIP_}</P>
    </c:forEach> --%>
</body>
</html>