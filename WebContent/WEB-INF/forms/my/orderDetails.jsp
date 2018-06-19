 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单详情</title>
</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">订单详情</div>
    <!--<div class="more"><img src="../../img/1.jpg" alt=""></div>-->
</div>
<div class="main_content" id="renting_details">
    <div id="mat"></div>
    <div class="stay_deliverGoods_message">
        <!-- 租用中 -->
        <c:if test="${order.items.orderState_ ==4 }">
            <div class="stay_deliverGoods_title flexLayout">
                <div class="stay_deliverGoods_logo"><img src="../../img/ing.png" alt=""></div>
                <div class="Goods_status"  id="zpzt">租用中</div>
                <div class="logistics_message">
                    <div><span  id="syTime"></span></div>
                </div>
            </div>
        </c:if>
        
        <!-- 已归还 -->
        <c:if test="${order.items.orderState_ ==5 }">
            <div class="stay_deliverGoods_title flexLayout">
                <div class="stay_deliverGoods_logo"><img src="../../img/old_return.png" alt=""></div>
                <div class="Goods_status">归还中</div>
            </div>
        </c:if>
         <!-- 已归还 -->
        <c:if test="${order.items.orderState_ ==6 }">
            <div class="stay_deliverGoods_title flexLayout">
                <div class="stay_deliverGoods_logo"><img src="../../img/old_return.png" alt=""></div>
                <div class="Goods_status">待评价</div>
            </div>
        </c:if>
          <!-- 已归还 -->
        <c:if test="${order.items.orderState_ ==8 }">
            <div class="stay_deliverGoods_title flexLayout">
                <div class="stay_deliverGoods_logo"><img src="../../img/old_return.png" alt=""></div>
                <div class="Goods_status">退款</div>
            </div>
        </c:if>
        <c:if test="${order.items.orderType_ ==3 || order.items.orderType_ ==2 }">
        	<c:if test="${order.items.orderState_ ==1 || order.items.orderState_ ==2 }">
		        <div class="stay_deliverGoods_title flexLayout">
		            <div class="stay_deliverGoods_logo"><img src="../../img/stay_deliverGoods.png" alt=""></div>
		            <div>待发货</div>
		        </div>
	        </c:if>
            <c:if test="${order.items.orderState_ ==3 }">
                <div class="stay_deliverGoods_title flexLayout">
                    <div class="stay_deliverGoods_logo"><img src="../../img/stay_getGoods.png" alt=""></div>
                    <div class="Goods_status">待收货</div>
                    <div class="logistics_message">
                        <div><span>物流服务：</span><span>${order.items.recLogisticsName_ }</span></div>
                        <div><span>运单编号：</span><span>${order.items.recLogisticsId_ }</span></div>
                    </div>
                </div>
            </c:if>
            <%-- <div class="client_message">
                <div class="client_name">
                    <span>${order.items.receiver_ }</span>
                    <span>${order.items.recPhone_ }</span>
                </div>
                <div class="client_address">
                    <span>地址：</span>
                    <span>${order.items.recAdr_ }</span>
                </div>
            </div> --%>
        </c:if>
        <c:if test="${order.items.orderType_ ==1 }">
        	 <c:if test="${order.items.orderState_ ==3 }">
		         <div class="stay_deliverGoods_title flexLayout">
	                   <div class="stay_deliverGoods_logo"><img src="../../img/stay_getGoods.png" alt=""></div>
	                   <div>待收货</div>
		        </div>
		     </c:if>
        </c:if>
        <!-- 代发货 -->
        
        
        <!-- 寄送到柜 -->
        <!-- <div class="stay_deliverGoods_title flexLayout">
            <div class="stay_deliverGoods_logo"><img src="../../img/stay_getGoods.png" alt=""></div>
            <div class="Goods_status">待收货</div>
            <div class="logistics_message">
                <div><span>物流服务：</span><span>中通快递</span></div>
                <div><span>运单编号：</span><span>8746484131211</span></div>
            </div>
        </div> -->
        
        <!-- 自取 -->
        <!-- <div class="QR_code">
            <img src="../../img/2.jpg" alt="" class="mb_10">
            <div class="text-gold">请在24小时后，到已选的柜组中扫描取货</div>
            <div>(若到柜后24小时未取件，则自动取消订单，并扣除一天的租金)</div>
        </div> -->
        
      <%--   <c:if test="${order.items.orderType_ ==3 || order.items.orderType_ ==2 }">
            <div class="client_message">
                <div class="client_name">
                    <span>${order.items.receiver_ }</span>
                    <span>${order.items.recPhone_ }</span>
                </div>
                <div class="client_address">
                    <span>地址：</span>
                    <span>${order.items.recAdr_ }</span>
                </div>
            </div>
        </c:if> --%>
        
        <div class="hint_box">
            <div class="mt_10 user_commodity_style border_b">
                <span class="mr_10">宏昌花园 5598854启享柜</span>
                <c:if test="${order.items.orderType_ == 1}"><span class="delivery_style">自取租赁</span></c:if>
                <c:if test="${order.items.orderType_ == 2}"><span class="delivery_style">寄送上门</span></c:if>
                <c:if test="${order.items.orderType_ == 3}"><span class="delivery_style">寄送到柜</span></c:if>
                <c:if test="${order.items.orderType_ == 4}"><span class="delivery_style">线上购买</span></c:if>
            </div>
        </div>
        <div class="hint_box">
            <div class="flexLayout right_buyCommodity_message border_0 mt_0">
                <div class="right_buyCommodity"><img src="${order.items.twoImgUrl_}" alt="" style="width: 100%;height: 100%;"></div>
                <div class="right_buyCommodity_details">
                    <div class="right_buyCommodity_name font14">${order.items.proName_}</div>
                    <div class="right_buyCommodity_color">
                        <c:if test="${order.items.isDiscount_ == 0}">
                            <span class="font18 text-danger">￥${order.items.dayRentMoney_}</span><span class="font11 text-danger">/天</span> 
                        </c:if>
                        <c:if test="${order.items.isDiscount_ == 1}">
                            <span class="font18 text-danger">￥${order.items.discountPrice_}</span><span class="font11 text-danger">/天</span> 
                            <span class="line-th">￥${order.items.dayRentMoney_}/天</span>
                        </c:if>
                    </div>
                    <div class="right_buyCommodity_price text-gold font10"><span>押金：￥</span><span class="text-gold">${order.items.cashPledge_}</span></div>
                </div>
            </div>
        </div>
        <ul class="pay_money mt_10"> 
        <c:if test="${order.items.orderState_ != 3}">
        	<li class="flexLayout">
                <div class="list_left">起租时间：</div>
                <div class="list_right"><span id="beginTime_">${order.items.beginTime_}</span></div>
            </li>
            <li class="flexLayout">
                <div class="list_left">归还时间：</div>
                <div class="list_right"><span id="returnTime_"><%-- ${order.items.returnTime_} --%></span></div>
            </li>
            <c:if test="${not empty order.items.returnOverTime_}">
                <li class="flexLayout">
                    <div class="list_left">实际归还时间：</div>
                    <div class="list_right"><span id="returnOverTime_">
                    	<fmt:formatDate value="${order.items.returnOverTime_}" pattern="yyyy-MM-dd HH:mm:ss" />
          <%--           <fmt:formatDate value="${order.items.returnOverTime_}" pattern="yyyy-MM-dd HH:mm:ss"/> --%>
                    </span></div>
                </li>
            </c:if>
        </c:if>
            <li class="flexLayout">
                <div class="list_left">租期时长：</div>
                <div class="list_right"><span id="">${order.items.rentTime_} </span>日</div>
            </li>
            <li class="flexLayout">
                <div class="list_left">总租金：</div>
                <div class="list_right">￥<span id="">${order.items.sumRentMoney_}</span></div>
            </li>
            <c:if test="${not empty order.items.shippingCosts_}">
                <li class="flexLayout">
                    <div class="list_left">运费：</div>
                    <div class="list_right">￥<span id="">${order.items.shippingCosts_}</span></div>
                </li>
            </c:if>
            <li class="flexLayout">
                <div class="list_left">优惠券：</div>
                <div class="list_right">-￥<span id="">${order.items.coupon_}</span></div>
            </li>
            <li class="flexLayout">
                <div class="list_left">减免押金金额：</div>
                <div class="list_right">-￥<span id="">${order.items.reliefDeposit_}</span></div>
            </li>
            <li class="old_pay flexLayout">
                <div class="list_left">已支付：</div>
                <div class="list_right text-gold font17">￥<span id="">${order.items.sumMoney_}</span></div>
            </li>
        </ul>
        <div class="leave_words mt_10 border_b">
            <c:if test="${not empty order.items.remark_}">
                <span>留言：</span><span id="">${order.items.remark_}</span>
            </c:if>
            <c:if test="${empty order.items.remark_}">
                <span>留言：</span><span id="">暂无</span>
            </c:if>
        </div>
        <ul class="orderDate_details">
            <li><span>订单编号：</span><span id="">${order.items.orderId_}</span></li>
            <li><span>创建时间：</span><span id="">${order.items.createDate_}</span></li>
            <li><span>付款时间：</span><span id="">${order.items.payTime_}</span></li>
        </ul>
        <div class="hint_center">
            <span class="text-gold">温馨提示：</span>寄送到柜约为48小时，起租时间按物品到箱时间起算
        </div>
    </div>
