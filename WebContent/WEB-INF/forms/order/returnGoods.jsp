<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="${cdn}/layui/layui.js"></script>
<title>一启享</title>
<style type="text/css">
.leftSide input[type="text"], .leftSide select {
	width: 153px;
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
<script type="text/javascript">
	function  agree(rgId_){
		$.ajax({
			url : 'FrmReturnGoodsOrder.agreeReturnGoods',
			dataType : 'json',
			type : 'post',
			cache : false,
			data : {
				rgId_ : rgId_
			},
			success : function(data) {
				if (data == true) {
					alert("同意退货成功 ！");
					window.location.reload();
				} else {
					alert("同意退货失败！");
					window.location.reload();
				}
			}
		});
	}
</script>
</head>
<body>
	<div class="mid-box fl" id="mid-box">
		<div class="top pl_20 pr_20">
			<span class="min-col f16">退货订单列表</span>
		</div>
		<form action="">
			<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
				<div class="fl leftSide">
					<div>
						<span class="back_hint6">物品名称</span><input type="text"
							value="${proName_ }" name="proName_"> <span
							class="back_hint4">归属机构</span><input type="text"
							value="${saleHomeAgency_ }" name="saleHomeAgency_"> <span
							class="back_hint8">退货申请时间 </span><input type="text"
							onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD '})"
							name="reGoodsTime_" value="${reGoodsTime_ }" />
					</div>
					<div>
						<span class="back_hint6">是否同意退货</span><select name="isAgree_">
							<option value="-1"
								<c:if test="${isAgree_ eq '-1' || isAgree_ eq  null  }">selected="selected"</c:if>>全部</option>
							<option value="0"
								<c:if test="${isAgree_ eq '0' }">selected="selected"</c:if>>不同意</option>
							<option value="1"
								<c:if test="${isAgree_ eq '1' }">selected="selected"</c:if>>同意</option>
						</select> <span class="back_hint4"> 退货处理</span><select name="rgHand_">
							<option value="-1"
								<c:if test="${rgHand_ eq '-1' || rgHand_ eq  null  }">selected="selected"</c:if>>全部</option>
							<option value="1"
								<c:if test="${rgHand_ eq '1' }">selected="selected"</c:if>>全额退款</option>
							<option value="0"
								<c:if test="${rgHand_ eq '0' }">selected="selected"</c:if>>部分退款</option>
						</select> <span class="back_hint8">退货申请人手机号</span><input type="text"
							value="${mobile_ }" name="mobile_"> <span
							class="back_hint4">退货状态</span><select name="rgStatus_">
							<option value="-1"
								<c:if test="${rgStatus_ eq '-1' || rgStatus_ eq  null  }">selected="selected"</c:if>>全部</option>
							<option value="0"
								<c:if test="${rgStatus_ eq '0' }">selected="selected"</c:if>>退货处理中</option>
							<option value="1"
								<c:if test="${rgStatus_ eq '1' }">selected="selected"</c:if>>退货成功</option>
						</select> <input type="submit" value="查询">
					</div>
				</div>
		</form>
		<div class="fr rightSide">
			<a
				href="FrmExcel?service=SvrReturnGoodsOrder&amp;exportKey=SvrReturnGoodsOrder&amp;templateId=SvrReturnGoodsOrder"
				class="btn_style mb_0">导出（Excel）</a>
		</div>
		<form action="" id="subForm">
			<div role="grid">
				<table class="tbl">
					<tbody>
						<tr>
							<td class="t-head">序号</td>
							<td class="t-head">订单编号</td>
							<td class="t-head">退货申请人手机号</td>
							<td class="t-head">退货申请时间</td>
							<td class="t-head">关联购买订单号</td>
							<td class="t-head">商品名称</td>
							<td class="t-head">物品归属机构</td>
							<td class="t-head">是否同意用户退货</td>
							<td class="t-head">退货快递公司</td>
							<td class="t-head">退货快递单号</td>
							<td class="t-head">收货检查</td>
							<td class="t-head">退货状态</td>
							<td class="t-head">退货处理</td>
							<td class="t-head">退货结算金额</td>
							<td class="t-head">操作</td>
						</tr>
					</tbody>
					<tbody class="t-body tc" id="userPage">
						<c:forEach items="${returngoods}" var="re" varStatus="status">
							<tr>
								<td>${status.index+1 }</td>
								<td>${re.items.rgId_ }</td>
								<td>${re.items.mobile_ }</td>
								<td>${re.items.createDate_ }</td>
								<td>${re.items.orderId_ }</td>
								<td>${re.items.proName_ }</td>
								<td>${re.items.saleHomeAgency_ }</td>
								<td>
									<c:if test="${re.items.isAgree_ == '0' }">
										不同意
									</c:if> 
									<c:if test="${re.items.isAgree_ == '1' }">
										同意
									</c:if>
								</td>
								<td>${re.items.rgLogisticsName_ }</td>
								<td>${re.items.rgLogisticsId_ }</td>
								<td>
									<c:if test="${re.items.check_ == '0' }">
										不达标
									</c:if> 
									<c:if test="${re.items.check_ == '1' }">
										达标
									</c:if>
								</td>
								<td>
									<c:if test="${re.items.rgStatus_ == '0' }">
										退货处理中
									</c:if> 
									<c:if test="${re.items.rgStatus_ == '1' }">
										退货成功
									</c:if>
								</td>
								<td>
									<c:if test="${re.items.rgHand_ == '0' }">
										部分退款
									</c:if> 
									<c:if test="${re.items.rgHand_ == '1' }">
										全额退款
									</c:if>
								</td>
								<td>${re.items.rgMoney_ }</td>
								<td>
									<a onclick="agree('${re.items.rgId_ }');"  class="btn_style mr_10 mb_10">同意退货</a>
									<a href="FrmReturnGoodsOrder.returnHand?rgId_=${re.items.rgId_ }&orderId_=${re.items.orderId_ }" class="btn_style">录入退货处理&款项</a>
								</td>
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
			<span>总条数：</span>${pages.recordCount}, 页数：${pages.current} /
			${pages.count}
		</div>
	</c:if>
	</div>
</body>
</html>