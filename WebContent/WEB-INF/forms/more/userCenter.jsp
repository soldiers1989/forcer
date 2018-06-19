<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cldn}/js/jquery-1.9.1.min.js"></script>
<title>个人中心</title>
</head>
<style type="text/css">
.attention {
	border: 1px solid white;
	border-radius: .34rem;
	padding: .05rem .17rem;
	color: white;
}
#myMessage .specific_num{
	line-height: .35rem;
}
</style>
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
</script>

<script type="text/javascript">
//签到
function tijiao() {
	$.ajax({
		url : 'FrmMore.sign',
		dataType : 'json',
		type : 'post',
		cache : false,
		success : function(data) {
			if (data == false) {
				window.location.reload();
			} else {
				window.location.reload();
			}
		}
	});
}
//取消签到
function cancel() {
	$.ajax({
		url : ' FrmMore.concerSign',
		dataType : 'json',
		type : 'post',
		cache : false,
		success : function(data) {
			if (data == false) {
				window.location.reload();
			} else {
				window.location.reload();
			}
		}
	});
}
</script>

<body>
<!-- <div class="header">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">一启享</div>
</div> -->
<div class="main_content" id="myMessage">
    <div class="my_message">
        <div class="mySet tr">
            <a href="FrmSetUp"><img src="../../img/mySet.png" alt=""></a>
            <a href="FrmMessageClass"><img src="../../img/myMessage.png" alt=""></a>
        </div>
        <div class="basic_message flexLayout pl_15 mt_10">
            <div class="my_img"><a href="#"><img src="${user.items.imgUrl_ }" alt=""></a></div>
            <div class="my_nameAndPhone">
                <div class="my_name">
                    <span class="font18">${user.items.name_ }</span>
                    <img src="../../img/vip.png" alt="">
                </div>
                <div class="my_phone font14">
                   ${user.items.mobile_ }
                </div>
            </div>
            <div class="my_sign tr">
        	  <a href="FrmMore.lijiqiandao">立即签到</a>
            </div>
        </div>
        <div class="kinds_num flexLayout">
            <div>
                <span class="right_line"></span>
                <a href="FrmMyWallet?overMoney_=<fmt:formatNumber value="${user.items.overMoney_ }" pattern=".00"/>">
                    <div class="specific_num font17">
                    	<c:if test="${user.items.overMoney_  != null}">
                    		<fmt:formatNumber value="${user.items.overMoney_ }" pattern=".00"/>
                    	</c:if>
                    	<c:if test="${user.items.overMoney_  eq null}">
                    		<fmt:formatNumber value="0" pattern=".00"/>
                    	</c:if>
                    </div>
                    
                    <div class="num_hint font10">余额</div>
                </a>
            </div>
            <div>
                <span class="right_line"></span>
                <a href="FrmOrder_My.getCashPledge?totCashPledge_=${totCashPledge_ }">
                <c:if test="${not empty totCashPledge_}">
                    <div class="specific_num font17">${totCashPledge_ }</div>
                </c:if>
                <c:if test="${empty totCashPledge_}">
                    <div class="specific_num font17">0</div>
                </c:if>
                    <div class="num_hint font10">押金</div>
                </a>
            </div>
            <div>
                <span class="right_line"></span>
                <a href="FrmCouponState">
	                <c:if test="${not empty couponAll.items.couponAll}">
	                    <div class="specific_num font17">${couponAll.items.couponAll}</div>
	                </c:if>
	                <c:if test="${empty couponAll.items.couponAll}">
	                    <div class="specific_num font17">0</div>
	                </c:if>
                    <div class="num_hint font10">代金券</div>
                </a>
            </div>
            <div>
                <a href="FrmIntegral.integral">
                <c:if test="${not empty signNum.items.signNum}">
                    <div class="specific_num font17">${signNum.items.signNum }</div>
                </c:if>
                <c:if test="${empty signNum.items.signNum }">
                    <div class="specific_num font17">0</div>
                </c:if>
                    <div class="num_hint font10">积分</div>
                </a>
            </div>
        </div>
    </div>
    <div class="myOrder_hint mt_10">
        <a href="FrmOrder_My.execute" class="flexLayout border_b">
            <span>我的订单</span>
           <div><img src="../../img/rightArrows.png" alt=""></div>
        </a>
    </div>
    <ul class="my_operation flexLayout pt_10">
        <li>
            <a href="FrmOrder_My.execute?falg=1">
                <div class="operation_logo"><img src="../../img/stay_deliverGoods1.png" alt=""></div>
                <div class="operation_hint">待发货/开箱</div>
            </a>
        </li>
        <li>
            <a href="FrmOrder_My.execute?falg=2">
                <div class="operation_logo"><img src="../../img/stay_getGoods1.png" alt=""></div>
                <div class="operation_hint">待收货/取件</div>
            </a>
        </li>
        <li>
            <a href="FrmOrder_My.execute?falg=3">
                <div class="operation_logo"><img src="../../img/ing1.png" alt=""></div>
                <div class="operation_hint">租用中</div>
            </a>
        </li>
        <li>
            <a href="FrmOrder_My.execute?falg=5">
                <div class="operation_logo"><img src="../../img/stay_evaluate.png" alt=""></div>
                <div class="operation_hint">待评价</div>
            </a>
        </li>
    </ul>
    <div class="myOrder_hint mt_10">
        <a href="#" class="flexLayout border_b">
            <span>我的服务</span>
        </a>
    </div>
    <ul class="my_service flexLayout" style="padding-bottom: 0;">
        <li>
            <a href="FrmMore.reliefDeposit">
                <div class="operation_logo"><img src="../../img/yajin.png" alt=""></div>
                <div class="operation_hint">减免押金</div>
            </a>
        </li> 
        <li>
            <a href="FrmIndemnity?mobile_=${user.items.mobile_ }">
                <div class="operation_logo"><img src="../../img/peifudan.png" alt=""></div>
                <div class="operation_hint">赔付单</div>
            </a>
        </li>

        <li>
            <a href="FrmMyServices">
                <div class="operation_logo"><img src="../../img/yaoqing.png" alt=""></div>
                <div class="operation_hint">邀请好友</div>
            </a>
        </li>
        <li>
            <a href="FrmCollect">
                <div class="operation_logo"><img src="../../img/shoucang.png" alt=""></div>
                <div class="operation_hint">我的收藏</div>
            </a>
        </li>
    </ul>
    <ul class="my_service flexLayout">
        <li>
            <a href="FrmDonation.myDonation">
                <div class="operation_logo"><img src="../../img/juanzeng.png" alt=""></div>
                <div class="operation_hint">公益捐赠</div>
            </a>
        </li>
        <li>
            <a href="FrmAdrmanage">
                <div class="operation_logo"><img src="../../img/dizhi.png" alt=""></div>
                <div class="operation_hint">地址管理</div>
            </a>
        </li>
        <li>
            <a href="FrmFeedback.addFeedback">
                <div class="operation_logo"><img src="../../img/yijian.png" alt=""></div>
                <div class="operation_hint">意见反馈</div>
            </a>
        </li>
        <li>
            <a href="FrmGuideList.Guide">
                <div class="operation_logo"><img src="../../img/zhinan.png" alt=""></div>
                <div class="operation_hint">使用指南</div>
            </a>
        </li>
    </ul>
    <!-- <img src="../../img/kefu.png" alt="" class="kefu"> -->
