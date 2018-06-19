<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>详情查看</title>
</head>
<body>
<div class="header2">
    <a href="FrmFeedback.addFeedback" class="prev"></a>
    <div class="head_title font18">反馈详情</div>
    
</div>
<div class="main_content" id="idea_feedback">
    <div id="mat"></div>
    <div class="feedback_listDetails mt_10">
    	<div class="font15">${val.items.view_}</div>
    	<div class="font12 text-gray">${val.items.submit_time}</div>
    </div>
    <div class="feedback_answer mt_10">
    	<div class="font14">${val.items.reply_}</div>
    	<div class="font12 text-gray">${val.items.answer_time}</div>
    </div>
		<%-- <p><label>${val.items.view_} </label></p>
		<p><label>${val.items.submit_time}</label></p>
		<p><label>${val.items.reply_}</label></p>
		<p>回复于<label>${val.items.answer_time}</label></p>
		<p><a href="FrmFeedback.addFeedback">返回</a></p> --%>
</div>
</body>
</html>