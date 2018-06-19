<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>百姓健康</title>
<link rel="stylesheet" href="${cdn}/admin/css/base.css">
<script src="${cdn}/admin/js/jquery-1.9.1.min.js"></script>
<style>
body {
	font-family: \5FAE\8F6F\96C5\9ED1;
	overflow: auto;
}

.header {
	background: #fff;
	height: 100px;
	overflow: hidden;
}

.hd-menu ul li {
	float: right;
	margin-left: 20px;
	color: #000;
	font-weight: bold;
}

.hd-menu p {
	font-size: 30px;
	color: #48b2bd;
	height: 28px;
	line-height: 25px;
	padding-left: 40px;
	margin: 22px 0;
	background: url("${cdn}/admin/images/icon/icon-phone.png") left center
		no-repeat;
}

.wrap {
	width: 1200px;
	margin: 0 auto;
}

.ban {
	width: 100%;
	height: 730px;
	background: url("${cdn}/admin/images/intro-icon-banbg.png") repeat-x
		left top;
}

.ban-left {
	width: 430px;
}

.ban-left .name {
	display: block;
	margin: 160px 0 100px 0;
	color: #fff;
	font-size: 46px;
}

.banlist-txt {
	position: relative;
}

.banlist-txt span {
	display: none;
	position: absolute;
	right: 0;
	top: 50%;
	margin-top: -79px;
}

.ban-ul li {
	width: 198px;
	height: 60px;
	line-height: 61px;
	border: 1px solid #d8f0ee;
	margin-bottom: 20px;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	text-indent: 60px;
	background: none;
	color: #fff;
	cursor: pointer;
}

.ban-ul li a {
	color: #d8f0ee;
	font-size: 18px;
}

.ban-ul li.curr a {
	color: #48b2bd;
	font-size: 18px;
}

.ban-ul li.icon1 {
	background: url("${cdn}/admin/images/intro-wx-on.png") 24px center
		no-repeat;
}

.ban-ul li.icon2 {
	background: url("${cdn}/admin/images/intro-ios-on.png") 24px center
		no-repeat;
}

.ban-ul li.icon3 {
	background: url("${cdn}/admin/images/intro-icon-android-on.png") 24px
		center no-repeat;
}

.ban-ul li.curr.icon1 {
	background: #d8f0ee url("${cdn}/admin/images/intro-wx-off.png") 24px
		center no-repeat;
}

.ban-ul li.curr.icon2 {
	background: #d8f0ee url("${cdn}/admin/images/intro-ios-off.png") 24px
		center no-repeat;
}

.ban-ul li.curr.icon3 {
	background: #d8f0ee
		url("${cdn}/admin/images/intro-icon-android-off.png") 24px center
		no-repeat;
}

.ban-right {
	width: 755px;
	margin-top: 100px;
}

.proct-list {
	margin-top: 116px;
	margin-bottom: 116px;
	overflow: hidden;
}

.proct-list ul li {
	float: left;
	width: 299px;
	text-align: center;
	border-right: 1px solid #e6e6e6;
}

.proct-list ul li:hover p {
	color: #48b2bd;
}

.proct-list ul li.none {
	border: 0;
}

.proct-list ul li p {
	margin-top: 20px;
}

.welc-box img {
	width: 100%;
}

.mincon-til {
	display: block;
	margin: 100px auto;
	text-align: center;
	font-size: 40px;
}

.mincon-list {
	border: 1px solid #e6e6e6;
	text-align: center;
	margin-bottom: 100px;
}

.mincon-list .item {
	display: inline-block;
	margin: 30px 15px;
}

.mincon-list .item p {
	margin: 10px 0;
}

.mincon-list .item img {
	width: 191px;
	height: 191px;
	border-radius: 5px;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	-ms-border-radius: 5px;
	-o-border-radius: 5px;
}

.mincon-list .item img.wx {
	width: 182px;
	height: 182px;
	padding: 4px;
	border: 1px solid #e6e6e6;
	border-radius: 5px;
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	-ms-border-radius: 5px;
	-o-border-radius: 5px;
}

.footer {
	background: #04474e;
	height: 102px;
	line-height: 102px;
	color: #fff;
}

.footer .copyright {
	line-height: 25px;
	color: #ddd;
	text-align: center;
}

.footer .copyright a {
	color: #ddd;
}
</style>
<script>
	$(function() {
		var tab = $("#Tab");
		var codelist = $("#wx_codelist");
		tab.find("li").on("click", function() {
			tab.find("li").removeClass("curr");
			$(this).addClass("curr");
			var _index = $(this).index();
			console.log(_index)
			codelist.find("span").eq(_index).show().siblings("span").hide();
		})

	})
</script>


