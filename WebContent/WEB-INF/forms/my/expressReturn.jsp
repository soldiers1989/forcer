 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的订单</title>
</head>
<body>
	<div>
		归还物流信息:
		<input type="text" placeholder="请填写物流名称" name="returnLogisticsName_" id="returnLogisticsName_"/>
		<input type="text" placeholder="请填写物流单号" name="retuenLogisticsId_" id="retuenLogisticsId_"/>
		<input type="button" value="确定" onclick="submit();">
	</div>
	<div>
		<img  src="${order.items.twoImgUrl_}">
		<li>
			<span>${order.items.proName_}</span>
		</li>
		<li>
			<span>
				<c:if test="${order.items.isDiscount_ == 0}">
					${order.items.dayRentMoney_}
				</c:if>
				<c:if test="${order.items.isDiscount_ == 1}">
					${order.items.discountPrice_}
				</c:if>
				元/天
			</span>
		</li>
		<li>押金：
			<span>${order.items.cashPledge_} 元</span>
		</li>
	</div>
</body>
<script type="text/javascript">
	function submit(){
		var orderId_ = '${order.items.orderId_}';
		console.log(orderId_);
		var returnLogisticsName_ = $("#returnLogisticsName_").val();
		if(returnLogisticsName_ == "" || returnLogisticsName_ == null){
			alert("请填写物流名称");
		}
		var retuenLogisticsId_ = $("#retuenLogisticsId_").val();
		if(retuenLogisticsId_ == "" || retuenLogisticsId_ == null){
			alert("请填写物流单号");
		}
		if(retuenLogisticsId_ != null && retuenLogisticsId_ != null){
			$.ajax({
				url : 'FrmOrder_My.seaExpReturn',
				data : {
					"returnLogisticsName_" : returnLogisticsName_,
					"retuenLogisticsId_" : retuenLogisticsId_,
					"orderId_":'${order.items.orderId_}'
				},
	        	type: "GET",
	        	dataType: "json",
	        	contentType: false, //必须
	        	success: function (value) {
	        		if(value){
	        			window.history.back(-1);
	        		}
	        		
	        	}
			})
		}
		
	}
</script>
</html>