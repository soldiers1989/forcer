<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起享受</title>
</head>
<body>

<form action="FrmTroubleshooting.upTroubleshooting?${values.items.id_}" method="post" >
 <input type="text" name="title_" value="${values.items.title_}">
    <input type="text" name="content_" value="${values.items.content_}">
    <input type="hidden" name="id_" value="${values.items.id_}">
    <input type="submit" value="修改" >
</form>

</body>
</html>