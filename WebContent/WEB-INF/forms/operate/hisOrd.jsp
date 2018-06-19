 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>租凭历史</title>

</head>
<body>
	<span>用户：	${user.items.code_ }</span><br>
	<div>
		<span>用户昵称：${user.items.name_ }</span>
		<span>用户余额：${user.items.name_ }</span><span>在租押金：</span><br>
		<span>在租租金：</span><span>已减免押金：</span><br>
		<span>会员等级：</span><span>积分：</span><br>
		<span>芝麻信用积分：</span><span>减免押金总额度：</span><br>
		<div>***************************************************************************</div>
	</div>
	<span>历史订单记录：</span>
	<div>
		<c:forEach items="${orders}" var="order" >
			<span >${order.items.orderId_}</span>
			<span>
				<c:if test="${order.items.orderState_ == 1}">待发货</c:if>
				<c:if test="${order.items.orderState_ == 2}">待开箱</c:if>
				<c:if test="${order.items.orderState_ == 3}">待收货</c:if>
				<c:if test="${order.items.orderState_ == 4}">租用中</c:if>
				<c:if test="${order.items.orderState_ == 5}">归还中</c:if>
				<c:if test="${order.items.orderState_ == 6}">完成</c:if>
				<c:if test="${order.items.orderState_ == 7}">退款</c:if>
			</span><br>
			 <span class="mr_10">昌宏花园 8688099启享柜</span>
			<span>
				<c:if test="${order.items.orderType_ == 1}">自取租赁</c:if>
				<c:if test="${order.items.orderType_ == 2}">寄送上门</c:if>
				<c:if test="${order.items.orderType_ == 3}">寄送到柜</c:if>
				<c:if test="${order.items.orderType_ == 4}">线上购买</c:if>
			</span><br>
			<img  src="">
			<span>${order.items.proName_}</span><br>
			<c:if test="${order.items.isDiscount_ == 0}">
				<span >${order.items.dayRentMoney_}</span><br>
			</c:if>
			<c:if test="${order.items.isDiscount_ == 1}">
				<span >${order.items.discountPrice_}</span><br>
			</c:if>
			<span>押金：￥ </span><span>${order.items.cashPledge_ }</span><br>
			<span>租用时间：${order.items.beginTime_ } 至 ${order.items.returnOverTime_ }</span>
			<span>
				共：${order.items.totDay_ }日 
			</span>
			<span>
				总租金：￥${order.items.totMoney_ }
			</span>
			<span>合计：${order.items.OverMoney_ }(含押金￥${order.items.cashMoney_ })</span>
			<span>**************************************************************</span>
		</c:forEach>
	</div>
	
</body>
<script type="text/javascript">
	function findHisOrd(userId_){
		window.location.href="FrmProDetails.findHisOrd?userId_="+userId_;
	}
	
</script>
</html>