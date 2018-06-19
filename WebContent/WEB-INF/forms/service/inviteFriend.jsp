<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
 <script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<title>邀请好友</title>
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
    <a href="FrmMore.userCenter" class="prev"></a>
    <div class="head_title font18">邀请好友</div>
    <div class="more">
  		<a href="FrmMyServices.myShare">我的分享</a>  
    </div>
</div>
<div class="main_content" id="inviteFriend">
    <div id="mat"></div>
    <div class="inviteFriend_title text-gold">分享有“<span class="gift">礼</span>”</div>
    <div class="font15 inviteFriend_hint">1、分享给好友，好友注册即可获得<span class="text-gold">1000元</span>减免押金金额</div>
    <div class="font15 mt_10 inviteFriend_hint">2、您每邀请1位好友注册并体验启享服务，即可获得<span class="text-gold">10积分</span>奖励，邀请人数越多，积分累计越多</div>
    <div class="inviteFriend_img mt_30"><img alt=""  src="FrmMyServices.createQR"></div>
    <div class="font12 text-gray">
        <div>请使用微信扫一扫，扫码关注公众号</div>
        <div>最终解释权一启享所有</div>
    </div>
    <input type="hidden" value="FrmMyServices.createQR" id="twoImgUrl_">
    <input type="hidden" value="${name_}邀请您注册一启享" id="proName_">
</div>
<!-- <a href="#" class="order_addAddress">分享给好友</a> -->
	<a id="share"  class="order_addAddress">
        	分享给好友
    </a>

   <!-- <div >
       <img alt=""  src="FrmMyServices.createQR">
       <p>最终解释权一启享所有</p>
       <p>请使用微信扫一扫，扫码关注公众号</p>
   </div> -->
<div id="chooseType">
    <div class="buyCommodity_container">
        <div class="buyCommodity_content">
            <div class="shareImg">
                <img alt="" src="${cdn}/img/shareFrends.png">
                <div style="height: 2.3rem;">
                </div>
            </div>
        </div>
        <div class="btn_box cancel"><input type="button" value="取消" style="color: #333;"></div> 
    </div>
</div>
 <script type="text/javascript" src="${cdn}/js/share/share.js"></script>
</body>
</html>