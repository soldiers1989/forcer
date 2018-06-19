 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>退款提交后</title>

</head>
<body>
</body>
<script type="text/javascript">
$(function(){
	var err = '${err}';
	if(err != null && err != ""){
		alert(err);
	}
	window.location.href="FrmOrder_My.execute"; 
})
</script>
</html>