</head>
<body>
    <div class="header">
        <div class="wrap">
            <div class="fl" style="margin-top: 25px;">
                <h1 class="logo"><a href="introduce"><img src="${cdn}/admin/images/intro-icon-logo.png"  > </a> </h1>
            </div>
            <div class="fr hd-menu">
                <p>400-888-3918</p>
                <div>
                    <ul>
                        <li><a href="http://www.zhongyinginfo.com"  target="_blank">关于我们</a> </li>
                        <!-- <li><a href="#">意见反馈</a> </li> -->
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="ban">
        <div class="wrap">
            <div class="ban-right fr">
                <img src="${cdn}/admin/images/intro-icon-img1.png" width="755" height="541">
            </div>
            <div class="ban-left fl">
                <h2 class="name">
                    百姓健康<br><br><br><span style="font-size: 25px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;百姓健康信息服务平台</span>
                </h2>
                <div class="banlist-txt">
                    <div class="ban-ul" id="Tab">
                        <ul>
                            <li class="curr icon1"><a href="javascript:;">微信公众号</a> </li>
                            <li class="icon2"><a href="javascript:;">App Store下载</a> </li>
                            <li class="icon3"><a href="javascript:;">Android下载</a> </li>
                        </ul>
                    </div>
                    <div id="wx_codelist">
                        <span style="display: block;">
                            <img src="${cdn}/admin/images/zhong_wx.png" width="158" height="158">
                        </span>
                        <span>
                            <img src="${cdn}/admin/images/zhong_ios.png" width="158" height="158">
                        </span>
                        <span>
                            <img src="${cdn}/admin/images/zhong_android.png" width="158" height="158">
                        </span>
					</div>
                </div>
            </div>
        </div>
    </div>

    <div class="con-mind">
        <div class="wrap">
            <div class="proct-list" style="display: none;">
                <ul>
                    <li>
                        <a href="#">
                            <img src="${cdn}/admin/images/intro-icon-ic1.png" width="140" height="140">
                            <p>病例档案 在线查看</p>
                        </a>
                    </li> <li>
                        <a href="#">
                            <img src="${cdn}/admin/images/intro-icon-ic2.png" width="140" height="140">
                            <p>预约医生 线上挂号</p>
                        </a>
                    </li> <li>
                        <a href="#">
                            <img src="${cdn}/admin/images/intro-icon-ic3.png" width="140" height="140">
                            <p>即时推送 健康知识</p>
                        </a>
                    </li> <li class="none">
                        <a href="#">
                            <img src="${cdn}/admin/images/intro-icon-ic4.png" width="140" height="140">
                            <p>一键查看 健康服务</p>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
	<div class="welc-box">
		<div>
			<img src="${cdn}/admin/images/welc1.png">
		</div>
		<div>
			<img src="${cdn}/admin/images/welc2.png">
		</div>
		<div>
			<img src="${cdn}/admin/images/welc3.png">
		</div>
		<div>
			<img src="${cdn}/admin/images/welc4.png">
		</div>
		<div>
			<img src="${cdn}/admin/images/welc5.png">
		</div>
		<div>
			<img src="${cdn}/admin/images/welc6.png">
		</div>
	</div>
	
	<div>
		<div class="wrap">
			<h2 class="mincon-til">百姓健康，您身边的健康管家</h2>
			<div class="mincon-list">
				<div class="item"><a  target="_blank" href="https://itunes.apple.com/cn/app/zhong-ying-jian-kang/id1193866106?mt=8">
					<img src="${cdn}/admin/images/wx_ios.png">
					<p>App Store下载</p></a>
				</div>
				<div class="item"><a  target="_blank" href="http://zhushou.360.cn/detail/index/soft_id/3664867?recrefer=SE_D_">
					<img src="${cdn}/admin/images/wx_adro.png">
					<p>Android下载</p></a>
				</div>
				<div class="item">
					<img src="${cdn}/admin/images/zhong_wx.png" class="wx">
					<p>微信公众号</p>
				</div>
			</div>
		</div> 
	</div>
    <div class="footer">
        <div class="wrap">
            <div class="fr" style="display: none;">
                <span><a href="#"><img src="${cdn}/admin/images/intro-icon-fotwx.png"> </a> </span>
                <span><a href="#"><img src="${cdn}/admin/images/intro-icon-fotqq.png"></a> </span>
                <span><a href="#"><img src="${cdn}/admin/images/intro-icon-fotwb.png"> </a></span>
            </div>
            <p class="copyright" style="padding-top:25px;">陕ICP备案15004481号 西卫网审[2015]53号</p>
            <p class="copyright"><a href="http://www.zhongyinginfo.com" target="_blank">Copyright◎西安众盈医疗信息科技有限公司</a></p>
        </div>
    </div>
</body>
</html>