<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心（运维端）</title>
</head>
<body>
<div class="header2">
    <a href="javascript:history.back(-1)" class="prev"></a>
    <div class="head_title font18">个人中心</div>
</div>
<div class="main_content" id="maintenance_uesrCenter">
    <div id="mat"></div>
        <div class="maintenance_name">
            <div><img alt="" src="${values.items.imgUrl_ }"> </div>
            <div class="maintenance_userName">${values.items.name_ }</div>
        </div>
    <div class="list">
        <ul class="message_list">
            <li>
                <a href="FrmMyCenter.MyPerson" class="flexLayout">
                    <div class="list_left">
                        <img alt="" src="${cdn }/img/maintenance_my.png">
                        <span class="ml_10">个人资料</span>
                        </div>
                    <div class="list_right"><img alt="" src="${cdn }/img/rightArrows.png"></div>
                </a>
            </li>
            <li>
                <a href="FrmMyCenter.PersonSetUp" class="flexLayout">
                    <div class="list_left">
                        <img alt="" src="${cdn }/img/maintenance_set.png">
                        <span class="ml_10">个人设置</span>
                        </div>
                    <div class="list_right"><img alt="" src="${cdn }/img/rightArrows.png"></div>
                </a>
            </li>
            <li>
                <a href="FrmMyCenter.FeedBackYunWei" class="flexLayout">
                    <div class="list_left">
                        <img alt="" src="${cdn }/img/maintenance_message.png">
                        <span class="ml_10">意见反馈</span>
                        </div>
                    <div class="list_right"><img alt="" src="${cdn }/img/rightArrows.png"></div>
                </a>
            </li>
        </ul>
    </div>
</div>
<%-- <c:forEach items="${values }" var="value" varStatus="status">
        <p>个人头像：${value.items.imgUrl_ }</p>
        <p>姓名：${value.items.name_ }</p>
</c:forEach>
        <p><a href="FrmMyCenter.MyPerson">个人资料</a></p>
        <p><a href="FrmMyCenter.PersonSetUp">个人设置</a></p>
        <p><a href="FrmMyCenter.FeedBackYunWei">意见反馈</a></p> --%>
</body>
</html>