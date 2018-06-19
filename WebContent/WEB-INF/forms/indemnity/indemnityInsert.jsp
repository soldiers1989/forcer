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
.box{
	width: 164px;
	display:inline-block;
    border-radius: 3px;
    height: 25px;
    border: 1px solid #ddd;
}
</style>
<script type="text/javascript">
	function tj(){
		$(".orderinfo").show();
	}
</script>
	<script type="text/javascript">
	function tijiao() {
		$.ajax({
			url : 'FrmIndemnityInfo.indemnityInsert',
			dataType : 'json',
			type : 'post',
			cache : false,
			data : {
				"payReason_":payReason_,
				"suggestMoney_":suggestMoney_,
				"successMoney_":successMoney_,
				"suggest_":suggest_,
				"payDesc_":payDesc_,
				"payRemark_":payRemark_
			},
			success : function(data) {
				if (data == false) {
					alert("赔付单未成功生效 ！");
				} else {
					alert("赔付单已生效！");
				}
			}
		});
	}
	</script>
<script type="text/javascript">
$(document).ready(function(){
	
	

	$("#qqq").click(function(){
	
// 		function click(){
			var  mobile_ = $("#mobile_").val();
			var orderId_ = $("#orderId_").val();
			$.ajax({
				url : 'FrmIndemnityInfo.IndemnityInsert',
				dataType : 'json',
				type : 'post',
				cache : false,
				async: false,
				data : {
					"mobile_":mobile_,
					"orderId_":orderId_
				},
				success : function(data) {
					if (data == false) {
						alert("添加赔付单失败 ！");
					} else {
						var payID_ = eval("("+ data+")");
						$("#payID_").val(payID_);
						console.log(payID_);
						alert("成功添加赔付单！");
						/* window.location.reload(); */
					}
				},error:function(data,type,err){
					  console.log("ajax错误类型："+type);  
					  console.log(err);  
				}
			});
})
})
	</script>
