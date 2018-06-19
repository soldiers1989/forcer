<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起享</title>
</head>
<body>
疑难解答
    <table width="1000" border="5" cellspacing="5" cellpadding="5">
<tr>
    <th>序号</th>
     <th>标题</th>
      <th>内容</th>
       <th>时间</th>
        <th>操作</th>
</tr>
<c:if test="${empty values}"><img src="../../img/zwsj.png"></c:if>
            <c:if test="${not empty values}">
<c:forEach items="${values }" var="value" varStatus="status">
<tr>
    <td>${ status.index + 1}</td>
    <td>${value.items.title_}</td>
     <td>${value.items.content_ }</td>
    <td>${value.items.date_}</td>
    <td><a href="FrmTroubleshooting.gotoUpTroubleshooting?id_=${value.items.id_}">修改</a>
    <a href="FrmTroubleshooting.gotoAddTroubleshooting">增加</a>
    | <%-- <a href="FrmTroubleshooting.delTroubleshooting?id_=${value.items.id_}">删除</a> --%>
    <a href="javascript:if(confirm('您确定刪除吗?'))location='FrmTroubleshooting.delTroubleshooting?id_=${value.items.id_}';">删除</a>
    </td>
</tr>
</c:forEach>
</c:if>
</table>
</body>
</html>