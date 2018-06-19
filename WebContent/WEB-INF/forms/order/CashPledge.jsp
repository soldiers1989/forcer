 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>押金信息</title>

</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">押金信息</div>
</div>
<div class="main_content" id="cash_pledge">
    <div id="mat"></div>
    <div class="my_cash_pledge">
    	<c:if test="${not empty totCashPledge_}">
       		<div class="specific_cash">${totCashPledge_}</div>
        </c:if>
        <c:if test="${empty totCashPledge_}">
       		<div class="specific_cash">0</div>
        </c:if>
        <div class="cash_hint">我的总押金(元)</div>
    </div>
    <ul class="cash_pledge_list mt_10">
        <c:forEach  items="${orders}" var="order">
                <li>
                    <a href="#" class="flexLayout">
                        <div class="pledge_img"><img alt="" src="${order.items.proZsImges_}"></div>
                        <div class="pledge_message">
                            <div class="pledge_name">${order.items.proName_}</div>
                            <div class="pledge_time">${order.items.beginTime_}</div>
                        </div>
                        <div class="pledge_money">￥${order.items.CashPledge_}</div>
                    </a>
                </li>
            </c:forEach>
        </ul>
</div>
    <%-- <div>
        <span>我的总租金</span>
        <span>${totCashPledge_}</span>
    </div>
    <div>押金明细</div>
    <div>
        <c:forEach  items="${orders}" var="order">
            <img alt="" src="${order.items.proZsImges_}">
            <li>    
                
                <span>消费-${order.items.proName_}</span><span> ${order.items.CashPledge_}</span><br>
                <span>${order.items.beginTime_}</span>
            </li>
            <div>----------------------------------------------------------------</div>
        </c:forEach>
    </div> --%>
</body>

</html>