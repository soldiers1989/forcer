<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改密码（运维端）</title>
</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">修改密码</div>
</div>
<form class="main_content" id="editPassword">
    <div id="mat"></div>
    <div class="list">
        <ul class="message_list">
            <li>
                <a class="flexLayout" href="#">
                    <div class="list_left"> <input type="text" value="${userid}"> </div>
                    <div class="list_right"></div>
                </a>
            </li>
            <li>
                <a class="flexLayout" href="#">
                    <div class="list_left"><input type="text" placeholder="请输入验证码"></div>
                    <div class="list_right">获取验证码</div>
                </a>
            </li>
            <li>
                <a class="flexLayout" href="#">
                    <div class="list_left"><input type="text" placeholder="请输入新密码"></div>
                    <div class="list_right"></div>
                </a>
            </li>
            <li class="border_0">
                <a class="flexLayout" href="#">
                    <div class="list_left"><input type="text" placeholder="请再次输入新密码"></div>
                    <div class="list_right"></div>
                </a>
            </li>
        </ul>
    </div>
    <div class="maintenance_btnBox">
        <input type="submit" class="maintenance_btn">
    </div>
</form>
<!-- 修改密码 -->
</body>
</html>