<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../ui/head1.jspf"%>
    <%@include file="../ui/head2.jspf" %> 
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
<style>
	.box{
		width:700px;
		margin:auto;
	}
	.box p{
		height: 30px;
    font-size: 16px;
	}
	.box p span{
		display:inline-block;
		width:150px;
		text-align:right;
	}
</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">查看赔付单</span>
    </div>
    <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	   		 <!-- <a href="FrmIndemnityQuery">返回</a> -->
	    	 <a href="javascript:window.history.go(-1);" class="min-col"
			style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>
    
<div class="box">
	<form action="">
		<input type="hidden" value="up" name="up">
		<input type="hidden" value="${details.items.orderId_}" name="orderId_">
		<input type="hidden" value="${details.items.operateId_}" name="operateId_">
	<p>
		<span>赔付单编号：</span><label>${details.items.payID_}</label>
	</p>
	<p>
		<span>关联租赁单号：</span><label>${details.items.orderId_}</label>
	</p>
	<p>
		<span>关联运维单：</span><label>${details.items.operateId_}</label>
	</p>
	<p>
		<span>物品名称：</span><label>${details.items.proName_}</label>
	</p>
	<p>
		<span>关联电子标签：</span><label>${details.items.zhuCode_}</label>
	</p>
	<p>
		<span>物品归属机构：</span><label>${details.items.homeAgency_}</label>
	</p>
	<p>
		<span>物品价值：</span><label>${details.items.proCostPrice_}</label>
	</p>
	<p>
		<span>已收押金：</span><label>${details.items.sumMoney_}</label>
	</p>
	<p>
		<span>免押金额度：</span><label>${details.items.reliefDeposit_}</label>
	</p>
	<p>
		<span>建议赔付金额：</span><label>${details.items.suggestMoney_}</label>
	</p>
	<p>
		<span>达成赔付金额：</span><label>${details.items.successMoney_}</label>
	</p>
	<p>
		<span>赔付原因：</span><label>${details.items.payReason_}</label>
	</p>
	<p>
		<span>赔付后建议：</span><label>${details.items.suggest_}</label>
	</p>
	<p>
		<span>赔付单时间：</span>
		<label>
			<fmt:formatDate value="${details.items.createDate_}" pattern="yyyy-MM-dd "/>
		</label>
	</p>
	</form>
	<!-- <p>
		<a href="FrmIndemnityQuery">返回</a>
	</p> -->
	</div>
</div>
</body>
</html>