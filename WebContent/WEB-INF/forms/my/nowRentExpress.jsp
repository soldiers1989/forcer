
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>立即租凭</title>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="${cdn}/js/orderJs/weixinPay.js"></script>
<script type="text/javascript">
	function payment() {
		var recAdr = $("#recAdr").val();
		if (recAdr == null || recAdr == "") {
			alert("请添加地址！");
			return;
		}
		var receiver = $("#receiver");
		if (receiver == null || receiver == "") {
			alert("请添加收件人！");
			return;
		}
		var recPhone = $("#recPhone");
		if (recPhone == null || recPhone == "") {
			alert("请添加收件人电话！");
			return;
		}
		var sumMoney = $("#sumMoney").val();
		var str = "亲,您需支付" + sumMoney + "元,确定支付吗？"

		if (sumMoney == null || sumMoney == "") {
			alert("请确认填写信息是否完整！");
			return;
		}
		if (confirm(str) == true) {
			mods("请选择支付方式", sumMoney);
		}
	}
	function mods(content, sumMoney) {
		var oDiv = document.createElement("div");
		oDiv.className = "mars1";
		oDiv.innerHTML = "<div id='container1'>" + "<p id='content1'>"
				+ content + "</p>" + "<div class='flex'>"
				+ "<div class='cancel1 modalBtn'>零钱支付</div>"
				+ "<div class='confirm1 modalBtn'>微信支付</div>" + "</div>"
				+ "</div>";
		var oStyle = document.createElement("style");
		oStyle.innerHTML = ".mars1{"
				+ "width: 100%;height: 100%;background-color: rgba(0, 0, 0, 0.6);position: fixed;top: 0;left:0;z-index: 1000;"
				+ "}"
				+ "#container1{"
				+ "width: 80%;background: white;position: absolute;top: 50%;transform:translateY(-50%);left: 10%;z-index: 2;font-family: PingFang-SC-Medium;border-radius:3px;-webkit-border-radius:3px;margin: 0;"
				+ "}"
				+ "#content1{"
				+ "width:100%;font-size: .34rem;text-align: center;line-height: .51rem;word-break: break-all;font-family: PingFang-SC-Medium;color: #4f4f4f;padding: .68rem .255rem;margin:0;box-sizing: border-box;-webkit-box-sizing: border-box;border-bottom:1px solid #ccc;"
				+ "}"
				+ ".flex{"
				+ "display:flex;width:100%;font-size: .315rem;height:.765rem;line-height: .765rem;"
				+ "}"
				+ ".modalBtn{"
				+ " width: 50%;text-align: center;height:.765rem;line-height: .765rem;background: white;color: #a0791a;cursor:pointer;"
				+ "}"
				+ ".confirm1{"
				+ "border-radius:0 0 3px 0;-webkit-border-radius:0 0 3px 0;"
				+ "}"
				+ ".cancel1{"
				+ "border-right: 1px solid #ccc;border-radius:0 0 0 3px;-webkit-border-radius:0 0 0 3px;"
				+ "}";
		document.getElementsByTagName('html')[0].getElementsByTagName('head')[0]
				.appendChild(oStyle);
		document.body.insertBefore(oDiv, document.body.children[0]);

		$("body").on("click", ".confirm1", function() {
			wxzf(sumMoney);
			$(".mars1").hide();

		});
		$("body").on("click", ".cancel1", function() {
			lqPay(sumMoney);
			$(".mars1").hide();
		});
	};
	function wxzf(sumMoney) {
		if (sumMoney == "" || sumMoney == null || sumMoney < 0) {
			alert("暂无获取支付金额，请确认");
			return;
		}
		weixintyzf2(sumMoney, "微信支付");
	}
	function lqPay(sumMoney) {
		$.ajax({
			url : "FrmOrder_Lease.payment",
			type : 'post',
			data : {
				"sumMoney" : sumMoney
			},
			datatype : "json",
			success : function(data) {
				var str = eval('(' + data + ')');
				var consumeId_ = str.consumeId_;
				if (consumeId_ == "" || consumeId_ == null) {
					alert("账户余额不足！请先充值");
				}
				if (consumeId_ != "" && consumeId_ != null) {
					$("#consumeId_").val(consumeId_);
					$("#delivery_door").submit();
				}
			},
			error : function() {
				alert("系统异常稍后重试！");
			}
		})
	}
