<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${details.items.title_ }</title>
</head>
<body>
<div class="header2">
    <a href="FrmGuideList.Guide" class="prev"></a>
    <div class="head_title font18">${details.items.title_ }</div>
</div>
<div class="main_content" id="myMessage_details">
    <div id="mat"></div>
    <div class="myMessage_details">${details.items.content_ }</div>
</div>
	<%-- <%-- <p><a href="FrmGuideList.Guide">返回</a></p>
	<p>${details.items.title_ }</p>
	<p>${details.items.content_ }</p> --%> --%>
</body>
</html>