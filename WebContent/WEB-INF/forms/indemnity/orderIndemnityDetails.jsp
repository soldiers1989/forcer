<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <%@include file="../ui/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
<style>
.order-box{
 	width: 900px;
    margin: 0 auto;
    text-align: left;
    margin-bottom: 10px;
    text-align:left;
}
.order-box span{
	width:100px;
	text-align:right;
}	
.order-box p{
	line-height: 28px;
    font-size: 17px;
}   
</style>
</head>
<body>
<div class="order-box">
		<p>
		<span>订单编号：<label>${details.items.orderId_}</label></span>
	</p>
	<p>
		<span>订单收货方式：<label> 
			<c:if test="${details.items.orderType_ == '1' }">
				本柜取
			</c:if>
			<c:if test="${details.items.orderType_ == '2' }">
				快递收
			</c:if>
			<c:if test="${details.items.orderType_ == '3' }">
				本柜取
			</c:if>
		</label></span>
	</p>
	<p>
		<span>物品名称：<label>${details.items.proName_}</label></span>
	</p>
	<p>
		<span>物品归属：<label>${details.items.homeAgency_}</label></span>
	</p>
	<p>
		<span>租时电子条码：<label>${details.items.zhuCode_}</label></span>
	</p>
	<p>
		<span>归时电子条码：<label>${details.items.zhuCode_}</label></span>
	</p>
	<p>
		<span>物品价值：<label>${details.items.proCostPrice_}</label></span>
	</p>
	<p>
		<span>租赁时长：<label>${details.items.rentTime_}</label></span>
	</p>
	<p>
		<span>订单租金：<label>${details.items.dayRentMoney_}</label></span>
	</p>
	<p>
		<span>订单押金：<label>${details.items.cashPledge_}</label></span>
	</p>
	<p>
		<span>押金减免：
		<label>${details.items.coupon_}</label></span>
	</p>
	<p>
		<span>超期租金：
		<label>${details.items.sumOverMoney_}</label></span>
	</p>
	<p>
		<span>订单租赁创建时间：
		<label> 
			<fmt:formatDate value="${details.items.createDate_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
		</label></span>
	</p>
	<p>
		<span>订单起租时间：
		<label> 
			<fmt:formatDate value="${details.items.beginTime_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
		</label></span>
	</p>
	<p>
		<span>订单归还时间：
		<label> 
			<fmt:formatDate value="${details.items.returnOverTime_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
		</label></span>
	</p>
	<p>
		<span>订单状态：
		<label> 
			<c:if test="${details.items.orderState_ == '1' }">
				待发货
			</c:if>
			<c:if test="${details.items.orderState_ == '2' }">
				待开箱
			</c:if>
			<c:if test="${details.items.orderState_ == '3' }">
				待收货
			</c:if>
			<c:if test="${details.items.orderState_ == '4' }">
				租用中
			</c:if>
			<c:if test="${details.items.orderState_ == '5' }">
				归还中
			</c:if>
			<c:if test="${details.items.orderState_ == '6' }">
				已归还
			</c:if>
			<c:if test="${details.items.orderState_ == '7' }">
				完成
			</c:if>
			<c:if test="${details.items.orderState_ == '8' }">
				退款
			</c:if>
		</label></span>
	</p>
	<p>
		<span>异常状态：
		<label> 
			<c:if test="${details.items.repairType_  == '0'}">
				自己责任
			</c:if>
			<c:if test="${details.items.repairType_  == '1'}">
				他人责任
			</c:if>
		</label></span>
	</p>
	<p>
		<span>结算状态：
		<label>
			<c:if test="${details.items.status_ =='0' }">
				未结算
			</c:if>
			<c:if test="${details.items.status_ =='1' }">
				已结算
			</c:if>
		</label></span>
	</p>
	</div>
</body>
</html>