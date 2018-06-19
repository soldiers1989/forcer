<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
<style>
.spe {
	margin-top: 20px;
}
table th{
	white-space: nowrap;
	padding:10px;
}  
table td{
   white-space: nowrap;
   padding:5px;
} 
.table{
	overflow:scroll;
	 min-height: 800px;
	 padding:0 15px;
}
</style>
<script type="text/javascript">
	function page(pageno) {
		$("#subForm").append(
				'<input type="hidden" name="pageno" value="'+ pageno +'">');
		$("#subForm").submit();
	}
</script>
</head>
<body>
	<div class="mid-box fl" id="mid-box">
		<div class="top pl_20 pr_20">
			<span class="min-col f16">折损查询展示</span>
		</div>
		<div role="grid">
			<div class="table">
				<form  action="FrmLossMgt" method="post" id="subForm">
					<table class="tbl spe" style="margin-top: 20px">
						<tbody>
							<tr>
								<td class="t-head tc">序号</td>
								<!-- <td class="t-head tc">编号</td> -->
								<td class="t-head tc">创建时间</td>
								<!-- <td class="t-head tc">创建者编号</td>
								<td class="t-head tc">最后修改时间</td>
								<td class="t-head tc">最后修改者</td>  -->
								<td class="t-head tc">订单编号</td>
								<!-- <td class="t-head tc">拿货柜子编号</td>
								<td class="t-head tc">出货柜子编号</td>
								<td class="t-head tc">拿货箱子编号</td>
								<td class="t-head tc">出货箱子编号</td> -->
								<td class="t-head tc">商品编号</td>
								<td class="t-head tc">用户编号</td>
								<td class="t-head tc">起租时间</td>
								<td class="t-head tc">应还时间</td>
								<td class="t-head tc">归还类型</td>
								<td class="t-head tc">归还方式</td>
								<td class="t-head tc">归还时间</td>
							<!-- 	<td class="t-head tc">报修类型</td> -->
								<td class="t-head tc">租金时长</td>
								<td class="t-head tc">初始付款租金</td>
								<td class="t-head tc">付款时间</td>
								<td class="t-head tc">运费</td>
								<td class="t-head tc">订单类型</td>
								<td class="t-head tc">订单状态</td>
								<td class="t-head tc">付款金额</td>
								<td class="t-head tc">商品类型编号</td>
								<td class="t-head tc">数量</td>
								<td class="t-head tc">用户留言</td>
								<td class="t-head tc">检验说明</td>
							<!-- 	<td class="t-head tc">退款原因</td>
								<td class="t-head tc">退款金额</td> -->
								<td class="t-head tc">归还物流名称</td>
								<td class="t-head tc">借出物流单号</td>
								<!-- <td class="t-head tc">支付方式</td>
								<td class="t-head tc">用户评价</td> -->
								<td class="t-head tc">赔付总金额</td>
								<td class="t-head tc">赔付说明</td>
								<!-- <td class="t-head tc">赔付图片编号</td>
								<td class="t-head tc">赔付状态</td> -->
								<!-- <td class="t-head tc">允许退款金额</td> -->
								<td class="t-head tc">优惠金额</td>
								<td class="t-head tc">减免金额</td>
								<td class="t-head tc">收件人</td>
								<td class="t-head tc">收货地址</td>
								<td class="t-head tc">收货人联系方式</td>
								<td class="t-head tc">物流状态</td>
								<td class="t-head tc">发货时间</td>
								<td class="t-head tc">收货时间</td>
								<td class="t-head tc">借出物流名称</td>
								<td class="t-head tc">租出快递时间</td>
								<td class="t-head tc">报修类型</td>
								<td class="t-head tc">归还物流单号</td>
								<td class="t-head tc">商品主电子条码</td>
								<td class="t-head tc">订单总租金</td>
								<td class="t-head tc">超期付款租金</td>
								<td class="t-head tc">超期天数</td>
								<td class="t-head tc">状态</td>
								<td class="t-head tc" colspan="2">操作</td>
							</tr>
						</tbody>
						<tbody class="t-body tc">
							  <c:if test="${empty values}">
								<div class="no_content">
									<img src="../../img/zwsj.png" style="width: 4rem;">
								</div>
							</c:if>
							<c:if test="${not empty values}"></c:if>
							<c:forEach items="${values }" var="loss" varStatus="status">
								<tr>
									<td>${status.index+1 }</td>
									<%-- <td>${loss.items.UID_ }</td> --%>
									<td>${loss.items.createDate_ }</td>
									<%-- <td>${loss.items.createUser_}</td>
									<td>${loss.items.updateDate_}</td>
									<td>${loss.items.updateUser_}</td> --%>
									<td>${loss.items.orderId_ }</td>
									<%-- <td>${loss.items.getCabinetId_ }</td>
									<td>${loss.items.setCabinetId_ }</td>
									<td>${loss.items.getBoxId_ }</td>
									<td>${loss.items.setBoxId_ }</td> --%>
									<td>${loss.items.proId_}</td>
									<td>${loss.items.userId_ }</td>
									<td>${loss.items.beginTime_}</td>
									<td>${loss.items.returnTime_}</td>
									<td>
										<c:if test="${loss.items.returnType_ == '0'}">
											无损归还
										</c:if>
										<c:if test="${loss.items.returnType_ == '1'}">
											有损归还
										</c:if>
									</td>
									<td>
										<c:if test="${loss.items.returnMethod_ == '0'}">
											箱子归还
										</c:if>
										<c:if test="${loss.items.returnMethod_ == '1'}">
											快递归还
										</c:if>
									</td>
									<td>${loss.items.returnOverTime_}</td>
									<%-- <td>
										<c:if test="${loss.items.fixType_ == '0'}">
											自己责任
										</c:if>
										<c:if test="${loss.items.fixType_ == '1'}">
											他人责任
										</c:if>
									</td> --%>
									<td>${loss.items.rentTime_ }</td>
									<td>${loss.items.sumRentMoney_}</td>
									<td>${loss.items.payTime_}</td>
									<td>${loss.items.shippingCosts_}</td>
									<td>
										<c:if test="${loss.items.orderType_ == '1'}">
											自取租赁
										</c:if>
										<c:if test="${loss.items.orderType_ == '2'}">
											寄送上门
										</c:if>
										<c:if test="${loss.items.orderType_ == '3'}">
											寄送到柜
										</c:if>
										<c:if test="${loss.items.orderType_ == '4'}">
											线上购买
										</c:if>
									</td>
									<td>
										<c:if test="${loss.items.orderState_  == '1'}">
											待发货
										</c:if>
										<c:if test="${loss.items.orderState_  == '2'}">
											待开箱
										</c:if>
										<c:if test="${loss.items.orderState_  == '3'}">
											租用中
										</c:if>
										<c:if test="${loss.items.orderState_  == '4'}">
											归还中
										</c:if>
										<c:if test="${loss.items.orderState_  == '5'}">
											已归还
										</c:if>
										<c:if test="${loss.items.orderState_  == '6'}">
											完成
										</c:if>
										<c:if test="${loss.items.orderState_  == '7'}">
											
										</c:if>
										<c:if test="${loss.items.orderState_  == '8'}">
											退款
										</c:if>
									</td>
									<td>${loss.items.sumMoney_}</td>
									<td>${loss.items.proModelId_ }</td>
									<td>${loss.items.counts_}</td>
									<td>${loss.items.remark_ }</td>
									<td>${loss.items.overhaul_}</td>
									<%-- <td>${loss.items.returnReason_ }</td>
									<td>${loss.items.returnMoney_ }</td> --%>
									<td>${loss.items.returnLogisticsName_ }</td>
									<td>${loss.items.recLogisticsId_ }</td>
								<%-- 	<td>${loss.items.payMethod_ }</td>
									<td>${loss.items.userEva_ }</td> --%>
									<td>${loss.items.pay_ }</td>
									<td>${loss.items.payDesc_ }</td>
									<%-- <td>${loss.items.payImg_ }</td>
									<td>${loss.items.payState_ }</td> --%>
									<%-- <td>${loss.items.allowReturnMoney_ }</td> --%>
									<td>${loss.items.coupon_ }</td>
									<td>${loss.items.reliefDeposit_ }</td>
									<td>${loss.items.receiver_ }</td>
									<td>${loss.items.recAdr_ }</td>
									<td>${loss.items.recPhone_ }</td>
									<td>
										<c:if test="${loss.items.logisticsState_ == '-1'}">
											单号或快递公司代码错误
										</c:if>
										<c:if test="${loss.items.logisticsState_ == '0'}">
											暂无轨迹
										</c:if>
										<c:if test="${loss.items.logisticsState_ == '1'}">
											快递收件
										</c:if>
										<c:if test="${loss.items.logisticsState_ == '2'}">
											在途中
										</c:if>
										<c:if test="${loss.items.logisticsState_ == '3'}">
											签收
										</c:if>
										<c:if test="${loss.items.logisticsState_ == '4'}">
											问题件
										</c:if>
									</td>
									<td>${loss.items.deliveryTime_ }</td>
									<td>${loss.items.recTime_ }</td>
									<td>${loss.items.recLogisticsName_ }</td>
									<td>${loss.items.recUpTime_ }</td>
									<td>
										<c:if test="${loss.items.repairType_ == '0' }">
											自己责任
										</c:if>
										<c:if test="${loss.items.repairType_ == '1' }">
											他人责任
										</c:if>
									</td>
									<td>${loss.items.retuenLogisticsId_ }</td>
									<td>${loss.items.zhuCode_ }</td>
									<td>${loss.items.orderRentMoney_ }</td>
									<td>${loss.items.sumOverMoney_ }</td>
									<td>${loss.items.overdueDay_ }</td>
									<td>
										<c:if test="${loss.items.status_ == '0' }">
											未通过
										</c:if>
										<c:if test="${loss.items.status_ == '1' }">
											通过
										</c:if>
									</td>
									<td><a href="FrmLossMgt.getLoss?UID_=${loss.items.UID_ }" class="btn_style">审核</a></td>	 
								</tr> 
							</c:forEach>  
						</tbody>
					</table>
				</form>
			</div>
		 </div>
		  <c:if test="${pages.count >= 1}">
			<div class="foot-page" align="center">
				<a href="javascript:page(1);" class='page-index Shouw'>首页</a> <a
					href="javascript:page(${pages.prior});">上一页</a> <a
					href="javascript:page(${pages.next});">下一页</a> <a
					href="javascript:page(${pages.count});" class="page-last Shouw">尾页</a>
				<span>总条数：</span>${pages.recordCount}, 页数：${pages.current} /
				${pages.count}
			</div>
		</c:if>  
	</div>  

</body>
</html>