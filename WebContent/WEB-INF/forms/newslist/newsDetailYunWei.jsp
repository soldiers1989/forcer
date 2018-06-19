<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消息详情</title>
</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">消息详情</div>
</div>
<div class="main_content" id="myMessage_details">
    <div id="mat"></div>
    <c:forEach items="${values }" var="value" varStatus="status">
        <div class="myMessage_details">${value.items.title_}<br/>${value.items.content_}</div>
    </c:forEach>
</div>

<%-- 消息详情
<c:forEach items="${values }" var="value" varStatus="status">
    ${value.items.content_}
</c:forEach> --%>
</body>
</html>