<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起享</title>
</head>
<body>
<!-- <p>消息分类</p>
<p><a href="FrmNewslistYunWei">1:运维</a></p> 
<p><a href="FrmNewslistYunWei">2:用户</a></p>
<p><a href="FrmNewslistYunWei">3:系统</a></p> -->
<!-- 消息分类 -->
 <div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">消息管理</div>
</div>
<div class="main_content" id="myMessage">
    <div id="mat"></div>
    <div class="list">
        <ul class="message_list">
            <li>
                <a href="FrmMessageList">
                    <img alt="" src="../../img/system_notice.png" class="message_logo mr_10">
                    <span>系统公告</span>
                </a>
            </li>
            <li>
                <a href="FrmMessageList.getOrder">
                    <img alt="" src="../../img/order_message.png"  class="message_logo mr_10">
                    <span>订单消息</span>
                </a>
            </li>
        </ul>
    </div>
</div>
</body>
</html>