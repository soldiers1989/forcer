<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<head>
<body>

<form name="form" method="post" action="FrmGuideList.addGuide" >
		<p><input type="hidden" value="in" name="in"></p>
		<p>文章标题&nbsp;&nbsp;&nbsp;<input type="text"  name="title" /></p>
		<p>文章内容&nbsp;&nbsp;&nbsp;
		<textarea id="textname" rows="10" cols="30"
			style="overflow: scroll:overflow-x:hidden" name="content" ></textarea></p>
		<input type="submit" value="添加">&nbsp;&nbsp;&nbsp;&nbsp;
	</form>
</body>
</html>