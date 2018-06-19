<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0">
    <link rel="stylesheet" href="${cnd }/files/common.css">
    <link rel="stylesheet" href="${cnd }/css/online_store.css">
    <link rel="stylesheet" href="${cnd }/css/user.css">
    <link rel="stylesheet" href="${cnd }/css/maintenance.css">
    <link rel="stylesheet" href="${cnd }/files/swiper/swiper-3.3.1.min.css"/>
    <script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <title>一启享</title>
    <style>
    #collect{
        position: relative;
        padding-top: .55rem;
    }
    #chooseType{
        width: 100%;
    height: 100%;
    background-color: rgba(0,0,0,.5);
    position: fixed;
    top: 0;
    left: 0;
    z-index: 1000;
    display: none;
    font-family: MicrosoftYaHei;
    }
    </style>
</head>
<body>
<div class="header2">
    <c:if test="${empty type_}">
           <a href="javascript:history.go(-1);" class="prev"></a>
    </c:if>
    <c:if test="${!empty type_}">
        <a href="javascript:history.go(-1);" class="prev"></a>
    </c:if>
    <div class="head_title font18">商品详情</div>
</div>
<div class="main_content" id="commodity_details">
    <!--轮播图-->
    <div id="mat"></div>
    <div class="swiper-container">
        <div class="swiper-wrapper">
            <c:forEach items="${proLbImges}" var="imgs">
                <div class="swiper-slide"><img src="${imgs}" alt=""></div>
            </c:forEach>
        </div>
        <!--如果需要分页器-->
        <div class="swiper-pagination"></div>
        <!--如果需要导航按钮-->
        <!--<div class="swiper-button-prev"></div>-->
        <!--<div class="swiper-button-next"></div>-->
    </div>
    <div class="mess_space"></div>
    
    <!--商品信息-->
    <div class="commodity_message pt_15 pl_10 pr_10 pb_15" style="height: auto;">
        <div class="commodity_name flexLayout mt_0">
            <div class="bu_name font17">${value.items.proName_ }</div>
            <div class="bu_status">
                <c:if test="${type_ eq 'yw'}">
                    <a class="text-gold font11" href="#">维</a>
                    <a class="text-gold font11" href="#">调</a>
                </c:if>
                <c:if test="${type_ eq 'bh'}">
                    <a class="text-gold font11" href="#">补</a>
                </c:if>
            </div>
        </div>
        <div class="deposit_mess">
            <span class="text-666 font14">识别码：</span>
            <span style="color: #000;" class="font14">1234</span>
        </div>
        <div class="commodity_address">
            <img src="../../img/address-white.png" class="pl_0">
            <span class="font14 text-gray">广东省深圳市宝安区金海路15号</span>
        </div>
    </div>

    <!-- 图文详情 -->
    <div class="hint_white border_b font15">图文详情</div>
     <!-- 文字部分 -->
    <div class="textImg_details">
         <div class="font14 pb_10">${value.items.proDesc_}</div>
        <!-- 图片部分 -->
        <div class="picture_details">
            <!-- <img alt="" src="../../img/1.jpg"> -->
            <c:forEach items="${Img }" var="image">
                <c:if test="${image.items.imgPath_ ==''}"></c:if>
                <c:if test="${image.items.imgPath_ !=''}"><img src="${image.items.imgPath_ }"></c:if>
            </c:forEach>
        </div>
        
    </div>
    <div id="foot_mat"></div>
    <c:if test="${empty type_}">
        <div class="foot flexLayout">
            <div>
                <ul class="flexLayout">
                    <li id="share">
                        <a>
                            <div><img src="../../img/share.png" alt=""></div>
                            <div><img src="../../img/share.png" class="listImg" alt=""></div>
                            <div>分享</div>
                        </a>
                    </li>
                    <li class="${status_!='0'?'':'footActive'}" id="collect">
                        <img src="../../img/collect.png" alt="" style="top: 15%;">
                        <img src="../../img/collectB.png" class="listImg" alt="" style="top: 15%;">
                        <div>收藏</div>
                    </li>
                </ul>
            </div>
            <div class="right_buy fr">我要租赁</div>
        </div>
    </c:if>

    <c:if test="${type_ eq 'yw'}">
    
        <div class="foot flexLayout foot_two border_0">
        <a href="FrmProDetails.goProDetails?falg=wh&zhuCode_=123456&id_=${id_}&cid_=${cid_}">立即维护</a>
        <a href="FrmProDetails.goProDetails?falg=dh&zhuCode_=123456&id_=${id_}" style="background-color: #88213D;">立即调货</a></div>
    </c:if>
    
    <c:if test="${type_ eq 'bh'}">
        <div class="foot foot_one border_0">
            <a href="FrmProDetails.goProDetails?falg=bh&zhuCode_=123456&id_=${id_}">现在补货</a>
        </div>
    </c:if>
    
    <input type="hidden" value="${value.items.twoImgUrl_ }" id="twoImgUrl_">
    <input type="hidden" value="${value.items.proName_ }" id="proName_">
</div>
<script src="../../files/jquery-1.11.3.min.js"></script>
<script src="../../files/rem1.js"></script>
<script src="../../files/swiper/swiper-3.3.1.min.js"></script>
<script src="../../js/modal.js"></script>
<script src="../../js/common.js"></script>
<script type="text/javascript" src="${cdn}/js/share/share.js"></script>
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
   /*  $(".foot").on("click","li",function(){
        if($(this).hasClass("footActive")){
            $(this).removeClass("footActive");
        }else{
            $(this).addClass("footActive").siblings().removeClass("footActive");
        }
    }); */
    $(".foot").on("click",".right_buy",function(){
        $(".buy_mars").show();
        $("body").css("overflow","hidden");
        $(".buy_mars").on('touchmove',function(e){
            e.preventDefault();  //阻止默认行为
        });
        $(".buy_mars").on("click",".close_buy,.btn_box",function(){
            $(".buy_mars").hide();
            $("body").css("overflow","auto");
        })
        $(".color_choose").on("click","li",function(){
            $(this).addClass("color_active").siblings().removeClass("color_active");
        });
    });
</script>
</body>
</html>