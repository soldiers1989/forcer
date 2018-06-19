<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">评价详情</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="javascript:window.history.go(-1);" class="min-col"
			style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>	
	<div class="easyui-panel tc mt_20">
	<form action="FrmEvaluate.replyEvaluateById" method="post">
		<input type="hidden" name="orderId_" value="${value.items.orderId_ }">
		<div class="group-box two" name="null" visible="false">
			<label >评价用户：</label>
			<input type="text"  value="${value.items.userName_ }" disabled="disabled" style="border:none">
		</div>
		<div class="group-box two" name="null" visible="false">
			<label >评价时间：：</label>
			<input type="text"  value="${value.items.createDate_ }" disabled="disabled" style="border:none">
		</div>
		<div class="group-box two" name="null" visible="false">
			<label >评价类型：</label>
			<c:if test="${value.items.evaState_==0}"><input type="text"  value="匿名" disabled="disabled" style="border:none"></c:if>
			<c:if test="${value.items.evaState_==1}"><input type="text"  value="实名" disabled="disabled" style="border:none"></c:if>			 			
		</div>
		<div class="group-box two" name="null" visible="false">
			<label >评价内容：</label>
			<input type="text"  value="${value.items.evaContent_ }" disabled="disabled" style="border:none">			 			
		</div>
		<div class="group-box two clearfloat" name="null" visible="false" >
			<label style="float:left">评价截图：</label>
		
			<ul >
			<c:forEach items="${value.items.imgPath_ }" var="img">
				<li style="float:left"><img alt="" src="${img}" style="width:200px;height:200px;border:1px solid #f5f5f5;padding:5px;margin-left:10px"></li>
			</c:forEach>
			</ul>			 			
		</div>
		<div class="group-box two" name="null" visible="false" >
			<label >订单号：</label>
			<input type="text"  value="${value.items.orderId_ }" disabled="disabled" style="border:none">			 			
		</div>
		<div class="group-box two" name="null" visible="false">
			<label >商品名称：</label>
			<input type="text"  value="${value.items.proName_ }" disabled="disabled" style="border:none">			 			
		</div>
		<div class="group-box two" name="null" visible="false" disabled="disabled" style="border:none">
			<label >商品类型：</label>
			<c:if test="${value.items.orderType_==0}"><input type="text"  value="租赁" disabled="disabled" style="border:none"></c:if>
			<c:if test="${value.items.orderType_==1}"><input type="text"  value="购买" disabled="disabled" style="border:none"></c:if>			 			
		</div>
		<div class="group-box two" name="null" visible="false">
			<label >交易时间：</label>
			<input type="text"  value="${value.items.payTime_ }" disabled="disabled" style="border:none">			 			
		</div>
		<div class="group-box two" name="null" visible="false">
			<label >回复：</label>
			<textarea rows="" cols="" name="adminReply_"></textarea>	 			
		</div>
		<div  class="group-box "  visible="false">
			<input type="hidden" name="id_" value="${values.items.id_}">
			<input type="submit" value="修改提交" style="margin-top:10px">
		</div>	
	</form>
	</div>
</div>
		
	
		<%-- <div>
			<span>评价详情</span>
		</div>
		<hr>
		 <form action="FrmEvaluate.replyEvaluateById" method="post">
		 	<input type="hidden" name="orderId_" value="${value.items.orderId_ }">
		 		<table>
			 			<tr><td>评价用户：</td>
			 				<td>${value.items.userName_ }</td>
			 			</tr>
			 			<tr><td>评价时间：</td>
			 				<td>${value.items.createDate_ }</td>
			 			</tr>
			 			<tr><td>评价类型：</td>
			 				<td><c:if test="${value.items.evaState_==0}">匿名</c:if><c:if test="${value.items.evaState_==1}">实名</c:if></td>
			 			</tr>
			 			<tr><td>评价内容：</td>
			 				<td>${value.items.evaContent_ }</td>
			 			</tr>
			 			<tr><td>评价截图：</td>
			 				<td>
			 					<c:forEach items="${value.items.imgPath_ }" var="img">
									<li><img alt="" src="${img}" style="width:200px;height:200px"></li>
								</c:forEach>  
			 				</td>
			 			</tr>
			 			<tr><td>订单号：</td>
			 				<td>${value.items.orderId_ }</td>
			 			</tr>
			 			<tr><td>商品名称：</td>
			 				<td>${value.items.proName_ }</td>
			 			</tr>
			 			<tr><td>商品类型：</td>
			 				<td><c:if test="${value.items.orderType_==0}">租赁</c:if><c:if test="${value.items.orderType_==1}">购买</c:if></td>
			 			</tr>
			 			<tr><td>交易时间：</td>
			 				<td>${value.items.payTime_ }</td>
			 			</tr>
			 			<tr><td>回复：</td>
			 				<td><textarea rows="" cols="" name="adminReply_"></textarea></td>
			 			</tr>
		 		</table>
		 		
		 		<button type="submit">修改提交</button>
		 </form> --%>

</body>
</html>