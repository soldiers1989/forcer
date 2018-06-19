 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${cdn }/js/mobiscroll/mobiscroll-2.13.2.full.min.css"/>
<script src="${cdn }/js/mobiscroll/mobiscroll-2.13.2.full.min.js"></script>
<script src="${cdn }/js/mobi.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="${cdn}/js/orderJs/weixinPay.js"></script>
<title>立即租凭</title>
<script type="text/javascript">
function payment(){
	var sumMoney = $("#sumMoney").val();
	if(sumMoney == null || sumMoney =="" ){
		alert("请确认填写信息是否完整！");
		return;
	}
	var str = "亲,您需支付"+sumMoney+"元,确定支付吗？"
	 if (confirm(str)==true){
		 mods("请选择支付方式",sumMoney);
	 }
}
function mods(content,sumMoney){
    var oDiv=document.createElement("div");
    oDiv.className="mars1";
    oDiv.innerHTML=
        "<div id='container1'>"+
        "<p id='content1'>"+content+"</p>"+
        "<div class='flex'>"+
        "<div class='cancel1 modalBtn'>零钱支付</div>"+
        "<div class='confirm1 modalBtn'>微信支付</div>"+
        "</div>"+
        "</div>";
    var oStyle=document.createElement("style");
    oStyle.innerHTML=
        ".mars1{"+"width: 100%;height: 100%;background-color: rgba(0, 0, 0, 0.6);position: fixed;top: 0;left:0;z-index: 1000;"+"}"+
        "#container1{"+"width: 80%;background: white;position: absolute;top: 50%;transform:translateY(-50%);left: 10%;z-index: 2;font-family: PingFang-SC-Medium;border-radius:3px;-webkit-border-radius:3px;margin: 0;"+"}"+
        "#content1{"+"width:100%;font-size: .34rem;text-align: center;line-height: .51rem;word-break: break-all;font-family: PingFang-SC-Medium;color: #4f4f4f;padding: .68rem .255rem;margin:0;box-sizing: border-box;-webkit-box-sizing: border-box;border-bottom:1px solid #ccc;"+"}"+
        ".flex{"+"display:flex;width:100%;font-size: .315rem;height:.765rem;line-height: .765rem;"+"}"+
        ".modalBtn{"+" width: 50%;text-align: center;height:.765rem;line-height: .765rem;background: white;color: #a0791a;cursor:pointer;"+"}"+
        ".confirm1{"+"border-radius:0 0 3px 0;-webkit-border-radius:0 0 3px 0;"+"}"+
        ".cancel1{"+"border-right: 1px solid #ccc;border-radius:0 0 0 3px;-webkit-border-radius:0 0 0 3px;"+"}";
    document.getElementsByTagName('html')[0].getElementsByTagName('head')[0].appendChild(oStyle);
    document.body.insertBefore(oDiv,document.body.children[0]);

    $("body").on("click",".confirm1",function(){
    	wxzf(sumMoney);
        $(".mars1").hide();
        
    });
    $("body").on("click",".cancel1",function(){
    	lqPay(sumMoney);
        $(".mars1").hide();
    });
};
function wxzf(sumMoney){
	if(sumMoney == "" || sumMoney == null || sumMoney<0){
		 alert("暂无获取支付金额，请确认");
            return;
	}
	 weixintyzf2(sumMoney, "微信支付");
}
function lqPay(sumMoney){
	$.ajax({
		 url:"FrmOrder_Lease.payment",
			type:'post',
			data:{"sumMoney":sumMoney},
			datatype:"json",
			success:function(data){
				var str = eval('(' + data + ')');
				var consumeId_ = str.consumeId_;
				if(consumeId_ == "" || consumeId_ == null){
					alert("账户余额不足！请先充值");
				}
				if(consumeId_ != "" && consumeId_ != null && consumeId_ != "A"){
					$("#consumeId_").val(consumeId_);
					$("#right_rent").submit();
				}
			},
			error:function(){
				alert("系统异常稍后重试！");
			}
	 })	
}
</script>
<style type="text/css">
	input {
		border: 0;
}
</style>
</head>
<body>
<%-- <div class="header">
    <a href="FrmWeiPro?zhuCode_=${zhuCode_}" class="prev"></a>
    <div class="head_title font18">一启享</div>
