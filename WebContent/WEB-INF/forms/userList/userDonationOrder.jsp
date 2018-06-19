<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="flayout_r">
	<div class="" style="width:100%">
		    <form action="FrmgetUser.userDonateOrder" method="post" id="subForm">
        		<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
                	<span class="back_hint4">订单号：</span><input type="text" name="orderId_" value="${orderId_ }">
               	 	<span class="back_hint4">按物品描述模糊搜索：</span><input type="text" name="orderDesc_" value="${orderDesc_ }">
               	 	<input type="submit" value="查询" id="sub">
        		</div>
   			</form>
		<div class="flayout_sb">
			<div style="width:100%">
				<table class="tbl" style="width:90%">
					<tr>
						<td class="t-head tc">订单编号</td>
						<td class="t-head tc">订单物品描述</td>
						<td class="t-head tc">数量</td>
						<td class="t-head tc">订单创建时间</td>
						<td class="t-head tc">捐赠柜地址</td>
						<td class="t-head tc">捐赠状态变更时间</td>
						<td class="t-head tc">收货状态</td>
						<td class="t-head tc">收货运维人员电话</td>
						<td class="t-head tc">收货时间</td>
						<td class="t-head tc">操作</td>
					</tr>
	                <tbody class="t-body tc">
	                  <%-- 	<c:if test="${empty values}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;"></div></c:if> --%>
	                   	<c:if test="${not empty values}">
		                    <c:forEach items="${values }" var="value" varStatus="status">
		                        <tr>
		                            <td>${value.items.orderId_}</td>
		                            <td>${value.items.orderDesc_}</td>
		                            <td>${value.items.count_}</td>
		                            <td>${value.items.adr_}</td>
		                            <td>
		                            	<c:if test="${value.items.status_ == '0'}">未发公益机构</c:if>
		                            	<c:if test="${value.items.status_ == '1'}">已发公益机构</c:if>
		                            </td>
		                            <td>${value.items.statusTime_}</td>
		                            <td>${value.items.shStatus_}</td>
		                            <td>${value.items.maintainPhone_}</td>
		                            <td>${value.items.shouhuoTime_}</td>
		                            <td>
		                            	<c:if test="${value.items.status_ == '0'}">
											<a onclick="show('${value.items.orderId_}')" class="btn_style" style="margin-right:5px;">变更捐赠状态 </a>
										</c:if>
		                            	<c:if test="${value.items.status_ == '1'}">
											<a onclick="showa()" class="btn_style" style="margin-right:5px;">变更捐赠状态 </a>
										</c:if>
		                            </td>
		                        </tr>
		                    </c:forEach>
	                    </c:if>
	                </tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	function showa(){
		alert("此订单状态已经变更过！！")
	}
	function show(orderId_){
		if(window.confirm('你确定变更状态吗？\n\n 请确认！！')){
		    $.ajax({
				url : 'FrmgetUser.upDonationOrder',
				dataType : 'json',
				type : 'post',
				data : { 
					"orderId_" : orderId_
				},
				cache : false,
				success : function(data) {
					if(data == true){
						alert("变更捐赠状态成功！");
						window.location.href='FrmgetUser.userDonateOrder';
					}else{
						alert("变更捐赠状态失败!")
					}
				}
				});
         }else{
            //alert("取消");
            return false;
        }
	}
</script>
