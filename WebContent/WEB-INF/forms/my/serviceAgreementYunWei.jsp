<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
     <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>服务协议（运维端）</title>
</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">服务协议</div>
</div>
<div class="main_content" id="maintenance_service">
    <div id="mat"></div>
    <c:if test="${empty values}"><img src="../../img/zwsj.png"></c:if>
    <c:if test="${not empty values}"></c:if>
    <div class="maintenance_service_title font17">《运维服务协议》</div>
    <c:forEach items="${values }" var="value" varStatus="status">
        <div class="maintenance_service_content">${value.items.content_ }</div>
    </c:forEach>
</div>
<%-- 服务协议
<c:forEach items="${values }" var="value" varStatus="status">
<a href="javascript:history.back(-1)">返回</a>
    内容${value.items.content_ }
</c:forEach> --%>
</body>
</html>