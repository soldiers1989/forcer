<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">在租订单</div>
</div>
<!--内容模块-->
<div class="main_content" >
    <div id="mat"></div>
	<c:forEach items="${rentOrders }" var="rent">
	<div class="zz">
		<div class="rent_order">
			<span>在租订单</span>
			<a class="zpf" href="FrmMyCabinet.toIndemnity?orderId_=${rent.items.orderId_ }">转赔付</a>
		</div>
		<div class="rentOrder_detail">
			<span>在租订单号：</span><span>${rent.items.orderId_ }</span>
		</div>
		<div class="rentOrder_detail">
			<span>租赁用户昵称：</span><span>${rent.items.name_ }</span>
		</div>
		<div class="rentOrder_detail">
			<span>租赁用户：</span><span>${rent.items.mobile_ }</span>
		</div>
		<div class="rentOrder_detail">
			<span>租赁物品：</span><span>${rent.items.proName_ }</span>
		</div>
		<div class="rentOrder_detail">
			<span>租赁起始时间：</span><span>
				<fmt:formatDate value="${rent.items.beginTime_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
			</span>
		</div>
		<div class="rentOrder_detail">
			<span>预计归还时间：</span><span>
				<fmt:formatDate value="${rent.items.returnTime_ }" pattern="yyyy-MM-dd HH:mm:ss" />
			</span>
		</div>
		<div class="rentOrder_detail">
			<span>支付租金：</span><span>${rent.items.sumRentMoney_ }</span>
		</div>
		<div class="rentOrder_detail">
			<span>支付押金：</span><span>${rent.items.orderRentMoney_ }</span>
		</div>
		
	</div>
	</c:forEach>
</div>



	<%-- <h2>在租订单</h2>
	<c:forEach items="${rentOrders }" var="rent">
		<div>
			<span>在租订单号:${rent.items.orderId_ }</span>
		</div>
		<div>
			<span>租赁用户昵称:${rent.items.name_ }</span>
		</div>
		<div>
			<span>租赁用户:${rent.items.mobile_ }</span>
		</div>
		<div>
			<span>租赁物品:${rent.items.proName_ }</span>
		</div>
		<div>
			<span>租赁起始时间:
				<fmt:formatDate value="${rent.items.beginTime_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
			</span>
		</div>
		<div>
			<span>预计归还时间:
				<fmt:formatDate value="${rent.items.returnTime_ }" pattern="yyyy-MM-dd HH:mm:ss" />
			</span>
		</div>
		<div>
			<span>支付租金:${rent.items.sumRentMoney_ }</span>
		</div>
		<div>
			<span>支付押金:${rent.items.orderRentMoney_ }</span>
		</div>
		<div>
			<a href="FrmMyCabinet.toIndemnity?orderId_=${rent.items.orderId_ }">转赔付</a>
		</div>
	</c:forEach> --%>
</body>
</html>