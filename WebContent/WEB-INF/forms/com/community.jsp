<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>社区列表</title>
</head>
<body>
<form action="">
<p><a href="FrmCommunity.insertCommunity">添加</a></p>
	<table border="1px;">
		<tr>
			<td>序号</td>
			<td>总部</td>
			<td>省代理</td>
			<td>市代理</td>
			<td>区域代理</td>
			<td>社区名称</td>
			<td>物业名称</td>
			<td>操作</td>
		</tr>
		<c:forEach items="${coms }" var="com" varStatus="status">
		<tr>
			<td>${status.index+1 }</td>
			<td>${com.items.headquarters_ }</td>
			<td>${com.items.provinceAgent_ }</td>    
			<td>${com.items.cityAgent_ }</td>
			<td>${com.items.areaAgent_ }</td>
			<td>${com.items.communityJname_ }</td>
			<td>${com.items.wuYeName_ }</td>
			<td>
				<a href="#">变更代理挂靠</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="FrmCommunity.modifyCommunity?communityId_=${com.items.communityId_ }">变更社区名称</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="#">删除</a>
			</td>
		</tr>
		</c:forEach>
	</table>
</form>
</body>
</html>