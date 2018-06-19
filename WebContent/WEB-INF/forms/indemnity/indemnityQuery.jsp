<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="../ui/head1.jspf"%>
    <%@include file="../ui/head2.jspf" %> 
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>一启享</title>
<style type="text/css">
.leftSide input[type='text'],.leftSide select{
	width:153px;
}
.tbl tbody:first-child tr:first-child td{
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
	width:100%;
	overflow:scroll;
	 min-height: 600px;
	 padding:0 15px;
}
</style>
</head>
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
</script>
<body>
<div class="mid-box fl" id="mid-box">
    <div class="top pl_20 pr_20">
        <span class="min-col f16">赔付单列表</span>
    </div>
<form action="">
<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
    <div class="fl leftSide">
	<div>
		 <span class="back_hint4">用户手机号</span><input type="text" name="mobile_" value="${mobile_ }">
		<span class="back_hint4">归属机构</span><input type="text" name="homeAgency_" value="${homeAgency_ }">
		<span class="back_hint6">关联租赁单号</span><input type="text" name="orderId_" value="${orderId_ }">
	</div>
	<div>
		<span class="back_hint4">物品名称</span><input type="text" name="proName_" value="${proName_ }">
		<span class="back_hint4">赔付原因</span><input type="text" name="payReason_" value="${payReason_ }">
		<span class="back_hint6">关联运维单号</span><input type="text" name="operateId_" value="${operateId_}">
		<span class="back_hint4">运维状态 </span>
		<select name="payStatus_">
			 <option value="-1" <c:if test="${payStatus_ eq '-1'  || payStatus_ eq null }">selected="selected"</c:if>>全部</option>
			 <option value="0" <c:if test="${payStatus_ eq '0' }">selected="selected"</c:if>>结算前生效</option>
			 <option value="1" <c:if test="${payStatus_ eq '1' }">selected="selected"</c:if>>结算后生效</option>
		</select>
	<input type="submit" value="搜索">
	</div>
	</div>
</form>
 <div class="fr rightSide">
     <a href="FrmExcel?service=SvrIndemnityList&amp;exportKey=SvrIndemnityList&amp;templateId=SvrIndemnityList" class="btn_style mb_0">导出（Excel）</a>
  </div>
    <div role="grid">
        <div class="table">
            <table class="tbl">
                <tbody>
				  <tr>
				  	<td>序号</td>
				  	<td>用户手机号</td>
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
	  		</tbody>
	  		<tbody class="t-body tc" id="userPage">
		  	<c:forEach items="${indemnitys }" var="inde" varStatus="status">
			   	<tr>
			   	<td>${status.index+1}</td>
			   	<td>${inde.items.mobile_ }</td>
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
	   		<%-- <c:if test="${inde.items.payState_ =='0' }">
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
	   		</c:if> --%>
	   			<a href="FrmIndemnityQuery.indemnityLook?orderId_=${inde.items.orderId_ }&operateId_=${inde.items.operateId_ }" class="btn_style">查看详情</a>
			&nbsp;<a href="#" class="btn_style">查看修改</a>&nbsp;&nbsp;<a href="#" class="btn_style">生效</a>&nbsp;&nbsp;<a href="#" class="btn_style">失效</a>
			</td>
		   </tr>
	  </c:forEach>
	   <tbody class="t-body tc" id="userPage">
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