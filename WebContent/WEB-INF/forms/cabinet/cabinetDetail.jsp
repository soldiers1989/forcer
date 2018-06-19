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
        }
        .header2{
            background-color: white;
        }
        .myCabinet_left div,.myCabinet_right{
        	color:#666;
        }
        .myCabinet_left{
        	position:relative;
        	width:100%;
        	box-sizing:border-box;
        	height:100%;
        	padding:.246rem;
        	margin-left:0;
        }
        .myCabinet_firstLi{
        	height:100%;
        }
        .myCabinet li{
		  width:100%;
		  height:1.263rem;
		  border-top:1px solid #f5f5f5;
		}
		.isActiveCa{
			color: #a0791a !important;
		}
    </style>
</head>
<body>
<!--我的柜组模块-->
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">柜组详情
</div>
</div>
<!--内容模块-->
<div class="main_content" >
    <div id="mat"></div>
    <!--排序部分-->

    <!--信息显示部分-->
	<div class="cabinet_title">
		<c:forEach items="${cons}" var="cons">
		最新捐赠动态（<span class="fca07">${cons.items.count}</span>条）
		</c:forEach>
	</div>
		
    <div class="">
    <ul class="myCabinet">
    
    <c:forEach  items="${counts}" var="con">
        <li>
        <input type="hidden" id="cabinetId_" value="${cabinetId_}">
         <a href="FrmGongYiCabinet.gotoJZDetail?orderId_=${con.items.orderId_}&cabinetId_=${cabinetId_}">
            <div class="myCabinet_firstLi">
                <div class="myCabinet_left">
                     <div class="font256" style="line-height:.5rem;">用户<span class="fc222">"${con.items.name_}"</span>进行了捐赠</div>
                     <div class="font222"><span>数量：<span class="fc222">${con.items.count_}</span></span></div>
               
                  	<div class="fcBCBC font222 donationTime">捐赠于:<fmt:formatDate value="${con.items.createTime_}" pattern="yyyy-MM-dd HH:mm:ss"/></div>  
            </div>
             </a>
        </li>
        </c:forEach> 
    </ul>
 </div>
 <div id="cabinetDetail_btn"></div>
 <div class="cabinetDetail_btn">
 	<a class="open" href="#">打开柜门</a>
 	<a class="take" href="#">立即取货</a>
 	<div class="seperate"></div>
 </div>
</div>
<script src="../../files/jquery-1.11.3.min.js"></script>
<script src="../../files/rem1.js"></script>
<script>
	$(function(){
		$("body").on("click",".cabinetDetail_btn a",function(){
			$(this).addClass("isActiveCa").siblings().removeClass("isActiveCa");
		})
	})
</script>
</body>
</html>