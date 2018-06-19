<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css" />
<script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
<script src="http://webapi.amap.com/maps?v=1.4.5&key=38397acd2ad476d36d92c16656f7e404"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>

<title>一启享</title>
<style type="text/css">
/* * {
  margin: 0;
  padding: 0;
}
 
#igs {
  margin: 0px auto;
  width: 500px;
  height: 320px;
  position: relative;
}
 
.ig {
  position: absolute;
}
 
#tabs {
  position: absolute;
  list-style: none;
  background-color: rgba(255,255,255,.5);
  left: 300px;
  bottom: 10px;
  border-radius: 10px;
  padding: 5px 0 5px 5px;
}
 
.tab{
  float: left;
  text-align: center;
  line-height: 20px;
  width: 20px;
  height: 20px;
  cursor: pointer;
  overflow: hidden;
  margin-right: 4px;
  border-radius: 100%;
  background-color: rgb(200,100,150);
}
 
.btn{
  position: absolute;
  color: #fff;
  top: 110px;
  width: 40px;
  height: 100px;
  background-color: rgba(255,255,255,.3);
  font-size: 40px;
  font-weight: bold;
  text-align: center;
  line-height: 100px;
  border-radius: 5px;
  margin: 0 5px;
}
 
.btn2{
  position: absolute;
  right: 0px;
}
 
.btn:hover{
  background-color: rgba(0,0,0,.7);
}  */

	.p_footer img {
	    width: .37rem;
	    height: .37rem;
	    position: absolute;
	    left: 39%;
	    top: 10%;
	}
	.header1 .search{
	    width: .5rem;
	    height: 0.769rem;
	    background-image: url(../../img/search.png);
	    background-position: center;
	    background-repeat: no-repeat;
	    background-size: 55%;
	    position: absolute;
	    left: 0;
	}
	.head_title{
	    height: 100%;
	}
	.searchBox{
	    background-color: transparent;
	    border: 0;
	    font-size: 0.222rem;
	    font-weight: normal;
	    font-stretch: normal;
	    color: white;
	    height: 98%;
	    width: 70%;
	    padding-left: 0.5rem;
	}
	.more a{
	    display: inline-block;
	    width: 100%;
	    height: 100%;
	    line-height: 0.34rem;
	    padding-top: .1rem;
	    font-size: 0.154rem;
	    font-weight: normal;
	    font-stretch: normal;
	    color: #ffffff;
	}
	.more a img{
	    width: 0.29rem;
	    height: 0.256rem;
	}
	.homepage_commodity_name {
	    padding: .17rem .255rem;
	}
	.homepage_commodity_img {
	    height: 1.8rem;
	    width: 100%;
	}
	.homepage_commodity_img img {
	    width: 100%;
	    height: 100%;
	}
	.main_list{
	
	width:100%;
	background-color:white;
	}
	.main_list li{
	float:left;
	}
	 #mainLi{
	width:5.6rem;
	margin:auto;
	text-align:center;
	padding:0px;
	}
	#mainLi li{
	width:1.3rem;
	padding:0px;
	margin-left:5px;
	margin-bottom:5px;
	}
	
	.main_categories{
	width:1.3rem;
	font-size:0.169rem;
	color:#88213d;
	}
    input::-webkit-input-placeholder {
        color: white;
    }
    input:-ms-input-placeholder {
        color: white;
    }
    input::-moz-placeholder {
        color: white;
    }
    input:-moz-placeholder {
        color: white;
    }
    .swiper-container1{
	    margin: 0 auto;
	    position: relative;
	    overflow: hidden;
	    z-index: 1;
    }
    #homePage .broadcast .swiper-container1{
    	/* width: 100%; */
    	height: .427rem;
    	line-height: .427rem;
    }
    #homePage .swiper-container{
    	padding:0;
    }
      .w{
    	width:5.751rem !important;
    	border-radius: 0.085rem;
    }
    .box{
    	width:100%;
    	height:2.584rem; 
    	background-color:#fff;
    	
}
   .online_commodityList{
    	 overflow: hidden;
         word-break: break-all;
        
    }
    .online_commodityList li{
    	display:inline-block;
    	width: 2.96rem;
    }
  .flow{
    	width:100%;
    	 overflow-x: auto;
         overflow-y: hidden;
    }
    .clearfloat:after{display:block;clear:both;content:"";visibility:hidden;height:0} 
