<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
</head>
<body>
<p><a href="FrmBuyOrders">返回</a></p>
	    <p> <label>订单编号：${details.items.orderId_ }</label></p>
		<p> <label>下单手机号：${details.items.recPhone_ }</label></p>
		<p> <label>收货人姓名：${details.items.receiver_ }</label></p>
		<p> <label>收货地址：${details.items.recAdr_ }</label></p>
		<p> <label>商品名称：${details.items.proName_ }</label></p>
		<p> <label>所选物品色号属性：${details.items.saleProColor_ }</label></p>
		<p> <label>物品归属机构：${details.items.saleHomeAgency_ }</label></p>
		<p> <label>商品单价：${details.items.jinPrice_ }</label></p>
		<p> <label>商品数量：${details.items.ruKuCount_ }</label></p>
		<p> <label>多个商品时优惠金额：${details.items.offerPrice_ }</label></p>
		<p> <label>创建时间：
			<fmt:formatDate value="${details.items.createDate_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
		</label></p>
		<p> <label>支付成功时间：
			<fmt:formatDate value="${details.items.createTime_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
		</label></p>
		<p> <label>支付单号：${details.items.number_ }</label></p>
		<p> <label>总金额：${details.items.sumRentMoney_ }</label></p>
		<p> <label>优惠券抵扣：${details.items.coupon_ }</label></p>
		<p> <label>实付金额：${details.items.sumMoney_ }</label></p>
		<p> <label>订单支付成功后账户余额：${details.items.userNowMoney_ }</label></p>
		<p> <label>快递公司：${details.items.recLogisticsId_ }</label></p>
		<p> <label>快递单号：${details.items.recLogisticsName_ }</label></p>
		<p> <label>寄出时间：
			<fmt:formatDate value="${details.items.deliveryTime_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
		</label></p>
		<p> <label>自动获取最新快递状态：${details.items.logisticsState_ }</label></p>
		<p> <label>是否同意退货：${details.items.agree_ }</label></p>
		<p> <label>关联退货单号：${details.items.reGoodsId_ }</label></p>
		<p> <label>退货状态：${details.items.orderState_ }</label></p>
		<p> <label>退货结算金额${details.items.reGoodsMoney_ }</label></p>
		<p> <label>订单状态：${details.items.orderState_ }</label></p>
</body>
</html>