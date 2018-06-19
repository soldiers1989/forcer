<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0">
    <%-- <link rel="stylesheet" href="${cdn }/css/common.css"> --%>
    <link rel="stylesheet" href="${cdn }/css/maintenance.css">
    <link rel="stylesheet" href="${cdn }/files/swiper/swiper-3.3.1.min.css"/>
    <title>一启享</title>
    <style>
        .swiper-container{
            height: 3.431rem;
            background-color: white;
        }
        .swiper-slide {
            line-height: 3.431rem;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">柜组物品</div>
</div>
<div class="main_content" id="cabinetGroup_goods">
    <div id="mat"></div>
    <div class="cabinetGroup cabinetGroup_edit">
        <ul class="cabinetGoods_list pt_15 pl_15 pb_0 clearfix">
        <c:forEach var="box" items="${boxCount}">
            <c:if test="${box.items.emptyStatus_ eq true}">
                <li>
                    <a href="#">
                        <div class="cabinetGoods_img"><img src="${box.items.proImges_ }" alt=""></div>
                        <div class="cabinetGoods_num font12 text-white">${box.items.boxId_ }</div>
                        <div class="cabinetGoods_code font13">识别码：<span style="color: #666666;">${box.items.orderId_ }</span></div>
                    </a>
                </li>
            </c:if>
            <c:if test="${box.items.emptyStatus_ eq false}">
                <li>
                    <a href="#">
                        <div class="cabinetGoods_img"><img src="" alt=""></div>
                        <div class="cabinetGoods_num font12 text-white">${box.items.proImges_ }</div>
                        <div class="cabinetGoods_code font13 tl">识别码：<span style="color: #666666;">${box.items.orderId_ }</span></div>
                    </a>
                     <div class="old_empty font15 text-white">已空</div>
                </li>
            </c:if>
        </c:forEach>
        </ul>
    </div>
   
</div>
<script src="../../files/jquery-1.11.3.min.js"></script>
<script src="../../files/rem1.js"></script>
<script src="../../files/swiper/swiper-3.3.1.min.js"></script>
<script src="../../js/modal.js"></script>
<script src="../../js/common.js"></script>

<script type="text/javascript" src="${cdn}/js/box/box.js"></script>
</body>
</html>