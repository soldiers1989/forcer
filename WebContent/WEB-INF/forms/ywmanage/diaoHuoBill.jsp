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
</style>
</head>
<body>
	<div class="mid-box fl" id="mid-box">
		<div class="top pl_20 pr_20">
			<span class="min-col f16">调货单</span>
		</div>

		<div role="grid">
			<div class="table">
				<form action="">
					<table class="tbl spe">
						<tbody>
							<tr>
								<th class="t-head tc">序号</th>
								<th class="t-head tc">调货单据号</th>
								<th class="t-head tc">单据责任人</th>
								<th class="t-head tc">调货时间</th>
								<th class="t-head tc">调货柜子名称</th>
								<th class="t-head tc">箱子编号</th>
								<!-- <th>调货后箱子空箱率</th> -->
								<th class="t-head tc">物品名称</th>
								<th class="t-head tc">物品主电子条码</th>
								<!-- <th>单据是否转仓库存放</th> -->
								<th class="t-head tc">单据是否转为仓库报修状态</th>
								<th class="t-head tc">操作</th>
							</tr>
						</tbody>
						<tbody class="t-body tc">
							<c:if test="${empty diaohuos}">
								<div class="no_content">
									<img src="../../img/zwsj.png" style="width: 4rem;">
								</div>
							</c:if>
							<c:if test="${not empty diaohuos}"></c:if>
							<c:forEach items="${diaohuos }" var="dh" varStatus="status">
								<tr>
									<td>${status.index+1}</td>
									<td>${dh.items.operateId_ }</td>
									<td>${dh.items.operateManId_ }</td>
									<td>${dh.items.CloseBoxTime_ }</td>
									<td>${dh.items.cabinetName }</td>
									<td>${dh.items.boxId_ }</td>
									<%-- <td>${dh.items. }</td> --%>
									<td>${dh.items.proName_ }</td>
									<td>${dh.items.zhuCode_ }</td>
									<%-- <td>${dh.items. }</td> --%>
									<td>${dh.items.repairStatus_ =='0'?"否":"是" }</td>
									<td><a
										href="FrmDiaoHuoBill.modifyRepair?operateId_=${dh.items.operateId_ }"
										class="btn_style">手工变更物品位置状态为仓库手工变更物品为报修状态</a></td>
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