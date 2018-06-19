<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../ui/head1.jspf"%>
    <%@include file="../ui/head2.jspf" %> 
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
</head>
<body>
<h1>送货到柜详情查看</h1>
<form action="">
	<p>订单编号:<label>${details.items.orderId_ }</label></p>
	<p>用户手机号:<label>${details.items.recPhone_ }</label></p>
	<p>租赁商品名称:<label>${details.items.proName_ }</label></p>
	<p>物品归属机构:<label>${details.items.homeAgency_ }</label></p>
	<p>租赁单价(/天):
		<label>
		<c:if test="${details.items.isDiscount_ ==0}">
				${details.items.dayRentMoney_ }
		</c:if>
		<c:if test="${details.items.isDiscount_ ==1}">
			${details.items.discountPrice_ }
		</c:if>
		</label>
	</p>
	<p>创建时间:<label>${details.items.createDate }</label></p>
	<p>付款时间:<label>${details.items.payTime }</label></p>
	<p>订单约定租赁时长:<label>${details.items.rentTime_ }</label></p>
	<p>订单初始收取租金:<label>${details.items.sumRentMoney_ }</label></p>
	<p>已收押金:<label>${details.items.reliefDeposit_ }</label></p>
	<p>优惠券抵扣：<label>${details.items.coupon_ }</label></p>
	<p>订单初始支付金额:<label>${details.items.sumMoney_ }</label></p>
	<p>租赁柜所在社区名称:<label>${details.items.boxCommunityName_ }</label></p>
	<p>租赁时主电子条码:<label>${details.items.zhuCode_ }</label></p>
	<p>订单状态:
		<label>
		<c:if test="${details.items.orderState_ ==1 }">
			待发货
		</c:if> 
		<c:if test="${details.items.orderState_ ==2 }">
			待开箱
		</c:if> 
		<c:if test="${details.items.orderState_ ==3 }">
			待收货
		</c:if> 
		<c:if test="${details.items.orderState_ ==4 }">
			租凭中
		</c:if> 
		<c:if test="${details.items.orderState_ ==5 }">
			归还中
		</c:if> 
		<c:if test="${details.items.orderState_ ==6 }">
			已归还
		</c:if> 
		<c:if test="${details.items.orderState_ ==7 }">
			完成
		</c:if> 
		<c:if test="${details.items.orderState_ ==8 }">
			退款
		</c:if> 
		</label>
	</p>
	<p> <a href="FrmDeliveryToBox">返回</a></p>
</form>
</body>
</html>