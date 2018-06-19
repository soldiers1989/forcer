<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起享</title>
</head>
<body>
	<form action="FrmPersonalInfo.updateNumber">
	    <input type="hidden" value="${order.items.orderId_ }" name="orderId_">
	    <input type="hidden" value="${order.items.userId_ }" name="userId_">
		<input type="hidden" value="up" name="up">
		<p>订单号<label>${order.items.orderId_ }</label></p>
		<p>物流公司<label>${order.items.recLogisticsName_ }</label></p>
		<p>物流单号<input type="text" value="${order.items.recLogisticsId_ }" name="recLogisticsId_" ></p>
		<input type="submit" value="提交"> 
	</form>
</body>
</html>