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
   .shareImg{
    	background-image:url('${cdn}/img/shareFrends.png');
    	background-size:100%;
    	width:100%;
    	height:6.65rem;
    } 
    </style>
</head>
<body>
	<div>商品租赁</div>
	<p>商品详情</p>
	<!-- 	轮播图 -->
	<%-- <div id="igs">
		  <c:forEach items="${value.items.proLbImges_ }" var="img">
				<a class="ig" href="#"><img alt="" src="${img}"></a>
		  </c:forEach> --%>
       
     <!--  <div class="btn btn1"><</div>
      <div class="btn btn2">></div> -->
       
	      <!-- <ul id="tabs">
	        <li class="tab">1</li>
	        <li class="tab">2</li>
	        <li class="tab">3</li>
	        <li class="tab">4</li>
	        <li class="tab">5</li>
	      </ul> -->
<div class="header">
    <a href="FrmRentWei" class="prev"></a>
    <div class="head_title font18">一启享</div>
    <div class="more"><span></span><span></span><span></span></div>
</div>
<div class="header1">
	<c:if test="${empty type_}">
   		<a href="javascript:history.go(-1);" class="prev"></a>
	</c:if>
	<c:if test="${!empty type_}">
		<a href="javascript:history.go(-1);" class="prev"></a>
	</c:if>
    <div class="head_title font18">商品详情</div>