</script>
<style type="text/css">
#rentTime {
	width: 1rem;
	height: 93%;
	border: 0;
	text-align: center;
}
#divCoupon{
	position:fixed;
	bottom:0;
	width:100%;
}
.mar{
	width: 100%;height: 100%;background-color: rgba(0, 0, 0, 0.6);position: fixed;top: 0;left:0;z-index: 1000;
}
.bg{
	background-color:#88213d;
	color:#fff;
}
</style>
</head>
<body>
	<!-- 	<div class="header">
    <a href="FrmWeiPro?zhuCode_=${zhuCode_}" class="prev"></a>
    <div class="head_title font18">一启享</div>
</div> -->
	<div class="header2">
		<a href="FrmWeiPro?zhuCode_=${zhuCode_}" class="prev"></a>
		<div class="head_title font18">立即租赁</div>
		<!--<div class="more">设置</div>-->
	</div>
	<form class="main_content" id="delivery_door"
		action="FrmOrder_Lease.addOrderr_Lease" method="post">
		<input type="hidden" id="orderType" name="orderType"
			value="${orderType}" /> <input type="hidden" id="orderType"
			name="orderType" value="${orderType}" />
		<div id="mat"></div>
		<!-- 送货上门 -->
		<c:if test="${orderType == 2}">
			<c:if test="${not empty users}">
				<div class="consignee_meaasge">
					<div class="address_logo fl">
						<img alt="" src="../../img/address.png">
					</div>
					<div class="consignee_basicMeaasge tl">
						<div class="consignee_name">
							<span>收件人:${users.items.name_}</span> <input type="hidden"
								id="receiver" name="receiver" value="${users.items.name_}">
							<span class="fr">${users.items.telpho_}</span> <input
								type="hidden" id="recPhone" name="recPhone"
								value="${users.items.telpho_}">
						</div>
						<div class="consignee_address">
							<span>收货地址：${users.items.adr_}/${users.items.exactadr_}</span> <input
								type="hidden" id="recAdr" name="recAdr"
								value="${users.items.adr_}/${users.items.exactadr_}"> <a
								href="FrmOrder_Lease.addAdrEdit?userid=${users.items.userid_}&orderType_=${orderType}&zhuCode_=${zhuCode_}"
								class="fr"><img src="../../img/rightArrows.png" alt=""></a>
						</div>
						<div class="address_hint">（收货不便时，可选择快递到您附近的启享柜）</div>
					</div>
				</div>
			</c:if>
			<c:if test="${empty users}">
				<div class="add_address">
					<a
						href="FrmAdrmanage.goIncreaseadr?mode=1&userId=${userId}&orderType_=${orderType}&zhuCode_=${zhuCode_}">
						<img src="../../img/add.png" alt=""> <span class="gold">添加收货地址</span>
						<div class="address_hint">（收货不便时，可选择快递到您附近的启享柜）</div>
					</a>
				</div>
			</c:if>
		</c:if>

		<!-- 送货到柜 -->
		<c:if test="${orderType == 3}">
			<c:if test="${empty users}">
				<div class="add_address">
					<a
						href="FrmAdrmanage.goIncreaseadr?mode=2&userId=${userId}&orderType_=${orderType}&zhuCode_=${zhuCode_}">
						<img src="../../img/add.png" alt=""> <span class="gold">添加收货地址</span>
						<div class="address_hint">（收货不便时，可选择快递到您附近的启享柜）</div>
					</a>
				</div>
			</c:if>
			<c:if test="${not empty users}">
				<div class="consignee_meaasge">
					<div class="address_logo fl">
						<img alt="" src="../../img/address.png">
					</div>
					<div class="consignee_basicMeaasge tl">
						<!-- 送货上门的时候，才有收件人信息 -->
						<%-- 	<div class="consignee_name">
								<span>收件人:${users.items.name_}</span>
								<input type="hidden" name="receiver" id="receiver" value="${users.items.name_}">
								<span class="fr">${users.items.telpho_}</span>
								<input type="hidden" name="recPhone" id="recPhone"  value="${users.items.telpho_}">
							</div> --%>
						<div class="consignee_address">
							<span>收货地址：${users.items.boxName_}</span> <input type="hidden"
								id="recAdr" name="recAdr"
								value="${users.items.adr_}/${users.items.exactadr_}/${users.items.boxName_}">
							<a
								href="FrmAdrmanage.goIncreaseadr?mode=2&userId=${userId}&orderType_=${orderType}&zhuCode_=${zhuCode_}"
								class="fr"> <img src="../../img/rightArrows.png" alt="">
							</a>
						</div>
						<div class="address_hint">（收货不便时，可选择快递到您附近的启享柜）</div>
					</div>
				</div>
			</c:if>
		</c:if>
		<div class="hint_box mt_10">
			<div class="user_commodity_style border_b">
				<span class="mr_10">${box.items.boxName_ }</span>
			</div>
		</div>
		<div class="flexLayout right_buyCommodity_message"
			style="margin-top: 0">
			<div class="right_buyCommodity">
				<img src="${pro.items.proZsImges_ }" alt="">
			</div>
			<div class="right_buyCommodity_details">
				<div class="right_buyCommodity_name">${pro.items.proName_ }</div>
				<div class="right_buyCommodity_price red">
					<span class="specific_price" id="span1"><span
						class="font11">/天</span></span>
				</div>
				<input type="hidden" id="dayRentMoney" name="dayRentMoney" value="" />
				<div class="text-gold font10">
					<input type="hidden" id="cashPledge" name="cashPledge"
						value="${pro.items.cashPledge_ }" />押金:￥<span>${pro.items.cashPledge_ }</span>
				</div>
				<input type="hidden" name="proId" id="proId"
					value="${pro.items.proId_ }" />
			</div>
		</div>
		<div class="list mt_10">
			<ul class="message_list">
				<!--  <li class="flexLayout">
				<div class="list_left">起租时间</div>
				<div class="list_right">
					<span class="" id="nowDate"></span>
					<input type="hidden" id="beginTime" name="beginTime">
				</div>
            </li>
            <li class="flexLayout">
				<div class="list_left">归还时间</div>
				<div class="list_right">
					<input type="date" id="xzTime" onchange="getRentTime();" />
					<input type="hidden" name="returnOverTime" id="returnOverTime" />
					<img src="../../img/rightArrows.png" alt="">
				</div>
            </li> -->
				<li class="flexLayout">
					<div class="list_left">租期时长(单位：天)</div>
					<div class="list_right">
						<input id="rentTime" name="rentTime" type="number"
							placeholder="天数" onkeyup="value=value.replace(/[^\- \d.]/g,'')" /><img
							src="../../img/rightArrows.png" alt="">
					</div>
				</li>
				<li class="flexLayout">
					<div class="list_left">总租金</div>
					<div class="list_right">
						￥<span id="sumRentMoney1"></span>
					</div>
				</li>
				<li class="flexLayout">
					<div class="list_left">运费</div>
					<div class="list_right">
						<c:if test="${empty pro.items.posTage_ }">
							<span>包邮</span>
						</c:if>
						<c:if test="${not empty pro.items.posTage_ }">
							<span>${pro.items.posTage_ }元</span>
							<input id="shippingCosts" name="shippingCosts" type="hidden"
								value="${pro.items.posTage_ }">
						</c:if>
					</div>
				</li>
				<li class="flexLayout">
					<div class="list_left">优惠券</div>
					<div class="list_right text-danger" id="getCoupon" style="display:">
						<c:if test="${empty coupons }">
							<span>无可用优惠卷</span>
						</c:if>
						<c:if test="${not empty coupons }">
							<a onclick="getCoupon();">请选择优惠卷</a>
						</c:if>
					</div>

					<div class="list_right text-danger" id="fCoupon"
						style="display: none;">
						<a onclick="getCoupon();"> -￥<span id="coupon"></span>
						</a>
					</div>
				</li>
				<li class="flexLayout">
					<div class="list_left">减免押金金额</div>
					<div class="list_right text-danger">
						-￥<span id="reliefDeposit">50</span>
					</div>
				</li>
				<li class="flexLayout">
					<div class="list_left1">留言</div>
					<div class="list_right1">
						<input type="text" name="remark" id="remark"
							placeholder="请输入您想备注的信息" />
					</div>
				</li>
			</ul>
		</div>
		<div class="warm_hint font11">
			<span class="text-gold">温馨提示：</span>寄送到柜约为48小时，起租时间按物品到箱时间起算，若物品到箱后24小时未取件，则自动取消订单，并扣除一天租金。
		</div>
		<div style="height: .85rem;"></div>
		<div class="foot_btn flexLayout">
			<input type="hidden" value="${userId}" name="userId"> <input
				type="hidden" id="sumMoney" name="sumMoney" /> <input type="hidden"
				id="coupon1" name="coupon" /> <input type="hidden" id="couponId_"
				name="couponId_" /> <input type="hidden" id="reliefDeposit1"
				name="reliefDeposit" /> <input type="hidden" name="sumRentMoney"
				id="sumRentMoney"> <input type="hidden" id="consumeId_"
				name="consumeId_" /> <input type="hidden" id="zhuCode"
				name="zhuCode" value="${zhuCode_}" /> <input type="hidden"
				id="allowReturnMoney" name="allowReturnMoney">
			<div style="width: 65%">
				<span>合计:</span><span class="gold">￥</span><span class="gold"
					id="total"></span> <span class="font10 fr mr_10"
					style="color: #808080;">（可退金额：<span id="upMoney"></span>）
				</span>
			</div>
			<button type="button" style="width: 35%;" onclick="payment();">去支付</button>
		</div>
	</form>



	<%-- <form action="FrmOrder_Lease.addOrderr_Lease" id="fy" method="post">
		<input type="hidden" id="orderType" name="orderType" value="${orderType}" />
		<!-- 送货上门 -->
		<c:if test="${orderType == 2}">
			<c:if test="${not empty users}">
				<div>
					<li>
						收件人:<span>${users.items.userid_}</span>
						<input type="hidden" name="receiver" value="${users.items.userid_}">
					</li>
					<li>
						收货地址:<span>${users.items.adr_}</span>
						<input type="hidden" name="recAdr" value="${users.items.adr_}">
					</li>
					<li>
						联系方式:<span>${users.items.telpho_}</span>
						<input type="hidden" name="recPhone" value="${users.items.telpho_}">
					</li>
					<li>
						<a href="FrmOrder_Lease.addAdrEdit?userid=${users.items.userid_}">更改收货地址</a>
					</li>
				</div>
			</c:if>
			<c:if test="${empty users}">
				<div>
					<a href="FrmOrder_Lease.addAdrEdit?userid=${users.items.userid_}">请选择收件地址</a>
				</div>
			</c:if>
		</c:if>
		
		<!-- 送货到柜 -->
		<c:if test="${orderType == 3}">
			<c:if test="${not empty users}">
				<div>
					<li>
						收件人:<span>${users.items.userid_}</span>
						<input type="hidden" name="receiver" value="${users.items.userid_}">
					</li>
					<li>
						收货地址:<span>${users.items.adr_}</span>
						<input type="hidden" name="recAdr" value="${users.items.adr_}">
					</li>
					<li>
						联系方式:<span>${users.items.telpho_}</span>
						<input type="hidden" name="recPhone" value="${users.items.telpho_}">
					</li>
					<li>
						<a href="FrmOrder_Lease.addAdrEdit?userid=${users.items.userid_}">更改收货地址</a>
					</li>
				</div>
			</c:if>
			<c:if test="${empty users}">
				<div>
					<a href="FrmOrder_Lease.addAdrEdit?userid=${users.items.userid_}">请选择收件地址</a>
				</div>
			</c:if>
		</c:if>
		
		<div>
			
			<span>${products.items.CabinetName } 昌宏花园 8688099启享柜</span>
			<input type="hidden" id="CabinetId" name="CabinetId" value=" ${products.items.CabinetId }" />
			<input type="hidden" id="BoxId" name="BoxId" value=" ${products.items.BoxId }" />
			
		</div>
		<div>
			<span>${products.items.proImgId }</span>
			<span>${pro.items.proName_ }</span>
			<span id="span1" style="display: none;"><input type="hidden" id="dayRentMoney" name="dayRentMoney" value="${pro.items.dayRentMoney_ }" />租金:${pro.items.dayRentMoney_ }/天</span>
			<span id="span2" style="display: none;"><input type="hidden" id="dayRentMoney" name="dayRentMoney" value="${pro.items.discountPrice_ }" />租金:${pro.items.discountPrice_ }/天</span>
			<span ><input type="hidden" id="cashPledge" name="cashPledge" value="${pro.items.cashPledge_ }" />押金:￥${pro.items.cashPledge_ }</span>
			<input type="hidden" name="proId" id="proId" value="${pro.items.proId_ }" /> 
		</div>
		<div>
				<li>
					<span>租期时长</span>
					<input id="rentTime" name="rentTime" type="text"/>
				</li>
				<li>
					<span>总租金</span>
					<input id="sumRentMoney" name="sumRentMoney" type="text">
				</li>
				
				<li>
					<span>运费:
					<c:if test="${empty pro.items.posTage_ }">
						包邮
					</c:if>
					<c:if test="${not empty pro.items.posTage_ }">
						${pro.items.posTage_ }元<input id="shippingCosts" name="shippingCosts" type="hidden" value="${pro.items.posTage_ }">
					</c:if>
					</span>
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
	<%-- <div id="divCoupon" style="display: none;">
		<c:forEach items="${coupons}" var="coupon">
			<a
				onclick="setCoupon('${coupon.items.Denomination_ }','${coupon.items.couponId_ }');">
				<img alt="" src="${coupon.items.imgUrl_ }"> <span>${coupon.items.Denomination_ }元优惠卷</span>
				<span>有效期：${coupon.items.enddate_ }-${coupon.items.enddate1_ }</span>
			</a>
		</c:forEach>
	</div> --%>
	<div class="mar" style="display:none">
	<div id="divCoupon">		
		<ul class='discount_coupon_list' style="display: block;border-radius: .2rem .2rem 0 0;background-color:#fff">
        <c:forEach items="${coupons}" var="coupon">
                    <li class="flexLayout mt_10 " style="height: 1.2rem;position:relative;border-radius: .1rem;border-bottom: 1px solid gray;">
                        <div class="discount_content_left"><!--  -->
                            <div class="yxq">
                                <div class="font19">￥${coupon.items.Denomination_ }元优惠券</div>
                                <div class="font10 text-gray"><span>有效期：</span>
                                <fmt:formatDate value="${coupon.items.enddate_  }" type="both" pattern="yyyy-MM-dd" />-
                                <fmt:formatDate value="${coupon.items.enddate1_ }" type="both" pattern="yyyy-MM-dd" /></div>
                            </div>
                           <%--  <div class="font10 text-gray">${value.items.couponcontent_ }</div> --%>
                        </div>
                       <div class="discount_content_right">
	                       <div style="position:relative;width:100%;height:100%;">
	                       		<img alt="" src="${coupon.items.imgUrl_ }" style="position:absolute;right:0;bottom:0;width: 2.25rem;height: 1.18rem;border-radius: 0 .1rem .1rem 0;">
	                       </div>
                          <%--   <div class="mb_10"><span class="font18">￥</span><span style="font-size: 0.597rem;">${coupon.items.Denomination_ }</span></div> --%>
                           <%--  <c:if test="${value.items.type_ eq '全平台'}">
                           	 <div class="font13">全平台</div>
                            </c:if>
                            <c:if test="${value.items.type_ eq '租赁'}">
                           	 <div class="font13">租赁</div>
                            </c:if>
                            <c:if test="${value.items.type_ eq '购买'}">
                            	<div class="font13">购买</div>
                            </c:if> --%>
                        </div> 
                    </li>
        </c:forEach>
    </ul>
    <div class="submitInBottom" style="margin-top:0;background-color:#fff;padding:.2rem 0">
    <input value="确定" style="text-align: center;" type="buttom" > 
    </div>
	</div>
	
