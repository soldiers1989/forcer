<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>
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
		
		$("input[type='submit']").on("click",function(){
			var cbs = document.getElementsByName("powerIds");
			var checkNum = 0;
			for (var i = 0; i < cbs.length; i++) {
			    if (cbs[i].checked) {
			        checkNum++;
			    }
			}
			if (checkNum == 0) {
			    alert("请至少选中一个");
			    return false;
			}
			return true;
		});
		
	});
</script>

<!--中间内容-->
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20 mb_20">
       <span class="min-col f16">分配功能</span>
    </div>
     <div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	 <a href="javascript:window.history.go(-1);" class="min-col"
			style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	    </div>
	    <div class="fr rightSide">
	    </div>
	</div>
    <div style="padding: 0 20px;text-align: left;">
    <form action="FrmRoleData.sendPower" method="post">
    	<input hidden="true" name="roleId" value="${roleId}" />
   			<c:forEach var="item" items="${lists}">
	  				<c:if test="${item.items.parentId_ == '-1'}">
	  					<div style="background-color: #e9e9e9;padding:5px 10px;" class="mb_10"><label style="font-weight:bold" class="cl-666"><input class="parentId"
	  					<c:forEach var="userPower" items="${userPowers }">
							<c:if test="${item.items.UID_ == userPower.items.powerId_ }">
							checked="true"
							</c:if>
						</c:forEach>
	  					 name="powerIds" type="checkbox" value="${item.items.UID_}"/> ${item.items.name_ }</label></div>
	  					<c:forEach var="item1" items="${lists}">
	  						<c:if test="${item1.items.parentId_ == item.items.UID_}">
	  							<label class="pb_10 ml_10 mr_10 cl-666" style="display: inline-table;"><input 
	  							<c:forEach var="userPower" items="${userPowers }">
	  								<c:if test="${item1.items.UID_ == userPower.items.powerId_ }">
	  								checked="true"
	  								</c:if>
	  							</c:forEach>
	  							 name="powerIds" class="sonMenu" data-parentId="${item1.items.parentId_}" type="checkbox" value="${item1.items.UID_}"/> ${item1.items.name_ }</label>
	  						</c:if>
	  					</c:forEach>
	  				</c:if>
     		</c:forEach>
     	<div class="tc">
	     	<div class="button mt_20 pt_20"><input type="submit" value="确定"/></div>
     	</div>
    </form>
    </div>
</div>
<!-- end content -->

<%@include file="../ui/footer.jspf"%>