</div>
<div class="main_content" id="commodity_details">
    <!-- <div id="mat"></div> -->
    <!--轮播图-->
    <div class="swiper-container">
        <div class="swiper-wrapper">
            <%-- <div class="swiper-slide"><img src="${cdn}/img/u=1667315353,561067597&fm=27&gp=0.jpg" alt=""></div>
            <div class="swiper-slide"><img src="${cdn}/img/u=2465775762,1509670197&fm=72.jpg" alt=""></div>
            <div class="swiper-slide"><img src="${cdn}/img/u=2661567341,837532549&fm=72.jpg" alt=""></div>
            <div class="swiper-slide"><img src="${cdn}/img/u=36337156,310763697&fm=27&gp=0.jpg" alt=""></div>
            <div class="swiper-slide"><img src="${cdn}/img/u=819923729,711931344&fm=27&gp=0.jpg" alt=""></div> --%>
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
    <div class="commodity_message ">
        <div class="commodity_name">
            <p>${value.items.proName_ }</p>
        </div>
        <div class="deposit_mess">
            <p><c:if test="${value.items.isDiscount_== '1' }"><span>${value.items.discountPrice_ }元/天</span><span class="old_price">￥${value.items.dayRentMoney_ }元/天</span></c:if>
    		<c:if test="${value.items.isDiscount_== '0' }"><span>${value.items.dayRentMoney_ }元/天</span></c:if><span>押金${value.items.cashPledge_ }</span>
    		 <a href="FrmMore.reliefDeposit">
    		<img src="../../img/successB.png"><span>减免押金</span>
    		</a></p>
        </div>
        <div class="commodity_address">
            <span>${value.items.communityName_}${value.items.boxId_}箱</span><img src="../../img/address_icon.png">
        </div>
        <div class="commodity_delivery">
            <div class="font10"><span>快递：<c:if test="${value.items.posTage_!= '' && value.items.posTage_ != null }">${value.items.posTage_ }元  </c:if>
    		<c:if test="${value.items.posTage_== '' || value.items.posTage_== null }">免邮费</c:if> </span></div>
        </div>
    </div>

	 <div class="withdraw">
	 <a href="FrmRentWei.searchSaleProduct?searchText=${value.items.proName_ }">
        <div class="option_left">
            <span>我要购买</span>
        </div>
        <div class="option_right ">
            <img src="../../img/right.png">
        </div> 
        </a>
    </div>

	
    <!--租机流程-->
    <div class="onlineRent" style="margin-top:0.178rem">
        <div class="onlineRent_detail">
            <div class="detail_text">线上租赁流程</div>
            <ul>
                <li>
                    <div class="onlineRent_detail_ico">
                        <img class="onlineRent_detail_img" src="../../img/commodity.png">
                        <div class="onlineRent_detail_line"></div>
                    </div>
                    <div class="onlineRent_detail_explain">挑选商品</div>
                </li>

                <li>
                    <div class="onlineRent_detail_ico">
                        <img class="onlineRent_detail_img" src="../../img/sign.png">
                        <div class="onlineRent_detail_line"></div>
                    </div>
                    <div class="onlineRent_detail_explain">选择租期</div>
                </li>
                <li>
                    <div class="onlineRent_detail_ico">
                        <img class="onlineRent_detail_img" src="../../img/pay.png">
                        <div class="onlineRent_detail_line"></div>
                    </div>
                    <div class="onlineRent_detail_explain">预付租金</div>
                </li>
                <li>
                    <div class="onlineRent_detail_ico">
                        <img class="onlineRent_detail_img" src="../../img/get.png">
                        <div class="onlineRent_detail_line"></div>
                    </div>
                    <div class="onlineRent_detail_explain">获取商品</div>
                </li>
                <li>
                    <div class="onlineRent_detail_ico">
                        <img class="onlineRent_detail_img" src="../../img/return.png">
                    </div>
                    <div class="onlineRent_detail_explain">归还商品</div>
                </li>
            </ul>
        </div>
    </div>


    <!--用户评价和购买-->

    <div class="recharge">
    	<a href="FrmWeiPro.queryProEvaluate?proId_=${value.items.proId_ }">
        	<div class="option_left">
            	<span>用户评价</span>
       		</div>
       
	        <div class="option_right">
	            <span>好评度&nbsp;</span><span class="gold">98%</span><img src="../../img/right.png">
	        </div>
        </a>
    </div>


 <!--图文详情-->
    			
    <div class="hint_white">图文详情</div>
    
 <!--    文字部分 -->
    <div class="text_details">
        <div class="text_details_title"><span>产品介绍</span></div>
        <div>
            <!-- <div><img src="../../img/3.jpg" alt=""></div> -->
            <div>
                <div>
                    ${value.items.proDesc_}
                </div>
                
            </div>
            <!-- <ul class="details_introduce">
                <li>
                    <span class="introduce_title fw">品牌</span>
                    <span class="introduce_content">索尼</span>
                </li>
                <li>
                    <span class="introduce_title fw">索尼单电系列</span>
                    <span class="introduce_content">ILCE-5100L套机(16-50MM)</span>
                </li>
                <li>
                    <span class="introduce_title fw">像素</span>
                    <span class="introduce_content">2430万像素</span>
                </li>
                <li>
                    <span class="introduce_title fw">传感器尺寸</span>
                    <span class="introduce_content">23.5MM*15.6MM</span>
                </li>
            </ul> -->
        </div>
    </div>
    
    <!--    图片部分 -->
    <div class="picture_details">
	    <c:forEach items="${Img }" var="image">
	    <c:if test="${image.items.imgPath_ ==''}"></c:if>
	     <c:if test="${image.items.imgPath_ !=''}"><img src="${image.items.imgPath_ }"></c:if>
		</c:forEach>
    </div>
    <div id="foot_mat1"></div>
    <c:if test="${empty type_}">
        <div class="foot flexLayout">
	        <div>
	            <ul class="flexLayout">
	                <!-- <li>
	                    <a href="#">
	                        <div><img src="../../img/service.png" alt=""></div>
	                        <div><img src="../../img/service.png" class="listImg" alt=""></div>
	                        <div>客服</div>
	                    </a>
	                </li> -->
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
		<div class="foot flexLayout">立即维护/立即调货</div>
    </c:if>
	<c:if test="${type_ eq 'bh'}">
		<div class="foot flexLayout">现在补货</div>
    </c:if>
    
    <input type="hidden" value="${value.items.twoImgUrl_ }" id="twoImgUrl_">
    <input type="hidden" value="${value.items.proName_ }" id="proName_">