</div> --%>
<div class="header2">
    <a href="FrmWeiPro?zhuCode_=${zhuCode_}" class="prev"></a>
    <div class="head_title font18">立即租赁</div>
    <!--<div class="more">设置</div>-->
</div>

<form class="main_content" id="right_rent" action="FrmOrder_Lease.addOrderr_Lease" method="post">
<input type="hidden" id="orderType" name="orderType" value="${orderType}" />
    <div id="mat"></div>
   
    <div class="hint_box mt_10">
        <div class="user_commodity_style border_b">
            <span class="mr_10">${box.items.boxName_ }</span>
        </div>
    </div>
    <div class="flexLayout right_buyCommodity_message" style="margin-top: 0">
        <div class="right_buyCommodity"><img src="${pro.items.proZsImges_ }" alt=""></div>
        <div class="right_buyCommodity_details">
            <div class="right_buyCommodity_name">${pro.items.proName_ }</div>
            <div class="right_buyCommodity_price red"><span class="specific_price" id="span1"></span><span class="font11"></span><span class="ml_10 font11 old_price">￥ <span>35</span>/天</span> </div>
            <div class="text-gold font10"><input type="hidden" id="cashPledge" name="cashPledge" value="${pro.items.cashPledge_ }" />押金：￥<span>${pro.items.cashPledge_ }</span></div>
			<input type="hidden" id="dayRentMoney" name="dayRentMoney" value="" />
			<input type="hidden" name="proId" id="proId" value="${pro.items.proId_ }" /> 
			<input type="hidden" name="zhuCode" id="zhuCode" value="${zhuCode_ }" />
        </div>
    </div>
    
    <div class="list mt_10">
        <ul class="message_list">
            <li class="flexLayout">
				<div class="list_left">起租时间</div>
				<div class="list_right pr_15">
					<span class="" id="nowDate"></span>
					<input type="hidden" id="beginTime" name="beginTime">
				</div>
            </li>
					
            <li class="flexLayout" style="padding-right: 0;">
				<div class="list_left">归还时间</div>
				<!-- <input type="text" id="returnOverTime1" value="" >
				<input type="hidden" id="returnOverTime" name="returnOverTime" value="" > -->
				<div class="list_right">
					<input type="date" id="xzTime" onchange="getRentTime()" name="returnOverTime" style="width: 2.1rem"/>
					<!-- <input type="month" id="xzTime" onchange="getRentTime();" /> -->
					<!-- <input placeholder="Date" class="textbox-n" type="text" onchange="getRentTime();" onfocus="(this.type='date')" id="xzTime"> -->
					<input type="hidden" name="returnOverTime" id="returnOverTime" />
					<!-- <img src="../../img/rightArrows.png" alt=""> -->
				</div>
            </li>
            <li class="flexLayout">
                <div class="list_left">租期时长(单位：天)</div>
                <div class="list_right"><span class="mr_15" id="rentTime"></span></div>
            </li>
            <li class="flexLayout">
                <div class="list_left">总租金</div>
                <div class="list_right">￥<span class="mr_15" id="sumRentMoney1" name="sumRentMoney1"></span></div>
            </li>
            <li class="flexLayout">
                <div class="list_left">优惠券</div>
                <div class="list_right text-danger" id="getCoupon" style="display: ">
	               	<c:if test="${empty coupons }">
	              	 	<span class="mr_15">无可用优惠卷</span>
	                </c:if>
	                <c:if test="${not empty coupons }">
	               	 	<a onclick="getCoupon();" class="mr_15">请选择优惠卷</a>
	                </c:if>
                </div>
               
                <div class="list_right text-danger" id="fCoupon" style="display: none;">
	                <a onclick="getCoupon();" class="mr_15">
	                	-￥<span id="coupon" ></span>
	                </a>
                </div>
            </li>
            <li class="flexLayout">
                <div class="list_left">减免押金金额</div>
                <div class="list_right text-danger"><span class="mr_15">-￥<span id="reliefDeposit">50</span></span></div>
            </li>
            <li class="flexLayout">
                <div class="list_left1">留言</div>
                <div class="list_right1"><input type="text" name="remark" id="remark" placeholder="请输入您想备注的信息"/></div>
            </li>
        </ul>
    </div>
    <div class="warm_hint font11">
        <span class="text-gold">温馨提示：</span>寄送到柜约为48小时，起租时间按物品到箱时间起算，若物品到箱后24小时未取件，则自动取消订单，并扣除一天租金。
    </div>
    <div style="height: .85rem;"></div>
    <div class="foot_btn flexLayout">
		<input type="hidden" value="${userId}" name="userId">	
		<input type="hidden" id="sumMoney" name="sumMoney" />
		<input type="hidden" id="coupon1" name="coupon" />
		<input type="hidden" id="couponId_" name="couponId_" />
		<input type="hidden" id="consumeId_" name="consumeId_" />
		<input type="hidden" id="reliefDeposit1" name="reliefDeposit" />
		<input type="hidden" id="allowReturnMoney" name="allowReturnMoney">
		<input type="hidden" name="sumRentMoney" id="sumRentMoney">
        <div style="width: 65%">
        	<span>合计:</span><span class="gold">￥</span><span class="gold" id="total"></span>
        	<span class="font10 fr mr_10" style="color: #808080;">（可退金额：<span id="upMoney"></span>）</span>	
        </div>
        <button type="button" style="width: 35%;" onclick="payment();">去支付</button>
    </div>
    
