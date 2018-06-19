<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@include file="../ui/head1.jspf"%>
	<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>变更社区代理挂靠</title>
<style>
	.group-box div{
		margin-top:10px;
	}
	.group-box div label{
		width:200px;
	}
</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">变更社区代理挂靠</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="javascript:window.history.go(-1);" class="min-col btn_style">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>	
	<div class="easyui-panel tc mt_20">
	<form action="FrmCommunity.changeCom">
	<div class="group-box">
	<input type="hidden" value="up" name="up">
	<input type="hidden" value="${change.items.communityId_ }" name="communityId_">
		<div><label>社区序号：</label>${change.items.communityNo_ }</div>
		<div><label>社区简称：</label><input type="text" name="communityJname_" value="${change.items.communityJname_ }"></div>
		<div><label>社区物业简称：</label><input type="text" name="wuYeJname_" value="${change.items.wuYeJname_ }"></div>
		<div><label>商城社区地址显示：</label><input type="text" name="address_" value="${change.items.address_ }"></div>
		<div><label class="fl">当前挂靠代理：</label>
			<table class="tbl">
				<tr>
					<td class="t-head">地区</td>
					<td class="t-head">代理级别</td>
					<td class="t-head">代理商简称</td>
					<td class="t-head">操作</td>
				</tr>
				<tbody class="t-body tc" id="userPage">
				<c:forEach items="${agents }" var="val">
				<tr>
					<td>${val.items.agentArea_ }</td>
					<td>${val.items.agentLevel_ }</td>
					<td>${val.items.agentJname_ }</td>
					<td>
						<a href="FrmCommunity.deleteAgent?agentId_=${val.items.agentId_ }" class="btn_style">删除</a>
					</td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<div><label>增加代理挂靠:</label>
			<a href="#" class="jg_city">省级</a>
			<a href="#" class="jg_city">市级</a>
			<a href="#" class="jg_city">区域级</a>
		</div>
		<div><input type="submit" value="提交" style="margin-left: 209px !important;margin-top:30px;"></div>
		</div>
		</form>
	</div>
</div>
	







	<%-- <form action="FrmCommunity.changeCom">
		<p><input type="hidden" value="up" name="up"></p>
		<p><input type="hidden" value="${change.items.communityId_ }" name="communityId_"></p>
		<p>社区序号:<label>${change.items.communityNo_ }</label></p>
		<p>社区简称:<input type="text" name="communityJname_" value="${change.items.communityJname_ }"></p>
		<p>社区物业简称:<input type="text" name="wuYeJname_" value="${change.items.wuYeJname_ }"></p>
		<p>商城社区地址显示:<input type="text" name="address_" value="${change.items.address_ }"></p>
		<div>
		<h2>当前挂靠代理</h2>
			<table border="1px;">
				<tr>
					<td>地区</td>
					<td>代理级别</td>
					<td>代理商简称</td>
					<td>操作</td>
				</tr>
				<c:forEach items="${agents }" var="val">
				<tr>
					<td>${val.items.agentArea_ }</td>
					<td>${val.items.agentLevel_ }</td>
					<td>${val.items.agentJname_ }</td>
					<td>
						<a href="FrmCommunity.deleteAgent?agentId_=${val.items.agentId_ }">删除</a>
					</td>
				</tr>
				</c:forEach>
			</table>
			<p>增加代理挂靠&nbsp;&nbsp;<a href="#">省级</a>
			&nbsp;&nbsp;&nbsp;<a href="#">市级</a>
			&nbsp;&nbsp;&nbsp;<a href="#">区域级</a>
			</p>
		</div>
		<p><input type="submit" value="提交"></p>
	</form> --%>
</body>
</html>