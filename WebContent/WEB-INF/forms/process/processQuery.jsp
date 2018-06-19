<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>使用流程</title>
</head>
<body>
	<form action="">
		<table>
			<tr>
				<td>序号</td>
				<td>修改时间</td>
				<td>使用流程</td>
				<td>操作</td>
			</tr>
			<tr>
				<td>1</td>
				<td>
					<fmt:formatDate value="${process.items.updateDate_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>${process.items.content_ }</td>
				<td>
					<a href="FrmUseProcess.processDetails?UID_=${process.items.UID_ }">查看</a>&nbsp;&nbsp;&nbsp;
					<a href="FrmUseProcess.processModify?UID_=${process.items.UID_ }">修改</a>
				</td>
			</tr>	
		</table>
	</form>
</body>
</html>