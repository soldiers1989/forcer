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
	table tbody:first-child tr:first-child td{
		background: #f2f2f2;
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
			<span class="min-col f16">按物品归属构订单查询</span>
		</div>
		<form action="" id="subForm">
			<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
 	 	       <div class="fl leftSide">
					租赁订单编号<input type="text" name="orderId_" value="${orderId_}">
					物品名称<input type="text" name="proName_" value="${proName_ }">
					<%-- 租赁单时间<input type="text" name="payTime" value="${payTime }"> --%>
					<span class="back_hint6">租赁单时间</span><input type="text"
					onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})"
					name="payTime" id="payTime" placeholder="起始日期"
					value="${payTime}" /> 
					<input type="submit" value="搜索">
				</div>
			<!-- 	<p>
		是否取物<input type="text" name="" value="">  
		物品是否归还<input type="text" name="" value="">
		物品是否赔付<input type="text" name="" value="">
	</p> -->
		
			<div class="fr rightSide">
				<a
					href="FrmExcel?service=SvrHomeOrdersQuery&amp;exportKey=SvrHomeOrdersQuery&amp;templateId=SvrHomeOrdersQuery"
					class="btn_style mb_0">导出（Excel）</a>
			</div>
		</div>
		</form>
		<div role="grid">
			<div class="table">
				<table class="tbl">
					<tbody>
						<tr>
							<td>序号</td>
							<td>物品归属机构简称</td>
							<td>租赁订单编号</td>
							<td>租赁单支付时间</td>
							<td>租赁单是否取物</td>
							<td>物品名称</td>
							<td>物品主条码</td>
							<td>租金收益</td>
							<td>订单产生社区简称</td>
							<td>应收超期租金</td>
							<td>实收超期租金</td>
							<td>物品是否归还</td>
							<td>物品是否赔付</td>
							<td>赔付差值</td>
							<td>物品是否报损</td>
						</tr>
					</tbody>
					<tbody class="t-body tc">
					<c:forEach items="${homeorders}" var="home" varStatus="status">
						<tr>
							<td>${status.index+1 }</td>
							<td>${home.items.homeAgency_ }</td>
							<td>${home.items.orderId_ }</td>
							<td>${home.items.payTime }</td>
							<td>
								<%-- ${home.items. } --%>
							</td>
							<td>${home.items.proName_ }</td>
							<td>${home.items.zhuCode_ }</td>
							<td>${home.items.sumRentMoney_ }</td>
							<td>${home.items.communityName_}</td>
							<td>${home.items.sumOverMoney_ }</td>
							<td>${home.items.sumOverMoney_ }</td>
							<td>
								<%-- ${home.items. } --%>
							</td>
							<td>
								<%-- ${home.items. } --%>
							</td>
							<td>
								<%-- ${home.items. } --%>
							</td>
							<td>
								<%-- ${home.items. } --%>
							</td>
						</tr>
					</c:forEach>
					<tbody class="t-body tc">
				</table>
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