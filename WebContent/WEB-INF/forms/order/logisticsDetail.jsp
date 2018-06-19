<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>物流详情</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">物流详情</span>
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

		<form action="#" method="post">				
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">订单编号：</label>
			<span>${detail.items.orderId_}</span>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">商品ID：</label>
			<span>${detail.items.proId_}</span>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">商品名称：</label>
			<span>${detail.items.proName_}</span>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">订单类型：</label>
			<c:if test="${detail.items.orderType_=='1' }"><span>自取租赁</span></c:if>
            <c:if test="${detail.items.orderType_=='2' }"><span>寄送上门</span></c:if>
            <c:if test="${detail.items.orderType_=='3' }"><span>寄送到柜</span></c:if>
            <c:if test="${detail.items.orderType_=='4' }"><span>线上购买</span></c:if>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">下单用户：</label>
			<span>${detail.items.userId_}</span>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">下单状态：</label>
			<c:if test="${detail.items.orderState_=='1' }"><span>待发货</span></c:if>
			<c:if test="${detail.items.orderState_=='2' }"><span>待开箱</span></c:if>
			<c:if test="${detail.items.orderState_=='3' }"><span>待收货</span></c:if>
			<c:if test="${detail.items.orderState_=='4' }"><span>租用中</span></c:if>
			<c:if test="${detail.items.orderState_=='5' }"><span>归还中</span></c:if>
			<c:if test="${detail.items.orderState_=='6' }"><span>已归还</span></c:if>
			<c:if test="${detail.items.orderState_=='7' }"><span>已完成</span></c:if>
			<c:if test="${detail.items.orderState_=='8' }"><span>退款</span></c:if>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">邮费：</label>
			<span>${detail.items.shippingCosts_}</span>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">收件人：</label>
			<span>${detail.items.receiver_}</span>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">收件人地址：</label>
			<span>${detail.items.recAdr_}</span>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">收件人电话：</label>
			<span>${detail.items.recPhone_}</span>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">发货时间：</label>
			<span>${detail.items.deliveryTime_}</span>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">收货时间：</label>
			<span>${detail.items.recTime_}</span>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">收货时间：</label>
			<span>${detail.items.recTime_}</span>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">快递公司：</label>
		  <c:if test="${detail.items.orderState_=='1'||detail.items.orderState_=='2'||detail.items.orderState_=='7'||detail.items.orderState_=='8'}"><span></span></c:if>
		</div>
		<div class="group-box" name="null" id="component1" visible="false">
			<label style="width:200px">快递单号：</label>
			<c:if test="${detail.items.orderState_=='3'||detail.items.orderState_=='4'}"><span>${detail.items.recLogisticsId_ }</span></c:if>
         	 <c:if test="${detail.items.orderState_=='5'||detail.items.orderState_=='6'}"><span>${detail.items.recLogisticsId_ }</span></c:if>
		</div>
           
	</form>
</div>
</div>

</body>
</html>