.clearfloat{zoom:1} 
</style>


</head>
<body>
<!-- <div class="header">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">一启享</div>
    <div class="more"><span></span><span></span><span></span></div>
</div> -->
<div class="header1">
    <a  class="search"></a>
    <div class="head_title font18">
        <input type="text" class="searchBox fl" id="searchText" value="" placeholder="搜索你想要的 " onkeydown="searchenter1(this);">
    </div>
<!--     <div class="more">
        <a href="#">
            <div><img src="../../img/saoyisao.png" alt="" id="scanQRCode" onclick="MyAutoRun()"></div>
            <div>扫一扫</div>
        </a>
    </div> -->
</div>
<div class="main_content" id="homePage">
    <div id="mat"></div>
    <!--轮播图-->
    <div class="box">
    <div class="swiper-container ">
    	<div class="swiper-wrapper">
    		<c:forEach items="${lunbo}" var="lunbos">
				<li  class="swiper-slide">
				<a href="${lunbos.items.imgSrc_}"> 
				<img alt="" src="${lunbos.items.imgPath_}"/>
				</a> 
				</li>
			</c:forEach>  
		</div> 
<!--         <div class="swiper-wrapper"> -->
<!--             <div class="swiper-slide"><img src="../../img/1.jpg" alt=""></div> -->
<!--             <div class="swiper-slide"><img src="../../img/2.jpg" alt=""></div> -->
<!--             <div class="swiper-slide"><img src="../../img/3.jpg" alt=""></div> -->
<!--             <div class="swiper-slide"><img src="../../img/4.jpg" alt=""></div> -->
<!--         </div> -->
        <!--如果需要分页器-->
        <div class="swiper-pagination"></div>
        <!--如果需要导航按钮-->
        <!--<div class="swiper-button-prev"></div>-->
        <!--<div class="swiper-button-next"></div>-->
    </div>
    </div>
    <!--公告-->
