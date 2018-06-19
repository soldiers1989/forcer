<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
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
            position:relative;
        }
        .header2{
            background-color: white;
        }
        .last{
          float:left !important;
        }
        .separateLine{
          position:absolute;
          left:45%;
        }
        .myCabinet li{
          padding-bottom:.1rem;
        }
        .myCabinet_right{
        	height:100%;
        	position:relative;
        }
       
        .myCabinet_right a{
      color: #a0791a;
      font-size:.222rem;
      background-color: #ffffff;
      border-radius: 0.248rem;
      border: solid 0.017rem #cfb065;
      padding:.1rem .3rem;
      position:absolute;
      top:.4rem;
      right:.0;
      
        }
        .createTime{
           height:.7rem !important;
           line-height:.7rem;
           padding:0 .246rem;
        }
        select{
        	width:1.3rem;
        	border:none;
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
    <div class="head_title font18">公益柜组
    </div>
    <a href="FrmGongYiCabinet.Historys" class="head_title_right">收货历史</a>
</div>
<!--内容模块-->
<div class="main_content" >
    <div id="mat"></div>
    <!--排序部分-->
    <div class="orderOpera" >
        <select class="area" id="communityJname_" onchange="changeqq()">
        	<option value="">全部</option>
            <c:forEach var="communityJnames" items="${communityJnames}">
            <option value="${communityJnames.items.communityJname_ }">
            ${communityJnames.items.communityJname_ }
            </option>
           
            </c:forEach> 
        </select>
        <div class="order" >
            <ul>
                <li class="last">
                    <select id="shouhuo" onchange="changeqq()">
                    	<option value="">全部</option>
                    	<option value="1">未收货 <img src="../../img/small_down.png" class="order_time"></option>
                    	<option value="0">已收货</option>
                    </select>
                   
                </li>

                <li >
                    <select>
                    	<option>离我最近<img src="../../img/small_down.png" class="order_time"></option>
                    </select>
                </li>
            </ul>
            <div class="separateLine"><span ></span></div>
        </div>
    </div>

    <!--信息显示部分-->
     <c:forEach var="cabinet" items="${cabinet}">
			<input type="hidden" name="id_" value="${cabinet.items.id_ }">
    <div class="info">
    <ul class="myCabinet">
        <li >
            <div class="myCabinet_firstLi">
            	<a href="FrmGongYiCabinet.gotocabinetDetail?id_=${cabinet.items.id_ }">
                <div class="myCabinet_left">
                     <div style="font-size:.256rem;line-height:.6rem;">${cabinet.items.name_ }</div>
                     <div><img src="../../img/position.png"><span style="color:#999">${cabinet.items.address_ }</span></div>
                </div>
                </a>
                <div  class="myCabinet_right">
                    <a href="FrmGongYiCabinet.GYCabinetRes?id_=${cabinet.items.id_ }">柜组物品</a>
                </div>
            </div>
        </li>
       <!--  <li>
            <div class="myCabinet_Li">
                <div class="myCabinet_left"><span>箱柜故障：3次</span></div>
            </div>
        </li> -->
        <li class="createTime">
            <div>
                <div><span>创建时间：
                 <fmt:formatDate value="${cabinet.items.createDate_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
                </span></div>
            <!--     <div class="myCabinet_lastRight"><span>1.2km</span></div> -->
            </div>
        </li>
    </ul>
 </div>
</c:forEach> 
</div>
<script src="../../files/jquery-1.11.3.min.js"></script>
<script src="../../files/rem1.js"></script>
<script type="text/javascript">
$(function(){
	 $("#communityJname_").val("${Jname}");
	 $("#shouhuo").val("${isShouhuo}");
})
	function changeqq(){
		var communityJname_ = $("#communityJname_").val() ;
		var isShouhuo = $("#shouhuo").val();
		window.location.href="FrmGongYiCabinet.changeqq?communityJname_="+communityJname_+"&shouhuo="+isShouhuo;
	}
</script>

</body>
</html>