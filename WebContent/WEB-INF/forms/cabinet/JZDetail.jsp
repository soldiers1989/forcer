<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0">
    <link rel="stylesheet" href="${cdn}/files/common.css">
    <link rel="stylesheet" href="${cdn}/css/maintenance.css">
    <title>一启享</title>
    <style>
        ul{
            display: inline;
            background-color:#fff;
            font-size: .256rem;
        }
        ul li{
        	line-heigh:.5rem;
        	line-height:.5rem;
        }
        ul li span{
        	color:#222;
        }
        .header2{
            background-color: white;
        }
        .info1{
      	    margin-top:0;
        	padding:.15rem .246rem .246rem;
        	background-color:#fff;
        	color:#666;
        }
        .cabinet_title{
        	border-bottom:1px solid #f5f5f5;
        }
    </style>
</head>
<body>
<!--我的柜组模块-->
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">捐赠详情
    </div>
</div>
<!--内容模块-->
<div class="main_content" >
    <div id="mat"></div>
    <!--排序部分-->

    <!--信息显示部分-->
		<div class="cabinet_title"><span>捐赠信息</span></div>
		
    <div class="info1">
	    <!-- <ul class="myCabinet"> -->
	    <ul>
		    <li>物品描述：<span>${Detail.items.orderDesc_}</span></li>
		   	<li>物品数量：<span>${Detail.items.count_}</span></li>
		   	<li>捐赠人：<span>${Detail.items.name_}</span></li>
		   	<li>捐赠时间：<span><fmt:formatDate value="${Detail.items.createTime_}" pattern="yyyy-MM-dd HH:mm:ss"/></span></li>
		   	<c:if test="${Detail.items.shStatus_ eq 1}">
		   		<li>捐赠状态:  <span>未收货</span>
		   		</li>
		   		</c:if>
		   		<c:if test="${Detail.items.shStatus_ eq 0}">
		   		<li>捐赠状态:  <span>已收货</span>
		   		</li>
		   		</c:if>
		   	<li>捐赠箱柜：<span>${Detail.items.address_}${Detail.items.name_}${Detail.items.boxId_}</span></li>
	    </ul>
 </div>
</div>
<script src="../../files/jquery-1.11.3.min.js"></script>
<script src="../../files/rem1.js"></script>

</body>
</html>