<!--     <div class="txtMarquee-top broadcast"> -->
<!--      	<div class="fl"><img src="../../img/message.png" alt=""></div> -->
<!-- 			<div class="bd"> -->
<!-- 				<ul class="infoList"> -->
<%-- 					<c:forEach items="${messages}" var="msg"> --%>
<%-- 						<li>${msg.items.content_ }</li> --%>
<%-- 					 </c:forEach> --%>
<!-- 				</ul> -->
<!-- 			</div> -->
<!-- 	</div> -->
    
    <div class="broadcast">
        <div class="fl"><img src="../../img/message.png" alt=""></div>
        <div class="scroll_message swiper-container1">
             <ul class="swiper-wrapper">
                <c:forEach items="${messages}" var="msg">
                    <li class="swiper-slide"><a href="#" style="color: white;">${msg.items.content_ }</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>

   <div class="main_list">    
     <ul class="main_nav pt_15"  style="overflow:hidden;" id="mainLi">
    	<c:forEach items="${values}" var="val" varStatus="vs">   	
				<li > 
					<a href="FrmRentWei.queryFristId?fristNameId_=${val.items.fristNameId_ }">
					 <img src="${val.items.fristImgUrl_ }" alt=""> 
                		<div class="main_categories">${val.items.fristName_ }</div>
					<input type="hidden" value="${val.items.fristNameId_ }" name="fristNameId_">
					</a>
 				</li> 				
		</c:forEach>  
    </ul>
    </div>
    
   <!--  <div><p>-----------热租商品--------</p></div> -->
    
    <c:forEach items="${types}" var="type">
        <div class="homepage_hint flexLayout">
            <div>${type.items.fristName_}</div>
            <a href="FrmRentWei.queryFristId?fristNameId_=${type.items.fristNameId_ }" class="text-gold font10">更多>></a>
        </div>
        <div class="flow">
        <ul class="online_commodityList clearfix">
            <c:forEach items="${coolList}" var="cool">
            <c:if test="${type.items.fristNameId_==cool.items.fristNameId_}">
                <li>
                    <a href="FrmWeiPro?zhuCode_=${cool.items.zhuCode_ }">
                        <div class="homepage_commodity_img"><img src="${cool.items.proZsImges_ }" alt=""></div>
                        <div class="cabinet_address">${cool.items.communityName_}${cool.items.boxId_}号箱子</div>
                        <div class="homepage_commodity_name">${cool.items.proName_ }</div>
                        <div class="homepage_commodity_price">
                        <c:if test="${cool.items.isDiscount_=='0'}"><span class="red" style="margin-right:.1rem">￥${cool.items.dayRentMoney_ }<span class="font10">/天</span></span></c:if>
                        <c:if test="${cool.items.isDiscount_=='1'}"><span class="red" style="margin-right:.1rem">￥${cool.items.discountPrice_ }<span class="font10">/天</span></span>
                        <span class="old_price">￥${cool.items.dayRentMoney_ }/天</span>
                        </c:if></div>
                        <div class="cash_pledge text-gold font10 tl pl_15">
                            <span>押金：￥</span><span>${cool.items.cashPledge_ }</span>
                        </div>
                    </a>
                </li>
            </c:if>
            </c:forEach>
        </ul>
        </div>
    </c:forEach>
    <div id="foot_mat1"></div>
    <ul class="p_footer">
        <li class="footActive">
            <a href="FrmRentWei">
                <div><img src="../../img/guiziA.png" alt=""></div>
                <div><img src="../../img/guiziB.png" class="listImg" alt=""></div>
                <div>首页</div>
            </a>
        </li>
        <li>
            <a href="FrmRentWei.queryFristId">
                <div><img src="../../img/femleiA.png" alt=""></div>
                <div><img src="../../img/fenleiB.png" class="listImg" alt=""></div>
                <div>分类</div>
            </a>
        </li>
        <li>
            <a href="FrmMyBoxGroup.nearbyCabinet">
                <div><img src="../../img/fujinA.png" alt=""></div>
                <div><img src="../../img/fujinB.png" class="listImg" alt=""></div>
                <div>附近柜</div>
            </a>
        </li>
        <li>
            <a href="FrmMore.userCenter">
                <div><img src="../../img/wodeA.png" alt=""></div>
                <div><img src="../../img/wodeA.png" class="listImg" alt=""></div>
                <div>我的</div>
            </a>
        </li>
    </ul>
    <input type="hidden" id="lng">
    <input type="hidden" id="lat">
    <div id="container" style="display: none" ></div>
</div>
	<%-- <div>
		<input type="text" placeholder="搜索你想要的">
	</div>
<!-- 	轮播图 -->
	<div id="igs">
	      <a class="ig" href="#"><img src="${cdn}/img/u=1667315353,561067597&fm=27&gp=0.jpg"/></a>
	      <a class="ig" href="#"><img src="${cdn}/img/u=2465775762,1509670197&fm=72.jpg"/></a>
	      <a class="ig" href="#"><img src="${cdn}/img/u=2661567341,837532549&fm=72.jpg"/></a>
	      <a class="ig" href="#"><img src="${cdn}/img/u=36337156,310763697&fm=27&gp=0.jpg"/></a>
	      <a class="ig" href="#"><img src="${cdn}/img/u=819923729,711931344&fm=27&gp=0.jpg"/></a>
       
      <div class="btn btn1"><</div>
      <div class="btn btn2">></div>
       
	      <ul id="tabs">
	        <li class="tab">1</li>
	        <li class="tab">2</li>
	        <li class="tab">3</li>
	        <li class="tab">4</li>
	        <li class="tab">5</li>
	      </ul>
    </div>
    <div>
    	<p>一启享共享柜子</p>
    	<table>
	    	<c:forEach items="${values}" var="val">
				<tr>
					<td>
					<a href="FrmRentWei.queryByFristId?fristNameId_=${val.items.fristNameId_ }">
					${val.items.fristName_ }</a>
					<input type="hidden" value="${val.items.fristNameId_ }" name="fristNameId_">
					</td>
				</tr>
			</c:forEach>
		</table>
    </div>
    <hr>
    <p>数码科技</p>
    	<table>
    		<tr>
    			<c:forEach items="${digital}" var="val">
    				<td>
    				<img src="${val.items.twoImgUrl_ }">
					123${val.items.proName_ }&
					<c:if test="${val.items.isDiscount==0 }">${val.items.dayRentMoney_ }元/天&</c:if>
					<c:if test="${val.items.isDiscount==1 }">${val.items.discountPrice_ }元/天&</c:if>
					押金${val.items.cashPledge_ }&&||
					</td>
				</c:forEach>
    		</tr>
    	</table>
      <hr>
    <p>奢侈酷玩</p>
    	<table>
    		<tr>
    			<c:forEach items="${cool}" var="val">
    				<td> 
    				<img src="${val.items.twoImgUrl_ }">
					${val.items.proName_ }&
					<c:if test="${val.items.isDiscount==0 }">${val.items.dayRentMoney_ }元/天&</c:if>
					<c:if test="${val.items.isDiscount==1 }">${val.items.discountPrice_ }元/天&</c:if>
					押金${val.items.cashPledge_ }&&||
					</td>
				</c:forEach>
    		</tr>
    	</table> --%>
