<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<form name="form" method="post" action="FrmGuideList.selArcitle">
		<p>文章标题:&nbsp;&nbsp;&nbsp;<label>${values.items.title_}</label></p>
		<p>文章内容:&nbsp;&nbsp;&nbsp;<label>${values.items.content_ }</label></p>
		<p><a href="FrmGuideList">返回</a></p>
	</form>
</body>
</html>