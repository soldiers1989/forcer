<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<title></title>

</head>
<body>

<script type="text/javascript">
$(function(){
	var zhuCode_ = '${zhuCode_}';
	var orderType_ = '${orderType_}';
	var str ="A"+zhuCode_+"B"+orderType_;
	window.location.href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxe68dea4a67cc11b0&redirect_uri=http://yqx2018.lucland.com/forms/FrmOrder_Lease.recharge&response_type=code&scope=snsapi_base&state="+str+"#wechat_redirect";
})
</script>
<script type="text/javascript" src="${cdn}/js/orderJs/weixinPay.js"></script>
</body>
</html>