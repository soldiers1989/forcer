<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@include file="../ui/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>一启享</title>
<style>
	.scroll_table{
		width:100%;
		overflow-x:scroll;
		min-height:400px;
		padding:10px;
		box-sizing:border-box;
	}
	.tbl tr td{
		word-break: keep-all;
		}
</style>

</head>
<script type="text/javascript">
  layui.use('laydate', function(){
      var laydate = layui.laydate; 
    });
</script>
<script type="text/javascript">
    function page(pageno) {
        $("#subForm").append(
                '<input type="hidden" name="pageno" value="'+ pageno +'">');
        $("#subForm").submit();
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
<body>
<div class="mid-box fl" id="mid-box" style="width:90%;">
    <form action="" id="subForm">
	<input type="hidden" value="${code_}" name="code_">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
	            <span>按订单号：</span><input type="text" value="${orderId_}" name="orderId_">
				<span>按物品名称：</span><input type="text" value="${proName_}" name="proName_">
				<span>按租金：</span><input type="text" value="${dayRentMoney_}" name="dayRentMoney_">
			    <span>按起租时间：</span><input type="text"  onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="beginTime_" id="beginTime_"  value="${beginTime_ }"/> 
                <input type="submit" value="搜索">
            </div>
        </div>
    </form>
	<form action="" id="subForm">
	<div class="scroll_table">
		<table class="tbl">
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
				<td class="t-head" >订单租赁创建时间</td>
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
			<c:forEach items="${perLeaseOrders }" var="info">
			<tr >
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
				<td> ${info.items.createDate_ } 
				</td>
				<td> ${info.items.beginTime_ } 
				</td>
				<td> ${info.items.returnOverTime_ } 
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
					<a href="#" onclick="hand('${info.items.orderId_}');" class="btn_style">转手工结算</a>
				</c:if>
				<c:if test="${info.items.settleState_ =='1' }">
					<a href="#" onclick="handSettle('${info.items.orderId_}');" class="btn_style">手工结算</a>
				</c:if>
				<c:if test="${info.items.settleState_ =='2' }">
					<a href="#" class="btn_style">已结算</a>
				</c:if>
			</tr>
			</c:forEach>
			</tbody>
		</table>
		</div>
	</form>
	 <c:if test="${pages.count >= 1}">
        <div class="foot-page" align="center">
            <a href="javascript:page(1);" class='page-index Shouw'>首页</a> <a
                href="javascript:page(${pages.prior});">上一页</a> <a
                href="javascript:page(${pages.next});">下一页</a> <a
                href="javascript:page(${pages.count});" class="page-last Shouw">尾页</a>
            <span>总条数：</span>${pages.recordCount}, 页数：${pages.current} / ${pages.count}
        </div>
    </c:if>

</div>



<%-- <form action="" id="subForm">
<input type="hidden" value="${code_}" name="code_">
	<p>按订单号<input type="text" value="${orderId_}" name="orderId_"></p>
	<p>按物品名称<input type="text" value="${proName_}" name="proName_"></p>
	<p>按租金<input type="text" value="${dayRentMoney_}" name="dayRentMoney_"></p>
    <p>按起租时间<input type="text"   onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="beginTime_" id="beginTime_"  value="${beginTime_ }"/></p> 
	<input type="submit" value="搜索">
</form> --%>
	<%-- <form action="" id="subForm">
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
				<td>操作</td>	
			</tr>
			<c:forEach items="${perLeaseOrders }" var="info">
			<tr >
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
				<td> ${info.items.createDate_ } 
				</td>
				<td> ${info.items.beginTime_ } 
				</td>
				<td> ${info.items.returnOverTime_ } 
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
		</table>
	</form>
	 <c:if test="${pages.count >= 1}">
        <div class="foot-page" align="center">
            <a href="javascript:page(1);" class='page-index Shouw'>首页</a> <a
                href="javascript:page(${pages.prior});">上一页</a> <a
                href="javascript:page(${pages.next});">下一页</a> <a
                href="javascript:page(${pages.count});" class="page-last Shouw">尾页</a>
            <span>总条数：</span>${pages.recordCount}, 页数：${pages.current} / ${pages.count}
        </div>
    </c:if> --%>
</body>
</html>