<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<head>
<body>

	<c:forEach items="${values }" var="value">
		<div>
			<ul>
				<li>${value.items.title_ }</li>
			</ul>
		</div>
	</c:forEach>

</body>
</html>