</div>
<%-- <c:if test="${order.items.orderType_ ==3 || order.items.orderType_ ==2 }">
        <c:if test="${order.items.orderState_ ==3 || order.items.orderState_ ==2 }">
            <li><span >待收货</span></li>
            <li><span>物流服务:${order.items.recLogisticsName_ }</span></li>
            <li><span>运单编号:${order.items.recLogisticsId_ }</span></li>
        </c:if>
    </c:if> 
    <c:if test="${order.items.orderState_ ==4 }">
        <span id="zpzt">租用中</span><span id="syTime"></span>
    </c:if> 
    <c:if test="${order.items.orderState_ ==5 }">
        <span>归还中</span>
    </c:if>
    <c:if test="${order.items.orderType_ ==3 || order.items.orderType_ ==2 }">
        <div>
            <li>
                <span>收货人:${order.items.receiver_ }</span>
                <span>${order.items.recPhone_ }</span>
            </li>
            <c:if test="${order.items.orderState_ ==3 }"><!--送货上门  -->
                <li>
                    <span>收货地址:${order.items.recAdr_ }</span>
                </li>
            </c:if>
            <c:if test="${order.items.orderState_ ==2 }"><!--送货到柜  -->
                <li>
                    <span>收货地址:${order.items.recAdr_ }/${order.items.exactadr_ }</span>
                </li>
            </c:if>
        </div>
    </c:if>
    <div>
        
        <li>
            <c:if test="${order.items.orderType_ == 1}">自取租赁</c:if>
            <c:if test="${order.items.orderType_ == 2}">寄送上门</c:if>
            <c:if test="${order.items.orderType_ == 3}">寄送到柜</c:if>
            <c:if test="${order.items.orderType_ == 4}">线上购买</c:if>
        </li>
    </div>
    
    <div>
        <li>
            <img  src="${order.items.twoImgUrl_}">
        </li>
        <li>
            <span>${order.items.proName_}</span>
        </li>
        <li>
            <span>
                <c:if test="${order.items.isDiscount_ == 0}">
                    ${order.items.dayRentMoney_}
                </c:if>
                <c:if test="${order.items.isDiscount_ == 1}">
                折扣后    ${order.items.discountPrice_}
                折扣前    ${order.items.dayRentMoney_}
                </c:if>
                元/天
            </span>
        </li>
        <li>押金：
            <span>${order.items.cashPledge_} 元</span>
        </li>
    </div>
    <div>
        <li>起租时间:<span id="beginTime_">${order.items.beginTime_}</span></li>
        <li>应还时间:<span id="returnTime_">${order.items.returnTime_}</span></li>
        <c:if test="${not empty order.items.returnOverTime_}">
            <li>实际归还时间:<span id="returnOverTime_">${order.items.returnOverTime_}</span></li>
        </c:if>
        <li>租期时长:<span id="">${order.items.rentTime_}</span></li>
        <li>总租金:<span id="">${order.items.sumRentMoney_}</span></li>
        <li>优惠卷:<span id="">${order.items.coupon_}</span></li>
        <c:if test="${not empty order.items.shippingCosts_}">
            <li>运费:<span id="">${order.items.shippingCosts_}</span></li>
        </c:if>
        <li>减免押金金额:<span id="">${order.items.reliefDeposit_}</span></li>
        <li>已支付:<span id="">${order.items.sumMoney_}</span></li>
    </div>
    <div>
        <c:if test="${not empty order.items.remark_}">
            <li>留言:<span id="">${order.items.remark_}</span></li>
        </c:if>
        <c:if test="${empty order.items.remark_}">
            <li>留言:<span id="">暂无</span></li>
        </c:if>
        <li>订单编号:<span id="">${order.items.orderId_}</span></li>
        <li>创建时间:<span id="">${order.items.createDate_}</span></li>
        <li>付款时间:<span id="">${order.items.payTime_}</span></li>
    </div>--%>
