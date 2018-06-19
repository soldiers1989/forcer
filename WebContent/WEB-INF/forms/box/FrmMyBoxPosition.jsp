<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0">
<link rel="stylesheet" href="${cnd }/files/common.css">
<link rel="stylesheet" href="${cnd }/css/user.css">
<link rel="stylesheet" href="${cnd }/css/online_store.css">
<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css" />
<script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
<script src="http://webapi.amap.com/maps?v=1.4.5&key=38397acd2ad476d36d92c16656f7e404&plugin=AMap.Walking""></script>
<title>一启享</title>
</head>
<body>
<div class="header">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">一启享</div>
    <div class="more"><span></span><span></span><span></span></div>
</div>
<div class="header1">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">柜子地址</div>
</div>
  
<div class="main_content" >
    <div id="container"></div>
    <input type="hidden" id="lng">
    <input type="hidden" id="lat">
    <c:if test="${not empty msg}">
        <div style="color: red">${msg}</div>
    </c:if>
	<!--  底部链接 -->
    <!--  <div id="foot_mat"></div>
    <ul class="p_footer">
        <li>
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
        <li class="footActive">
            <a href="FrmMyBoxGroup.nearbyCabinet">
                <div><img src="../../img/nearbyA.png" alt=""></div>
                <div><img src="../../img/nearbyB.png" class="listImg" alt=""></div>
                <div>附近柜</div>
            </a>
        </li>
        <li>
            <a href="FrmMore.userCenter">
                <div><img src="../../img/wodeA.png" alt=""></div>
                <div><img src="../../img/wodeB.png" class="listImg" alt=""></div>
                <div>我的</div>
            </a>
        </li>
    </ul> -->
  
</div>
<script src="../../files/jquery-1.11.3.min.js"></script>
<script src="../../files/rem1.js"></script>
<script src="../../js/modal.js"></script>
<script src="../../js/common.js"></script>
<script>
    $(".classify_list").on("click","li",function(){
        $(this).addClass("listActive").siblings().removeClass("listActive");
        $(this).find(".identification").show().parent().siblings().find(".identification").hide();
        $(".classify_message").hide();
        $(".classify_message").eq($(this).index(0)).show();
    })
</script>
<script type="text/javascript">
var map,geolocation,marker,marker1,lng,lat;
map = new AMap.Map('container', {
    resizeEnable : true,
    zoom: 15,
    center : [ '${position.items.x_}', '${position.items.y_}'],
});
//柜子标记点
marker1 = new AMap.Marker({
    position : [ '${position.items.x_}', '${position.items.y_}'],
    icon:new AMap.Icon({
        image: "${cdn}/img/boxImg.png",
        size: new AMap.Size(42, 64),  //图标大小
        imageSize: new AMap.Size(21,32)
    })
});
marker1.setMap(map);
marker1.setAnimation('AMAP_ANIMATION_DROP');
// 设置label标签
marker1.setLabel({//label默认蓝框白底左上角显示，样式className为：amap-marker-label
    offset : new AMap.Pixel(20, 20),//修改label相对于maker的位置
    content : '${position.items.name_}'
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
        showCircle : false, //定位成功后用圆圈表示定位精度范围，默认：true
        panToLocation : true, //定位成功后将定位到的位置作为地图中心点，默认：true
        zoomToAccuracy : true//定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：fa
    });
    map.addControl(geolocation);
    geolocation.getCurrentPosition();
    AMap.event.addListener(geolocation, 'complete', onComplete,'error', onError);//返回定位信息
    //AMap.event.addListener(geolocation, 'error', onError); //返回定位出错信息
}); 
//解析定位结果
 function onComplete(data) {
    lng = data.position.getLng();
    lat = data.position.getLat();
    $("#lng").val(lng);
    $("#lat").val(lat);
    marker = new AMap.Marker({
        position : [lng, lat],
        icon:new AMap.Icon({
            image: "",
            size: new AMap.Size(0, 0),  //图标大小
            imageSize: new AMap.Size(0,0)
        })
    });
    marker.setMap(map);
    map.setFitView();
   /*  walking.search([lng, lat],['${position.items.x_}', '${position.items.y_}']); */
} 
function onError() {
    alert('定位失败!');
}
//步行导航
var walking = new AMap.Walking({
    map : map
});
//根据起终点坐标规划步行路线
 marker1.on('click', function(e) {
    walking.search([lng, lat],['${position.items.x_}', '${position.items.y_}']);
   /*  alert(lng +"; " +lat) */
}) 
</script>
</body>
</html>