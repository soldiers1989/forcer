 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品详情</title>

</head>
<body>
	<div>
		<input type="button" value="立即维护" onclick="wh('${zhuCode_}');" />
		<input type="button" value="立即调货" onclick="dh('${zhuCode_}');" />
	</div>
</body>
<script type="text/javascript">
	function wh(zhuCode_){
		window.location.href="FrmProDetails.goProDetails?falg=wh&zhuCode_="+zhuCode_;
	}
	function dh(zhuCode_){
		window.location.href="FrmProDetails.goProDetails?falg=dh&zhuCode_="+zhuCode_;
	}
</script>
</html>