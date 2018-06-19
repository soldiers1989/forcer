 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>

</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">运维管理</div>
</div>
<div class="main-contnet" id="maintain_management">
    <div id="mat"></div>
    <div class="house_box">
    	<select class="house_estate house_estate1 font13"><option>A小区</option></select>
    	<select class="house_estate house_estate2 font13"><option>红场花园小区</option></select>
    </div>
    <ul class="nav_bar4 nav_bar flexLayout" style="width: 100%;">
	    <li class="font16"><a href="#">运维单</a></li>
	    <li class="font16"><a href="#">补货单</a></li>
	    <li class="font16"><a href="#">调货单</a></li>
	    <li class="font16"><a href="#">赔付单</a></li>
	</ul>
   	<ul class="mt_10 management_contnent">
   		<li>
   			<a href="#" class="flexLayout">
   				<div class="management_img">
   					<div><img alt="" src="${cdn }/img/1.jpg"> </div>
   					<div class="cabinetGoods_num font12">A01</div>
   				</div>
   				<div class="management_details">
   					<div class="font15">联想拯救者游戏笔记本电脑</div>
   					<div class="font12"><span class="text-gray">上报人: </span>张大大</div>
   					<div class="font12"><span  class="text-gray">上报时间: </span>2017-11-10  08:02:00</div>
   				</div>
   			</a>
   		</li>
   		<li>
   			<a href="#" class="flexLayout">
   				<div class="management_img">
   					<div><img alt="" src="${cdn }/img/2.jpg"> </div>
   					<div class="cabinetGoods_num font12">A01</div>
   				</div>
   				<div class="management_details">
   					<div class="font15">联想拯救者游戏笔记本电脑</div>
   					<div class="font12"><span class="text-gray">上报人: </span>张大大</div>
   					<div class="font12"><span  class="text-gray">上报时间: </span>2017-11-10  08:02:00</div>
   				</div>
   			</a>
   		</li>
   		<!-- <li>图片</li>
   		<li>联想拯救者游戏笔记本电脑</li>
   		<li>张大大</li>
   		<li>上报时间：</li> -->
   	</ul>
</div>
</body>
</html>