</form>

	<%-- <form action="FrmOrder_Lease.addOrderr_Lease" id="fy" method="post" >
		<input type="hidden" id="orderType" name="orderType" value="${orderType}" />
		<div>
			<span>${products.items.CabinetName } 昌宏花园 8688099启享柜</span>
			<input type="hidden" id="CabinetId" name="CabinetId" value=" ${products.items.CabinetId }" />
			<input type="hidden" id="BoxId" name="BoxId" value=" ${products.items.BoxId }" />
			
		</div>
		<div>
			<span>${products.items.proImgId }</span>
			<span>${pro.items.proName_ }</span>
			<span id="span1"></span>
			<input type="hidden" id="dayRentMoney" name="dayRentMoney" value="" />
			<span ><input type="hidden" id="cashPledge" name="cashPledge" value="${pro.items.cashPledge_ }" />押金:￥${pro.items.cashPledge_ }</span>
			<input type="hidden" name="proId" id="proId" value="${pro.items.proId_ }" /> 
			<input type="hidden" name="zhuCode" id="zhuCode" value="${zhuCode_ }" /> 
		</div>
		<div>
				<li>
					<span>起租时间</span>
					<span id="nowDate"></span>
					<input type="hidden" id="beginTime" name="beginTime">
				</li>
				<li>
					<span>归还时间</span>
					<input type="date" id="xzTime" onchange="getRentTime();" />
					<input type="hidden" name="returnOverTime" id="returnOverTime" />
				</li>
		</div>
		<div>
				<li>
					<span>租期时长</span>
					<input id="rentTime" name="rentTime" type="text">
				</li>
				<li>
					<span>总租金</span>
					<input id="sumRentMoney" name="sumRentMoney" type="text">
				</li>
				<li>
					<span>优惠卷</span>
					已优惠￥<input id="coupon" name="coupon" type="text" value="2">
				</li>
				<li>
					<span>减免押金金额</span>
					已减免￥<input id="reliefDeposit" name="reliefDeposit" value="50">
				</li>
				<span>留言:<input type="text" name="remark" id="remark"/></span>
		</div>
		<input type="hidden" value="${userId}" name="userId">
		合计：<span id="total"></span>
		<input type="hidden" id="sumMoney" name="sumMoney" />
		<input type="hidden" id="consumeId_" name="consumeId_" />
		可退金额：<span id="upMoney"></span>
		<input type="hidden" id="allowReturnMoney" name="allowReturnMoney">
		<input type="button" value="去支付" onclick="payment();"/>
	</form> --%>
	<div id="divCoupon" style="display: none;">
		<c:forEach items="${coupons}" var="coupon">
				<a onclick="setCoupon('${coupon.items.Denomination_ }','${coupon.items.couponId_ }');">
					<img alt="" src="${coupon.items.imgUrl_ }" >
					<span >${coupon.items.Denomination_ }元优惠卷</span>
					<span >有效期：${coupon.items.enddate_ }-${coupon.items.enddate1_ }</span>
				</a>
		</c:forEach>
	</div>
