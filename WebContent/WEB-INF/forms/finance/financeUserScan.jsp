<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>用户余额查询</title>
<style>
</style>
</head>
<body style="background-color: #ffffff;">

	<div class="mid-box fl" id="mid-box">
		<div class="top pl_20 pr_20">
			<span class="min-col f16">用户账户余额查询</span>
		</div>
		<form action="FrmUserBalance.getUser" method="post" id="subForm">
			<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
				<div class="fl leftSide">
	                <div>
	                    <span class="back_hint6">按账户余额大于</span><input type="text" name="yed_" value="${yed_ }">
						<span class="back_hint6">按账户余额小于</span><input type="text" name="yex_" value="${yex_ }">
						<span class="back_hint6">按账户押金大于</span><input type="text" name="yjd_" value="${yjd_ }">
					</div>
					<div class="mt_10">
						<span class="back_hint6">按历史充值大于</span><input type="text" name="czd_" value="${czd_ }">
						<span class="back_hint6">按历史提现大于</span><input type="text" name="txd_" value="${txd_ }">
						<span style="width:150px">按组订单物品价值总金额大于</span><input type="text" name="zod_" value="${zod_ }">
					</div>
				</div>
				<div class="fr rightSide">
					<input type="submit" value="查询" id="sub">
	                <a href="FrmUserBalance.ExcelUser?service=SvrGetUserMoney&amp;exportKey=SvrGetUserMoney&amp;templateId=SvrUserMoney"><input type="button" value="查询结果导出"></a>
				</div>
			</div>
		</form>
		<div>
		 <div role="grid">
        <div class="table">
            <table class="tbl">
		
				<tr>
					<td class="t-head tc">序号</td>
					<td class="t-head tc">用户名</td>
					<td class="t-head tc">账户余额</td>
					<td class="t-head tc">账户押金</td>
					<td class="t-head tc">账户锁定金额</td>
					<td class="t-head tc">未结清赔付账户</td>
					<td class="t-head tc">账户历史充值</td>
					<td class="t-head tc">账户历史提现</td>
					<td class="t-head tc">账户租订单物品价值总金额</td>
					<td class="t-head tc">在租订单免押总额度</td>
				</tr>
				<tbody class="t-body tc" id="userPage">
				<c:forEach items="${userMoney }" var="fin" varStatus="status">
					<tr>
						<td>${status.index+1 }</td>
						<td>${fin.items.name_ }</td>
						<c:if test="${empty fin.items.overMoney_}">
							<td>0.00</td>
						</c:if>
						<c:if test="${!empty fin.items.overMoney_}">
							<td>${fin.items.overMoney_ }</td>
						</c:if>
						
						<c:if test="${empty fin.items.cashPledge_}">
							<td>0.00</td>
						</c:if>
						<c:if test="${!empty fin.items.cashPledge_}">
							<td>${fin.items.cashPledge_ }</td>
						</c:if>
						
						<c:if test="${empty fin.items.sumRentMoney_}">
							<td>0.00</td>
						</c:if>
						<c:if test="${!empty fin.items.sumRentMoney_}">
							<td>${fin.items.sumRentMoney_ }</td>
						</c:if>
						<td>0.00</td>
						
						<c:if test="${empty fin.items.amount_1}">
							<td>0.00</td>
						</c:if>
						<c:if test="${!empty fin.items.amount_1}">
							<td>${fin.items.amount_1 }</td>
						</c:if>
						
						<c:if test="${empty fin.items.amount_2}">
							<td>0.00</td>
						</c:if>
						<c:if test="${!empty fin.items.amount_2}">
							<td>${fin.items.amount_2 }</td>
						</c:if>
						
						<c:if test="${empty fin.items.dayRentMoney_}">
							<td>0.00</td>
						</c:if>
						<c:if test="${!empty fin.items.dayRentMoney_}">
							<td>${fin.items.dayRentMoney_ }</td>
						</c:if>
						
						<c:if test="${empty fin.items.dayRentMoney_}">
							<td>0.00</td>
						</c:if>
						<c:if test="${!empty fin.items.dayRentMoney_}">
							<td>${fin.items.dayRentMoney_ }</td>
						</c:if>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			</div>
			    
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
		</div>
	</div>
</body>
<script type="text/javascript">
	function page(pageno) {
	    $("#subForm").append(
	            '<input type="hidden" name="pageno" value="'+ pageno +'">');
	    $("#subForm").submit();
	}
</script>
</html>
