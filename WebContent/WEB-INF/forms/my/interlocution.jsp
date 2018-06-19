<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>反馈详情</title>
<style>
	.yjfk_content{
		width:800px;
		margin:auto;
	} 
	.group-box div{
		margin-bottom:10px;
	}
	.group-box p{
		padding-left:0px;
	}
</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">反馈详情</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	<a href="FrmFeedback" class="btn_style">返回</a>
	    	<!-- <a href="javascript:window.history.go(-1);" class="btn_style">返回</a> -->
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>	
	<div class="group-box">			
		<div><label>反馈人姓名：</label>${val.items.username}</div>
		<div><label>反馈人手机号：</label>${val.items.userphone}</div>
		<div><label>反馈内容：</label>${val.items.view_}</div>
		<div><label>反馈时间：</label>${val.items.submit_time}</div>
		<div class="flexLayout"><label>回复内容：</label>${val.items.reply_}</div>
		<div><label>回复时间：</label>${val.items.answer_time}</div>
	</div>	
</div>
			

<%-- <div>
	<p>反馈人姓名：<label>${val.items.username}</label></p>
	<p>反馈人手机号：<label>${val.items.userphone}</label></p>
	<p>反馈内容：<label>${val.items.view_} </label></p>
	<p>反馈时间：<label>${val.items.submit_time}</label></p>
	<p>回复内容：<label>${val.items.reply_}</label></p>
	<p>回复时间：<label>${val.items.answer_time}</label></p>
	<p><a href="FrmFeedback">返回</a></p>
</div> --%>
</body>
</html>