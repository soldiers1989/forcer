<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@include file="../ui/head1.jspf"%>
	<%@include file="../ui/head2.jspf" %> 
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>积分记录详情查看</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">积分记录详情查看</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="javascript:window.history.go(-1);" class="min-col"
			style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>	
	<div class="easyui-panel tc mt_20">
		<div class="group-box" name="null" id="component1" visible="false">
			<label>用户名：</label><input type="text" value="${record.items.shareName }" disabled="disabled">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label>获取方式：</label><input type="text" value="${record.items.type_ == '0'?"签到":"分享" }" disabled="disabled">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label>获取积分：</label><input type="text" value="${record.items.integral_ }" disabled="disabled">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label>积分总额：</label><input type="text" value="${record.items.sum }" disabled="disabled">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label>当前积分等级：</label><input type="text" value="${record.items.grade_ }" disabled="disabled">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label>被分享用户：</label>
			<c:if test="${record.items.regName != null }">
				<input type="text" value="${record.items.regName }" disabled="disabled">
			</c:if>
			<c:if test="${record.items.regName == null }">
				<input type="text" value="/" disabled="disabled">
			</c:if>
		</div>
	</div>
</div>
		
		
		
		
<%-- <p><a href="FrmJiFenRecords">返回</a></p>
	<div>
		<h2>积分记录详情查看</h2>
		<p>用户名:<label>${record.items.shareName }</label></p>
		<p>获取方式:<label>${record.items.type_ == '0'?"签到":"分享" }</label></p>
		<p>获取积分:<label>${record.items.integral_ }</label></p>
		<p>积分总额:<label>${record.items.sum }</label></p>
		<p>当前积分等级:<label>${record.items.grade_ }</label></p>
		<p>被分享用户:
			<c:if test="${record.items.regName != null }">
				<label>${record.items.regName }</label>
			</c:if>
			<c:if test="${record.items.regName == null }">
				<label>/</label>
			</c:if>
		</p>
	</div> --%>
</body>
</html>