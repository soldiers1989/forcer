<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
<link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css" />
<script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
<script src="http://webapi.amap.com/maps?v=1.4.5&key=38397acd2ad476d36d92c16656f7e404&plugin=AMap.Walking""></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<title>一启享</title>
<style type="text/css">
.amap-logo {
	opacity: 0;
}

.amap-copyright {
	opacity: 0;
}

#panel {
	position: fixed;
	background-color: white;
	max-height: 90%;
	overflow-y: auto;
	top: 10px;
	right: 10px;
	width: 280px;
}
#container{
	width: 100%;
	height: 7.25rem;
	margin-top: .769rem;
}
.more img {
    width: .51rem;
}
.footer{
	width:100%;
	height:.769rem;
	position:fix;
	bottom:0;
	z-index:1000;
	
}
.footer  a{
	display:inline-block;
	width:50%;
	height:100%;
	font-size: .255rem;
	text-align:center;

	line-height:.769rem;
	background-color:#fafafa;
	box-sizing:border-box;
}
.footer a:first-child{
	border-right:.001rem solid #AFAFAF;
}
.operation_list li a div{
	width:100%;
	height:100%;
}
</style>
</head>
<body style="background-color:#fff">
	<div class="header2" style="background-color:#fff">
	    <!-- <a href="javascript:history.go(-1);" class="prev"></a> -->
	    <div class="head_title font18" id="fenxiang" onclick="MyAutoRun()">首页</div>
	    <div class="more"><img src="../../img/sys.png" alt="" id="scanQRCode" onclick="MyAutoRun()"></div>
	</div>
	<div id="container"></div>
	
	<div class="Administrator_operation">
		<ul class="operation_list flexLayout">
			<li class="border_r yunActive">
				<a href="FrmMyCabinet">
					<img alt="" src="${cdn }/img/yunA.png">
					<img alt="" src="${cdn }/img/yunB.png" class="listImg">
					<div>我的柜组</div>	
				</a>
			</li>	
			<li>
				<a href="FrmYwManage">
					<img alt="" src="${cdn }/img/yunC.png">
					<img alt="" src="${cdn }/img/yunD.png" class="listImg">
					<div>运维管理</div>	
				</a>
			</li>	
		</ul>	
		<ul class="operation_list flexLayout">
			<li class="border_r">
				<a href="FrmNewslistYunWei">
					<img alt="" src="${cdn }/img/yunE.png">
					<img alt="" src="${cdn }/img/yunF.png" class="listImg">
					<div>消息管理</div>
				</a>
			</li>
			<li>
				<a href="FrmGongYiCabinet">
					<img alt="" src="${cdn }/img/yunA.png">
					<img alt="" src="${cdn }/img/yunB.png" class="listImg">
					<div>公益柜组</div>	
				</a>
			</li>
		</ul>
	</div>
		<div class="footer">
		<a href="FrmMap">首页</a><a href="FrmMyCenter">我的</a>
		</div>
