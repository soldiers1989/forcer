<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>
<%@include file="../jspf/head1.jspf"%>
<script>
	$(function(){
		$(".parentId").each(function(){
			$(this).on("click",function(){
				var uid  = $(this).attr("value");
				if($(this).is(':checked') == true)
					$("input[data-parentId="+uid+"]").prop("checked",true);
				else
					$("input[data-parentId="+uid+"]").prop("checked",false);
			})
			
		});
		
		$(".sonMenu").each(function(){
			$(this).on("click",function(){
				if($(this).is(":checked"))
					$(".parentId[value="+$(this).attr("data-parentid")+"]").prop("checked",true);
			})
		})
		
		for(var key in $(".sonMenu")){
			if($(".sonMenu").eq(key).is(":checked")){
				var parObj = $(".parentId[value="+$(".sonMenu").eq(key).attr("data-parentid")+"]");
				if(!parObj.is(":checked"))
					parObj.prop("checked",true);
			}
		}
		
	});
</script>

<!--中间内容-->
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">详情</span>
    </div>
    <div style="padding: 0 20px;text-align: left;">
		<c:forEach var ="item" items="${asso }">
			<table>
				<tr>
					<td>保人信息id</td><td>${item.items.insurerId_ }</td>
					<td>投保人</td><td>${item.items.name_ }</td>
					<td>投保人性别 0：女 1：男</td><td>${item.items.sex_ }</td>
					<td>投保人身份证号</td><td>${item.items.ID_ }</td>
					<td>投保人身份证正面照</td><td>${item.items.IDimage1_ }</td>
				<tr>
					<td>投保人身份证反面照</td><td>${item.items.IDimage2_ }</td>
					<td>被保人</td><td>${item.items.insuredName_ }</td>
					<td>被保人性别 0：女 1：男</td><td>${item.items.insuredSex_ }</td>
					<td>被保人身份证反号</td><td>${item.items.insuredID_ }</td>
					<td>被保人身份证正面照</td><td>${item.items.insuredIDimage1_ }</td>
					<td>被保人身份证反面照:</td><td>${item.items.insuredIDimage2_ }</td>
				</tr>
			</table>
		</c:forEach>
    </div>
</div>
<!-- end content -->

<%@include file="../ui/footer.jspf"%>