<script type="text/javascript">
$(function(){
	$(".online_commodityList").each(function(){
		
		var t = $(this).children().length;
		$(this).width(t*3.13 + 0.17 +"rem");
	})
});

function searchenter1(event) {
	document.onkeydown=keyListener;
	   var lng = $("#lng").val();
	    var lat = $("#lat").val();
	    var searchText = $("#searchText").val();
	function keyListener(e){
	    e = e ? e : event;// 兼容FF
	    if(e.keyCode == 13){
	    	 window.location.href="FrmRentWei.searchProduct?submit=submit&lng="+lng+"&lat="+lat+"&searchText="+searchText;
	    }
	}    
}

/* 广告向上滚动 */
var swiper = new Swiper('.swiper-container1', {
        pagination: '.swiper-pagination',
        paginationClickable: true,
        direction: 'vertical',
        autoplay:2000,
        loop: true
    });

</script >
		
<script type="text/javascript">
var browser = {
		versions : function() {
			var u = navigator.userAgent, app = navigator.appVersion;
			return {
				trident : u.indexOf('Trident') > -1, //IE内核
				presto : u.indexOf('Presto') > -1, //opera内核
				webKit : u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
				gecko : u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1,//火狐内核
				mobile : !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端
				ios : !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
				android : u.indexOf('Android') > -1 || u.indexOf('Adr') > -1, //android终端
				iPhone : u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
				iPad : u.indexOf('iPad') > -1, //是否iPad
				webApp : u.indexOf('Safari') == -1, //是否web应该程序，没有头部与底部
				weixin : u.indexOf('MicroMessenger') > -1, //是否微信 （2015-01-22新增）
				qq : u.match(/\sQQ/i) == " qq" //是否QQ
			};
		}(),
		language : (navigator.browserLanguage || navigator.language)
				.toLowerCase()
	}

	if (browser.versions.weixin) {
		//后台获取静默跳转链接，请求获取code，重新执行登录
		var value = '${userCode_}'; 
		if(isEmpty(value)){
			$.ajax({
				type : "GET",
				url : "FrmWeixin.anewLogin",
				dataType : "json",
				async : false,
				success : function(loginUrl) {
					if (loginUrl) {
						window.location.href = loginUrl;
					}
				}
			});
		}
	}
	
	function isEmpty(obj){
	    if(typeof obj == "undefined" || obj == null || obj == ""){
	        return true;
	    }else{
	        return false;
	    }
	}
// 	function query(node){
// 		var fristNameId_=$(node).find("input[type='hidden']").val();
// 		alert(fristNameId_);
// 		$.ajax({
// 			url:"FrmRentWei."
			
// 		})
		
// 	}
</script>



<script type="text/javascript">

/* 初始化轮播图 */
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

