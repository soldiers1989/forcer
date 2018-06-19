<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../ui/head1.jspf"%>
    <%@include file="../ui/head2.jspf" %> 
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>一启享</title>
<style>
	.leftSide input[type='text'],.leftSide select{
		width:153px;
	}
	table tbody:first-child tr:first-child td{
		background: #f2f2f2;
	}
	table th{
	white-space: nowrap;
	padding:10px;
	}  
	table td{
	   white-space: nowrap;
	   padding:5px;
	} 
	.table{
		width:99%;
		overflow:scroll;
		 min-height: 600px;
		 padding:0 15px;
	}
</style>
<script type="text/javascript">
    function page(pageno) {
        $("#subForm").append(
                '<input type="hidden" name="pageno" value="'+ pageno +'">');
        $("#subForm").submit();
    }
</script>
</head>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">快递归还订单</span>
    </div>
<form action="">
	<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
    	<div class="fl leftSide">
        	<div>
				<span class="back_hint6">物品名称</span><input type="text" name="proName_" value="${proName_ }">
				<span class="back_hint4">归属机构</span><input type="text" name="homeAgency_" value="${homeAgency_ }">
				<span class="back_hint6">关联租赁单号</span><input type="text" name="orderId_" value="${orderId_ }">
				<input type="submit" value="搜索">
			</div>
			<div>
			<span class="back_hint6">归还用户手机号</span><input type="text" name="mobile_" value="${mobile_ }">
			<span class="back_hint4">结算状态</span>
				<select name="settleState_">
				   <option value="-2" <c:if test="${settleState_ eq '-2' || settleState_ eq  null  }">selected="selected"</c:if>>全部</option>
				   <option value="0" <c:if test="${settleState_ eq '0' }">selected="selected"</c:if>>未结算</option>
			       <option value="1" <c:if test="${settleState_ eq '1' }">selected="selected"</c:if>>手工结算</option>
			        <option value="2" <c:if test="${settleState_ eq '2' }">selected="selected"</c:if>>已结算</option>
				</select>
			</div>
		</div>
		</div>
</form>
<div class="fr rightSide">
     <a href="FrmExcel?service=SvrExpressOrdersQuery&amp;exportKey=SvrExpressOrdersQuery&amp;templateId=SvrExpressOrdersQuery" class="btn_style mb_0">导出（Excel）</a>
  </div>
    <div role="grid">
        <div class="table">
            <table class="tbl">
                <tbody>
					<tr>
						<td>序号</td>
						<td>快递归还归还订单</td>
						<td>归还人手机号</td>
						<td>物品归属机构</td>
						<td>商品名称</td>
						<td>归还物流状态(默认为待发货)</td>
						<td>归还物流公司</td>
						<td>归还物流单号</td>
						<td>物流单号发出时间(发出时间默认为归还时间)</td>
						<td>运维检修是否报异常</td>
						<td>租借时主电子条码</td>
						<td>租借时配件电子条码</td>
						<td>归还时电子条码</td>
						<td>缺失条码</td>
						<td>关联运维订单单号</td>
						<td>关联租赁订单号</td>
						<td>关联租赁订单结算状态</td>
						<td>操作</td>
					</tr>
				</tbody>
				<tbody class="t-body tc" id="userPage">
				<c:forEach items="${express}" var="ex" varStatus="status">
					<tr>
						<td>${status.index+1 }</td>
						<td>${ex.items.orderId_}</td>
						<td>${ex.items.mobile_}</td>
						<td>${ex.items.homeAgency_}</td>
						<td>${ex.items.proName_}</td>
						<td>
							<c:if test="${ex.items.logisticsState_ == '0'}">
								待发货
							</c:if>
							<c:if test="${ex.items.logisticsState_ == '1'}">
								快递收件
							</c:if>
							<c:if test="${ex.items.logisticsState_ == '2'}">
								途中
							</c:if>
							<c:if test="${ex.items.logisticsState_ == '3'}">
								签收
							</c:if>
						</td>
						<td>${ex.items.recLogisticsName_}</td>
						<td>${ex.items.recLogisticsId_}</td>
						<td>${ex.items.deliveryTime_}</td>
						<td>无</td>
						<td>${ex.items.zhuCode_}</td>
						<td>${ex.items.ciCode_}</td>
						<td>${ex.items.zhuCode_}${ex.items.ciCode_}</td>
						<td>0</td>
						<td>${ex.items.operateId_}</td>
						<td>${ex.items.orderId_}</td>
						<td> 
							<c:if test="${ex.items.settleState_  == '0'}">
								未结算
							</c:if>
							<c:if test="${ex.items.settleState_  == '1'}">
								手工结算
							</c:if>
							<c:if test="${ex.items.settleState_  == '2'}">
								已结算
							</c:if>
						</td>
						<td><a href="FrmExpressOrders.modifyLogistics?orderId_=${ex.items.orderId_}" class="btn_style">查看修改物流信息</a></td>
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
         <span>总条数：</span>${pages.recordCount}, 页数：${pages.current} / ${pages.count}
     </div>
 </c:if>
 </div>
</body>
</html>