</div>
	<!--  底部链接 -->
    <div id="foot_mat"></div> 
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
        <li>
            <a href="FrmMyBoxGroup.nearbyCabinet">
                <div><img src="../../img/nearbyA.png" alt=""></div>
                <div><img src="../../img/nearbyB.png" class="listImg" alt=""></div>
                <div>附近柜</div>
            </a>
        </li>
        <li class="footActive">
            <a href="FrmMore.userCenter">
                <div><img src="../../img/wodeA.png" alt=""></div>
                <div><img src="../../img/wodeB.png" class="listImg" alt=""></div>
                <div>我的</div>
            </a>
        </li>
    </ul>
	<%-- <div>
		<p>个人头像：<img alt="" src="${user.items.imgUrl_ }">&nbsp;&nbsp;&nbsp;<span>用户名：<label>${user.items.name_ }</label></span></p>
		<p>今日签到总数：${sum }</p>
		<p>已签到天数:${sumSign }</p>
		<p>
			<c:if test="${user.items.sign == 0}">
						<div>
							<a href="#" 
								onclick="tijiao()">签到</a>
						</div>
						<div class="cancle" style="display: none;">
							<a href="#" style="color: #1185fe;"
								onclick="cancel()">取消签到</a>
						</div>
					</c:if>
					<c:if test="${user.items.sign == 1}">
						<div style="display: none;">
							<a href="#" style="color: #1185fe;"
								onclick="tijiao()">签到</a>
						</div>
						<div style="width: 26%;">
							<a href="#" 
								onclick="cancel()">取消签到</a>
						</div>
					</c:if>
		</p>
	</div> --%>
<!-- 	<div>
		<p>余额：<label>0</label>&nbsp;&nbsp;&nbsp;<span>押金：<label>0</label></span>&nbsp;&nbsp;&nbsp;
		<span>优惠券：<label>0</label></span>&nbsp;&nbsp;&nbsp;<span>积分：<label>0</label></span>
		</p>
	</div> -->
	<!-- <div>
		<h2>我的订单</h2> &nbsp;&nbsp;&nbsp;<a>查看全部></a>
		<div>
			<p>
				<a href="#"><img alt="" src="">待发货/开箱</a>&nbsp;&nbsp;&nbsp;<a href="#"><span><img alt="" src="">待收获取件</span></a>
				&nbsp;&nbsp;&nbsp;<a href="#"><span><img alt="" src="">租用中</span></a>
				&nbsp;&nbsp;&nbsp;<a href="#"><span><img alt="" src="">待评价</span></a>
			</p>
		</div>
	</div>
	<div>
		<h2>我的服务</h2>
		<div>
			<p>
				<a href="#"><img alt="" src="">减免押金</a>&nbsp;&nbsp;&nbsp;<a href="#"><span><img alt="" src="">赔付单</span></a>
				&nbsp;&nbsp;&nbsp;<a href="FrmMyServices"><span><img alt="" src="">邀请好友</span></a>
				&nbsp;&nbsp;&nbsp;<a href="#"><span><img alt="" src="">我的收藏</span></a>
			</p>
			<p>
				<a href="FrmDonation.myDonation"><img alt="" src="">我的捐赠</a>&nbsp;&nbsp;&nbsp;<a href="#"><span><img alt="" src="">地址管理</span></a>
				&nbsp;&nbsp;&nbsp;<a href="#"><span><img alt="" src="">意见反馈</span></a>
				&nbsp;&nbsp;&nbsp;<a href="#"><span><img alt="" src="">使用指南</span></a>
			</p>
		</div>
	</div> -->

</body>
<script type="text/javascript" src="${cdn}/js/box/wxmorelogin.js"></script>
</html>