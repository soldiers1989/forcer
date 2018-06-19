<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@include file="../jspf/head1.jspf"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消息管理</title>
</head>
<body>
<!-- 消息列表 -->
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">消息列表</div>
</div>
<div class="main_content" id="myMessage_list">
    <div id="mat"></div>
    <ul class="myMessage_list">
        <c:forEach items="${values }" var="value" varStatus="status">
            <li>
                <a id="id_" href="FrmNewslistYunWei.detail?id_=${value.items.id_}">
                    <div class="font15 myMessage_title"> ${value.items.title_}</div>
                    <div class="font12 text-gray">${value.items.sendTime_ }</div>    
                </a>
            </li>
        </c:forEach>
    </ul>
</div>
    <c:if test="${empty values}"><img src="../../img/zwsj.png"></c:if>
    <c:if test="${not empty values}"></c:if>
<c:forEach items="${values }" var="value" varStatus="status">
 发送人：${value.items.sender_}  
 消息类型： ${value.items.sendOb_ } 
  消息标题： ${value.items.title_ } 
 消息内容：${value.items.content_}  
 发送时间：${value.items.sendTime_ } 
<a id="id_" href="FrmNewslistYunWei.detail?id_=${value.items.id_}">详情</a><br> 
</c:forEach>
</body>
</html>