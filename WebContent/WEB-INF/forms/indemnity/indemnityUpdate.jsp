<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@include file="../ui/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>一启享</title>
<style>
	.leftSide input[type='text']{
		width:150px;
	}
</style>
<script type="text/javascript">
	function tj(){
		$(".orderinfo").show();
	}
</script>
<script type="text/javascript">
//转为手工结算
function hand(orderId_) {
	$.ajax({
		url : 'FrmIndemnityInfo.toHandSettle',
		dataType : 'json',
		type : 'post',
		cache : false,
		data : {
			orderId_ : orderId_
		},
		success : function(data) {
			if (data == false) {
				alert("转为手工结算失败！");
				window.location.reload();
			} else {
				alert("成功转为手工结算 ！");
				window.location.reload();
			}
		}
	});
}

//手工结算
function handSettle(orderId_) {
	$.ajax({
		url : 'FrmIndemnityInfo.handSettle',
		dataType : 'json',
		type : 'post',
		cache : false,
		data : {
			orderId_ : orderId_
		},
		success : function(data) {
			if (data == false) {
				alert("手工结算失败！");
				window.location.reload();
			} else {
				alert("成功手工结算 ！");
				window.location.reload();
			}
		}
	});
}
</script>
</head>
<body>
<div class="mid-box fl" id="mid-box" style="width:90%">
	<span class="min-col f16">修改赔付单信息</span>
	<form action="">
	 <div class="tab_box mt_20 mb_10 clear pr_20">
            <div class="fl leftSide">
				<span>当前用户 </span>
				<input type="text" name="mobile_" value="${info.items.mobile_ }" disabled="disabled">
				<span>当前赔付单号 </span>
				<input type="text" name="payID_" value="${info.items.payID_ }" disabled="disabled">
				<span>关联租赁单号 </span>
				<input type="text" name="orderId_" value="${info.items.orderId_ }" disabled="disabled">
			</div>
		
		 <div class="fr rightSide">
			<input type="button" value="查询" onclick="tj();" class="btn_style">
		</div>
	</div>
	</form> 
	<form action="">
	<div class=" overflowX" style="min-height:100px;">
		<table class="tbl kl">
			<tr>
				<td class="t-head">订单编号</td>
				<td class="t-head">订单收货方式</td>
				<td class="t-head">物品名称</td>
				<td class="t-head">物品归属</td>
				<td class="t-head">租时电子条码</td>
				<td class="t-head">归时电子条码</td>
				<td class="t-head">物品价值</td>
				<td class="t-head">租赁时长</td>
				<td class="t-head">订单租金</td>
				<td class="t-head">订单押金</td>
				<td class="t-head">押金减免</td>
				<td class="t-head">超期租金</td>
				<td class="t-head">订单租赁创建时间</td>
				<td class="t-head">订单起租时间</td>
				<td class="t-head">订单归还时间</td>
				<td class="t-head">订单状态</td>
				<td class="t-head">异常状态</td>
				<td class="t-head">运维协议</td>
				<td class="t-head">结算状态</td>
				<td class="t-head">订单详情</td>
				<td class="t-head">操作</td>	
			</tr>
			<tbody class="t-body tc" id="userPage">
			
			<c:forEach items="${orderinfo }" var="info">
			<tr class="orderinfo" style="display:none">
				<td>${info.items.orderId_ }</td>
				<td>
					<c:if test="${info.items.orderType_ == '1' }">
						本柜取
					</c:if>
					<c:if test="${info.items.orderType_ == '2' }">
						快递收
					</c:if>
					<c:if test="${info.items.orderType_ == '3' }">
						本柜取
					</c:if>
				</td>
				<td>${info.items.proName_ }</td>
				<td>${info.items.homeAgency_ }</td>
				<td>${info.items.zhuCode_ }</td>
				<td>${info.items.zhuCode_ }</td>
				<td>${info.items.proCostPrice_ }</td>
				<td>${info.items.rentTime_ }</td>
				<td>${info.items.dayRentMoney_ }</td>
				<td>${info.items.cashPledge_ }</td>
				<td>${info.items.coupon_ }</td>
				<td>${info.items.sumOverMoney_ }</td>
				<td>
					<fmt:formatDate value="${info.items.createDate_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${info.items.beginTime_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${info.items.returnOverTime_ }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<c:if test="${info.items.orderState_ == '1' }">
						待发货
					</c:if>
					<c:if test="${info.items.orderState_ == '2' }">
						待开箱
					</c:if>
					<c:if test="${info.items.orderState_ == '3' }">
						待收货
					</c:if>
					<c:if test="${info.items.orderState_ == '4' }">
						租用中
					</c:if>
					<c:if test="${info.items.orderState_ == '5' }">
						归还中
					</c:if>
					<c:if test="${info.items.orderState_ == '6' }">
						已归还
					</c:if>
					<c:if test="${info.items.orderState_ == '7' }">
						完成
					</c:if>
					<c:if test="${info.items.orderState_ == '8' }">
						退款
					</c:if>
				</td>
				<td>
					<c:if test="${info.items.repairType_  == '0'}">
						自己责任
					</c:if>
					<c:if test="${info.items.repairType_  == '1'}">
						他人责任
					</c:if>
				</td>
				<td><a href="FrmIndemnityInfo.ywAgreement?type_=6" class="btn_style">查看</a></td>
				<td>
					<c:if test="${info.items.settleState_ =='0' }">
						未结算
					</c:if>
					<c:if test="${info.items.settleState_ =='1' }">
						手工结算
					</c:if>
					<c:if test="${info.items.settleState_ =='2' }">
						已结算
					</c:if>
				</td>
				<td><a href="FrmIndemnityInfo.orderDetails?orderId_=${info.items.orderId_}" class="btn_style">订单详情</a></td>
				<td>
				<c:if test="${info.items.settleState_ =='0' }">
					<a href="#" onclick="hand('${info.items.orderId_}');">转手工结算</a>
				</c:if>
				<c:if test="${info.items.settleState_ =='1' }">
					<a href="#" onclick="handSettle('${info.items.orderId_}');">手工结算</a>
				</c:if>
				<c:if test="${info.items.settleState_ =='2' }">
					<a href="#">已结算</a>
				</c:if>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		</div>
	</form>
	<div>
		<form action="">
			<table class="tbl mt_20 kl mb_20 " style="min-width:50%">
				<tr>
					<td class="t-head">序号</td>
					<td class="t-head">单据编号</td>
					<td class="t-head">操作</td>
				</tr>
				<tbody class="t-body tc" id="userPage">
				<c:forEach items="${yeRecords }" var="yw" varStatus="status">
				<tr class="orderinfo" style="display: none;">
					<td>${status.index+1 }</td>
					<td>${yw.items.operateId_ }</td>
					<td>
						<a href="FrmIndemnityInfo.deleteYWLists?orderId_=${yw.items.orderId_ }&operateId_=${yw.items.operateId_ }">删除</a>
					</td>
				</tr>
				</c:forEach>
				</tbody>
			</table>
		</form>
	</div>
	<div>
		<form action="FrmIndemnityInfo.updateIndemnity" method="post">
		<div class="reason">
			<input type="hidden" value="up" name="up">
		    <input type="hidden" value="${info.items.orderId_ }" name="orderId_">
		    <input type="hidden" value="${info.items.code_ }" name="userId_">
			<p>
				<span>赔付原因(简)</span>
				<input type="text" value="${info.items.payReason_ }" name="payReason_">
			</p>
			<p>
				<span>建议赔付金额</span>
				<input type="text" value="${info.items.suggestMoney_ }" name="suggestMoney_">
			</p>	
			<p>
				<span>达成赔付金额</span>
				<input type="text" value="${info.items.successMoney_ }" name="successMoney_">
			</p>	
			<p>
				<span>赔付后建议</span>
				<input type="text" value="${info.items.suggest_ }" name="suggest_">
			</p>	
			<p>
				<span>赔付说明(公布给用户)</span>
				<input type="text" value="${info.items.payDesc_ }" name="payDesc_">
			</p>	
			<p>
				<span>赔付备注(内部查看用)</span>
				<input type="text" value="${info.items.payRemark_ }" name="payRemark_">
			</p>	
			<p>
				<input type="submit" value="提交" style="margin-left:155px;">
			</p>	
		</form>
		</div>
	</div>
</body>
</html>