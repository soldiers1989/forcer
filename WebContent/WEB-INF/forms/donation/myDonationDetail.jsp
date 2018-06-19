<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的捐赠详情查看</title>
</head>
<body>
<div class="header2">
	<!-- <a href="FrmDonation.myDonation">返回</a> -->
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">捐赠详情</div>
</div>

<div class="main_content">
    <div id="mat"></div>
    <!--我要捐赠流程-->
    <div class="wantToDonation">
       <div class="wantToDonation_item">物品描述：<span>${donation.items.proRemark_ }</span></div>
	<!-- <h3>捐赠信息</h3> -->
	<!--  <div class="wantToDonation_item"><a href="FrmDonation.myDonation">返回</a></div> -->
	 <div class="wantToDonation_item">物品描述：<span>${donation.items.proRemark_ }</span></div>
	 <div class="wantToDonation_item">物品数量：<span>${donation.items.productNum_ }</span></div>
	 <div class="wantToDonation_item">物品规格：<span>${donation.items.proGuiGe_ == '0'?"大":(donation.items.proGuiGe_ == '1'?"小":"中")}</span></div>
	 <div class="wantToDonation_item">捐赠人：<span>${donation.items.name_ }</span></div>
	 <div class="wantToDonation_item">捐赠时间：<span><fmt:formatDate value="${donation.items.createDate_ }" pattern="yyyy-MM-dd"/></span></div>
	 <div class="wantToDonation_item">捐赠状态：<span>${donation.items.status_ == '0'?"物品已发至公益机构":"物品尚未发至公益机构" }</span></div>
	 <div class="wantToDonation_item">捐赠箱柜：<span>${donation.items.address_ }${donation.items.boxId_ }</span></div>
</body>
</html>