<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@include file="../ui/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>一启享</title>
</head>
<body>
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
<div class="mid-box fl" id="mid-box">
    <form action="FrmInformationList" method="post" id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
	            <div>
	            	<span class="back_hint6">按订单号</span><input type="text" value="${orderId_}" name="orderId_">
					<span class="back_hint6">按物品名称</span><input type="text" value="${proName_}" name="proName_">
					<span class="back_hint6">按应付金额</span><input type="text" value="${sumMoney_}" name="sumMoney_">
				</div>
				<div class="mt_10">
					<span class="back_hint6">按起租时间</span><input type="text"   onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="createDate_" id="createDate_"  value="${createDate_ }"/>
					<span class="back_hint6">按订单状态</span><input type="text" value="${orderState_}" name="orderState_">
	            </div>
            </div>
             <div class="fr rightSide">
             	<input type="submit" value="搜索">
            </div>
        </div>
    </form>
	<form action="" id="subForm">
	<table class="tbl">
		<tr>
			<td class="t-head tc">订单编号</td>
			<td class="t-head tc">收货人姓名</td>
			<td class="t-head tc">物品名称</td>
			<td class="t-head tc">物品归属</td>
			<td class="t-head tc">收货地址</td>
			<td class="t-head tc">总金额</td>
			<td class="t-head tc">应付金额</td>
			<td class="t-head tc">订单时间</td>
			<td class="t-head tc">快递公司</td>
			<td class="t-head tc">快递单号</td>
			<td class="t-head tc">快递最新状态</td>
			<td class="t-head tc">订单状态</td>
			<td class="t-head tc">操作</td>
		</tr>
		<tbody class="t-body tc">
			
		<c:forEach items="${perBuyOrders }" var="val">
			<tr>
				<td>${val.items.orderId_ }</td>
				<td>${val.items.receiver_ }</td>
				<td>${val.items.proName_ }</td>
				<td>${val.items.homeAgency_ }</td>
				<td>${val.items.recAdr_ }</td>
				<td>${val.items.sumRentMoney_ }</td>
				<td>${val.items.sumMoney_}</td>
				<td>${val.items.createDate_ }</td>
				<td>${val.items.recLogisticsName_ }</td>
				<td>${val.items.recLogisticsId_ }</td>
				<td>
					<c:if test="${val.items.logisticsState_  == '-1'}">
						单号或快递公司代码错误
					</c:if>
					<c:if test="${val.items.logisticsState_  == '0'}">
						暂无轨迹
					</c:if>
					<c:if test="${val.items.logisticsState_  == '1'}">
						快递收件
					</c:if>
					<c:if test="${val.items.logisticsState_  == '2'}">
						在途中
					</c:if>
					<c:if test="${val.items.logisticsState_  == '3'}">
						签收
					</c:if>
					<c:if test="${val.items.logisticsState_  == '4'}">
						问题件
					</c:if>
					
				</td>
				<td>
				<c:if test="${val.items.orderState_  == '1'}">
						代发货
					</c:if>
					<c:if test="${val.items.orderState_  == '3'}">
						待收货
					</c:if>
					<c:if test="${val.items.orderState_  == '4'}">
						租用中
					</c:if>
					<c:if test="${val.items.orderState_  == '7'}">
						完成
					</c:if>
					<c:if test="${val.items.orderState_  == '8'}">
						退款
					</c:if>
					<c:if test="${val.items.orderState_  == '9'}">
						退货中
					</c:if>
					<c:if test="${val.items.orderState_  == '10'}">
						已退货
					</c:if>
				</td>
				<td>
					<a href="FrmPersonalInfo.updateNumber?orderId_=${val.items.orderId_ }" class="btn_style">变更物流单号</a>&nbsp;&nbsp;&nbsp;
					<a href="FrmPersonalInfo.buyOrderDetails?orderId_=${val.items.orderId_ }" class="btn_style">查看订单详情</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
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
    </c:if>
</div>


<%--<form action="" id="subForm">
<input type="hidden" value="${code_}" name="code_">
	<p>按订单号<input type="text" value="${orderId_}" name="orderId_"></p>
	<p>按物品名称<input type="text" value="${proName_}" name="proName_"></p>
	<p>按应付金额<input type="text" value="${sumMoney_}" name="sumMoney_"></p>
	<p>按起租时间<input type="text"   onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})" name="createDate_" id="createDate_"  value="${createDate_ }"/></p> 
	<p>按订单状态<input type="text" value="${orderState_}" name="orderState_"></p>
	<input type="submit" value="搜索">
</form>
 <form action="" id="subForm">
	<table>
		<tr>
			<td>订单编号</td>
			<td>收货人姓名</td>
			<td>物品名称</td>
			<td>物品归属</td>
			<td>收货地址</td>
			<td>总金额</td>
			<td>应付金额</td>
			<td>订单时间</td>
			<td>快递公司</td>
			<td>快递单号</td>
			<td>快递最新状态</td>
			<td>订单状态</td>
			<td>操作</td>
		</tr>
		<c:forEach items="${perBuyOrders }" var="val">
			<tr>
				<td>${val.items.orderId_ }</td>
				<td>${val.items.receiver_ }</td>
				<td>${val.items.proName_ }</td>
				<td>${val.items.homeAgency_ }</td>
				<td>${val.items.recAdr_ }</td>
				<td>${val.items.sumRentMoney_ }</td>
				<td>${val.items.sumMoney_}</td>
				<td>${val.items.createDate_ }</td>
				<td>${val.items.recLogisticsName_ }</td>
				<td>${val.items.recLogisticsId_ }</td>
				<td>
					<c:if test="${val.items.logisticsState_  == '-1'}">
						单号或快递公司代码错误
					</c:if>
					<c:if test="${val.items.logisticsState_  == '0'}">
						暂无轨迹
					</c:if>
					<c:if test="${val.items.logisticsState_  == '1'}">
						快递收件
					</c:if>
					<c:if test="${val.items.logisticsState_  == '2'}">
						在途中
					</c:if>
					<c:if test="${val.items.logisticsState_  == '3'}">
						签收
					</c:if>
					<c:if test="${val.items.logisticsState_  == '4'}">
						问题件
					</c:if>
					
				</td>
				<td>
				<c:if test="${val.items.orderState_  == '1'}">
						代发货
					</c:if>
					<c:if test="${val.items.orderState_  == '3'}">
						待收货
					</c:if>
					<c:if test="${val.items.orderState_  == '4'}">
						租用中
					</c:if>
					<c:if test="${val.items.orderState_  == '7'}">
						完成
					</c:if>
					<c:if test="${val.items.orderState_  == '8'}">
						退款
					</c:if>
					<c:if test="${val.items.orderState_  == '9'}">
						退货中
					</c:if>
					<c:if test="${val.items.orderState_  == '10'}">
						已退货
					</c:if>
				</td>
				<td>
					<a href="FrmPersonalInfo.updateNumber?orderId_=${val.items.orderId_ }">变更物流单号</a>&nbsp;&nbsp;&nbsp;
					<a href="FrmPersonalInfo.buyOrderDetails?orderId_=${val.items.orderId_ }">查看订单详情</a>
				</td>
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