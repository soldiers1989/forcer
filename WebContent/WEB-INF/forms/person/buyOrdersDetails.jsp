<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起享</title>
</head>
<body>
            <p>订单编号<label>${details.items.orderId_ }</label></p>
			<p>收货人姓名<label>${details.items.receiver_ }</label></p>
			<p>物品名称<label>${details.items.proName_ }</label></p>
			<p>物品归属<label>${details.items.homeAgency_ }</label></p>
			<p>收货地址<label>${details.items.recAdr_ }</label></p>
			<p>总金额<label>${details.items.sumRentMoney_ }</label></p>
			<p>应付金额<label>${details.items.sumMoney_ }</label></p>
			<p>订单时间<label>${details.items.createDate_ }</label></p>
			<p>快递公司<label>${details.items.recLogisticsName_ }</label></p>
			<p>快递单号<label>${details.items.recLogisticsId_ }</label></p>
			<p>快递最新状态<label> 
					<c:if test="${details.items.logisticsState_  == '-1'}">
						单号或快递公司代码错误
					</c:if>
					<c:if test="${details.items.logisticsState_  == '0'}">
						暂无轨迹
					</c:if>
					<c:if test="${details.items.logisticsState_  == '1'}">
						快递收件
					</c:if>
					<c:if test="${details.items.logisticsState_  == '2'}">
						在途中
					</c:if>
					<c:if test="${details.items.logisticsState_  == '3'}">
						签收
					</c:if>
					<c:if test="${details.items.logisticsState_  == '4'}">
						问题件
					</c:if>
					
				
			</label></p>
			<p>订单状态 <label>
					<c:if test="${details.items.orderState_  == '1'}">
						代发货
					</c:if>
					<c:if test="${details.items.orderState_  == '3'}">
						待收货
					</c:if>
					<c:if test="${details.items.orderState_  == '4'}">
						租用中
					</c:if>
					<c:if test="${details.items.orderState_  == '7'}">
						完成
					</c:if>
					<c:if test="${details.items.orderState_  == '8'}">
						退款
					</c:if>
					<c:if test="${details.items.orderState_  == '9'}">
						退货中
					</c:if>
					<c:if test="${details.items.orderState_  == '10'}">
						已退货
					</c:if>	
			</label></p>
</body>
</html>