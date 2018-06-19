 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0">
<link rel="stylesheet" href="${cnd }/files/common.css">
<link rel="stylesheet" href="${cnd }/css/user.css">
<title>我的订单</title>
   
</head>
<body>
		<div >
			<img alt=""  src="FrmOrderInterface.createQR?zhuCode_=${zhuCode_}&orderId_=${orderId_}&type_=${type_}">
			<p>最终解释权一启享所有</p>
			<p>请使用微信扫一扫，扫码关注公众号</p>
		</div>
		<input type="button" onclick="open();" value="开锁测试">
		<input type="button" onclick="down();" value="关箱测试">
</body>
<script type="text/javascript">
	function open(){
		 $.ajax({
			 url:"FrmOrderInterface.getOpen",
				type:'post',
				datatype:"text",
				success:function(data){
					if(data){
						alert("开锁成功");
						alert("用户正在取东西");
					}else{
						alert("开锁失败");
					}
				} 
		 })		
	}
	function down(){
		 $.ajax({
			 url:"FrmOrderInterface.getDown",
				type:'post',
				datatype:"text",
				success:function(data){
					if(data){
						alert("用户已关箱子");
						alert("用户取走东西");
					}else{
						alert("用户已关箱子失败");
					}
				} 
		 })		
	}
</script>
</html>