</head>
<body> 
<div class="mid-box fl" id="mid-box" style="width:90%">
<span class="min-col f16">添加赔付单信息</span>
	<form action="FrmIndemnityInfo.toIndemnityInsert">	
	 <div class="tab_box mt_20 mb_10 clear pr_20 " >
            <div class="fl leftSide">
				<input type="hidden" value="${info.items.mobile_ }" name="mobile_">
				<span>当前用户 </span>
				<input type="text" name="mobile_" value="${info.items.mobile_ }" id="mobile_" disabled="disabled">
				<c:if test="${orderId_ != null}">
					<span>当前赔付单号 </span>
					<input type="text" disabled="disabled" id="pay" value="${guids }" >
				</c:if>
				<c:if test="${orderId_ == null}">
					<span>当前赔付单号 </span>
					<div class="box"><input type="text" disabled="disabled" id="pay" value="${guids }" style="display:none;"></div>
				</c:if>
				<span>关联租赁单号 </span>
				<input type="text" name="orderId_"  id="orderId_"  value="${orderId_}" >
			</div>
			 <div class="fr rightSide">
			 	<input type="submit" value="查询" onclick="tj();">
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
				<td class="t-head" >订单押金</td>
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
			</tr>
			<tbody class="t-body tc" id="userPage">
			<c:forEach items="${orderinfo }" var="info">
			<tr>
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
				<td><a href="FrmIndemnityInfo.ywAgreement?type_=6" style="btn_style">查看</a></td>
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
				<td><a href="FrmIndemnityInfo.orderDetails?orderId_=${info.items.orderId_}" style="btn_style">订单详情</a></td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		</div>
	</form> 

		<form action="">
		
			<table class="tbl mt_20 kl mb_20 " style="min-width:50%">
				<tr>
					<td class="t-head">序号</td>
					<td class="t-head">单据编号</td>
					<td class="t-head">操作</td>
				</tr>
				<tbody class="t-body tc" id="userPage">
				<c:forEach items="${yeRecords }" var="yw" varStatus="status">
				<tr>
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
	
		<form action="FrmIndemnityInfo.indemnityInsert" method="post">
		<div class="reason">
		<input type="hidden" name="in" value="in">
		<input type="hidden" value="${guids }" name="payID_">
		<input type="hidden" value="${info.items.userId_ }" name="userId_">
			<p>
				<span>赔付原因(简)</span>
				<input type="text"   name="payReason_">
			</p>
			<p>
				<span>建议赔付金额</span>
				<input type="text"   name="suggestMoney_">
			</p>	
			<p>
				<span>达成赔付金额</span>
				<input type="text"   name="successMoney_">
			</p>	
			<p>
				<span>赔付后建议</span>
				<input type="text"   name="suggest_">
			</p>	
			<p>
				<span>赔付说明(公布给用户)</span>
				<input type="text"   name="payDesc_">
			</p>	
			<p>
				<span>赔付备注(内部查看用)</span>
				<input type="text"  name="payRemark_">
			</p>	
			<p>
				<input type="submit" value="提交" style="margin-left:155px;"> 
			</p>
		</div>	
		</form>






















	<%-- <h2>添加赔付单信息</h2>
	<form action="FrmIndemnityInfo.toIndemnityInsert">	
	<input type="hidden" value="${info.items.mobile_ }" name="mobile_">
		<div>
			<span>当前用户 </span>
			<input type="text" name="mobile_" value="${info.items.mobile_ }" id="mobile_" disabled="disabled">
		</div>
		
		<c:if test="${orderId_ != null}">
		<div>
			<span>当前赔付单号 </span>
				<div class="box"><input type="text" disabled="disabled" id="pay" value="${guids }" style="display:block;"></div>
		</div>
		</c:if>
			<c:if test="${orderId_ == null}">
		<div>
			<span>当前赔付单号 </span>
				<div class="box"><input type="text" disabled="disabled" id="pay" value="${guids }" style="display:none;"></div>
		</div>
		</c:if>
		<div>
			<span>关联租赁单号 </span>
			<input type="text" name="orderId_"  id="orderId_"  value="${orderId_}" >
		</div>
		
		<div>
			<!-- <a href="#" id="qqq">查询</a> -->
			<input type="submit" value="查询" onclick="tj();">
			
		</div>
	</form> 
	<form action="">
		<table border="1px;">
			<tr>
				<td>订单编号</td>
				<td>订单收货方式</td>
				<td>物品名称</td>
				<td>物品归属</td>
				<td>租时电子条码</td>
				<td>归时电子条码</td>
				<td>物品价值</td>
				<td>租赁时长</td>
				<td>订单租金</td>
				<td>订单押金</td>
				<td>押金减免</td>
				<td>超期租金</td>
				<td>订单租赁创建时间</td>
				<td>订单起租时间</td>
				<td>订单归还时间</td>
				<td>订单状态</td>
				<td>异常状态</td>
				<td>运维协议</td>
				<td>结算状态</td>
				<td>订单详情</td>
			</tr>
			<c:forEach items="${orderinfo }" var="info">
			<tr>
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
				<td><a href="FrmIndemnityInfo.ywAgreement?type_=6">查看</a></td>
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
				<td><a href="FrmIndemnityInfo.orderDetails?orderId_=${info.items.orderId_}">订单详情</a></td>
			</tr>
			</c:forEach>
		</table>
	</form>
	<div>
		<form action="">
			<table border="1px;">
				<tr>
					<td>序号</td>
					<td>单据编号</td>
					<td>操作</td>
				</tr>
				<c:forEach items="${yeRecords }" var="yw" varStatus="status">
				<tr>
					<td>${status.index+1 }</td>
					<td>${yw.items.operateId_ }</td>
					<td>
						<a href="FrmIndemnityInfo.deleteYWLists?orderId_=${yw.items.orderId_ }&operateId_=${yw.items.operateId_ }">删除</a>
					</td>
				</tr>
				</c:forEach>
			</table>
		</form>
	</div>
	<div>
		<form action="FrmIndemnityInfo.indemnityInsert" method="post">
		<input type="hidden" name="in" value="in">
		<input type="hidden" value="${guids }" name="payID_">
		<input type="hidden" value="${info.items.userId_ }" name="userId_">
			<p>
				<span>赔付原因(简)</span>
				<input type="text"   name="payReason_">
			</p>
			<p>
				<span>建议赔付金额</span>
				<input type="text"   name="suggestMoney_">
			</p>	
			<p>
				<span>达成赔付金额</span>
				<input type="text"   name="successMoney_">
			</p>	
			<p>
				<span>赔付后建议</span>
				<input type="text"   name="suggest_">
			</p>	
			<p>
				<span>赔付说明(公布给用户)</span>
				<input type="text"   name="payDesc_">
			</p>	
			<p>
				<span>赔付备注(内部查看用)</span>
				<input type="text"  name="payRemark_">
			</p>	
			<p>
				<input type="submit" value="提交">
			</p>	
		</form>
	</div>  --%>
	
</body>
</html>