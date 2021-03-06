<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客服电话（运维端）</title>
</head>
<body>
<div class="header2">
    <a href="javascript:history.back(-1)" class="prev"></a>
    <div class="head_title font18">联系客服</div>
</div>
<div class="main_content" id="maintenance_kefu">
    <div id="mat"></div>
    <c:forEach items="${values }" var="value" varStatus="status">
        <div class="font15">
            <span class="maintenance_kefu_hint">客服电话：</span>
            <span>${value.items.content_ }</span>
        </div>
        <div  class="font15">
            <span class="maintenance_kefu_hint">对帮助中心提建议/邮件留言：</span>
            <span>service@jd.com</span>
        </div>
    </c:forEach>
</div>
<%-- 客服电话
<c:forEach items="${values }" var="value" varStatus="status">
<a href="javascript:history.back(-1)">返回</a>
    内容${value.items.content_ }
    </c:forEach> --%>
</body>
</html>