<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../ui/head1.jspf"%>
	<%@include file="../ui/head2.jspf" %> 
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>签到详情</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">签到详情</span>
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
			<label>用户微信昵称：</label><input type="text"  value="${sign.items.userName }" disabled="disabled">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label>用户手机号：</label><input type="text"  value="${sign.items.mobile }" disabled="disabled">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label>签到时间：</label><fmt:formatDate value="${sign.items.createTime_ }" pattern="yyyy-MM-dd HH:mm:dd"/>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label>当前所获积分：</label><input type="text"  value="${sign.items.integral_ }" disabled="disabled">
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label>积分总额:</label><input type="text" value="${sign.items.sum }" disabled="disabled">
		</div>
	</div>
</div>


<%-- <p><a href="FrmSignRecords">返回</a></p>
<p>用户微信昵称:<label>${sign.items.userName }</label></p>
<p>用户手机号:<label>${sign.items.mobile }</label></p>
<p>签到时间:
	<fmt:formatDate value="${sign.items.createTime_ }" pattern="yyyy-MM-dd HH:mm:dd"/>
</p>
<p>当前所获积分:<label>${sign.items.integral_ }</label></p>
<p>积分总额:<label>${sign.items.sum }</label></p> --%>
</body>
</html>