/* 底部导航按钮切换 */
$(".p_footer").on("click","li",function(){
    $(this).addClass("footActive").siblings().removeClass("footActive");
});


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
$(".search").on("click",function(){
    var lng = $("#lng").val();
    var lat = $("#lat").val();
    var findWhat =  $("#searchText").val();
    var searchText = $("#searchText").val();
    if(searchText == null || searchText == ""){
    	window.location.href="FrmRentWei.GOTOSearchProduct?lng="+lng+"&lat="+lat;
    }else{
    	 window.location.href="FrmRentWei.searchProduct?submit=submit&lng="+lng+"&lat="+lat+"&searchText="+searchText;
    }
})

    var map, geolocation;
    map = new AMap.Map('container', {
        resizeEnable : true,
    });
    map.plugin('AMap.Geolocation', function() {
        geolocation = new AMap.Geolocation({
            enableHighAccuracy : true,//是否使用高精度定位，默认:true
            timeout : 10000, //超过10秒后停止定位，默认：无穷大
            maximumAge : 0, //定位结果缓存0毫秒，默认：0
            convert : true, //自动偏移坐标，偏移后的坐标为高德坐标，默认：true
            showButton : true, //显示定位按钮，默认：true
            buttonPosition : 'LB', //定位按钮停靠位置，默认：'LB'，左下角
            buttonOffset : new AMap.Pixel(10, 20),//定位按钮与设置的停靠位置的偏移量，默认：Pixel(10, 20)
            showMarker : true, //定位成功后在定位到的位置显示点标记，默认：true
            showCircle : true, //定位成功后用圆圈表示定位精度范围，默认：true
            panToLocation : true, //定位成功后将定位到的位置作为地图中心点，默认：true
            zoomToAccuracy : true
        //定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：fa
        });
        map.addControl(geolocation);
        geolocation.getCurrentPosition();
        AMap.event.addListener(geolocation, 'complete', onComplete,'error', onError);//返回定位信息
        //AMap.event.addListener(geolocation, 'error', onError); //返回定位出错信息
    });
  //解析定位结果
    function onComplete(data) {
        var lng = data.position.getLng();
        var lat = data.position.getLat();
        $("#lng").val(lng);
        $("#lat").val(lat);
    }
    function onError() {
        alert('定位失败!');
    }
    
    
	//=====================================================================下面是微信扫一扫

/* 	wx.error(function(res) {
		alert("出错了：" + res.errMsg);//这个地方的好处就是wx.config配置错误，会弹出窗口哪里错误，然后根据微信文档查询即可。
	});

	wx.ready(function() {
		wx.checkJsApi({
			jsApiList : [ 'scanQRCode' ],
			success : function(res) {

			}
		});

		//点击按钮扫描二维码
		document.querySelector('#scanQRCode').onclick = function() {
			wx.scanQRCode({
				needResult : 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
				scanType : [ "qrCode" ], // 可以指定扫二维码还是一维码，默认二者都有
				success : function(res) {
					var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
					window.location.href = result;//因为我这边是扫描后有个链接，然后跳转到该页面
				}
			});
		};

	});
	
	function MyAutoRun() {
		wx.config({
			debug : false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
			appId : '${appId}', // 必填，企业号的唯一标识，此处填写企业号corpid
			timestamp : '${timestamp}', // 必填，生成签名的时间戳
			nonceStr : '${nonceStr}', // 必填，生成签名的随机串
			signature : '${signature}',// 必填，签名，见附录1
			jsApiList : [ 'scanQRCode' ]
		// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
		});

		wx.ready(function() {
			wx.scanQRCode({
				desc : 'scanQRCode desc',
				needResult : 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
				scanType : [ "qrCode", "barCode" ], // 可以指定扫二维码还是一维码，默认二者都有
				success : function(res) {
					var result = res.resultStr;
					window.location.href = 'FrmLogin?result='+ result;
				},
				error : function(res) {
					if (res.errMsg.indexOf('function_not_exist') > 0) {
						alert('版本过低请升级')
					}
				}
			});
		});
	}; */
	
	
</script>
</body>
<script type="text/javascript" src="${cdn}/js/box/wxlogin.js"></script>
</html>