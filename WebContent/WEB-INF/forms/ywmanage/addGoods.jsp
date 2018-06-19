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
</head>
<body>
	<div class="mid-box fl" id="mid-box">
		<div class="top pl_20 pr_20">
			<span class="min-col f16">补货单查询展示</span>
		</div>
		<div role="grid">
			<div class="table">
				<form action="">
					<table class="tbl spe" style="margin-top: 20px">
						<tbody>
							<tr>
								<td class="t-head tc">序号</td>
								<td class="t-head tc">补货单据号</td>
								<td class="t-head tc">单据负责人</td>
								<td class="t-head tc">补货时间</td>
								<td class="t-head tc">补货柜子名称</td>
								<td class="t-head tc">箱子编号</td>
								<!-- <td class="t-head tc">补货后箱子空箱率</td> -->
								<td class="t-head tc">物品名称</td>
								<td class="t-head tc">物品主电子条码</td>
								<td class="t-head tc">物品配件条码</td>
							</tr>
						</tbody>
						<tbody class="t-body tc">
							<c:if test="${empty addGoods}">
								<div class="no_content">
									<img src="../../img/zwsj.png" style="width: 4rem;">
								</div>
							</c:if>
							<c:if test="${not empty addGoods}"></c:if>
							<c:forEach items="${addGoods }" var="ag" varStatus="status">
								<tr>
									<td>${status.index+1 }</td>
									<td>${ag.items.operateId_ }</td>
									<td>${ag.items.operateManId_ }</td>
									<td>${ag.items.CloseBoxTime_ }</td>
									<td>${ag.items.cabinetName }</td>
									<td>${ag.items.boxId_ }</td>
									<%-- <td>${ag.items.CloseBoxTime_ }</td> --%>
									<td>${ag.items.proName_ }</td>
									<td>${ag.items.zhuCode_ }</td>
									<td>${ag.items.ciCode_ }</td>
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