</body>
<script>
	$(function(){
		var beginTime_ = '${order.items.beginTime_}';
		var returnTime_ = '${order.items.returnTime_}';
		var databeginTime_ = beginTime_.split(" ");
		var datareturnTime_ = returnTime_.split(" ");
		//$("#beginTime_").val(beginTime_);
		//alert(datareturnTime_[1])
		var time = datareturnTime_[0] +" "+ databeginTime_[1];
		$("#returnTime_").text(time);
	});
		//$("#returnTime_").val(time);
		//alert(data[1])#create
</script>
<script type="text/javascript">
    function getTime(){
        var returnTime = new Date('${order.items.returnTime_}');
        var nowTime = Date.parse(new Date());
        var time = returnTime - nowTime;
        if(time >= 0){
            var sumsec=time/1000;
            var day = parseInt(sumsec/(24*60*60));
            var hours = parseInt((sumsec-(day*24*60*60))/(60*60));
            var min = parseInt((sumsec-(day*24*60*60)-(hours*60*60))/60);
            var sec =sumsec%60;
            var str = "剩下："+day+"天"+hours+"小时"+min+"分"+sec+"秒";
            $("#syTime").html(str);
        }
        if(time < 0){
            time = nowTime - returnTime;
            var sumsec=time/1000;
            var day = parseInt(sumsec/(24*60*60));
            var hours = parseInt((sumsec-(day*24*60*60))/(60*60));
            var min = parseInt((sumsec-(day*24*60*60)-(hours*60*60))/60);
            var sec =sumsec%60;
            var str = "您已超过应还时间："+day+"天"+hours+"小时"+min+"分"+sec+"秒";
            $("#syTime").html(str);    
            /* window.clearTimeout(t1);//去除定时器
            $("#syTime").html("");
            $("#zpzt").html("待归还");
             $.ajax({
                    url : 'FrmOrder_My.updateOrder',
                    data : {
                        "orderId":'${order.items.orderId_}',
                        "orderState":"5"
                    },
                    type: "GET",
                    dataType: "json",
                    contentType: false, //必须
                    success: function (value) {
                        
                    }
             }) */
                
        }
        
    }
    var t1 = window.setInterval("getTime()",1000); 
</script>
</html>