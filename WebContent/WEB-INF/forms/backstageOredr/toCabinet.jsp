 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>租凭到柜列表</title>
<script type="text/javascript">
	function page(pageno) {
		$("#fy").append('<input type="hidden" name="pageno" value="'+ pageno +'">');
		$("#fy").submit();
	}
	function lrwl(orderId){
		window.location.href="FrmDeliveryorder.pickUpRecDetails?orderId_="+orderId; 
	}
</script>
</head>
<body>
	<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
		<span class="min-col f16">送货上门列表</span>
	</div>
	<form action="" id="fy">
		<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
			<span>
				按物品名称：
				<input type="text" name="title_" id="title_" placeholder="请输入关键字搜索"> 
			</span>
			<span>
				按归属机构简称：
				<input type="text" name="title_" id="title_" placeholder="请输入关键字搜索"> 
			</span>
			<span>
				结算状态：
				<input type="text" name="title_" id="title_" placeholder="请输入关键字搜索"> 
			</span>
			<span>
				创建时间：
				<input type="text" name="createDate_" id="createDate_" placeholder="请输入关键字搜索"> 
			</span>
			<span>
				按实际归还时间：
				<input type="text" name="title_" id="title_" placeholder="请输入关键字搜索"> 
			</span>
			<span>
				按社区名称：
				<input type="text" name="title_" id="title_" placeholder="请输入关键字搜索"> 
			</span>
			<input type="hidden" name="orderType_" value="${orderType_ }" />
			<input type="button" class="button" onclick="page(1)" value="查询" id="sub">
		</div>
	</form>
	<div class="table">
		<form action="" id="fy">
			<table class="tbl">
				<thead>
					<tr>
						<th class="t-head" width="2%">序号</th>
						<th class="t-head" width="3%">订单编号</th>
						<th class="t-head" width="5%">用户手机号</th>
						<th class="t-head" width="10%">租凭商品名称</th>
						<th class="t-head" width="3%">物品归属机构</th>
						<th class="t-head" width="3%">租凭单价(/天)</th>
						<th class="t-head" width="3%">创建时间</th>
						<th class="t-head" width="3%">付款时间</th>
						<th class="t-head" width="3%">支付单号</th>
						<th class="t-head" width="3%">起租时间(快递补货到柜时间)</th>
						<th class="t-head" width="4%">订单约定归还时间</th>
						<th class="t-head" width="3%">订单约定租凭时长(天)</th>
						<th class="t-head" width="5%">总租金</th>
						<th class="t-head" width="5%">订单初始收取租金</th>
						<th class="t-head" width="5%">订单初始是否受到个信影响</th>
						<th class="t-head" width="5%">超期租金</th>
						<th class="t-head" width="5%">超期天数</th>
						<th class="t-head" width="5%">物品价值</th>
						<th class="t-head" width="5%">已收押金</th>
						<th class="t-head" width="5%">押金减免</th>
						<th class="t-head" width="5%">优惠卷抵扣</th>
						<th class="t-head" width="5%">订单初始支付金额</th>
						<th class="t-head" width="5%">订单支付成功前账户余额</th>
						<th class="t-head" width="5%">订单支付成功后账户余额</th>
						<th class="t-head" width="5%">结算成功后账户余额</th>
						<th class="t-head" width="5%">结算后租金收益</th>
						<th class="t-head" width="5%">租借柜所在社区名称</th>
						<th class="t-head" width="5%">租借柜名称</th>
						<th class="t-head" width="5%">租借柜箱号</th>
						<th class="t-head" width="5%">归还柜名称</th>
						<th class="t-head" width="5%">取货时间</th>
						<th class="t-head" width="5%">实际归还时间</th>
						<th class="t-head" width="5%">租借时主电子条码</th>
						<th class="t-head" width="5%">租借时配件电子条码</th>
						<th class="t-head" width="5%">归还时电子条码</th>
						<th class="t-head" width="5%">订单状态</th>
						<th class="t-head" width="5%">异常状态</th>
						<th class="t-head" width="5%">运维异议</th>
						<th class="t-head" width="5%">结算状态</th>
						<th class="t-head" width="5%">结算时间</th>
						<th class="t-head" width="5%">订单详情</th>
						<th class="t-head" width="5%">关联的赔付单号</th>
						<th class="t-head" width="5%">操作</th>
					</tr>
				</thead>
				<tbody class="t-body tc" id="userPage">
					<c:forEach items="${values }" var="val" varStatus="status">
						<tr>
							<td>${ status.index + 1}</td>
							<td>${val.items.orderId_ }</td>
							<td><!-- 用户手机号 --></td>
							<td><!-- 租凭商品名称 --></td>
							<td><!-- 物品归属机构 --></td>
							<td><!-- 租凭单价(/天) --></td>
							<td>${val.items.createDate_ }</td>
							<td>${val.items.payTime_ }</td>
							<td><!-- 支付单号 --></td>
							<td>${val.items.beginTime_ }</td>
							<td>${val.items.returnTime_ }</td>
							<td>${val.items.rentTime_ }</td>
							<td><!-- 总租金 --></td>
							<td>${val.items.sumRentMoney_ }</td>
							<td><!-- 订单初始是否受到个信影响 --></td>
							<td><!-- 超期租金 --></td>
							<td><!-- 超期天数 --></td>
							<td><!-- 物品价值 --></td>
							<td>${val.items.reliefDeposit_ }</td>
							<td><!-- 押金减免 --></td>
							<td>${val.items.coupon_ }</td>
							<td>${val.items.sumMoney_ }</td>
							<td><!-- 订单支付成功前账户余额 --></td>
							<td><!-- 订单支付成功后账户余额 --></td>
							<td><!-- 结算成功后账户余额 --></td>
							<td><!-- 结算后租金收益 --></td>
							<td><!-- 租借柜所在社区名称 --></td>
							<td><!-- 租借柜名称 --></td>
							<td><!-- 租借柜箱号 --></td>
							<td><!-- 归还柜名称 --></td>
							<td><!-- 取货时间 --></td>
							<td><!-- 实际归还时间 --></td>
							<td><!-- 租借时主电子条码 --></td>
							<td><!-- 租借时配件电子条码 --></td>
							<td><!-- 归还时电子条码 --></td>
							<td>
							
								<c:if test="${val.items.orderState_ ==1 }">
									待发货
								</c:if> 
								<c:if test="${val.items.orderState_ ==2 }">
									待开箱
								</c:if> 
								<c:if test="${val.items.orderState_ ==3 }">
									待收货
								</c:if> 
								<c:if test="${val.items.orderState_ ==4 }">
									租凭中
								</c:if> 
								<c:if test="${val.items.orderState_ ==5 }">
									归还中
								</c:if> 
								<c:if test="${val.items.orderState_ ==6 }">
									完成
								</c:if> 
								<c:if test="${val.items.orderState_ ==7 }">
									退款
								</c:if> 
							</td>
							<td><!-- 异常状态 --></td>
							<td><!-- 运维异议 --></td>
							<td><!-- 结算状态 --></td>
							<td><!-- 结算时间 --></td>
							<td><!-- 订单详情 --></td>
							<td><!-- 关联的赔付单号 --></td>
							<td>
								<input type="button" value="查看详情" onclick="lrwl('${val.items.orderId_ }');">
							</td>
						</tr>				
					</c:forEach>
				</tbody>
			</table>
		</form>
		<c:if test="${pages.count >= 1}">
			<div class="foot-page" align="center">
					<a href="javascript:page(1);" class='page-index Shouw'>首页</a> 
					<a href="javascript:page(${pages.prior});">上一页</a>
					<a href="javascript:page(${pages.next});">下一页</a>
					<a href="javascript:page(${pages.count});" class="page-last Shouw">尾页</a>
				笔数：${pages.recordCount}, 页数：${pages.current} / ${pages.count}
			</div>
		</c:if>
	</div>
	<div  class="page-number text-right" id="bbb"></div>
</div>
</body>
<script type="text/javascript">
</script>
</html>