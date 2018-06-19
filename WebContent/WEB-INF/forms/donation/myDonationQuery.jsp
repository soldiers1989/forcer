<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的捐赠</title>
<style>
	ul li{
		width:100%;
		padding:0 .256rem ;
		box-sizing:border-box;
		background-color:#fff;
	}
</style>
</head>
<body>
<div class="header2">
    <input type="hidden" value="${type}" name="type">
    <a href="FrmMore.userCenter" class="prev"></a>
    <div class="head_title font18">我的捐赠</div>
    <a href="FrmDonation.donationInsert" class="more">我要捐赠</a>
</div>
<div class="main_content" id="use_guide">
    <div id="mat"></div>

<!-- <div>
	<a href="FrmDonation.donationInsert">我要捐赠</a>
</div> -->
	 <div>
		<!-- <h2>我的捐赠</h2> -->
		<ul>
		<c:forEach items="${donations }" var="donat">
			<li>
				<div class="donation_my">
					<div class="donation_goods">${donat.items.proRemark_ }</div>
					<div class="donation_num"><span>${donat.items.productNum_ }</span><span>1</span></div>
					<div class="donation_time">捐于<span>${donat.items.createDate_ }</span></div>
					<a href="FrmDonation.myDonationDetail?donationId_=${donat.items.donationId_ }"><img alt="" src="${cdn }/img/right.png" class="donation_more"></a>
				</div>
			</li>
			</c:forEach>
		</ul>
		
	</div>
</div>
<%-- <c:forEach items="${donations }" var="donat">
			<p>${donat.items.proRemark_ }</p>
			<p>${donat.items.productNum_ }</p>
			<p>捐于${donat.items.productNum_ }</p>
			<p><a href="FrmDonation.myDonationDetail?donationId_=${donat.items.donationId_ }">查看捐赠单</a></p>
		</c:forEach>  --%>
</body>
</html>		