</body>
<script type="text/javascript">
	var x;
	var y;

	var map, geolocation, marker;
	map = new AMap.Map('container', {
		resizeEnable : true,
		zoom : 14,
		center : [ 113.861418, 22.579594 ]
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
		AMap.event.addListener(geolocation, 'error', onError); //返回定位出错信息

		//这个地方循环出附近的柜子标记即可
		marker = new AMap.Marker({
			position : [ 113.861418, 22.579594 ],
			icon : 'http://webapi.amap.com/theme/v1.3/markers/n/mark_b.png',
		});
		marker.setMap(map);
		marker.setAnimation('AMAP_ANIMATION_DROP');
		// 设置label标签
		marker.setLabel({//label默认蓝框白底左上角显示，样式className为：amap-marker-label
			offset : new AMap.Pixel(20, 20),//修改label相对于maker的位置
			content : "柜子1"
		});
		marker.on('click', function(e) {
			alert('柜子1');
			walking
					.search([ 113.867029, 22.572719 ],
							[ 113.861418, 22.579594 ]);
		})

		marker = new AMap.Marker({
			position : [ 113.861333, 22.579224 ],
			icon : 'http://webapi.amap.com/theme/v1.3/markers/n/mark_b.png',
		});
		marker.setMap(map);
		marker.setAnimation('AMAP_ANIMATION_DROP');
		// 设置label标签
		marker.setLabel({//label默认蓝框白底左上角显示，样式className为：amap-marker-label
			offset : new AMap.Pixel(20, 20),//修改label相对于maker的位置
			content : "柜子2"
		});
		marker.on('click', function(e) {
			alert('柜子2');
			walking
					.search([ 113.867029, 22.572719 ],
							[ 113.861333, 22.579224 ]);
		})

		function onError() {
			var str = '定位失败,';
			str += '错误信息：'
			switch (data.info) {
			case 'PERMISSION_DENIED':
				str += '浏览器阻止了定位操作';
				break;
			case 'POSITION_UNAVAILBLE':
				str += '无法获得当前位置';
				break;
			case 'TIMEOUT':
				str += '定位超时';
				break;
			default:
				str += '未知错误';
				break;
			}
			alert(str)
		}
	});
	//步行导航
	var walking = new AMap.Walking({
		map : map
	});
	//根据起终点坐标规划步行路线
	walking.search([ 113.867029, 22.572719 ], [ 113.861418, 22.579594 ]);
	/*// 实例化点标记
	function addMarker(x,y) {
	    marker = new AMap.Marker({
	        position: [x, y],
	        icon : 'http://webapi.amap.com/theme/v1.3/markers/n/mark_b.png',
	    });
	    marker.setMap(map);
	    marker.setAnimation('AMAP_ANIMATION_DROP');
	    // 设置label标签
	    marker.setLabel({//label默认蓝框白底左上角显示，样式className为：amap-marker-label
	        offset: new AMap.Pixel(20, 20),//修改label相对于maker的位置
	        content: "柜子"
	    });
	} */
	//为地图注册click事件获取鼠标点击出的经纬度坐标
	var clickEventListener = map.on('click', function(e) {
		x = e.lnglat.getLng();
		y = e.lnglat.getLat();
		alert(x + '----' + y);
	});

	//=====================================================================下面是微信扫一扫
	

	/* wx.error(function(res) {
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
			
			/* // 朋友圈
			wx.onMenuShareTimeline({
			    title: '登录试试', // 分享标题
			    link: 'http://yqx2018.lucland.com/forms/FrmLogin', // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
			    imgUrl: 'http://hg-oss-yf2.oss-cn-beijing.aliyuncs.com/ZHAOSHIFU/CONSULT/IMG/3a6053eb-d009-4ff2-a778-52cd30f3cfba.jpeg', // 分享图标
			    success: function () {
			    // 用户确认分享后执行的回调函数
			},
			cancel: function () {
			    // 用户取消分享后执行的回调函数
			    }
			});
			
			// 好友
			wx.onMenuShareAppMessage({
				title: '登录试试', // 分享标题
				desc: '登录试试', // 分享描述
				link: 'http://yqx2018.lucland.com/forms/FrmLogin', // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
				imgUrl: 'http://hg-oss-yf2.oss-cn-beijing.aliyuncs.com/ZHAOSHIFU/CONSULT/IMG/3a6053eb-d009-4ff2-a778-52cd30f3cfba.jpeg', // 分享图标
				success: function () {
				// 用户确认分享后执行的回调函数
				},
				cancel: function () {
				// 用户取消分享后执行的回调函数
				}
			}); */
		//});
	//}; 
	
	/* 按钮切换 */
	$(".Administrator_operation").on("click",".operation_list li",function(){
	    $(this).addClass("yunActive").siblings().removeClass("yunActive").parent(".operation_list").siblings().find("li").removeClass("yunActive");
	});
</script>
</html>