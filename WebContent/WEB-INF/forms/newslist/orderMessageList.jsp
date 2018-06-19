<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消息管理</title>
<style type="text/css">
.noMess{
	height: 7rem;
    padding: .51rem 0;
    background-image: url(../../img/zwsj.png);
    background-position: center 1.5rem;
    background-repeat: no-repeat;
}
</style>
</head>
<body>
<!-- 消息列表 -->
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">消息列表</div>
</div>
<div class="main_content" id="myMessage_list">
    <div id="mat"></div>
     <c:if test="${empty values}"><!-- <img src="../../img/zwsj.png"> -->
    	<div class="noMess"></div>
    </c:if>
    <ul class="myMessage_list">
    <c:if test="${not empty values}">
        <c:forEach items="${values }" var="value" varStatus="status">
            <li>
                    <div class="font15 myMessage_title"> ${value.items.content_}
                    <c:if test="${value.items.status_ == 1}">订单无效</c:if>
                    <c:if test="${value.items.status_ == 0}">订单有效</c:if></div>
                    <div class="font12 text-gray">${value.items.sendTime_ }</div>    
                   <!-- 订单状态：0 是  有效 ，1 是   无效 -->
            </li>
        </c:forEach>
        </c:if>
    </ul>
</div>
</body>
</html>