</div>
</body>
<script type="text/javascript">
	$(function() {
		$("#coupon").html(0) //默认优惠卷金额为0
		$("#coupon1").val(0);
		$("#reliefDeposit1").val($("#reliefDeposit").html());
		 var isDiscount_ = ${pro.items.isDiscount_};
		
		if (isDiscount_ == "0") {
			$("#dayRentMoney").val('${pro.items.dayRentMoney_ }');
			$("#span1").html('￥:${pro.items.dayRentMoney_ }');
		}
		if (isDiscount_ == "1") {
			$("#dayRentMoney").val('${pro.items.discountPrice_ }');
			$("#span1").html('￥:${pro.items.discountPrice_ }');
		} 
		
		$("body").on("click",".discount_coupon_list li",function(){
			$(this).addClass("bg").siblings().removeClass("bg");
		});
		$(".submitInBottom input").on("click",function(){
			$(".mar").hide();
		})
	})
	
	
	$("body").on("blur", "#rentTime", function() {
		rentTime();
	})
	function rentTime() {
		//获取总天数
		var day = $("#rentTime").val();
		if (day <= 0) {
			alert("请输入正确的天数");
		}
		//运费
		var shippingCosts = $("#shippingCosts").val();
		if (shippingCosts == null) {
			shippingCosts = "0";
		}
		//添加总租金
		/* var dayRentMoney = $("#dayRentMoney").val();
		$("#sumRentMoney1").html(day*dayRentMoney);
		$("#sumRentMoney").val(day*dayRentMoney);
		//添加到合计（总租金-优惠金+押金-减免押金）
		$("#total").html(day*dayRentMoney+parseFloat($("#cashPledge").val())+parseFloat(shippingCosts)-parseFloat($("#reliefDeposit").html())-parseFloat($("#coupon").html()));
		$("#sumMoney").val(day*dayRentMoney+parseFloat($("#cashPledge").val())+parseFloat(shippingCosts)-parseFloat($("#reliefDeposit").html())-parseFloat($("#coupon").html()));
		 */
		var dayRentMoney = $("#dayRentMoney").val();
		var sumRentMoney = day * dayRentMoney
		$("#sumRentMoney1").html(sumRentMoney);
		$("#sumRentMoney").val(sumRentMoney);
		var coupon = $("#coupon").html();
		$("#coupon1").val(coupon);
		if ((sumRentMoney - coupon) < 0) {
			coupon = sumRentMoney;
			$("#coupon1").val(coupon);
		}
		//添加到合计（总租金-优惠金+押金-减免押金）
		$("#total").html(
				day * dayRentMoney + parseFloat($("#cashPledge").val())
						- parseFloat($("#reliefDeposit").html())
						- parseFloat(coupon));
		$("#sumMoney").val(
				day * dayRentMoney + parseFloat($("#cashPledge").val())
						- parseFloat($("#reliefDeposit").html())
						- parseFloat(coupon));
		//可退金额：（押金-减免押金）
		$("#upMoney").html(
				parseFloat($("#cashPledge").val())
						- parseFloat($("#reliefDeposit").html()));
		$("#allowReturnMoney").val(
				parseFloat($("#cashPledge").val())
						- parseFloat($("#reliefDeposit").html()));
	}
	function getCoupon() {
		/* $("#divCoupon").css("display", ""); */
		 $(".mar").css("display",""); 

	}
	function setCoupon(Denomination_, couponId_) {
		$("#getCoupon").css("display", "none");
		$("#fCoupon").css("display", "");
		$("#coupon").html(Denomination_);
		$("#coupon1").val(Denomination_);
		$("#couponId_").val(couponId_);
		$("#divCoupon").css("display", "none");
		rentTime();
	}
</script>

</html>