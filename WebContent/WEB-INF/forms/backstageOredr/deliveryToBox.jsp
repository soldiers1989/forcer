
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>送货到柜</title>
<style type="text/css">
table th {
	white-space: nowrap;
	padding: 10px;
}

table td {
	white-space: nowrap;
	padding: 5px;
}

.table {
	overflow: scroll;
	min-height: 550px;
	padding: 0 15px;
}
 .back_hint4,.back_hint6,.back_hint8{
text-align:right;
} 


#subForm .leftSide input,#subForm .leftSide select{
	margin-right:40px;
}
</style>
<script type="text/javascript">
	layui.use('laydate', function() {
		var laydate = layui.laydate;
	});
</script>
<script type="text/javascript">
	function page(pageno) {
		$("#subForm").append(
				'<input type="hidden" name="pageno" value="'+ pageno +'">');
		$("#subForm").submit();
	}
	function lrwl(orderId) {
		window.location.href = "FrmDeliveryGoHome.goEntryLogistics?orderId_="
				+ orderId;
	}
</script>
<script type="text/javascript">
	function getEWM(orderId_){
		window.location.href="FrmDeliveryToBox.printErWeiMa?orderId_="+ orderId_ ;
	}
</script>
<script type="text/javascript">
	$(function() {
		$('#sub').on('click', function() {
			var startdate = $('#unlockDate_').val();
			var enddate = $('#endDate_').val();
			var returnDate_ = $('#returnDate_').val();
			var endReturnDate_ = $('#endReturnDate_').val();
			if (startdate != null && startdate != "") {
				if (startdate > enddate) {
					alert("结束时间必须大于开始时间");
					return false;
				}
			}
			if (returnDate_ != null && returnDate_ != "") {
				if (returnDate_ > endReturnDate_) {
					alert("结束时间必须大于开始时间");
					return false;
				}
			}
		});
	})
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
	<%-- 	<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
		<span class="min-col f16">送货到柜列表</span>
	</div>
	<form action="" id="fy">
		<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
			<span>
				按物品名称：
				<input type="text" name="proName_" id="proName_" value="${proName_}" placeholder="请输入关键字搜索"> 
			</span>
			<span>
				按归属机构简称：
				<input type="text" name="homeAgency_" id="homeAgency_" value="${homeAgency_}" placeholder="请输入关键字搜索"> 
			</span>
			<span>
				结算状态：
				<input type="text" name="title_" id="title_" placeholder="请输入关键字搜索"> 
			</span>
			<span>
				创建时间：
				<input type="text" name="createDate_" id="createDate_" value="${createDate_}" placeholder="请输入关键字搜索"> 
			</span>
			<span>
				按实际归还时间：
				<input type="text" name="title_" id="title_"  placeholder="请输入关键字搜索"> 
			</span>
			<span>
				按主电子条码：
				<input type="text" name="zhuCode_" id="zhuCode_" value="${zhuCode_}" placeholder="请输入关键字搜索"> 
			</span>
			<!-- <span>
				物流状态：
				<input type="text" name="title_" id="title_" placeholder="请输入关键字搜索"> 
			</span> -->
			<input type="hidden" name="orderType_" value="${orderType_ }" />
			<input type="button" class="button" onclick="page(1)" value="查询" id="sub">
		</div>
	</form>
	<div class="table">
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
						<th class="t-head" width="5%">租凭柜所在社区名称</th>
					    <th class="t-head" width="5%">租凭柜名称</th>
						<th class="t-head" width="5%">租凭柜编号</th>
						<th class="t-head" width="5%">归还柜名称</th>
						<th class="t-head" width="5%">取货时间</th>
						<th class="t-head" width="5%">实际归还时间(按归还物流单号发出时间)</th>
						<th class="t-head" width="5%">租借时主电子条码</th>
						<th class="t-head" width="5%">订单状态</th>
						<th class="t-head" width="5%">操作</th>
					</tr>
				</thead>
				<tbody class="t-body tc" id="userPage">
					<c:forEach items="${values }" var="val" varStatus="status">
						<tr>
							<td>${ status.index + 1}</td>
							<td>${val.items.orderId_ }</td>
							<td><!-- 用户手机号 -->${val.items.recPhone_ }</td>
							<td><!-- 租凭商品名称 -->${val.items.proName_ }</td>
							<td><!-- 物品归属机构 -->${val.items.homeAgency_ }</td>
							<td><!-- 租凭单价(/天) -->
								<c:if test="${val.items.isDiscount_ ==0}">
									${val.items.dayRentMoney_ }
								</c:if>
								<c:if test="${val.items.isDiscount_ ==1}">
									${val.items.discountPrice_ }
								</c:if>
							</td>
							<td><!-- 创建时间 -->${val.items.createDate_ }</td>
							<td><!-- 付款时间 -->${val.items.payTime_ }</td>
							<td>支付单号</td>
							<td> 起租时间 ${val.items.beginTime_ }</td>
							<td> 订单约定归还时间 ${val.items.returnTime_ }</td>
							<td>${val.items.rentTime_ }</td>
							<td> 总租金 </td>
							<td> ${val.items.sumRentMoney_ }</td>
							<td>订单初始是否受到个信影响</td>
							<td>超期租金</td>
							<td> 超期天数 </td>
							<td>物品价值 </td>
							<td> ${val.items.reliefDeposit_ }</td>
							<td>押金减免</td>
							<td>${val.items.coupon_ }</td>
							<td>${val.items.sumMoney_ }</td>
							<td>订单支付成功前账户余额 </td>
							<td>订单支付成功后账户余额 </td>
							<td> 结算成功后账户余额 </td>
							<td> 结算后租金收益 </td>
							<td>${val.items.boxCommunityName_}</td>
							<td>租凭柜名称</td>
							<td>租凭柜编号</td>
							<td>归还柜名称</td>
							<td>取货时间</td>
							<td>实际归还时间(按归还物流单号发出时间)</td>
							<td>${val.items.zhuCode_ }</td>
							<td><!-- 订单状态 -->
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
									已归还
								</c:if> 
								<c:if test="${val.items.orderState_ ==7 }">
									完成
								</c:if> 
								<c:if test="${val.items.orderState_ ==8 }">
									退款
								</c:if> 
							</td>
							<td>
								<a href="FrmDeliveryToBox.configureProBox?boxId_=${val.items.boxId_ }">配置</a>
							</td>
							<td>
								操作
							</td>
						</tr>				
					</c:forEach>
				</tbody>
			</table>
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
	<div  class="page-number text-right" id="bbb"></div> --%>

	<div class="mid-box fl" id="mid-box">
		<div class="top pl_20 pr_20">
			<span class="min-col f16">租赁送货到柜列表</span>
		</div>
		<form action="FrmDeliveryToBox" method="post" id="subForm">
			<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
				<div class="fl leftSide">
					<div class="mb_10">
						<span class="back_hint8">按物品名称：</span><input type="text"
							name="proName_" id="proName_" value="${proName_}"
							placeholder="请输入关键字搜索"> 
							<span class="back_hint8">按归属机构简称：</span><input
							type="text" name="homeAgency_" id="homeAgency_"
							value="${homeAgency_}" placeholder="请输入关键字搜索">
					</div>
					<div class="mb_10">
				<%-- 	<span class="back_hint8">按主电子条码：</span><input type="text"
							name="zhuCode_" id="zhuCode_" value="${zhuCode_}"
							placeholder="请输入关键字搜索"> --%>
							<span class="back_hint6">订单状态：</span>
						<select name="orderState_">
							<option value="0"
								<c:if test="${orderState_ eq '0' ||  orderState_ eq null }">selected="selected"</c:if>>全部</option>
							<option value="1"
								<c:if test="${orderState_ eq '1' }">selected="selected"</c:if>>待发货</option>
							<option value="2"
								<c:if test="${orderState_ eq '2' }">selected="selected"</c:if>>待开箱</option>
							<option value="3"
								<c:if test="${orderState_ eq '3' }">selected="selected"</c:if>>待收货</option>
							<option value="4"
								<c:if test="${orderState_ eq '4' }">selected="selected"</c:if>>租赁中</option>
							<option value="5"
								<c:if test="${orderState_ eq '5' }">selected="selected"</c:if>>归还中</option>
							<option value="6"
								<c:if test="${orderState_ eq '6' }">selected="selected"</c:if>>已完成</option>
							<option value="7"
								<c:if test="${orderState_ eq '7' }">selected="selected"</c:if>>归还</option>
							<option value="8"
								<c:if test="${orderState_ eq '8' }">selected="selected"</c:if>>退款</option>
						</select>
						<span class="back_hint8">结算状态</span>
		              	  <select name = "settleState_">
		              	    <option value="-1" <c:if test="${settleState_ eq '-1' ||  settleState_ eq null }">selected="selected"</c:if>>全部</option>
		              	 	<option value="0" <c:if test="${settleState_ eq '0' }">selected="selected"</c:if>>未结算</option>
		              	 	<option value="1" <c:if test="${settleState_ eq '1' }">selected="selected"</c:if>>手工结算</option>
		              	 	<option value="2" <c:if test="${settleState_ eq '2' }">selected="selected"</c:if>>已结算</option>
		              	  </select>
						
						
					</div>
					<div class="mb_10">
					
						<span class="back_hint8" >实际归还时间：</span><input style="margin-right:0;"
							type="text"
							onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})"
							name="returnDate_" id="returnDate_" placeholder="起始日期"
							value="${returnDate_ }" /><font> -至- </font> <input type="text"
							onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})"
							name="endReturnDate_" id="endReturnDate_" placeholder="终止日期"
							value="${endReturnDate_ }" /> 
					</div>
					<div class="mb_10">
					<span class="back_hint8">创建时间：</span><input type="text" style="margin-right:0;"
							onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})"
							name="unlockDate_" id="unlockDate_" placeholder="起始日期"
							value="${unlockDate_ }" /><font> -至- </font> <input type="text"
							onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})"
							name="endDate_" id="endDate_" placeholder="终止日期"
							value="${endDate_ }" />

						<%--    <span class="back_hint6">创建时间：</span><input type="text" name="createDate_" id="createDate_" value="${createDate_}" placeholder="请输入关键字搜索"> 
                    <span class="back_hint8">按实际归还时间：</span><input type="text" name="title_" id="title_"  placeholder="请输入关键字搜索"> 
                  --%>
					</div>
				</div>
				<div class="fr rightSide">
					<input type="hidden" name="orderType_" value="${orderType_ }" />
					<!--    <input type="button" class="button btn_style" onclick="page(1)" value="查询" id="sub"> -->
					<input type="submit" value="查询" id="sub">
				</div>
			</div>
		</form>
		<div role="grid">
			<div class="table">   
				<form action="" id="subForm">
					<table class="tbl">
						<tbody>
							<tr>
								<th class="t-head">序号</th>
								<th class="t-head">订单编号</th>
								<th class="t-head">用户手机号</th>
								<th class="t-head">租赁商品名称</th>
								<th class="t-head">物品归属机构</th>
								<th class="t-head">租凭单价(/天)</th>
								<th class="t-head">创建时间</th>
								<th class="t-head">付款时间</th>
								<th class="t-head">支付单号</th>
								<th class="t-head">起租时间(快递补货到柜时间)</th>
								<th class="t-head">订单约定归还时间</th>
								<th class="t-head">订单约定租凭时长(天)</th>
								<th class="t-head">总租金</th>
								<th class="t-head">订单初始收取租金</th>
								<th class="t-head">订单初始是否受到个信影响</th>
								<th class="t-head">超期租金</th>
								<th class="t-head">超期天数</th>
								<th class="t-head">物品价值</th>
								<th class="t-head">已收押金</th>
								<th class="t-head">押金减免</th>
								<th class="t-head">优惠卷抵扣</th>
								<th class="t-head">订单初始支付金额</th>
								<th class="t-head">订单支付成功前账户余额</th>
								<th class="t-head">订单支付成功后账户余额</th>
								<th class="t-head">结算成功后账户余额</th>
								<th class="t-head">结算后租金收益</th>
								<th class="t-head">租凭柜所在社区名称</th>
								<th class="t-head">租凭柜名称</th>
								<th class="t-head">租凭柜编号</th>
								<th class="t-head">归还柜名称</th>
								<th class="t-head">取货时间</th>
								<th class="t-head">实际归还时间</th>
								<th class="t-head">租借时主电子条码</th>
								<th class="t-head">租借时配件电子条码</th>
								<th class="t-head">订单状态</th>
								<th class="t-head">异常状态</th>
								<th class="t-head">运维协议</th>
								<th class="t-head">结算状态</th>
								<th class="t-head">结算时间</th>
								<th class="t-head">订单详情</th>
								<th class="t-head">关联的赔付单</th>
								<th class="t-head">操作</th>
							</tr>
						</tbody>
						<tbody class="t-body tc" id="userPage">
							<c:forEach items="${values }" var="val" varStatus="status">
								<tr>
									<td>${ status.index + 1}</td>
									<td>${val.items.orderId_ }</td>
									<td>
										<!-- 用户手机号 -->${val.items.mobile_ }</td>
									<td>
										<!-- 租凭商品名称 -->${val.items.proName_ }</td>
									<td>
										<!-- 物品归属机构 -->${val.items.homeAgency_ }</td>
									<td>
										<!-- 租凭单价(/天) --> <c:if test="${val.items.isDiscount_ ==0}">
									${val.items.dayRentMoney_ }
								</c:if> <c:if test="${val.items.isDiscount_ ==1}">
									${val.items.discountPrice_ }
								</c:if>
									</td>
									<td>
										<!-- 创建时间 --> ${val.items.createDate }
									</td>
									<td>
										<!-- 付款时间 --> ${val.items.payTime}
									</td>
									<td>${val.items.out_trade_no_ }</td>
									<td> ${val.items.beginTime}</td>
									<td>${val.items.returnTime }</td>
									<td>${val.items.rentTime_ }</td>
									<td>${val.items.orderRentMoney_}</td>
									<td>${val.items.sumRentMoney_ }</td>
									<td>订单初始是否受到个信影响</td>
									<td>${val.items.sumOverMoney_ }</td>
									<td>${val.items.overdueDay_}</td>
									<td>${val.items.price_ }</td>
									<td>${val.items.cashPledge_ }</td>
									<td>${val.items.reliefDeposit_ }</td>
									<td>${val.items.Denomination_ }</td>
									<td>${val.items.sumMoney_ }</td>
									<td>${val.items.userNowMoney_ }</td>
									<td>${val.items.userNowMoney_  - val.items.amount_}</td>
									<td>${val.items.userNowMoney_  - val.items.amount_}</td>
									<td>${val.items.orderRentMoney_ }</td>
									<td>${val.items.boxCommunityName_}</td>
									<td>${val.items.boxName_ }</td>
									<td>${val.items.boxId_}</td>
									<td>${val.items.boxName_ }</td>
									<td>${val.items.recTime_}</td>
									<td>${val.items.returnOverTime_ }</td>
									<td>${val.items.zhuCode_ }</td>
									<td>
										${val.items.ciCode_ }
									</td>
									<td>
										<!-- 订单状态 --> <c:if test="${val.items.orderState_ ==1 }">
									待发货
								</c:if> <c:if test="${val.items.orderState_ ==2 }">
									待开箱
								</c:if> <c:if test="${val.items.orderState_ ==3 }">
									待收货
								</c:if> <c:if test="${val.items.orderState_ ==4 }">
									租凭中
								</c:if> <c:if test="${val.items.orderState_ ==5 }">
									归还中
								</c:if> <c:if test="${val.items.orderState_ ==6 }">
									已归还
								</c:if> <c:if test="${val.items.orderState_ ==7 }">
									完成
								</c:if> <c:if test="${val.items.orderState_ ==8 }">
									退款
								</c:if>
									</td>
									<td>异常状态</td>
									<td><a href="FrmIndemnityInfo.ywAgreement?type_=6" class="btn_style">查看</a></td>
									<td>
										<c:if test="${val.items.settleState_ =='0' }">
											未结算
										</c:if>
										<c:if test="${val.items.settleState_ =='1' }">
											手工结算
										</c:if>
										<c:if test="${val.items.settleState_ =='2' }">
											已结算
										</c:if>
									</td>
									<td>结算时间</td>
									<td><a class="btn_style" href="#">订单详情</a></td>
									<td>关联的赔付单</td>
									<td><a href="FrmDeliveryToBox.lookDetails?orderId_=${val.items.orderId_ }" class="btn_style">查看详情</a>&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="button" onclick="getEWM('${val.items.orderId_ }')" value="打印补货二维码" class="btn_style">
									   &nbsp;&nbsp;&nbsp;
                                <c:if test="${val.items.settleState_ =='0' }">
									<a href="#" onclick="hand('${val.items.orderId_}');" class="btn_style">转手工结算</a>
								</c:if>
								<c:if test="${val.items.settleState_ =='1' }">
									<a href="#" onclick="handSettle('${val.items.orderId_}');" class="btn_style">手工结算</a>
								</c:if>
								<c:if test="${val.items.settleState_ =='2' }">
									<a href="#" class="btn_style">已结算</a>
								</c:if>
									</td>
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