 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>租凭历史</title>

</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">租赁历史</div>
</div>
<div class="main-contnet" id="rightAway_maintain">
    <div id="mat"></div>
    <c:forEach items="${orders}" var="order" >
        <div class="list mb_10">
            <ul class="message_list">
                <li class="flexLayout">
                    <div class="">
                        <span class="font13 text-666">历史订单号：</span>
                        <span class="font13">${order.items.orderId_}</span>
                        <c:if test="${order.items.orderType_ == 1}"><span class="delivery_style">自取租赁</span></c:if>
                        <c:if test="${order.items.orderType_ == 2}"><span class="delivery_style">寄送上门</span></c:if>
                        <c:if test="${order.items.orderType_ == 3}"><span class="delivery_style">寄送到柜</span></c:if>
                        <c:if test="${order.items.orderType_ == 4}"><span class="delivery_style">线上购买</span></c:if>
                    </div>
                </li>    
                <li class="flexLayout">
                    <div class="">
                        <span class="font13 text-666">租凭用户：</span>
                        <span class="font13">${order.items.recPhone_}</span>
                    </div>
                </li>
                <li class="">
                    <div >
                        <span class="font13 text-666">租凭时间：</span>
                        <span class="font13">
                            <fmt:formatDate value="${order.items.beginTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            <span>-</span>
                            <fmt:formatDate value="${order.items.returnOverTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </span>
                    </div>
                </li>
                <li class="">
                    <div class="">
                        <span class="font13 text-666">归还类型：</span>
                        <c:if test="${order.items.returnType_ == 0}">
                            <span class="font13">无损归还 - </span>
                        </c:if>
                        <c:if test="${order.items.returnType_ == 1}">
                            <span class="font13">报修归还 - </span>
                        </c:if>
                        <c:if test="${order.items.returnMethod_ == 0}">
                            <span class="font13">箱子归还</span>
                        </c:if>
                        <c:if test="${order.items.returnMethod_ == 1}">
                            <span class="font13">快递归还</span>
                        </c:if>
                    </div>
                </li>
                <li class="flexLayout">
                    <div class="">
                        <span class="font13 text-666">检修说明：</span>
                        <span class="font13">${order.items.leaveMess_}</span>
                    </div>
                </li>
                <li class="historyOrder_img">
                    <div class="font13 text-666" style="line-height: .75rem;height: .75rem">检修图片</div>
                    <div class="historyImg_show pb_10 flexLayout">
                        <c:forEach items="${order.items.imgPath_}" var="img" >
                            <img alt="" src="${img}">
                           <%--  <img alt="" src="${img}">
                            <img alt="" src="${img}"> --%>
                        </c:forEach>
                    </div>
                </li>
                <li class="flexLayout">
                    <div style="width: auto;">
                        <span class="font13 text-666">检修人：</span>
                        <span class="font13">${order.items.operateManName_}</span>
                    </div>
                    <div style="width: auto;">
                        <span class="font13 text-666">检修时间：</span>
                        <span class="font13"><fmt:formatDate value="${order.items.OpenBoxTime_}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                    </div>
                </li>
            </ul>
        </div>
    </c:forEach>
</div>

    <%-- <div>
        <c:forEach items="${orders}" var="order" >
            <span>历史订单号：${order.items.orderId_}</span>
            <span>
                <c:if test="${order.items.orderType_ == 1}">自取租赁</c:if>
                <c:if test="${order.items.orderType_ == 2}">寄送上门</c:if>
                <c:if test="${order.items.orderType_ == 3}">寄送到柜</c:if>
                <c:if test="${order.items.orderType_ == 4}">线上购买</c:if>
            </span><br>
            <span>租凭用户：${order.items.receiver_}</span><br>
            <span>租凭时间： 
                    <fmt:formatDate value="${order.items.beginTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    -
                    <fmt:formatDate value="${order.items.returnOverTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </span><br>
            <span>归还类型：
                <c:if test="${order.items.returnType_ == 0}">
                    无损归还 - 
                </c:if>
                <c:if test="${order.items.returnType_ == 1}">
                    报修归还 - 
                </c:if>
                <c:if test="${order.items.returnMethod_ == 0}">
                    箱子归还
                </c:if>
                <c:if test="${order.items.returnMethod_ == 1}">
                    快递归还
                </c:if>
            </span><input type="button" value="历史订单" onclick="findHisOrd('${order.items.userId_}');"><br>
            
            <span>检修说明：${order.items.leaveMess_}</span><br>
            <span>检修图片：</span><br>
            <div>
                <c:forEach items="${order.items.imgPath_}" var="img" >
                    <img style="width: 50px;height: 50px;" src="${img}">
                </c:forEach>
                
            </div>
            <span>检修人：${order.items.name_} </span><span> 检修时间：
                <fmt:formatDate value="${order.items.OpenBoxTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </span><br>
            <span>************************************************************************************************</span>
        </c:forEach>
    </div> --%>
    
</body>
<script type="text/javascript">
    function findHisOrd(userId_){
        window.location.href="FrmProDetails.findHisOrd?userId_="+userId_;
    }
</script>
</html>