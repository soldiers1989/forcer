
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>减免押金</title>
<style>
	.cash_pledge_list li{
		width:100%;
		height: 0.819rem;
		border-bottom: 1px solid #e6e6e6;
		margin:auto;
		line-height:0.819rem;
	}
	.cash_pledge_list li a{
		width:100%;
		height: 100%;
		line-height:0.819rem;
		border-bottom: none;
	}
	.ta_r{
		text-align:right;
	}
	.fc_gold{
		color: #a0791a;
	}
	.fc_red{
		color: #f00000;
	}
</style>
</head>
<body>
	<div class="header2">
		<a href="javascript:history.go(-1);" class="prev"></a>
		<div class="head_title font18">减免押金</div>
	</div>
	<div class="main_content" id="cash_pledge">
		<div id="mat"></div>
		<div class="my_cash_pledge">
			<c:if test="${not empty totCashPledge_}">
				<div class="specific_cash">${totCashPledge_}</div>
			</c:if>
			<c:if test="${empty totCashPledge_}">
				<div class="specific_cash">0</div>
			</c:if>
			<div class="cash_hint">我的总押金(元)</div>
		</div>
		<ul class="cash_pledge_list mt_10">
			<c:if test="${zhima eq 0}">
				<a href="FrmSesame" href="#"><li><span>芝麻信用认证</span><span class="fr mr_10 fc_gold">未认证</span></li></a>
			</c:if>
			<c:if test="${zhima ne 0}">
				<a href="FrmSesameCredit" href="#"><li><span>芝麻信用认证</span><span class="fr mr_10 fc_red">减免${credit1}</span></li></a>
			</c:if>
			<c:if test="${cardNum_ eq 0}">
				<a href="FrmAddBank"><li><span>银行卡绑定</span><span class="fr mr_10 fc_gold">未认证</span></li></a>
			</c:if>
			<c:if test="${cardNum_ ne 0}">
				<a href="FrmAddBank"><li><span>银行卡绑定</span><span class="fr mr_10 fc_red">减免${credit3}</span></li></a>
			</c:if>
			<a href="#"><li><span>活体影像</span><span class="fr mr_10 fc_gold">未认证</span></li></a>
			<a href="#"><li><span>绑定手机号</span><span class="fr mr_10 fc_red">减免100</span></li></a>
			
		</ul>
	</div>
</body>
</html>