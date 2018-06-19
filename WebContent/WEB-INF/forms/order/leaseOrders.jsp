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
<title>一启享</title>
<style>
	.leftSide input[type='text']{
		width:153px;
	}
	table tbody:first-child tr:first-child td{
		background: #f2f2f2;
	}
</style>
</head>
<body>
	<div class="mid-box fl" id="mid-box">
		<div class="top pl_20 pr_20">
			<span class="min-col f16">用户列表</span>
		</div>
		<form action="">
		<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
    		<div class="fl leftSide">
				按租赁订单<input type="text" name="orderId_" value="${orderId_ }">
				按归还订单<input type="text" name="returnId_" value="${returnId_ }">
				按运维订单<input type="text" name="operateId_" value="${operateId_ }">
				按赔付单<input type="text" name="payID_" value="${payID_ }"> 
				<input type="submit" value="查询">
			</div>
			<div class="fr rightSide">
				<a href="FrmExcel?service=SvrLeaseOrdersQuery&amp;exportKey=SvrLeaseOrdersQuery&amp;templateId=SvrLeaseOrdersQuery"
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
							<td>租赁订单</td>
							<td>支付时间</td>
							<td>取物订单</td>
							<td>取物时间</td>
							<td>归还订单</td>
							<td>归还时间</td>
							<td>运维订单</td>
							<td>运维时间</td>
							<td>赔付单</td>
							<td>赔付时间</td>
							<td>异常单号</td>
							<td>异常单创建时间</td>
							<td>操作</td>
						</tr>
					</tbody>
					<tbody class="t-body tc" id="userPage">
					<c:forEach items="${leases }" var="lease" varStatus="status">
						<tr>
							<td>${status.index+1 }</td>
							<td>${lease.items.orderId_}</td>
							<td>${lease.items.payTime_}</td>
							<td>${lease.items.id_}</td>
							<td>${lease.items.qwdate_}</td>
							<td>${lease.items.returnId_}</td>
							<td>${lease.items.returnOverTime_}</td>
							<td>${lease.items.operateId_}</td>
							<td>${lease.items.OpenBoxTime_}</td>
							<td>${lease.items.payID_}</td>
							<td>${lease.items.payDate_}</td>
							<td>${lease.items.ycNo_}</td>
							<td>${lease.items.ycTime_}</td>
							<td><a href="#" class="btn_style">手工绑定单据关联信息</a></td>
						</tr>
					</c:forEach>
					</tbody>
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