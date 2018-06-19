<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>帮助中心（运维端）</title>
</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">帮助中心</div>
</div>
<form class="main_content" id="editPassword">
    <div id="mat"></div>
    <div class="list">
        <ul class="message_list">
            <li>
                <a class="flexLayout" href="#">
                    <div class="font15">Q. 如何使用？</div>
                </a>
            </li>
            <li>
                <a class="flexLayout" href="#">
                    <div class=" font15">Q. 物品维护时需要注意什么？</div>
                </a>
            </li>
            <li>
                <a class="flexLayout" href="#">
                    <div class="font15">Q. 如何提升小白信用?</div>
                </a>
            </li>
            <li>
                <a class="flexLayout" href="#">
                    <div class="font15">Q. 什么是金币?</div>
                </a>
            </li>
            <li>
                <a class="flexLayout" href="#">
                    <div class="font15">Q. 如何使用？</div>
                </a>
            </li>
        </ul>
    </div>
    <div style="height: 1.275rem;"></div>
    <div class="maintenance_helpBox">
        <div class="font15 text-gray">了解更多详情请咨询客服 </div>
        <div class="font15 text-gray">客服热线：<span class="maintenance_helpNumber">400-888-8888</span></div>
    </div>
</form>
<!-- 修改密码 -->
<%-- 帮助中心
<c:forEach items="${values }" var="value" varStatus="status">
文章标题${value.items.title_ }
文章内容${value.items.content_ }
创建时间${value.items.addtime_ }
</c:forEach> --%>
</body>
</html>