<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
<style type="text/css">
font{
	color:red;
}
.group-box label:last-child{
	text-align:left;
	padding-left:.2rem;
	width:300px;
}
.group-box label:first-child{
	width:200px;
}
.sub_div{
	width:200px;
}
.sub_div input{
	margin-left:295px;
	text-align:left;
}

</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">审核折损单</span>
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
	<form action="FrmLossMgt.updateLoss" method="post" >
<%-- 	<input type="hidden" value="${values.items.UID_}" name="UID_"> --%>
		<%-- <div class="group-box two" name="null" visible="false">
			<label>创建时间</label>
			<input type="text" name="createDate_" disabled value="${values.items.createDate_}">
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>创建者编号</label>
			<input type="text" name="createUser_" disabled value="${values.items.createUser_}">
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>最后修改时间</label>
			<input type="text" name="updateDate_" disabled value="${values.items.updateDate_}">
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>最后修改者</label>
			<input type="text" name="updateUser_" disabled value="${values.items.updateUser_}">
		</div> --%>
		<div class="group-box two" name="null" visible="false">
			<label>订单编号</label>
			<label>${values.items.orderId_}</label>
			<!-- <input type="text" name="orderId_" disabled value=""> -->
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>拿货柜子编号</label>
			<label>${values.items.getCabinetId_}</label>
		<%-- 	<input type="text" name="getCabinetId_" disabled value="${values.items.getCabinetId_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>出货柜子编号</label>
			<label>${values.items.setCabinetId_}</label>
			<%-- <input type="text" name="setCabinetId_" disabled value="${values.items.setCabinetId_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>拿货箱子编号</label>
			<label>${values.items.getBoxId_}</label>
			<%-- <input type="text" name="getBoxId_" disabled  value="${values.items.getBoxId_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>出货箱子编号</label>
			<label>${values.items.setBoxId_}</label>
			<%-- <input type="text" name="setBoxId_" disabled value="${values.items.setBoxId_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>商品编号</label>
			<label>${values.items.proId_}</label>
			<%-- <input type="text" name="proId_" disabled value="${values.items.proId_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>用户编号</label>
			<label>${values.items.userId_}</label>
			<%-- <input type="text" name="userId_" disabled value="${values.items.userId_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>起租时间</label><label>
			<fmt:formatDate value="${values.items.beginTime_}" pattern="yyyy-MM-dd HH:mm:ss"/></label>
		<%-- 	<input type="text" name="beginTime_" disabled value="${values.items.beginTime_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>应还时间</label><label>
			<fmt:formatDate value="${values.items.returnTime_}" pattern="yyyy-MM-dd HH:mm:ss"/></label>
			<%-- <input type="text" name="returnTime_" disabled value="${values.items.returnTime_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>归还类型</label>
			<label>${values.items.returnType_}</label>
			<%-- <input type="text" name="returnType_" disabled value="${values.items.returnType_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>归还方式</label>
			<label>${values.items.returnMethod_}</label>
			<%-- <input type="text" name="returnMethod_" disabled value="${values.items.returnMethod_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>归还时间</label><label>
			<fmt:formatDate value="${values.items.returnOverTime_}" pattern="yyyy-MM-dd HH:mm:ss"/></label>
		<%-- 	<input type="text" name="returnOverTime_" disabled value="${values.items.returnOverTime_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>保修类型</label>
			<label>${values.items.fixType_}</label>
			<%-- <input type="text" name="fixType_" disabled value="${values.items.fixType_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>租金时长</label>
			<label>${values.items.rentTime_}</label>
			<%-- <input type="text" name="rentTime_" disabled  value="${values.items.rentTime_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>初始付款租金</label>
			<label>${values.items.sumRentMoney_}</label>
			<%-- <input type="text" name="sumRentMoney_" disabled value="${values.items.sumRentMoney_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>付款时间</label><label>
			<fmt:formatDate value="${values.items.payTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
			<%-- <input type="text" name="payTime_" disabled disabledvalue="${values.items.payTime_}"> --%></label>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>运费</label>
			<label>${values.items.shippingCosts_}</label>
		<%-- 	<input type="text" name="shippingCosts_"  disabled value="${values.items.shippingCosts_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>订单类型</label>
			<label>${values.items.orderType_}</label>
			<%-- <input type="text" name="orderType_" disabled value="${values.items.orderType_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>订单状态</label>
			<label>${values.items.orderState_}</label>
			<%-- <input type="text" name="orderState_" disabled value="${values.items.orderState_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>付款金额</label>
			<label>${values.items.sumMoney_}</label>
			<%-- <input type="text" name="sumMoney_" disabled value="${values.items.sumMoney_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>商品类型编号</label>
			<label>${values.items.proModelId_}</label>
			<%-- <input type="text" name="proModelId_" disabled value="${values.items.proModelId_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>数量</label>
			<label>${values.items.counts_}</label>
			<%-- <input type="text" name="counts_" disabled value="${values.items.counts_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>用户留言</label>
			<label>${values.items.remark_}</label>
			<%-- <input type="text" name="remark_" disabled disabled value="${values.items.remark_}"> --%>
		</div>
		<%-- <div class="group-box two" name="null" visible="false">
			<label>检验说明</label>
			<input type="text" name="overhaul_"  value="${values.items.overhaul_}"><font>**</font>
		</div> --%>
		<%-- <div class="group-box two" name="null" visible="false">
			<label>退款原因</label>
			<label>${values.items.returnReason_}</label>
			<input type="text" name="returnReason_" disabled value="${values.items.returnReason_}">
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>退款金额</label>
			<input type="text" name="returnMoney_"  value="${values.items.returnMoney_}">
		</div> --%>
		<div class="group-box two" name="null" visible="false">
			<label>归还物流名称</label>
			<label>${values.items.returnLogisticsName_}</label>
			<%-- <input type="text" name="returnLogisticsName_" disabled value="${values.items.returnLogisticsName_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>借出物流单号</label>
			<label>${values.items.recLogisticsId_}</label>
			<%-- <input type="text" name="recLogisticsId_" disabled value="${values.items.recLogisticsId_}"> --%>
		</div>
	<%-- 	<div class="group-box two" name="null" visible="false">
			<label>支付方式</label>
			<input type="text" name="payMethod_" disabled value="${values.items.payMethod_}">
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>用户评价</label>
			<input type="text" name="userEva_" disabled value="${values.items.userEva_}">
		</div> --%>
	<%-- 	<div class="group-box two" name="null" visible="false">
			<label>赔付照片编号</label>
			<input type="text" name="payImg_" value="${values.items.payImg_}"><font>**</font>
		</div> --%>
		<%-- <div class="group-box two" name="null" visible="false">
			<label>赔付状态</label>
			<label>${values.items.payState_}</label>
			<input type="text" name="payState_" disabled value="${values.items.payState_}">
		</div> --%>
	<%-- 	<div class="group-box two" name="null" visible="false">
			<label>允许退款金额</label>
			<label>${values.items.allowReturnMoney_}</label>
			<input type="text" name="allowReturnMoney_" disabled value="${values.items.allowReturnMoney_}">
		</div> --%>
		<div class="group-box two" name="null" visible="false">
			<label>优惠金额</label>
			<label>${values.items.coupon_}</label>
			<%-- <input type="text" name="coupon_" disabled  value="${values.items.coupon_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>减免金额</label>
			<label>${values.items.reliefDeposit_}</label>
		<%-- 	<input type="text" name="reliefDeposit_" disabled value="${values.items.reliefDeposit_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>收件人</label>
			<label>${values.items.receiver_}</label>
			<%-- <input type="text" name="receiver_" disabled value="${values.items.receiver_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>收货地址</label>
			<label>${values.items.recAdr_}</label>
			<%-- <input type="text" name="recAdr_" disabled value="${values.items.recAdr_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>收货人联系方式</label>
			<label>${values.items.recPhone_}</label>
			<%-- <input type="text" name="recPhone_" disabled value="${values.items.recPhone_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>物流状态</label>
			<label>${values.items.logisticsState_}</label>
			<%-- <input type="text" name="logisticsState_" disabled value="${values.items.logisticsState_}"> --%>
		</div>
	<%-- 	<div class="group-box two" name="null" visible="false">
			<label>发货时间</label>
			<label>${values.items.deliveryTime_}</label>
			<input type="text" name="deliveryTime_" disabled value="${values.items.deliveryTime_}">
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>收货时间</label>
			<label>${values.items.recTime_}</label>
			<input type="text" name="recTime_" disabled value="${values.items.recTime_}">
		</div> --%>
		<div class="group-box two" name="null" visible="false">
			<label>借出物流名称</label>
			<label>${values.items.recLogisticsName_}</label>
			<%-- <input type="text" name="recLogisticsName_" disabled value="${values.items.recLogisticsName_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>租出快递时间</label>
			<label><fmt:formatDate value="${values.items.recUpTime_}" pattern="yyyy-MM-dd HH:mm:ss"/></label>
		<%-- 	<input type="text" name="recUpTime_" disabled value="${values.items.recUpTime_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>报修类型</label>
			<label>${values.items.repairType_}</label>
			<%-- <input type="text" name="repairType_" disabled value="${values.items.repairType_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>归还物流单号</label>
			<label>${values.items.retuenLogisticsId_}</label>
			<%-- <input type="text" name="retuenLogisticsId_" disabled value="${values.items.retuenLogisticsId_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>商品主电子条码</label>
			<label>${values.items.zhuCode_}</label>
			<%-- <input type="text" name="zhuCode_" disabled value="${values.items.zhuCode_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>订单总租金</label>
			<label>${values.items.orderRentMoney_}</label>
			<%-- <input type="text" name="orderRentMoney_" disabled value="${values.items.orderRentMoney_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>超期付款租金</label>
			<label>${values.items.sumOverMoney_}</label>
			<%-- <input type="text" name="sumOverMoney_" disabled value="${values.items.sumOverMoney_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>超期天数</label>
			<label>${values.items.overdueDay_}</label>
			<%-- <input type="text" name="overdueDay_" disabled value="${values.items.overdueDay_}"> --%>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>赔付总金额</label>
			<input type="text" name="pay_" value="${values.items.pay_}"><font>**</font>
		</div>
		<div class="group-box two" name="null" visible="false">
			<label>赔付说明</label>
			<input type="text" name="payDesc_" value="${values.items.payDesc_}"><font>**</font>
		</div>
			<div class="group-box two" name="null" visible="false">
			<label>审核</label>
			 <c:if test="${values.items.status_ == '0' }">
				<input type="radio" name="status_" checked="checked" value="0">未通过
				<input type="radio" name="status_" value="1">通过
			 </c:if>
			  <c:if test="${values.items.status_ == '1' }">
				<input type="radio" name="status_"  value="0">未通过
				<input type="radio" name="status_"  checked="checked"value="1">通过
			 </c:if>
			<%-- <input type="text" name="overdueDay_" disabled value="${values.items.overdueDay_}"> --%>
		</div>
		 
		<div  class="sub_div "  visible="false">
		
			<input type="hidden" name="UID_" value="${values.items.UID_}">
			<input type="submit" value="修改" >
		</div>	
	</form>
	</div>
</div>
</body>
</html>