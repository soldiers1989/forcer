<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@include file="../ui/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>一启享</title>
</head>
<!-- <h2>赔付单信息</h2> -->
<script type="text/javascript">
    function page(pageno) {
        $("#subForm").append(
                '<input type="hidden" name="pageno" value="'+ pageno +'">');
        $("#subForm").submit();
    }
</script>
<script type="text/javascript">
//生效
function tijiao(orderId_,operateId_) {
	$.ajax({
		url : 'FrmIndemnityInfo.effectIndemnity',
		dataType : 'json',
		type : 'post',
		cache : false,
		
		data : {
			orderId_ : orderId_,
			operateId_:operateId_
		},
		success : function(data) {
			if (data == false) {
				alert("赔付单未成功生效 ！");
				window.location.reload();
			} else {
				alert("赔付单已生效！");
				window.location.reload();
			}
		}
	});
}
//失效
function cancel(orderId_,operateId_) {
	$.ajax({
		url : 'FrmIndemnityInfo.invalidIndemnity',
		dataType : 'json',
		type : 'post',
		cache : false,
		data : {
			orderId_ : orderId_,
			operateId_:operateId_
		},
		success : function(data) {
			if (data == false) {
				alert("赔付单未成功失效！");
				window.location.reload();
			} else {
				alert("赔付单已失效！");
				window.location.reload();
			}
		}
	});
}

//检查用户是否有订单
function addIndemnity() {
	var orderNum = $("#orderNum").val();
	var mobile_ = $("#mobile_").val();
	if(orderNum > 0){
		window.location.href="FrmIndemnityInfo.toIndemnityInsert?mobile_="+mobile_;
	}
	else{
		alert("该用户暂无可添加赔付单的订单！");
		return false;
	}
}
</script>
<body>
<div class="mid-box fl" id="mid-box" style="width:100%">
    <form action="FrmInformationList" method="post" id="subForm">
        <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
            <div class="fl leftSide">
            <input type="text" value="${orderNum }" name="orderNum" id="orderNum">
            <input type="text" value="${mobile_ }" name="mobile_" id="mobile_">
            	<a 	onclick="addIndemnity();" class="btn_style">添加赔付单</a>
               <%--  <span>当前用户名</span>
               	<input type="text" value="${mobile_}" name="mobile_"> --%>
            </div>
            <div class="fl leftSide">
            	
            </div>
        </div>
    </form>
   <form action="">
   <div class="table overflowX">
   <table class="tbl kl" border="1px;" id="subForm">
	  <tr>
	  	<td class="t-head">序号</td>
	  	<td class="t-head">赔付单编号</td>
	  	<td class="t-head">关联租赁单号</td>
	  	<td class="t-head">关联运维单</td>
	  	<td class="t-head">物品名称</td>
	  	<td class="t-head">关联电子标签</td>
	  	<td class="t-head">物品归属机构</td>
	  	<td class="t-head">物品价值</td>
	  	<td class="t-head">已收押金</td>
	  	<td class="t-head">免押金额度</td>
	  	<td class="t-head">建议赔付金额</td>
	  	<td class="t-head">达成赔付金额</td>
	  	<td class="t-head">赔付原因</td>
	  	<td class="t-head">赔付后建议</td>
	  	<td class="t-head">赔付单时间</td>
	  	<td class="t-head">状态</td>
	  	<td class="t-head">操作</td>
	  </tr>
	  <tbody class="t-body tc" id="userPage">
	  <c:forEach items="${indemnitys }" var="inde" varStatus="status">
	   <tr>
	   	<td>${status.index+1}</td>
	   	<td>${inde.items.payID_ }</td>
	   	<td>${inde.items.orderId_ }</td>
	   	<td>${inde.items.operateId_ }</td>
	   	<td>${inde.items.proName_ }</td>
	   	<td>${inde.items.zhuCode_ }</td>
	    <td>${inde.items.homeAgency_ }</td>
	   	<td>${inde.items.proCostPrice_ }</td> 
	   	<td>${inde.items.sumMoney_ }</td>
	   	<td>${inde.items.reliefDeposit_ }</td>
	   	<td>${inde.items.suggestMoney_ }</td>
	   	<td>${inde.items.successMoney_ }</td>
	   	<td>${inde.items.payReason_ }</td>
	   	<td>${inde.items.suggest_ }</td>
	   	<td>
	   		<fmt:formatDate value="${inde.items.createDate_ }" pattern="yyyy-MM-dd  "/>
	   	</td>
	   	<td>
	   		<c:if test="${inde.items.payStatus_ =='0' }">
	   			结算前生效
	   		</c:if>
	   		<c:if test="${inde.items.payStatus_ =='1' }">
	   			结算后生效
	   		</c:if>
	   	</td>
	   	<td>
	   		<c:if test="${inde.items.payState_ =='0' }">
	   			<a href="FrmIndemnityInfo.updateIndemnity?orderId_=${inde.items.orderId_ }" class="btn_style">查看修改</a>&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;已生效
	   		</c:if>
	   		<c:if test="${inde.items.payState_ =='1' }">
	   		<a href="FrmIndemnityInfo.updateIndemnity?orderId_=${inde.items.orderId_ }" class="btn_style">查看修改</a>&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;已失效
	   		</c:if>
	   		<c:if test="${inde.items.payState_ == '2' }">
				<a href="FrmIndemnityInfo.updateIndemnity?orderId_=${inde.items.orderId_ }" class="btn_style">查看修改</a>&nbsp;&nbsp;&nbsp;
				<a href="#" onclick="tijiao('${inde.items.orderId_ }','${inde.items.operateId_ }')" class="btn_style">生效</a>&nbsp;&nbsp;&nbsp;
				<a href="#" onclick="cancel('${inde.items.orderId_ }','${inde.items.operateId_ }')" class="btn_style">失效</a>
	   		</c:if>
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
            <span>总条数：</span>${pages.recordCount}, 页数：${pages.current} / ${pages.count}
        </div>
    </c:if>
