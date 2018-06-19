<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="${cdn}/css/style.css"/>
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>编辑运费模板</title>
<style>
	.checkbox_shipping,.checkbox_notshipping{
		margin-left:200px;
	}
	.checkbox_shipping input,.checkbox_notshipping input{
		margin-left:14px;
	}
 	.checkbox_shipping input:first-child,.checkbox_notshipping input:first-child{
		margin-left:9px;
	} 
</style>
</head>
<body>
 <div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">编辑运费模板</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="javascript:window.history.go(-1);" class="min-col"
			style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>
	<!-- <p>模板基础信息</p> -->
	<div class="easyui-panel tc mt_20">
		<form action="FrmOperateStandard.updateStandard" method="post" id="ProductsForm">
		<!--<p>当前商品名称序号：<input type="text" name="UID_" id="UID_"></p> -->
		<input type="hidden" name="nameId_" value="${value.items.nameId_ }">
			<div class="group-box" name="null" id="component1" visible="false">
				<label style="width:200px">模板名称：</label>
				<input type="text" name="name_" value="${value.items.name_ }">
			</div>			
			<div class="group-box">
				<label class="fl"  style="width:200px">计费方式：</label>
				<input type="radio" name="method_" value="1" checked>按件计费			
			</div>
			<div class="group-box">
				<label style="width:200px" class="fl">包邮配送区域：</label>
				<div class="checkbox_shipping">
					<input type="checkbox" value="北京" name="baoArea_">北京<input type="checkbox" value="天津" name="baoArea_">天津
					<input type="checkbox" value="上海" name="baoArea_">上海<input type="checkbox" value="重庆" name="baoArea_">重庆
					<input type="checkbox" value="河北" name="baoArea_">河北<input type="checkbox" value="山西" name="baoArea_">山西
					<input type="checkbox" value="辽宁" name="baoArea_">辽宁<input type="checkbox" value="吉林" name="baoArea_">吉林
					<input type="checkbox" value="黑龙江" name="baoArea_">黑龙江<input type="checkbox" value="江苏" name="baoArea_">江苏
					<input type="checkbox" value="浙江" name="baoArea_">浙江<input type="checkbox" value="安徽" name="baoArea_">安徽
					<input type="checkbox" value="江西" name="baoArea_">江西<input type="checkbox" value="福建" name="baoArea_">福建
					<input type="checkbox" value="山东" name="baoArea_">山东<input type="checkbox" value="河南" name="baoArea_">河南
					<input type="checkbox" value="湖北" name="baoArea_">湖北<input type="checkbox" value="湖北" name="baoArea_">湖北
					<input type="checkbox" value="湖南" name="baoArea_">湖南<input type="checkbox" value="广东" name="baoArea_">广东
					<input type="checkbox" value="海南" name="baoArea_">海南<input type="checkbox" value="河南" name="baoArea_">海南
					<input type="checkbox" value="四川" name="baoArea_">四川<input type="checkbox" value="贵州" name="baoArea_">贵州
					<input type="checkbox" value="云南" name="baoArea_">云南<input type="checkbox" value="陕西" name="baoArea_">陕西
					<input type="checkbox" value="甘肃" name="baoArea_">甘肃<input type="checkbox" value="青海" name="baoArea_">青海
					<input type="checkbox" value="台湾" name="baoArea_">台湾<input type="checkbox" value="内蒙古" name="baoArea_">内蒙古
					<input type="checkbox" value="广西" name="baoArea_">广西<input type="checkbox" value="西藏" name="baoArea_">西藏
					<input type="checkbox" value="新疆" name="baoArea_">新疆<input type="checkbox" value="香港" name="baoArea_">香港
					<input type="checkbox" value="澳门" name="baoArea_">澳门<input type="checkbox" value="宁夏" name="baoArea_">宁夏
				</div>
				<div class="checkbox_shipping mt_10">
					<input type="button" value="全选">
					<input type="button" value="反选">
				</div>
			</div>
			<div class="group-box">
				<label style="width:200px" class="fl">不包邮配送区域：</label>
				<div class="checkbox_notshipping">
					<input type="checkbox" value="北京" name="notBaoArea_">北京<input type="checkbox" value="天津" name="notBaoArea_">天津
					<input type="checkbox" value="上海" name="notBaoArea_">上海<input type="checkbox" value="重庆" name="notBaoArea_">重庆
					<input type="checkbox" value="河北" name="notBaoArea_">河北<input type="checkbox" value="山西" name="notBaoArea_">山西
					<input type="checkbox" value="辽宁" name="notBaoArea_">辽宁<input type="checkbox" value="吉林" name="notBaoArea_">吉林
					<input type="checkbox" value="黑龙江" name="notBaoArea_">黑龙江<input type="checkbox" value="江苏" name="notBaoArea_">江苏
					<input type="checkbox" value="浙江" name="notBaoArea_">浙江<input type="checkbox" value="安徽" name="notBaoArea_">安徽
					<input type="checkbox" value="江西" name="notBaoArea_">江西<input type="checkbox" value="福建" name="notBaoArea_">福建
					<input type="checkbox" value="山东" name="notBaoArea_">山东<input type="checkbox" value="河南" name="notBaoArea_">河南
					<input type="checkbox" value="湖北" name="notBaoArea_">湖北<input type="checkbox" value="湖北" name="notBaoArea_">湖北
					<input type="checkbox" value="湖南" name="notBaoArea_">湖南<input type="checkbox" value="广东" name="notBaoArea_">广东
					<input type="checkbox" value="海南" name="notBaoArea_">海南<input type="checkbox" value="河南" name="notBaoArea_">海南
					<input type="checkbox" value="四川" name="notBaoArea_">四川<input type="checkbox" value="贵州" name="notBaoArea_">贵州
					<input type="checkbox" value="云南" name="notBaoArea_">云南<input type="checkbox" value="陕西" name="notBaoArea_">陕西
					<input type="checkbox" value="甘肃" name="notBaoArea_">甘肃<input type="checkbox" value="青海" name="notBaoArea_">青海
					<input type="checkbox" value="台湾" name="notBaoArea_">台湾<input type="checkbox" value="内蒙古" name="notBaoArea_">内蒙古
					<input type="checkbox" value="广西" name="notBaoArea_">广西<input type="checkbox" value="西藏" name="notBaoArea_">西藏
					<input type="checkbox" value="新疆" name="notBaoArea_">新疆<input type="checkbox" value="香港" name="notBaoArea_">香港
					<input type="checkbox" value="澳门" name="notBaoArea_">澳门<input type="checkbox" value="宁夏" name="notBaoArea_">宁夏
				</div>
				<div class="checkbox_notshipping mt_10">
					<input type="button" value="全选">
					<input type="button" value="反选">
				</div>
			</div>
			<!-- <div class="group-box" style="background-color:#81c181	;">
				<label style="width:200px">配送运费：</label>
				<label >件数：</label>
			</div> -->
			<div class="group-box">
				<label style="width:200px">配送运费：</label>
				<span >首件：</span><input name="fristJian_" type="number" style="width:50px;" value="${value.items.fristJian_ }">
				<label >首费：</label><input name="fristJianMoney_" type="number" style="width:50px;" value="${value.items.fristJianMoney_ }">
				<label >续件：</label><input name="nextJian_" type="number" style="width:50px;" value="${value.items.nextJian_ }">
				<label >续费：</label><input name="nextJianMoney_" type="number" style="width:50px;" value="${value.items.nextJianMoney_ }">
			</div>
			<div class="group-box">
				<label style="width:200px">指定条件包邮：</label>
				<select>
					<option>请选择</option>
					<option>件数</option>
				</select>
				<label >满</label><input name="baoFreight_" type="number" style="width:50px;" value="${value.items.baoFreight_ }">件包邮
			</div>
			<div class="group-box" id="component4" style="margin-left:30%">
			<input type="submit" name="submit" value="提交" >				
		</div>
		</form>
		
	</div>
	
</div>




			
	
</body>
</html>