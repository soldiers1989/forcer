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
        .no_content img{
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translate(-50%,-50%)
    }
    .myCabinet_firstLi{
    	position:relative;
    	height:100%;
    }
    .myCabinet_left{
    	width:100%;
    	height:100%;
    	padding:.1rem .246rem .1rem .246rem;
    	margin-left:0;
    	box-sizing:border-box;
    	
    }
    .myCabinet_left div:first-child{
   	 line-height:.7rem;
    }
   .myCabinet li{
		  width:100%;
		  height:1.263rem;
		  border-top:1px solid #f5f5f5;
		}
     
    </style>
</head>
<body>
<!--我的柜组模块-->
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">收货历史
    </div>
</div>
<!--内容模块-->
<div class="main_content" >
    <div id="mat"></div>
    <!--排序部分-->

    <!--信息显示部分-->
		<div class="title">
	
	<%-- 	<c:forEach items="${cons}" var="cons">
		最新历史动态（${cons.items.count}条）
		</c:forEach> --%>
		</div>
		
    <div class="info1">
     <ul class="myCabinet">
        <c:if test="${empty HistoryList}"><img src="../../img/zwsj.png"></c:if>
   <c:forEach  items="${HistoryList}" var="con">
        <li >
         <a href="FrmGongYiCabinet.HistoryDetail?cabinetId_=${con.items.id_}&orderId_=${con.items.orderId_}">
            <div class="myCabinet_firstLi">
                <div class="myCabinet_left">
                     <div  style="font-size:.256rem">${con.items.address_}${con.items.id_}${con.items.boxId_}</div>
                     <div class=" fc999"><span>收货人：<span class="fca07">${con.items.name_}</span></span></div>
                </div>
                <div  class="myCabinet_right1 fcBCBC">
                    收货于<fmt:formatDate value="${con.items.shouhuoTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </div>
            </div>
            <input type="hidden" id="cabinetId_" value="${con.items.id_}">
        	<input type="hidden" id="orderId_" value="${con.items.orderId_}">
             </a>
        </li>
        </c:forEach>
       
    </ul>
 </div>
</div>
<script src="../../files/jquery-1.11.3.min.js"></script>
<script src="../../files/rem1.js"></script>

</body>
</html>