 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>申请退款</title>
<style>
	textarea{
	width: 100%;
	height: 2.765rem;
	background-color: #ffffff;
	border:none;
	text-align:left;
	font-size: 0.256rem;
	padding:.17rem;
}
.refundMon{
	font-size: 0.239rem;
	line-height: 0.512rem;
	letter-spacing: 0rem;
	color: #a0791a;
	float:right;
	margin-right:.3rem
}
.submit,.cancle{
	width: 5.29rem;
	height: 0.717rem;
	font-size:.307rem;
	border-radius: 0.358rem;
	margin-left:.55rem;
	
}
.submit{
	color:#ffffff;
	background-color:#88213d;
	border:none;
	margin:3.5rem .55rem .52rem .55rem;
}
.cancle{
	border: solid 1px #a0791a;
	background-color:#f5f5f5;
	color: #a0791a;
}
</style>
</head>
<body>
<div class="header2">
    <a href="javascript:window.history.go(-1);" class="prev"></a>
    <div class="head_title font18">申请退款</div>
</div>
<div class="main_content" id="myOrder">
    <div id="mat"></div>
    <div>
		<form action="FrmOrder_My.refund" id="right_rent" >			
			<textarea rows="10px" cols="40px" name="returnReason_" placeholder="请填写退款原因"></textarea>
			<span class="refundMon" style="">退款金额：${order.items.allowReturnMoney_}</span>
			<br>
			<input type="button" value="提交" onclick="Sub();" class="submit">
			<input type="button" value="取消" onclick="Sub();" class="cancle">
			<input type="hidden" name="orderId_" value="${order.items.orderId_ }">
			<input type="hidden" name="returnMoney_" value="${order.items.allowReturnMoney_ }">
			<input type="hidden" name="zhuCode_" value="${order.items.zhuCode_ }">
			
		</form>
	</div>
</div>
	
</body>
<script type="text/javascript">
function Sub(){
	var str = "亲,确定退款吗？";
	if (confirm(str)==true){
		$("#right_rent").submit();
	}
}

</script>
</html>