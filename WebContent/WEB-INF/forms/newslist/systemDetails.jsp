<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@include file="../jspf/head1.jspf"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
            <li>
                    <div class="font15 myMessage_title"> ${values.items.title_}</div>
                    <div class="font12 text-gray"><fmt:formatDate value="${values.items.sendTime_ }" type="date" pattern="yyyy-MM-dd HH:mm:ss"/></div>  
                     <div class="font15 myMessage_title"> ${values.items.content_}</div>
            </li>
    </ul>
</div>
</body>
</html>