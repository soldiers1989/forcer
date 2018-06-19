 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../ui/head1.jspf"%>
	<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>自取租赁详情页面</title>
<script type="text/javascript">
	
</script>
<style>
	.order{
	
		text-align:left;
	}
	.order li{
		margin-left:30%;
		line-height:30px;
		
	}
</style>
</head>
<body>
	<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">租凭自取订单详情</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="javascript:window.history.go(-1);" class="min-col"
			style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>
	<div class="easyui-panel tc mt_20">
	
	
	<ul class="order">
		<li >订单号：${value.items.orderId_}</li>
		<li >下单用户：${value.items.userId_}</li>
		<li >用户手机号：${value.items.userId_}</li>
		<li >租凭商品名称：${value.items.proName_}</li>
		<li >物品归属机构：${value.items.homeAgency_}</li>
		<li >租凭单价(/天)：
			<c:if test="${value.items.isDiscount_ ==0}">
				${value.items.dayRentMoney_ }
			</c:if>
			<c:if test="${val.items.isDiscount_ ==1}">
				${value.items.discountPrice_ }
			</c:if>
		</li>
		<li >创建时间：${value.items.createDate_}</li>
		<li >付款时间：${value.items.payTime_}</li>
		<li >支付单号：</li>
		<li >起租时间：${value.items.beginTime_}</li>
		<li >订单约定归还时间：${value.items.returnTime_}</li>
		<li >订单约定租凭时长(天)：${value.items.rentTime_}</li>
		<li >总租金：</li>
		<li >订单初始收取租金：${value.items.sumRentMoney_}</li>
		<li >订单初始是否受到个信影响：</li>
		<li >超期租金：</li>
		<li >超期天数：</li>
		<li >物品价值：</li>
		<li >已收押金：${value.items.reliefDeposit_}</li>
		<li >押金减免：${value.items.userId_}</li>
		<li >优惠卷抵扣：${value.items.coupon_}</li>
		<li >订单初始支付金额：${value.items.sumMoney_}</li>
		<li >订单支付成功前账户余额：</li>
		<li >订单支付成功后账户余额：</li>
		<li >结算成功后账户余额：</li>
		<li >结算后租金收益：</li>
		<li >租借柜所在社区名称：</li>
		<li >租借柜名称：</li>
		<li >租借柜箱号：</li>
		<li >归还柜名称：</li>
		<li >取货时间：</li>
		<li >实际归还时间：</li>
		<li >租借时主电子条码：</li>
		<li >租借时配件电子条码：</li>
		<li >归还时电子条码：</li>
		<li >订单状态：
			<c:if test="${value.items.orderState_ ==1 }">
				待发货
			</c:if> 
			<c:if test="${value.items.orderState_ ==2 }">
				待开箱
			</c:if> 
			<c:if test="${value.items.orderState_ ==3 }">
				待收货
			</c:if> 
			<c:if test="${value.items.orderState_ ==4 }">
				租凭中
			</c:if> 
			<c:if test="${value.items.orderState_ ==5 }">
				待归还
			</c:if> 
			<c:if test="${value.items.orderState_ ==6 }">
				正在归还
			</c:if> 
			<c:if test="${value.items.orderState_ ==7 }">
				已归还
			</c:if>  
			<c:if test="${value.items.orderState_ ==8 }">
				完成
			</c:if>  
			<c:if test="${value.items.orderState_ ==9 }">
				退款
			</c:if> 
		</li>
		<li >异常状态：</li>
		<li >运维异议：</li>
		<li >结算状态：</li>
		<li >结算时间：</li>
		<li >订单详情：</li>
		<li >关联的赔付单号：</li>
		</ul>
	</div>
	</div>
</body>
<script type="text/javascript">
</script>
</html>