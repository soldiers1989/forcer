<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css" />
<script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
<script src="http://webapi.amap.com/maps?v=1.4.5&key=38397acd2ad476d36d92c16656f7e404"></script>
<title>一启享</title>
<style>
    #fristName_{
            border: 0; 
            background: transparent;
    }
    .header1 .more{
        width: .5rem;
        text-align: right;
    }
    .header1 input{
        background-color: transparent;
        border: 0;
        color: #ffffff;
        -webkit-appearance: button;
        width: 1.3rem;
    }
    .head_title img{
        width: 0.3rem;
        height: .17rem;
        margin-left: .1rem;
    }
    .head_title.rotateActive img{
        transform: rotate(-180deg);
        /*transition: all .2s linear;*/
    }
    .head_title select option{
        /*background-color: #88213d;*/
        background-color: #00000085;
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
</style>
</head>
<body>
    <div class="header1">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">
        <c:choose>
                <c:when test="${twoName_!=''&&twoName_!=null}">
                    <input type="text" name="name" value="${twoName_}" readonly="readonly"/>
                </c:when>
                <c:otherwise>
                    <input type="text" name="name" value="${fristName_}" readonly="readonly"/>
                </c:otherwise>
            </c:choose>
        <img src="../../img/down.png" alt="" id="name">
    </div>
    <div class="more" id="search1"><img src="../../img/search.png" alt=""></div>
</div>
<div class="main_content" id="rent_list">
    <div id="mat"></div>
    <ul class="classify_sort flexLayout">
        <li  class="${sort == null ? 'navActive' : ''}">
			<a href="FrmRentWei.queryByFristId?fristNameId_=${frist}&twoNameId_=${two}">默认排序</a>
		</li>
		<li class="${sort == 'p.price_' ? 'navActive' : ''}">
			<a href="FrmRentWei.queryByFristId?fristNameId_=${frist}&twoNameId_=${two}&sort=p.price_">价格最低</a>
		</li>
		<li class="${sort == 'p.proSaleCount_' ? 'navActive' : ''}">
			<a href="FrmRentWei.queryByFristId?fristNameId_=${frist}&twoNameId_=${two}&sort=p.proSaleCount_">最热好物</a>
		</li>
    </ul>
    <ul class="online_commodityList clearfix">
        <c:forEach items="${value}" var="val" >
            <li>
                <a href="FrmWeiPro?zhuCode_=${val.items.zhuCode_}">
                    <div class="homepage_commodity_img"><img src="${val.items.proZsImges_ }" alt=""></div>
                    <div class="cabinet_address">${val.items.communityName_}${val.items.boxId_}号箱子</div>
                    <div class="homepage_commodity_name">${val.items.proName_ }</div>
                    <div class="homepage_commodity_price">
                        <c:if test="${val.items.isDiscount_=='0' }">
                            <div class="homepage_commodity_price"><span class="red">￥${val.items.dayRentMoney_ }</span></div>
                        </c:if>
                        <c:if test="${val.items.isDiscount_=='1' }">
                            <div class="homepage_commodity_price"><span class="red">￥${val.items.discountPrice_ }</span><span class="old_price">￥${val.items.dayRentMoney_ }</span></div>
                        </c:if>
                    </div>
                    <div class="cash_pledge text-gold font10 tl pl_15"><span>押金：￥</span><span>${val.items.cashPledge_ }</span></div>
                </a>
            </li>
        </c:forEach>
    </ul>
    <c:if test="${empty value}">
        <div>暂无数据</div>
    </c:if>
    <input type="hidden" id="lng">
    <input type="hidden" id="lat">
</div>
<div id="container" style="display: none" ></div>
</body>
<script type="text/javascript">

//根据一级分类查询
	$("#name").on("click",function(){
		window.location.href="FrmRentWei.queryFristId?fristNameId_=${frist}";
	})
    $("#search1").on("click",function(){
        var lng = $("#lng").val();
        var lat = $("#lat").val();
        window.location.href="FrmRentWei.searchProduct?fristNameId_=${frist}&lng="+lng+"&lat="+lat;
    })
    
    //  菜单切换
    $("body").on("click",".classify_sort li",function(){
        $(this).addClass("navActive").siblings().removeClass("navActive")
    });
    /* $(".header1").on("click",".head_title",function(){
        if($(this).hasClass("rotateActive")){
            $(this).removeClass("rotateActive");
        }else{
            $(this).addClass("rotateActive");
        }
    }); */
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
</script>
</html>