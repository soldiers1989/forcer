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
        }
        .header2{
            background-color: white;
        }
    </style>
</head>
<body>
<!--我的柜组模块-->
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">我的柜组
    </div>
    <a href="FrmMyCabinet.deployCabinetList" class="head_title_right">待配置柜组</a>
</div>
<!--内容模块-->
<div class="main_content" >
    <div id="mat"></div>
    <!--排序部分-->
    <div class="orderOpera">
        <select class="area">
            <option>A小区</option>
            <option>B小区</option>
            <option>C小区</option>
        </select>
        <div class="order">
            <ul>
                <li class="last">
                    <a>箱柜状态</a>
                    <img src="../../img/small_down.png" class="order_time">
                </li>

                <li class="separateLine"><span ></span></li>
                <li>
                    <a>按距离排序</a>
                    <img src="../../img/small_down.png" class="order_time">
                </li>
                <li class="separateLine"><span ></span></li>
                <li >
                    <a>按时间排序</a>
                    <img src="../../img/small_down.png" class="order_time">
                </li>
            </ul>
        </div>
    </div>

    <!--信息显示部分-->
    <c:forEach var="cabinet" items="${cabinet}">
			<input type="hidden" name="id_" value="${cabinet.items.id_ }">
    <div class="info">
    <ul class="myCabinet">
        <li >
            <div class="myCabinet_firstLi">
                <div class="myCabinet_left">
                     <div style="font-size:.256rem;color: #222222;">${cabinet.items.name_ }</div>
                     <div><img src="../../img/position.png"><span>${cabinet.items.address_ }</span></div>
                </div>
                <div  class="myCabinet_right" style="position:relative;">
                    <a href="FrmMyCabinet.cabinetrRes?id_=${cabinet.items.id_ }" class="my_gzwp">柜组物品</a>
                </div>
            </div>
        </li>
        <li>
            <div class="myCabinet_Li">
                <div class="myCabinet_left">
                    <span>代运维：5</span>
                </div>
                <div  class="myCabinet_right">
                    <span>报损归还：4</span>
                </div>
            </div>
        </li>
        <li>
            <div class="myCabinet_Li">
                <div class="myCabinet_left"><span>箱柜故障：3次</span></div>
                <div  class="myCabinet_right"><span>空箱率：6/12次</span></div>
            </div>
        </li>
        <li >
            <div class="myCabinet_Li">
                <div class="myCabinet_left"><span>同城补货异常单：3</span></div>
                <div class="myCabinet_right"><span>二次租赁：7</span></div>
            </div>
        </li>
        <li >
            <div class="myCabinet_Li">
                <div class="myCabinet_left"><span>取消租赁：3</span></div>
                <div class="myCabinet_right"><span>空箱未关锁：2</span></div>
            </div>
        </li>
        <li >
            <div class="myCabinet_Li">
            <div class="myCabinet_left"><span>租赁中：9</span></div>
            </div>
        </li>
        <li >
            <div class="myCabinet_LastLi">
                <div class="myCabinet_left"><span>创建时间：2017-12-30</span></div>
                <div class="myCabinet_lastRight"><span>1.2km</span></div>
            </div>
        </li>
    </ul>
 </div>
</c:forEach>



   

<%-- <c:forEach var="cabinet" items="${cabinet}">
			<input type="hidden" name="id_" value="${cabinet.items.id_ }">
			<!-- 点击柜组名 查看柜子属性和配置 -->
			<a></a><h2>柜组名：${cabinet.items.name_ }</h2>
							<!-- 点击柜组物品查看柜子内物品 -->
			<span>地址:${cabinet.items.address_ }</span>丨丨丨<span>柜组物品</span><br/>
			
			<span>待运维 2</span>
			<span>报损归还 3</span><br/>
			<span>箱柜故障 2</span>
			<span>空箱率 3/11</span><br/>
			<span>同城补货异常单 2</span>
			<span>二次租赁 2</span><br/>
			<span>租赁取消 3</span>
			<span>空箱未关锁 3</span><br/>
			<span>租赁中 3</span><br/><br/><br/>
			<span>创建时间：${cabinet.items.createDate_ }</span>
			<span>距离：1.2km</span><br/>
		</c:forEach> --%>
</div>
<script src="../../files/jquery-1.11.3.min.js"></script>
<script src="../../files/rem1.js"></script>
</body>
</html>