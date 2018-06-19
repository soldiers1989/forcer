<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
<style type="text/css">
	.group-box label{
		width:190px;
		background-color:#f5f5f5;
		text-align:center;
		padding:10px 10px;
		margin-right:20px;
	}
	.group-box input[type="text"],.group-box select{
		width:200px;
		height:35px;
	}
</style>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">录入退货处理&款项</span>
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
		<form action="FrmReturnGoodsOrder.returnHand">
		<div>
			<input type="hidden" value="up" name="up">
			<input type="hidden" value="${hand.items.rgId_ }" name="rgId_">
			<input type="hidden" value="${hand.items.orderId_ }" name="orderId_">
		</div>
		<div class="group-box" >
			<label>当前退货订单号：</label>${hand.items.rgId_ }
		</div>
		<div class="group-box">
			<label>当前退货订单号：</label>${hand.items.rgId_ }
		</div>
		<div class="group-box">
			<label>当前订单物品名称：</label>${hand.items.proName_ }
		</div>
		<div class="group-box">
			<label>当前订单物品分类情况：  </label>一级:${hand.items.fristName_ }  二级：${hand.items.twoName_ }
		</div>
		<div class="group-box">
			<label>当前退货单关联租赁订单号：</label>${hand.items.orderId_ }
		</div>
		<div class="group-box">
			<label>购买订单号物品数量：</label>${hand.items.saleCount_ }
		</div>
		<div class="group-box">
			<label>购买订单号实付金额：</label>${hand.items.salePrice_ }
		</div>
		<div class="group-box">
			<label>录入退货物流公司：</label><select name="rgLogisticsName_" id="rgLogisticsName_">
					<option>请选择</option>
					<option>顺丰</option>
					<option>申通</option>
					<option>中通</option>
					<option>百世快递</option>
					<option>圆通</option>
					<option>韵达</option>
					<option>邮政平邮</option>
					<option>EMS</option>
					<option>天天</option>
					<option>京东</option>
					<option>全峰</option>
					<option>国通</option>
					<option>广通</option>
					<option>优速</option>
					<option>德邦</option>
					<option>八达通</option>
					<option>快捷</option>
					<option>亚马逊</option>
					<option>宅急送</option>
					<option>安捷快递</option>
					<option>百世快运</option>
					<option>广东邮政</option>
					<option>汇丰物流</option>
					<option>速尔快递</option>
					<option>运通快递</option>
				</select>
		</div>
		<div class="group-box">
			<label>录入退货物流单号：</label><input type="text" name="rgLogisticsId_" value="${hand.items.rgLogisticsId_ }">
		</div>
		<div class="group-box">
			<label>录入退货收获检查：</label>
			<c:if test="${hand.items.check_  == '0'}">
				<input type="radio" name="check_" value="0" checked="checked">不达标
				<input type="radio" name="check_" value="1" >达标
			</c:if>
			<c:if test="${hand.items.check_  == '1'}">
				<input type="radio" name="check_" value="0" >不达标
				<input type="radio" name="check_" value="1" checked="checked" >达标
			</c:if>
		</div>
		<div class="group-box">
			<label>录入退货状态：</label>
			<c:if test="${hand.items.rgStatus_  == '0'}">
				<input type="radio" name="rgStatus_" value="0" checked="checked">退货处理中
				<input type="radio" name="rgStatus_" value="1" >退货成功
			</c:if>
			<c:if test="${hand.items.rgStatus_  == '1'}">
				<input type="radio" name="rgStatus_" value="0" >退货处理中
				<input type="radio" name="rgStatus_" value="1" checked="checked">退货成功
			</c:if>
		</div>
		<div class="group-box">
			<label>录入退货处理：</label>
			<c:if test="${hand.items.rgHand_  == '0'}">
				<input type="radio" name="rgHand_" value="0" checked="checked">部分退款
				<input type="radio" name="rgHand_" value="1" >全额退款
			</c:if>
			<c:if test="${hand.items.rgHand_  == '1'}">
				<input type="radio" name="rgHand_" value="0" >部分退款
				<input type="radio" name="rgHand_" value="1" checked="checked">全额退款
			</c:if>
		</div>
		<div class="group-box">
		 <label>退货结算金额：</label>
			<input type="text" name="rgMoney_" value="${hand.items.rgMoney_}">
		</div>
		<div>
			<input type="submit" value="提交" style="padding: 5px 20px; margin-left: -349px;">
		</div>
	</form>
	</div>