</div>
<form action="" class="buy_mars">
    <div class="buyCommodity_container">
        <div class="buyCommodity_content">
            <!-- <div class="flexLayout">
                <div class="buyCommodity_img"><img src="../../img/1.jpg" alt=""></div>
                <div class="buyCommodity_message">
                    <div class="buyCommodity_name">索尼微单A500</div>
                    <div class="buyCommodity_price">￥3600</div>
                    <div class="buyCommodity_choose">选择 颜色分类</div>
                </div>
                <div class="close_buy"><img src="../../img/close1.png" alt=""></div>
            </div>
            <div class="hint">颜色分类</div>
            <ul class="color_choose clearfix">
                <li class="color_active">红色</li>
                <li>白色</li>
                <li>金色</li>
                <li>红色</li>
                <li>白色</li>
                <li>金色</li>
            </ul> -->
            
            <ul class="color_choose clearfix">
                <a href="FrmOrder_Lease?orderType_=1&zhuCode_=${value.items.zhuCode_ }"><li class="">自取租赁</li></a>
                <a href="FrmOrder_Lease?orderType_=2&zhuCode_=${value.items.zhuCode_ }"><li class="">送货上门</li></a>
                <a href="FrmOrder_Lease?orderType_=3&zhuCode_=${value.items.zhuCode_ }"><li class="">送货到柜</li></a>
            </ul>
        </div>
        <div class="btn_box"><input type="button" value="取消" style="color: #333;"></div> 
    </div>
</form>
<div id="chooseType">
    <div class="buyCommodity_container">
        <div class="buyCommodity_content">
            <div class="shareImg">
               <%--  <img alt="" src="${cdn}/img/shareFrends.png">  --%>
            </div>
            <div style="height: 2.3rem;">
            </div>
        </div>
        <div class="btn_box cancel"><input type="button" value="取消" style="color: #333;"></div> 
    </div>
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

<script type="text/javascript">
	function rent(){
		$(".chooseMethod").show();
	}
	function cancle(){
		$(".chooseMethod").hide();
	}
</script>


<script type="text/javascript">
var i = 0 ;
var timer;
 
$(document).ready(function(){
  //用jquery方法设置第一张图片显示，其余隐藏
  $('.ig').eq(0).show().siblings('.ig').hide();
   
  //调用showTime()函数（轮播函数）
  showTime();
   
  //当鼠标经过下面的数字时，触发两个事件（鼠标悬停和鼠标离开）
  $('.tab').hover(function(){
    //获取当前i的值，并显示，同时还要清除定时器
    i = $(this).index();
    Show();
    clearInterval(timer);
  },function(){
    //
    showTime();
  });
   
  //鼠标点击左侧的箭头
  $('.btn1').click(function(){
    clearInterval(timer);
    if(i == 0){
      i = 5;//注意此时i的值
    }
    i--;
    Show();
    showTime();
  });
   
  //鼠标点击右侧的箭头
  $('.btn2').click(function(){
    clearInterval(timer);
    if(i == 4){
      i = -1;//注意此时i的值
    }
    i++;
    Show();
    showTime();
  });
   
});
 
 
//创建一个showTime函数
function showTime(){
  //定时器
  timer = setInterval(function(){
    //调用一个Show()函数
    Show();
    i++;
    //当图片是最后一张的后面时，设置图片为第一张
    if(i==5){
      i=0;
    }
  },2000);
}
 
 
//创建一个Show函数
function Show(){
  //在这里可以用其他jquery的动画
  $('.ig').eq(i).fadeIn(300).siblings('.ig').fadeOut(300);
   
  //给.tab创建一个新的Class为其添加一个新的样式，并且要在css代码中设置该样式
  $('.tab').eq(i).addClass('bg').siblings('.tab').removeClass('bg');
   
  /*
   * css中添加的代码：
   * .bg{ background-color: #f00; }
   * */
}
$("#collect").on('click',function(){
    $.ajax({
        url : "FrmCollect.add",
        dataType : 'json',
        type : 'post',
        cache : false,
        async : false,
        data : {
            "zhuCode_" : '${zhuCode_ }',
        },
        success : function(data) {
            if(data.status=='0'){
                $("#collect").addClass("footActive").siblings().removeClass("footActive");
                alert("收藏成功");
            }else{
                $("#collect").removeClass("footActive");
                alert("取消收藏成功");
            }
        },
        error : function() {
            alert("运行错误，请稍后再试");
        }
    });
})

</script>
</body>
</html>