</body>
<script type="text/javascript">

/* $("body").on("click","#returnOverTime1",function(){
	 mobiDate("returnOverTime1");
	 setTimeout(function () {
		 getRentTime();
	 }, 5000);
	
}); */

$(function(){
	$("#coupon").html(0) //默认优惠卷金额为0
	$("#coupon1").val(0);
	$("#reliefDeposit1").val($("#reliefDeposit").html());
	var today = new Date();  
	var submitTime = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate(); 
	
	$("#nowDate").html(submitTime);
	var isDiscount_ = ${pro.items.isDiscount_};
	if(isDiscount_ == "0"){
		$("#dayRentMoney").val('${pro.items.dayRentMoney_ }');
		$("#span1").html("￥:${pro.items.dayRentMoney_ }<span class='font11'>/天</span>");
	}
	if(isDiscount_ == "1"){
		$("#dayRentMoney").val('${pro.items.discountPrice_ }');
		$("#span1").html("￥:${pro.items.discountPrice_ }<span class='font11'>/天</span>");
	}
	
})
function getRentTime(){
	//获取当前时间  n y r s f m 
	var timestamp = Date.parse(new Date());
	var today = new Date();
	var nowDate = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
	// 转为 ：上午10:33:24 
	var time1 = today.getHours()+':'+today.getMinutes()+':'+today.getSeconds();
	$("#beginTime").val(nowDate+' '+time1);
	//获取选择当前的时间
	var returnOverTime = $("#xzTime").val()+" "+time1 ;
	//添加到input框
	$("#returnOverTime").val(returnOverTime);
	returnOverTime=returnOverTime.replace(new RegExp(/-/gm) ,"/");
	//转时间戳
	var timestamp2 = Date.parse(new Date(returnOverTime));
	//时间差转天数
	var time = timestamp2 - timestamp;
	
	if(time <= 0){
		alert("归还时间应大于起租时间，请重新选择");
		return;
	}
	var day =Math.floor(time/86400000);
	
	//添加总天数
	$("#rentTime").html(day);
	//添加总租金
	var dayRentMoney = $("#dayRentMoney").val();
	var sumRentMoney = day*dayRentMoney
	$("#sumRentMoney1").html(sumRentMoney);
	$("#sumRentMoney").val(sumRentMoney);
	var coupon = $("#coupon").html();
	$("#coupon1").val(coupon);
	if((sumRentMoney-coupon) < 0){
		coupon = sumRentMoney;
		$("#coupon1").val(coupon);
	}
	
	//添加到合计（总租金-优惠金+押金-减免押金）
	$("#total").html(day*dayRentMoney+parseFloat($("#cashPledge").val())-parseFloat($("#reliefDeposit").html())-parseFloat(coupon));
	$("#sumMoney").val(day*dayRentMoney+parseFloat($("#cashPledge").val())-parseFloat($("#reliefDeposit").html())-parseFloat(coupon));
	//可退金额：（押金-减免押金）
	$("#upMoney").html(parseFloat($("#cashPledge").val())-parseFloat($("#reliefDeposit").html()));
	$("#allowReturnMoney").val(parseFloat($("#cashPledge").val())-parseFloat($("#reliefDeposit").html()));
}
function getCoupon(){
	$("#divCoupon").css("display","");

}
function setCoupon(Denomination_,couponId_){
	$("#getCoupon").css("display","none");
	$("#fCoupon").css("display","");
	$("#coupon").html(Denomination_);
	$("#coupon1").val(Denomination_);
	$("#couponId_").val(couponId_);
	$("#divCoupon").css("display","none");
	getRentTime();
}
</script>

</html>