</div>











<%-- <h2>对退货单进行处理</h2>
<form action="FrmReturnGoodsOrder.returnHand">
	<div>
		<input type="hidden" value="up" name="up">
		<input type="hidden" value="${hand.items.rgId_ }" name="rgId_">
		<input type="hidden" value="${hand.items.orderId_ }" name="orderId_">
	</div>
	<div>
		当前退货订单号：${hand.items.rgId_ }
	</div>
	<div>
		当前订单物品名称：${hand.items.proName_ }
	</div>
	<div>
		当前订单物品分类情况：  一级:${hand.items.fristName_ }  二级：${hand.items.twoName_ }
	</div>
	<div>
		当前退货单关联租赁订单号：${hand.items.orderId_ }
	</div>
	<div>
		购买订单号物品数量：${hand.items.saleCount_ }
	</div>
	<div>
		购买订单号实付金额：${hand.items.salePrice_ }
	</div>
	<div>
		录入退货物流公司：	<select name="rgLogisticsName_" id="rgLogisticsName_" style="width:300px;">
				<option>请选择</option>
				<option>顺丰</option>
				<option>申通</option>
				<option>中通</option>
				<option>百世快递</option>
				<option>圆通</option>
				<option>韵达</option>
				<option>邮政平邮</option>
				<option>EMS</option>
				<option>天天</option>
				<option>京东</option>
				<option>全峰</option>
				<option>国通</option>
				<option>广通</option>
				<option>优速</option>
				<option>德邦</option>
				<option>八达通</option>
				<option>快捷</option>
				<option>亚马逊</option>
				<option>宅急送</option>
				<option>安捷快递</option>
				<option>百世快运</option>
				<option>广东邮政</option>
				<option>汇丰物流</option>
				<option>速尔快递</option>
				<option>运通快递</option>
			</select>
	</div>
	<div class="group-box">
		录入退货物流单号：<input type="text" name="rgLogisticsId_" value="${hand.items.rgLogisticsId_ }">
	</div>
	<div class="group-box">
		录入退货收获检查：
		<c:if test="${hand.items.check_  == '0'}">
			<input type="radio" name="check_" value="0" checked="checked">不达标
			<input type="radio" name="check_" value="1" >达标
		</c:if>
		<c:if test="${hand.items.check_  == '1'}">
			<input type="radio" name="check_" value="0" >不达标
			<input type="radio" name="check_" value="1" checked="checked" >达标
		</c:if>
	</div>
	<div class="group-box">
		录入退货状态：
		<c:if test="${hand.items.rgStatus_  == '0'}">
			<input type="radio" name="rgStatus_" value="0" checked="checked">退货处理中
			<input type="radio" name="rgStatus_" value="1" >退货成功
		</c:if>
		<c:if test="${hand.items.rgStatus_  == '1'}">
			<input type="radio" name="rgStatus_" value="0" >退货处理中
			<input type="radio" name="rgStatus_" value="1" checked="checked">退货成功
		</c:if>
	</div>
	<div class="group-box">
		录入退货处理：
		<c:if test="${hand.items.rgHand_  == '0'}">
			<input type="radio" name="rgHand_" value="0" checked="checked">部分退款
			<input type="radio" name="rgHand_" value="1" >全额退款
		</c:if>
		<c:if test="${hand.items.rgHand_  == '1'}">
			<input type="radio" name="rgHand_" value="0" >部分退款
			<input type="radio" name="rgHand_" value="1" checked="checked">全额退款
		</c:if>
	</div>
	<div class="group-box">
	 退货结算金额：
		<input type="text" name="rgMoney_" value="${hand.items.rgMoney_}">
	</div>
	<div>
		<input type="submit" value="提交">
	</div>
</form> --%>
</body>
</html>