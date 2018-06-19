<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    <%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>签到说明</title>
</head>
<body>
<form action="FrmSign.editSignExplain">
	<table border="1px;ss">
		<tr>
			<td>序号</td>
			<td>修改时间</td>
			<td>说明内容</td>
			<td>操作</td>
		</tr>
		<tr>
			<td>1</td>
			<td>
				<fmt:formatDate value="${explains.items.updateTime_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
			</td>
			<td>${explains.items.remark_ }</td>
			<td><a href="FrmSign.editSignExplain?UID_=${explains.items.UID_ }">编辑</a></td>
		</tr>
	</table>
	</form>
</body>
</html>