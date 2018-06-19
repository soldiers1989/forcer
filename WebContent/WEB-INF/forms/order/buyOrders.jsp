<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>一启享</title>
<style>
table th{
	white-space: nowrap;
	padding:10px;
}  
table td{
   white-space: nowrap;
   padding:5px;
} 
.leftSide input[type='text'],.leftSide select{
	width:153px;
}
.table{
width:100%;
	overflow:scroll;
	 min-height: 550px;
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
<script type="text/javascript">
	layui.use('laydate', function() {
		var laydate = layui.laydate;
	});
</script>
</head>
<body>
	<div class="mid-box fl" id="mid-box">
		<div class="top pl_20 pr_20">
			<span class="min-col f16">线上购买</span>
		</div>
		<form action="">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide mb_10">
           		 <div>
                    <span class="back_hint4">按物品名称</span><input type="text" name="proName_" value="${proName_ }">
					<span class="back_hint6">按归属机构</span><input type="text" name="saleHomeAgency_" value="${saleHomeAgency_ }">
					<span class="back_hint4">订单状态</span>
					<%-- <input type="text" name="orderState_" value="${orderState_ }"> --%>
				<select name="orderState_">
					<option value="-1"
						<c:if test="${orderState_ eq '-1' || orderState_ eq  null  }">selected="selected"</c:if>>全部</option>
					<option value="1"
						<c:if test="${orderState_ eq '1' }">selected="selected"</c:if>>待发货</option>
					<option value="2"
						<c:if test="${orderState_ eq '2' }">selected="selected"</c:if>>待开箱</option>
					<option value="3"
						<c:if test="${orderState_ eq '3' }">selected="selected"</c:if>>待收货</option>
					<option value="4"
						<c:if test="${orderState_ eq '4' }">selected="selected"</c:if>>租用中</option>
					<option value="5"
						<c:if test="${orderState_ eq '5' }">selected="selected"</c:if>>归还中</option>
					<option value="6"
						<c:if test="${orderState_ eq '6' }">selected="selected"</c:if>>已归还</option>
					<option value="7"
						<c:if test="${orderState_ eq '7' }">selected="selected"</c:if>>完成</option>
					<option value="8"
						<c:if test="${orderState_ eq '8' }">selected="selected"</c:if>>退款</option>
					<option value="9"
						<c:if test="${orderState_ eq '9' }">selected="selected"</c:if>>退货中</option>
					<option value="10"
						<c:if test="${orderState_ eq '10' }">selected="selected"</c:if>>已退货</option>
				</select>
				</div>
			<div >
			<span class="back_hint4">快递状态</span>
				<%-- <input type="text" name="logisticsState_" value="${logisticsState_ }"> --%>
				<select name="logisticsState_">
					<option value="-2"
						<c:if test="${logisticsState_ eq '-2' || logisticsState_ eq  null  }">selected="selected"</c:if>>全部</option>
					<option value="-1"
						<c:if test="${logisticsState_ eq '-1' }">selected="selected"</c:if>>单号或快递公司代码错误</option>
					<option value="0"
						<c:if test="${logisticsState_ eq '0' }">selected="selected"</c:if>>暂无轨迹</option>
					<option value="1"
						<c:if test="${logisticsState_ eq '1' }">selected="selected"</c:if>>快递收件</option>
					<option value="2"
						<c:if test="${logisticsState_ eq '2' }">selected="selected"</c:if>>在途中</option>
					<option value="3"
						<c:if test="${logisticsState_ eq '3' }">selected="selected"</c:if>>签收</option>
					<option value="4"
						<c:if test="${logisticsState_ eq '4' }">selected="selected"</c:if>>问题件</option>
				</select> 
				<span class="back_hint6">支付成功时间</span><input type="text"
					onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})"
					name="createTime_" id="createTime_" placeholder="起始日期"
					value="${createTime_}" /> 
					<span class="back_hint4">收货人姓名</span><input type="text"
					name="receiver_" value="${receiver_ }">

			<!-- </p> -->
			<p>按下单手机号:<input type="text" value="${recPhone_ }" name="recPhone_"></p>
		<!-- 	<p> -->

					</div>
			</div>
				<input type="submit" value="查询">
			</div>
		</form>
		<div class="fr rightSide">
			<a href="FrmExcel?service=SvrBuyOrdersQuery&amp;exportKey=SvrBuyOrdersQuery&amp;templateId=SvrBuyOrdersQuery"
				class="btn_style mb_0">导出（Excel）</a>
		</div>
		<form action="" id="subForm">
			<div role="grid" >
				<div class="table">
					<table class="tbl">
						<tbody>
							<tr>
								<td class="t-head">序号</td>
								<td class="t-head">订单编号</td>
								<td class="t-head">下单用户手机号</td>
								<td class="t-head">收货人姓名</td>
								<td class="t-head">收货地址</td>
								<td class="t-head">商品名称</td>
								<td class="t-head">所选物品色号属性</td>
								<td class="t-head">物品归属机构</td>
								<td class="t-head">商品单价</td>
								<td class="t-head">商品数量</td>
								<td class="t-head">多个商品时优惠金额</td>
								<td class="t-head">创建时间</td>
								<td class="t-head">支付成功时间</td>
								<td class="t-head">支付单号</td>
								<td class="t-head">总金额</td>
								<td class="t-head">优惠券抵扣</td>
								<td class="t-head">实付金额</td>
								<td class="t-head">订单支付成功后账户余额</td>
								<td class="t-head">快递公司</td>
								<td class="t-head">快递单号</td>
								<td class="t-head">寄出时间</td>
								<td class="t-head">自动获取最新快递状态</td>
								<td class="t-head">是否同意退货</td>
								<td class="t-head">关联退货单号</td>
								<td class="t-head">退货状态</td>
								<td class="t-head">退货结算金额</td>
								<td class="t-head">订单状态</td>
								<td class="t-head">操作</td>
							</tr>
						</tbody>
						<tbody class="t-body tc">
							<c:forEach items="${buyOrders }" var="buy" varStatus="status">
								<tr>
									<td>${status.index+1 }</td>
									<td>${buy.items.orderId_ }</td>
									<td>${buy.items.recPhone_ }</td>
									<td>${buy.items.receiver_ }</td>
									<td>${buy.items.recAdr_ }</td>
									<td>${buy.items.proName_ }</td>
									<td>${buy.items.saleProColor_ }</td>
									<td>${buy.items.saleHomeAgency_ }</td>
									<td>${buy.items.jinPrice_ }</td>
									<td>${buy.items.ruKuCount_ }</td>
									<td>${buy.items.offerPrice_ }</td>
									<td>${buy.items.createDate_ }</td>
									<td>${buy.items.createTime_ }</td>
									<td>${buy.items.number_ }</td>
									<td>${buy.items.sumRentMoney_ }</td>
									<td>${buy.items.coupon_ }</td>
									<td>${buy.items.sumMoney_ }</td>
									<td>${buy.items.userNowMoney_ }</td>
									<td>${buy.items.recLogisticsName_ }</td>
									<td>${buy.items.recLogisticsId_ }</td>
									<td>${buy.items.deliveryTime_ }</td>
									<td><c:if test="${buy.items.logisticsState_ == '-1' }">
										单号或快递公司代码错误
										</c:if> <c:if test="${buy.items.logisticsState_ == '0' }">
										暂无轨迹
										</c:if> <c:if test="${buy.items.logisticsState_ == '1' }">
										快递收件
										</c:if> <c:if test="${buy.items.logisticsState_ == '2' }">
										在途中
										</c:if> <c:if test="${buy.items.logisticsState_ == '3' }">
										签收
										</c:if> <c:if test="${buy.items.logisticsState_ == '4' }">
										问题件
										</c:if>
									</td>
									<td>${buy.items.agree_ }</td>
									<td>${buy.items.reGoodsId_ }</td>
									<td><c:if test="${buy.items.orderState_ == '9' }">
										退货中
										</c:if> <c:if test="${buy.items.orderState_ == '10' }">
										已退货
										</c:if>
									</td>
									<td>${buy.items.reGoodsMoney_ }</td>
									<td>
										<c:if test="${buy.items.orderState_ == '1' }">
										待发货
										</c:if> <c:if test="${buy.items.orderState_ == '2' }">
										待开箱
										</c:if> <c:if test="${buy.items.orderState_ == '3' }">
										待收货
										</c:if> <c:if test="${buy.items.orderState_ == '4' }">
										租用中
										</c:if> <c:if test="${buy.items.orderState_ == '5' }">
										归还中
										</c:if> <c:if test="${buy.items.orderState_ == '6' }">
										已归还
										</c:if> <c:if test="${buy.items.orderState_ == '7' }">
										完成
										</c:if> <c:if test="${buy.items.orderState_ == '8' }">
										退款
										</c:if>
									</td>
										<td><a href="FrmBuyOrders.buyOrderDetails?orderId_=${buy.items.orderId_ }" class="btn_style mr_10">查看详情</a>
											 <a href="FrmBuyOrders.goEntryLogistics?orderId_=${buy.items.orderId_ }" class="btn_style">录入物流信息</a>
										</td>
								</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</form>
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