</div>






<%-- <p><a href="FrmIndemnityInfo.toIndemnityInsert?mobile_=${mobile_}">添加赔付单</a></p>
<form action="">
	<div>
		<span>当前用户名</span>
		<input type="text" value="${mobile_}" name="mobile_">
	</div>

	<table border="1px;" id="subForm">
	  <tr>
	  	<td>序号</td>
	  	<td>赔付单编号</td>
	  	<td>关联租赁单号</td>
	  	<td>关联运维单</td>
	  	<td>物品名称</td>
	  	<td>关联电子标签</td>
	  	<td>物品归属机构</td>
	  	<td>物品价值</td>
	  	<td>已收押金</td>
	  	<td>免押金额度</td>
	  	<td>建议赔付金额</td>
	  	<td>达成赔付金额</td>
	  	<td>赔付原因</td>
	  	<td>赔付后建议</td>
	  	<td>赔付单时间</td>
	  	<td>状态</td>
	  	<td>操作</td>
	  </tr>
	  <c:forEach items="${indemnitys }" var="inde" varStatus="status">
	   <tr>
	   	<td>${status.index+1}</td>
	   	<td>${inde.items.payID_ }</td>
	   	<td>${inde.items.orderId_ }</td>
	   	<td>${inde.items.operateId_ }</td>
	   	<td>${inde.items.proName_ }</td>
	   	<td>${inde.items.zhuCode_ }</td>
	    <td>${inde.items.homeAgency_ }</td>
	   	<td>${inde.items.proCostPrice_ }</td> 
	   	<td>${inde.items.sumMoney_ }</td>
	   	<td>${inde.items.reliefDeposit_ }</td>
	   	<td>${inde.items.suggestMoney_ }</td>
	   	<td>${inde.items.successMoney_ }</td>
	   	<td>${inde.items.payReason_ }</td>
	   	<td>${inde.items.suggest_ }</td>
	   	<td>
	   		<fmt:formatDate value="${inde.items.createDate_ }" pattern="yyyy-MM-dd  "/>
	   	</td>
	   	<td>
	   		<c:if test="${inde.items.payStatus_ =='0' }">
	   			结算前生效
	   		</c:if>
	   		<c:if test="${inde.items.payStatus_ =='1' }">
	   			结算后生效
	   		</c:if>
	   	</td>
	   	<td>
	   		<c:if test="${inde.items.payState_ =='0' }">
	   			<a href="FrmIndemnityInfo.updateIndemnity?orderId_=${inde.items.orderId_ }">查看修改</a>&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;已生效
	   		</c:if>
	   		<c:if test="${inde.items.payState_ =='1' }">
	   		<a href="FrmIndemnityInfo.updateIndemnity?orderId_=${inde.items.orderId_ }">查看修改</a>&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;已失效
	   		</c:if>
	   		<c:if test="${inde.items.payState_ == '2' }">
				<a href="FrmIndemnityInfo.updateIndemnity?orderId_=${inde.items.orderId_ }">查看修改</a>&nbsp;&nbsp;&nbsp;
				<a href="#" onclick="tijiao('${inde.items.orderId_ }','${inde.items.operateId_ }')">生效</a>&nbsp;&nbsp;&nbsp;
				<a href="#" onclick="cancel('${inde.items.orderId_ }','${inde.items.operateId_ }')">失效</a>
	   		</c:if>
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