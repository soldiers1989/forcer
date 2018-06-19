<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
</head>
<body>
	<div class="mid-box fl" id="mid-box">
		<div class="top pl_20 pr_20">
			<span class="min-col f16">消息详情</span>
		</div>
		<form action="">
			<div>
				发送人<label>${details.items.sender_ }</label>
			</div>
			<div>
				发送对象<label>${details.items.sendOb_ }</label>
			</div>
			<div>
				消息内容<label>${details.items.content_ }</label>
			</div>
			<div>
				发送时间
				<fmt:formatDate value="${details.items.sendTime_ }"
					pattern="yyyy-MM-dd HH:mm:ss" />
			</div>
			<div>
				<a href="FrmNewslist">返回</a>
			</div>
		</form>
	</div>
</body>
</html>