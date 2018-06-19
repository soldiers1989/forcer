<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
</head>
<body>
<div>
	<h2>配置箱子与商品关系</h2>
	<form action="FrmDeliveryToBox.configureProBox" method="post">
		<input type="hidden" value="in" name="in">
		<p>箱子编号<input type="text" name="" value="${proBox.items.boxId_}"></p>
		<p>商品主电子条码<input type="text" name="cabId_" placeholder="请输入商品主电子条码"></p>
		<input type="submit" value="提交">
	</form>
</div>
</body>
</html>   