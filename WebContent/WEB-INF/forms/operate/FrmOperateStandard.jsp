<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>模板列表</title>
<style>
	.tableWidth{
		width:10%;
	}
</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">运维模板</span>
    </div>
	<form action="#" method="post" id="subForm">
	    <div role="grid" style="margin-top:20px;">
	        <div class="table">
	        <a href="FrmOperateStandard.toAddStandard" class="btn_style mb_10">新增模板</a>
	       		<table class="tbl">
	       		<tbody>
	       			<tr>
	       				<td class="t-head">模板名称</td>
	       				<td class="t-head">计费方式</td>
	       				<td class="t-head">最后编辑时间</td>
	       				<td class="t-head">操作</td>
	       			</tr>
	       			</tbody>
	       			<tbody class="t-body tc">
	       			<c:forEach items="${value}" var="var" varStatus="status">
		       			<tr>
                            <td>${var.items.name_}</td>
                            <c:if test="${var.items.method_=='1'}"><td>按件记重</td></c:if>
		       				<td>${var.items.updateDate_}</td>
		       				<td><a href="FrmOperateStandard.toUpdateStandard?nameId_=${var.items.nameId_}" class="btn_style">编辑</a>
		       				<a href="FrmOperateStandard.delStandard?nameId_=${var.items.nameId_}" class="btn_style">删除</a></td>
		       			</tr>
	       			</c:forEach>
	       			</tbody>
	       		</table>
	        </div>
	    </div>
    </form>
 </div>
</body>

</html>