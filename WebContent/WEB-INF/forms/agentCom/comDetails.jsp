<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>社区详情</title>
<style>
	.group-box label{
		width:200px;
	}
	.group-box p{
		margin-bottom:10px;
	}
</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">社区详情</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	<!-- <a href="FrmAgent" class="min-col btn_style">返回</p> -->
	    	 <a href="javascript:window.history.go(-1);" class="min-col btn_style">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>	
	<div class="easyui-panel group-box tc mt_20">
		<p><label>社区序号：</label><span>${com.items.communityNo_ }</span></p>
		<p><label>社区简称：</label><span>${com.items.communityJname_ }</span></p>
		<p><label>社区物业简称：</label><span>${com.items.wuYeJname_ }</span></p>
		<p><label>社区物业全称：</label><span>${com.items.wuYeName_ }</span></p>
		<p><label>社区物业电话：</label><span>${com.items.wuYePhone_ }</span></p>
		<p><label>社区所在区域：</label><span>${com.items.communityArea_ }</span></p>
		<p><label>社区街道门牌地址：</label><span>${com.items.doorPlate_ }</span></p>
		<p><label>商城社区地址：</label><span>${com.items.address_ }</span></p>
	</div>
</div>

<%-- <p>社区序号：<span>${com.items.communityNo_ }</span></p>
<p>社区简称：<span>${com.items.communityJname_ }</span></p>
<p>社区物业简称：<span>${com.items.wuYeJname_ }</span></p>
<p>社区物业全称：<span>${com.items.wuYeName_ }</span></p>
<p>社区物业电话：<span>${com.items.wuYePhone_ }</span></p>
<p>社区所在区域：<span>${com.items.communityArea_ }</span></p>
<p>社区街道门牌地址：<span>${com.items.doorPlate_ }</span></p>
<p>商城社区地址：<span>${com.items.address_ }</span></p>
<p><a href="FrmAgent">返回</a></p> --%>
</body>
</html>