 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看物流信息</title>
</head>
<body>
	<div>
		<span>
				<c:if test="${order.items.orderState_ == 1}">待发货</c:if>
				<c:if test="${order.items.orderState_ == 2}">待开箱</c:if>
				<c:if test="${order.items.orderState_ == 3}">待收货</c:if>
				<c:if test="${order.items.orderState_ == 4}">租用中</c:if>
				<c:if test="${order.items.orderState_ == 5}">待归还</c:if>
				<c:if test="${order.items.orderState_ == 6}">完成</c:if>
				<c:if test="${order.items.orderState_ == 7}">退款</c:if>
		</span>
		<li>
			<span>物流服务：${order.items.recLogisticsName_}</span>
		</li>
		<li>
			<span>运单编号：${order.items.recLogisticsId_}</span>
		</li>
	</div>
	<div id="LogisticsXX">
		
	</div>
</body>
<script type="text/javascript">
	$(function(){
		var data = ${str};
		if(data.Success){
			var state = data.State;
			var state1 = "";
			if(state == -1){
				state1 = "单号或快递公司代码错误";
			}
			if(state == 0){
				state1 = "暂无轨迹";
			}
			if(state == 1){
				state1 = "快递收件";
			}
			if(state == 2){
				state1 = "在途中";
			}
			if(state == 3){
				state1 = "已签收";
			}
			if(state == 4){
				state1 = "问题件";
			}
			var str="<li>物流情况:"+state1+"</li>";
			if(state == 2 || state == 3){
				var Traces= data.Traces;
				for(var i=Traces.length-1;i!=-1;i--){
					var Trace = Traces[i];
					var AcceptStation = Trace.AcceptStation;
					var AcceptTime = Trace.AcceptTime;
					str +="<li><span>"+AcceptTime  +"<span><span>"+  AcceptStation+"<span></li>";
				}
			}
			$("#LogisticsXX").html(str);
			
		}
		if(!data.Success){
			$("#LogisticsXX").html("暂无此物流信息");
		}
		
	})
</script>
</html>