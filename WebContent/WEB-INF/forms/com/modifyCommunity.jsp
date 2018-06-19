<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改社区信息</title>
<style>
	.group-box label{
		width:200px;
	}
</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">修改社区信息</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="javascript:window.history.go(-1);" class="min-col btn_style">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>	
	<div class="easyui-panel group-box tc mt_20">
	<form action="FrmCommunity.modifyCommunity">
		<input type="hidden" name="up" value="up">
		<input type="hidden" name="communityId_" value="${com.items.communityId_ }">
		<div><label>社区序号：</label>${com.items.communityNo_ }</div>
		<div><label>社区名称：</label><input type="text" name="communityName_" id="communityName_" value="${com.items.communityName_ }"></div>
		<div><label>社区简称：</label><input type="text" name="communityJname_" id="communityJname_" value="${com.items.communityJname_ }"></div>
		<div><label>社区物业简称：</label><input type="text" name="wuYeJname_" id="wuYeJname_" value="${com.items.wuYeJname_ }"></div>
		<div><label>社区物业全称：</label><input type="text" name="wuYeName_" id="wuYeName_" value="${com.items.wuYeName_ }"></div>
		<div><label>社区物业电话：</label><input type="text" name="wuYePhone_" id="wuYePhone_" value="${com.items.wuYePhone_ }"></div>
		<div><label>社区所在区域：</label><input type="text" name="communityArea_" id="communityArea_" value="${com.items.communityArea_ }"></div>
		<div><label>社区街道门牌地址：</label><input type="text" name="doorPlate_" id="doorPlate_" value="${com.items.doorPlate_ }"></div>
		<div><label>商城社区地址显示：</label><input type="text" name="address_" id="address_" value="${com.items.address_ }"></div>
		<div><input type="submit" value="提交" style="margin-left: 206px !important;"></div>
	</form>
	</div>
</div> 

<%--  <form action="FrmCommunity.modifyCommunity">	
	<p><input type="hidden" name="up" value="up"></p>
	<p><input type="hidden" name="communityId_" value="${com.items.communityId_ }"></p>
	<p>社区序号<label>${com.items.communityNo_ }</label></p>
	<p>社区名称：<input type="text" name="communityName_" id="communityName_" value="${com.items.communityName_ }"></p>
	<p>社区简称：<input type="text" name="communityJname_" id="communityJname_" value="${com.items.communityJname_ }"></p>
	<p>社区物业简称：<input type="text" name="wuYeJname_" id="wuYeJname_" value="${com.items.wuYeJname_ }"></p>
	<p>社区物业全称：<input type="text" name="wuYeName_" id="wuYeName_" value="${com.items.wuYeName_ }"></p>
	<p>社区物业电话：<input type="text" name="wuYePhone_" id="wuYePhone_" value="${com.items.wuYePhone_ }"></p>
	<p>社区所在区域：<input type="text" name="communityArea_" id="communityArea_" value="${com.items.communityArea_ }"></p>
	<p>社区街道门牌地址：<input type="text" name="doorPlate_" id="doorPlate_" value="${com.items.doorPlate_ }"></p>
	<p>商城社区地址显示：<input type="text" name="address_" id="address_" value="${com.items.address_ }"></p>
	<p><input type="submit" value="提交"></p>
</form> --%> 
</body>
</html>