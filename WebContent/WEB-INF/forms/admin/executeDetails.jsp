<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>
<%@include file="../jspf/head1.jspf"%>
<style>
.group-box label {
    /* display: inline-block; */
    width: 150px;
    text-align: right;
    margin-right: 5px;
    vertical-align: middle;
}
</style>
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
     <div class="easyui-panel tc mt_20">
		<div class="tl ml_20 mb_20">
			<a href="javascript:window.history.go(-1);" class="min-col" style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
		</div>
	</div>
    <div style="padding: 0 20px;text-align: left;">
		<c:forEach var ="item" items="${details }">
		<div class="group-box">
				<label>保人信息id：</label><input type="text"  readonly value="${item.items.insurerId_ }">
		</div>
		<div class="group-box">
				<label>投保人：</label><input type="text"  readonly value="${item.items.name_ }">
		</div>
		<div class="group-box">
				<label style="margin-right: 0;">投保人性别：</label> <!-- 0：女 1：男 -->
				<input type="text"  readonly value="${item.items.sex_ }">
		</div>
		<div class="group-box">
				<label>投保人身份证号：</label><input type="text"  readonly value="${item.items.ID_ }">
		</div>
		<div class="group-box">
				<label class="Vtop" style="margin-right: 0;">投保人身份证正面照：</label>
				<img width="100px" height="100px" class="ui_grap" src="${item.items.IDimage1_ }">
		</div>
		<div class="group-box">
				<label class="Vtop">投保人身份证反面照：</label><img class="ui_grap" src="${item.items.IDimage2_ }" width="100px" height="100px">
		</div>
		<div class="group-box">
				<label>被保人：</label>
				<input type="text"  readonly value="${item.items.insuredName_ }">
		</div>
		<div class="group-box">
				<label>被保人性别 ：</label><!-- 0：女 1：男</td> -->
				<input type="text"  readonly value="${item.items.insuredSex_ }">
		</div>
		<div class="group-box">
				<label>被保人身份证反号：</label>
				<input type="text"  readonly value="${item.items.insuredID_ }">
		</div>
		<div class="group-box">
				<label class="Vtop">被保人身份证正面照：</label><img class="ui_grap" src="${item.items.insuredIDimage1_ }" width="100px" height="100px"/>
		</div>
		<div class="group-box">
				<label class="Vtop">被保人身份证反面照：</label><img class="ui_grap" src="${item.items.insuredIDimage2_ }" width="100px" height="100px">
		</div>
		</c:forEach>
    </div>
</div>
<!-- end content -->

<%@include file="../ui/footer.jspf"%>