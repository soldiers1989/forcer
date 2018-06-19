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
        .cabinetGoods_code{
        	width:68%;
        }
        .cabinetGoods_name,.cabinetGoods_code{
	        overflow:hidden;
	        white-space: nowrap;
	    	text-overflow: ellipsis;
        }
    </style>
</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">柜组物品</div>
    <div class="more">
   		 <a href="FrmMyCabinet.onRentingOrders">在租订单</a>
    </div>
    <div class="more save">返回</div>
</div>
<div class="main_content" id="cabinetGroup_goods">
    <div id="mat"></div>
    <div class="cabinetGroup cabinetGroup_edit"><input type="hidden" value="${id_ }" name="id_">
        <ul class="cabinetGoods_list pt_15 pl_15 pb_0 clearfix">
        <c:forEach var="box" items="${boxCount}">
            <c:if test="${box.items.status_ eq true}">
                <li>
                    <a href="FrmWeiPro?zhuCode_=${box.items.zhuCode_ }&type_=yw&a=${box.items.boxId_ }&id_=${id_}">
                        <div class="cabinetGoods_img"><img src="${box.items.proZsImges_ }" alt=""></div>
                        <div class="cabinetGoods_num font12 text-white">${box.items.boxId_ }</div>
                        <div class="cabinetGoods_name font14">${box.items.proName_ }</div>
                        <div class="cabinetGoods_code font13">识别码：<span style="color: #666666;">${box.items.zhuCode_ }</span></div>
                    </a>
                    <a href="#" class="text-gold font11 chestGroup_operation yun_maintenance mr_0">维</a>
                    <a href="#" class="text-gold font11 chestGroup_operation yun_adjust">调</a>
                </li>
            </c:if>
            <c:if test="${box.items.status_ eq false}">
                <li>
                    <a href="FrmWeiPro?zhuCode_=${box.items.zhuCode_ }&type_=bh&a=${box.items.boxId_ }">
                        <div class="cabinetGoods_img"><img src="${box.items.proZsImges_ }" alt=""></div>
                        <div class="cabinetGoods_num font12 text-white">${box.items.boxId_ }</div>
                        <div class="cabinetGoods_name font14">${box.items.proName_ }</div>
                        <div class="cabinetGoods_code font13 tl">识别码：<span style="color: #666666;">${box.items.zhuCode_ }</span></div>
                        <%-- <div class="cabinetGoods_num">${box.items.proName_ }</div>
                        <span>识别码：${box.items.zhuCode_ }</span> --%>
                    </a>
                    <a href="#" class="text-gold font11 chestGroup_operation yun_replenish mr_0">补</a>
                </li>
            </c:if>
            <c:if test="${box.items.status_ eq null}">
                <li>
                    <a href="FrmWeiPro?zhuCode_=${box.items.zhuCode_ }&type_=bh&a=${box.items.boxId_ }">
                        <div class="cabinetGoods_img"><img src="../../img/3.jpg" alt=""></div>
                        <div class="cabinetGoods_num font12 text-white">${box.items.boxId_ }</div>
	                    <div class="cabinetGoods_name font14">${box.items.proName_ }sss</div>
	                    <div class="cabinetGoods_code font13">识别码：<span style="color: #666666;">${box.items.zhuCode_ }</span></div>
                        <%-- <div class="cabinetGoods_num">${box.items.proName_ }</div>
                        <span>识别码：${box.items.zhuCode_ }</span> --%>
                    </a>
                    <a href="#" class="text-gold font11 chestGroup_operation yun_replenish mr_0">补</a>
                    <div class="old_empty font15 text-white">已空</div>
                </li>
            </c:if>
        </c:forEach>
        </ul>
    </div>
    <div class="cabinetGroup cabinetGroup_save" style="display: none;">
        <!--轮播图-->
        <div class="swiper-container">
            <!--如果需要分页器-->
            <div class="swiper-pagination"></div>
        </div>
        <ul class="attribute_list">
            <li>
                <span class="attribute_hint">柜组名称：</span>
                <span>${cabinet.items.name_ }</span>
            </li>
            <li>
                <span class="attribute_hint">柜组编号：</span>
                <span>${cabinet.items.id_ }</span>
            </li>
            <li>
                <span class="attribute_hint">柜组大小：</span>
                <span>长150m*</span>
                <span>宽150m*</span>
                <span>高150m</span>
            </li>
            <li>
                <span class="attribute_hint">柜组型号：</span>
                <span>中</span>
            </li>
            <li>
                <span class="attribute_hint">负责人：</span>
                <span>张大大</span>
            </li>
            <li>
                <span class="attribute_hint">启用状态：</span>
                <span>开</span>
            </li>
            <li class="flexLayout">
                <span class="attribute_hint">柜组用途：</span>
                <div>
                    <select>
                        <option value="">租赁柜组</option>
                        <option value="">公益柜组</option>
                    </select>
                </div>
            </li>
        </ul>
        <div class="cabinet_sum flexLayout">
            <span class="attribute_hint">柜组地址：</span>
            <div>${cabinet.items.address_ }</div>
        </div>
    </div>
</div>
<script src="../../files/jquery-1.11.3.min.js"></script>
<script src="../../files/rem1.js"></script>
<script src="../../files/swiper/swiper-3.3.1.min.js"></script>
<script src="../../js/modal.js"></script>
<script src="../../js/common.js"></script>
<script>
    var mySwiper=new Swiper(".swiper-container",{
        direction:"horizontal",
        loop:true,
        autoplay:2000,
        autoplayDisableOnInteraction:false,

        pagination:".swiper-pagination",
        paginationClickable:true,

        prevButton:".swiper-button-prev",
        nextButton:".swiper-button-next"
    });
</script>
<script>
    //  编辑和保存页面切换
    $("body").on("click",".edit",function(){
        $(this).hide().next().show();
        $(".cabinetGroup_edit").hide().next().show();
    });
    $("body").on("click",".save",function(){
        $(this).hide().prev().show();
        $(".cabinetGroup_save").hide().prev().show();
    })

</script>
<script type="text/javascript" src="${cdn}/js/box/box.js"></script>
</body>
</html>