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
	min-height: 800px;
	padding: 0 15px;
}

</style>
</head>
<body>
	<div class="mid-box fl" id="mid-box">
		<div class="top pl_20 pr_20">
			<span class="min-col f16">运维单</span>
		</div>
		<div role="grid">
			<div class="table">
				<form action="">
					<table class="tbl spe" style="margin-top: 20px">
						<tbody>
							<tr>
								<td class="t-head tc">序号</td>
								<td class="t-head tc">运维单号</td>
								<td class="t-head tc">运维负责人</td>
								<td class="t-head tc">关联租赁单号</td>
								<!-- <td class="t-head tc">发起订单用户</td>
								<td class="t-head tc">关联归还订单号丢失情况</td> -->
								<td class="t-head tc">关联物品名称</td>
								<td class="t-head tc">物品主电子条码</td>
								<td class="t-head tc">运维时间(关锁)</td>
								<td class="t-head tc">柜子名称</td>
								<td class="t-head tc">箱子编号</td>
								<!-- <td class="t-head tc">物品上次运维时间</td>
								<td class="t-head tc">物品上次租赁单关联运维单号</td> -->
								<td class="t-head tc">运维留言</td>
								<td class="t-head tc">开锁次数</td>
								<td class="t-head tc">查看运维图片</td>
								<td class="t-head tc">本次运维上报的折损率</td>
								<td class="t-head tc">操作</td>
							</tr>
						</tbody>
						<tbody class="t-body tc">
							<c:if test="${empty yunweis}">
								<div class="no_content">
									<img src="../../img/zwsj.png" style="width: 4rem;">
								</div>
							</c:if>
							<c:if test="${not empty yunweis}"></c:if>
							<c:forEach items="${yunweis }" var="yw" varStatus="status">
								<tr>
									<td>${status.index+1 }</td>
									<td>${yw.items.operateId_ }</td>
									<td>${yw.items.operateManId_ }</td>
									<td>${yw.items.orderId_ }</td>
									<%-- <td>发起订单用户${yw.items. } </td> --%>
									<%-- <td>关联归还订单号丢失情况${yw.items. }</td> --%>
									<td>${yw.items.proName_ }</td>
									<td>${yw.items.zhuCode_ }</td>
									<td>${yw.items.CloseBoxTime_ }</td>
									<td>${yw.items.cabinetName }</td>
									<td>${yw.items.boxId_ }</td>
									<%-- <td>物品上次运维时间${yw.items. }</td>
				<td>物品上次租赁单关联运维单号${yw.items. }</td> --%>
									<td>${yw.items.leaveMess_ }</td>
									<td>${yw.items.openTime }</td>
									<td><a
										href="FrmYunWeiBill.lookImg?operateId_=${yw.items.operateId_ }"
										class="btn_style">查看</a></td>
									<td>${yw.items.nowLoss_ }</td>
									<td><a
										href="FrmYunWeiBill.modifySale?operateId_=${yw.items.operateId_ }"
										class="btn_style">变更物品当前折旧率</a></td>
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