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
       <span class="min-col f16">后台-详情</span>
    </div>
    <div class="easyui-panel tc mt_20">
		<div class="tl ml_20 mb_20">
			<a href="javascript:window.history.go(-1);" class="min-col" style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
		</div>
	</div>
	<c:forEach var ="item" items="${pers}">
		<div class="group-box">
			<label>用户名：</label><input type="text"  readonly value="${item.items.name_ }">
		</div>
		<div class="group-box">
			<label>用户头像：</label><img class="ui_grap" width="100px" height="100px" src="${item.items.portrait_ }">
		</div>
		<div class="group-box">
			<label>用户手机号：</label><input type="text"  readonly value="${item.items.mobile_ }">
		</div>
		<div class="group-box">
			<label>注册时间：</label><input type="text"  readonly value="${item.items.createTime_ }">
		</div>
	</c:forEach>
	
    <%-- <div role="grid">
	<div class="table">
		<table class="tbl">
			<tbody>
				<tr>
					<th class="t-head tc" width="50px">用户名</th>
					<th class="t-head tc" width="50px">用户头像</th>
					<th class="t-head tc" width="50px">用户手机号</th>
					<th class="t-head tc" width="50px">注册时间</th>
				</tr>
				<c:forEach var ="item" items="${pers}">
				<tr>
					<td class="tc">${item.items.name_ }</td>
					<td class="tc">${item.items.portrait_ }</td>
					<td class="tc">${item.items.mobile_ }</td>
					<td class="tc">${item.items.createTime_ }</td>
				</tr>
				</c:forEach>
			</tbody>
			<!-- <tbody class="t-body tc">
				
			</tbody> -->
		</table> --%>

	</div>
</div>
    <%-- <div style="padding: 0 20px;text-align: left;">
		<c:forEach var ="item" items="${pers}">
		<table>
			<tr>
				<td>用户名：</td><td>${item.items.name_ }</td>
			</tr>
			<tr>
				<td>用户头像：</td><td>${item.items.portrait_ }</td>
			</tr>
			<tr>
				<td>用户手机号：</td><td>${item.items.mobile_ }</td>
			</tr>
			<tr>
				<td>注册时间：</td><td>${item.items.createTime_ }</td>
			</tr>
		</table>
		</c:forEach>
    </div> --%>
</div>
<!-- end content -->

<%@include file="../ui/footer.jspf"%>