<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>优惠券使用情况</title>
</head>
<body>
	<div>
		<h2>未使用</h2>
		<c:forEach items="${infos }" var="info">
			<c:if test="${info.items.use_ == '0' }">
				<p>￥${info.items.Denomination_ }</p>
				<p>${info.items.range_ }</p>
				<p>
					<c:if test="${info.items.kind_ == '0' }">
						启享红包
					</c:if>
					<c:if test="${info.items.kind_ == '1' }">
						抵扣券
					</c:if>
				</p>
				<p>有效期：
					<fmt:formatDate value="${info.items.enddate_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
				-<fmt:formatDate value="${info.items.enddate1_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</p>
				<p>
					<c:if test="${info.items.kind_ == '0' }">
					此红包不可与其他优惠活动叠加使用
				</c:if>
				<c:if test="${info.items.kind_ == '1' }">
						仅限于超期租赁订单的租金抵扣
				</c:if>
				</p>
				<h2 style="color: orange;">未使用</h2>
			</c:if>
		</c:forEach>
	</div>
	<div>
		<h2>已使用</h2>
		<c:forEach items="${infos }" var="info">
			<c:if test="${info.items.use_ == '1' }">
				<p>￥${info.items.Denomination_ }</p>
					<p>${info.items.range_ }</p>
					<p>
						<c:if test="${info.items.kind_ == '0' }">
							启享红包
						</c:if>
						<c:if test="${info.items.kind_ == '1' }">
							抵扣券
						</c:if>
					</p>
					<p>有效期：
					<fmt:formatDate value="${info.items.enddate_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
					-<fmt:formatDate value="${info.items.enddate1_ }" pattern="yyyy-MM-dd HH:mm:ss"/></p>
					<p>
						<c:if test="${info.items.kind_ == '0' }">
						此红包不可与其他优惠活动叠加使用
					</c:if>
					<c:if test="${info.items.kind_ == '1' }">
							仅限于超期租赁订单的租金抵扣
					</c:if>
					</p>
					<h2 style="color: gray;">已使用</h2>
			</c:if>
		</c:forEach>
	</div>
</body>
</html>