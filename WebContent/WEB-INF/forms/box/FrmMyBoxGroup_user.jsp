<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0">
    <link rel="stylesheet" href="${cnd }/files/common.css">
    <link rel="stylesheet" href="${cnd }/css/online_store.css">
    <link rel="stylesheet" href="${cnd }/css/user.css">
    <link rel="stylesheet" href="${cnd }/css/rent.css">
    <link rel="stylesheet" href="${cnd }/files/swiper/swiper-3.3.1.min.css"/>
    <title>柜子详情</title>
    <style>
    .homepage_commodity_img img {
	    width: 100%;
	    height: 100%;
	}
	.footer_btn{
		margin-left:-.06rem;
	}
    </style>
</head>
<body>
<div class="header">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">一启享</div>
    <div class="more"><span></span><span></span><span></span></div>
</div>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">柜子详情</div>
    <input type="hidden" value="${cabinetId}" id="cabinetId">
    <a href="FrmMyBoxGroup.searchPageProduct?cabinetId=${cabinetId }"><div class="more"><img src="${cnd}/img/search1.png" style="width:0.322rem;height:100%s"></div></a>
</div>
<div class="main_content" id="commodity_details">
    <div id="mat"></div>
    <!--轮播图-->
    <div class="swiper-container">
        <div class="swiper-wrapper">
            <div class="swiper-slide"><img src="../../img/1.jpg" alt=""></div>
            <div class="swiper-slide"><img src="../../img/2.jpg" alt=""></div>
            <div class="swiper-slide"><img src="../../img/3.jpg" alt=""></div>
            <div class="swiper-slide"><img src="../../img/4.jpg" alt=""></div>
        </div>
        <!--如果需要分页器-->
        <div class="swiper-pagination"></div>
        <!--如果需要导航按钮-->
        <!--<div class="swiper-button-prev"></div>-->
        <!--<div class="swiper-button-next"></div>-->
    </div>
    
    <!-- 地址 -->
    <div class="cabinet_topAddress flexLayout" id="address">
    	<div class="cabinet_address_text" >
    		<p>${boxInfo.communityName }</p>
    		<p>${boxInfo.address }</p>
    	</div>
    	<div class="cabinet_address_img">
    		<img src="${cnd }/img/address_icon.png">
    		<p>100m</p>
    	</div>
    </div>
    
   <!--  图片显示文字提示 -->
   <div class="cabinet_pic_remark ">
   		<div>可租赁的宝贝</div>
   		
   </div>
   
 <!--   图片显示 -->
 	 <ul class="online_commodityList clearfix"  id="goods">	
 	 	<c:forEach var="gd" items="${boxInfo.goods }">
       <%--  <div>
            ${gd.num }
            <img src="${gd.imageUrl }" />
            ${gd.name }
            ${gd.money }
            ${gd.pledge }
        </div> --%>
        <li style="height:4.2rem">
            <a href="FrmWeiPro?zhuCode_=${gd.zhuCode }">
                <div class="homepage_commodity_img" ><img src="${gd.imageUrl }"  alt=""></div>
                <div class="cabinet_address">${gd.num }</div>
                <div class="homepage_commodity_name">${gd.name }</div>
                <div class="homepage_commodity_price"><span class="red">￥${gd.discountPrice }</span><span class="old_price">￥${gd.money }</span></div>
                <div class="cash_pledge text-gold font10 tl pl_15"><span>押金：￥</span><span>${gd.pledge }</span></div>
            </a>
        </li>
        
    </c:forEach>
 	 
 	 <!-- 显示数据 ，以后删除 -->
     <!--    <li style="height:4.2rem">
            <a href="FrmWeiPro?zhuCode_=1231">
                <div class="homepage_commodity_img" ><img style="height:100%;width:100%" src="../../img/1.jpg" alt=""></div>
                <div class="cabinet_address">洪湖社区A1-01号箱子</div>
                <div class="homepage_commodity_name">测试商品</div>
                <div class="homepage_commodity_price"><span class="red">￥180</span><span class="old_price">￥500/天</span></div>
                <div class="cash_pledge text-gold font10 tl pl_15"><span>押金：￥</span><span>800</span></div>
            </a>
        </li>     -->
    </ul>
    <!--  底部链接 -->
     <div id="foot_mat"></div>
    <ul class="p_footer">
        <li>
            <a href="#">
                <div><img src="../../img/zlA.png" alt=""></div>
                <div><img src="../../img/zlB.png" class="listImg" alt=""></div>
                <div class="footer_btn">租赁</div>
            </a>
        </li>
        <li>
            <a href="#">
                <div><img src="../../img/ghA.png" alt=""></div>
                <div><img src="../../img/ghB.png" class="listImg" alt=""></div>
                <div class="footer_btn">归还</div>
            </a>
        </li>
        
        <li>
            <a href="#">
                <div><img src="../../img/jzA.png" alt=""></div>
                <div><img src="../../img/jzB.png" class="listImg" alt=""></div>
                <div class="footer_btn">捐赠</div>
            </a>
        </li>
        
    </ul>
   

   

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
    $(".foot").on("click","li",function(){
        $(this).addClass("footActive").siblings().removeClass("footActive");
    });
    $(".foot").on("click",".right_buy",function(){
        $(".buy_mars").show();
        $(".buy_mars").on('touchmove',function(e){
            e.preventDefault();  //阻止默认行为
        });
        $(".buy_mars").on("click",".close_buy,.btn_box",function(){
            $(".buy_mars").hide();
        })
        $(".color_choose").on("click","li",function(){
            $(this).addClass("color_active").siblings().removeClass("color_active");
        });
    });
</script>
</body>
</html>



<%-- <body>

<script type="text/javascript">
window.onload=function() {
	var mySwiper = new Swiper(".swiper-container.bar_img", {
		autoplay : 3000,
        pagination : '.swiper-pagination.bar_img',
        autoplayDisableOnInteraction : false,
        paginationClickable : true,
        loop : true,
    });
}
</script>
<div id="header">
    柜子详情
</div>

<div id="image" class="swiper-container bar_img">
    <div class="swiper-wrapper">
    <c:forEach var="img" items="${boxInfo.images }">
        <div class="swiper-slide">
            <img src="${img }" />
        </div>
    </c:forEach>
    </div>
    <div class="swiper-pagination bar_img"></div>
</div>

<div id="address">
    ${boxInfo.communityName } <br/>
    ${boxInfo.communityNum } <br/>
    ${boxInfo.address }
</div>

<p>
可租赁的宝贝
</p>
<div id="goods">
    <c:forEach var="gd" items="${boxInfo.goods }">
        <div>
            ${gd.num }
            <img src="${gd.imageUrl }" />
            ${gd.name }
            ${gd.money }
            ${gd.pledge }
        </div>
    </c:forEach>
</div> --%>
</body>