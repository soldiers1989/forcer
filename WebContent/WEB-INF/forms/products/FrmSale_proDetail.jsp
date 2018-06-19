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
    .colorBox{
    padding:.17rem;
     background-color:#fff;
    }
    .colorBoxDetail{
    	box-sizing: border-box;
    }
    .color_pic{
    	width:40%;
    }
    .color_mess{
    	width:60%;
    	background-color:#fff;
    	font-size: 0.256rem;
    	line-height:.425rem;
    	
    }
    .mr_2{
    	margin-right:.2rem;
    }
    .color_fc{
    	color:#c90d00;
    }
    .color_fc2{
    	color:#a0791a;
    }
    .color_classify{
    	width:100%;
    	line-height:.4rem;
    	padding:  .246rem .246rem 0;
    	box-sizing: border-box;
    }
    .color_btn{
    	
    }
    .color_choo{
    	width:100%;
    	padding:0 .17rem .17rem;;
    	box-sizing: border-box;
    	background-color:#fff;
    }
    .color_choo .color_btn{
    	padding:.1rem .4rem;
    	border:1px solid #f5f5f5;
    	margin:0 .17rem .17rem 0;
    	min-width:.4rem;
    	display: block;
   		min-width: .8rem;
    	float: left;
    	text-align: center;
    }
    .selet_color{
    	width:100%;
    	position:fixed;
    	bottom:0;
    	z-index:1000;
    }
    .color_btnGroup{
    	width:100%;
    	padding: .17rem;
   		box-sizing: border-box;
    }
    .isAcitve{
    	color: #a0791a;
    	background-color: rgba(207, 176, 101, 0.2);
		border-radius: 0.051rem;
		border: solid 1px #a0791a !important;

    }
    .sureColor{
    }
    .sureColor_btn{
    	width:100%;
    	margin-top:.3rem;
    	padding:.17rem 0;
    	text-align:center;
    	margin-top:.3rem;
    	padding:.1rem 0rem;
    	text-align:center;
    	border:none;
    	color:#fff;
    	background-color:#88213d;
    	border-radius:.05rem;
    }
    #sureColor{
   		margin-top:.3rem;
    	padding:.1rem .17rem;
    	text-align:center;
    	border:none;
    	color:#fff;
    	background-color:#88213d;
    	border-radius:.05rem;
    	
    }
    .flat{
    	width:100%;
    	height:100%;
    	BACKGROUND-COLOR:#c5c9ce8f;
    	z-index:1000;
    	position:fixed;
    	bottom:0;
    }
    .main_content{
    	height:auto !important;
    }
.clearfloat:after{display:block;clear:both;content:"";visibility:hidden;height:0} 
.clearfloat{zoom:1}
    </style>
</head>
<body>
<!--颜色-->
 <div class="flat">
 	<div class="selet_color" >
   

	<div style="" id="color" >
	<div class="colorBox ">
		<div class="colorBoxDetail flexLayout">
			<div class="color_pic">
				<img alt="" src="${proZsImges_ }">
			</div>
			<div class="color_mess">
				<div><span>${value.items.proName_ }</span></div>
				<div><span class="mr_2 color_fc">${value.items.salePrice_ }元</span><span  class="font12 color_fc2">会员价</span><span  class="font12 color_fc2">${value.items.saleMemPrice_ }元</span></div>
			</div>
		</div>
	</div>
		<div class="color_choo">
			<div class="color_classify">
            	<span>颜色分类</span>
       		</div>
			<!-- <p>颜色分类</p> -->
			<div class="color_btnGroup clearfloat">
			<c:forEach items="${color }" var="co">
				<span class="color_btn">${co.items.saleProColor_ } </span><input type="hidden" value="${co.items.ruKuId_ }" >
			</c:forEach>
			</div>
			<div class="sureColor_btn" id="sureColor">确定</div>
				<!-- <input type="button" value="" id="sureColor"> -->
		</div>
		</div>
	</div>
</div> 


	<!-- <div>商品租赁</div>
	<p>商品详情</p> -->
<div class="header">
    <a href="FrmRentWei" class="prev"></a>
    <div class="head_title font18">一启享</div>
    <div class="more"><span></span><span></span><span></span></div>
</div>
<div class="header1">
	<c:if test="${empty type_}">
   		<a href="FrmRentWei" class="prev"></a>
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
            <p><span>${value.items.salePrice_ }元</span>   <span>会员价</span><span>${value.items.saleMemPrice_ }元</span></p>
        </div>
        <div class="commodity_delivery">
            <div class="font10"><span>快递：<c:if test="${value.items.posTage_!= '' && value.items.posTage_ != null }">${value.items.posTage_ }元  </c:if>
    		<c:if test="${value.items.posTage_== '' || value.items.posTage_== null }">免邮费</c:if> </span></div>
        </div>
    </div>

<%-- 	 <div class="withdraw">
	 <a href="FrmRentWei.searchSaleProduct?searchText=${value.items.proName_ }">
        <div class="option_left">
            <span>我要购买</span>
        </div>
        <div class="option_right ">
            <img src="../../img/right.png">
        </div> 
        </a>
    </div> --%>

 	
			
	</div>
	
	
	 <div class="recharge">
    	<a href="#" id="chooseColor">
        	<div class="option_left" style="width:100%">
            	<span>选择颜色分类</span>
       		</div>
        </a>
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
	        <div class="right_buy fr">我要购买</div>
    	</div>
    </c:if>
    <input type="hidden" value="${value.items.twoImgUrl_ }" id="twoImgUrl_">
    <input type="hidden" value="${value.items.proName_ }" id="proName_">
</div>
<div id="chooseType">
    <div class="buyCommodity_container">
        <div class="buyCommodity_content">
            <div class="shareImg">
                <img alt="" src="${cdn}/img/shareFrends.png">
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
<script type="text/javascript">
	$("#chooseColor").on("click",function(){
		$("#color").show();
	})
	$("#sureColor").on("click",function(){
		$("#color").hide();
	})
</script>
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
    	$(".color_btnGroup ").find("span").each(function(){
    		var qwe=$(this).attr("class");
    		alert(qwe);
    	})
       /*  $(".buy_mars").show();
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
        }); */
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

<script>
$(function(){
	
	$(".flat").hide();
	$("body").on("click",".color_btn",function(){
		$(this).addClass("isAcitve").siblings().removeClass("isAcitve");
	})
	
	$(".recharge").on("click",function(){
		$(".selet_color").show();
		$(".selet_color").show();
		$(".flat").show();
	})
	$(".sureColor").on("click",function(){
		
		$(".flat").hide();
	})
	
})

</script>
</body>
</html>