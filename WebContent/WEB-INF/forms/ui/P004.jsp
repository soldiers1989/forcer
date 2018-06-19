<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="head1.jspf"%>
<style>
<!--
.hide{display: none;}
-->
</style>
<script type="text/javascript">
function page(pageno){
	$("#subForm").append('<input type="hidden" name="pageno" value="'+ pageno +'">');
	$("#subForm").submit();
}
</script>
<%@include file="head2.jspf" %> 
${jspPage.script}
${jspPage.css}
<!--中间内容-->
<div class="mid-box fl" id="mid-box">
<div class="top pl_20 pr_20">
   <span class="min-col f16">${title}</span>
   <c:if test="${not empty backbutton}">
	   <div class="tl ml_20 mb_20" style="margin-top:20px;">
	       <a href="javascript:window.history.go(-1);" class="min-col"
	           style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
	   </div>
   </c:if>
</div>
<c:if test="${not empty tab.components}">
	<div class="tab_box clear mr_20 mt_20 ml_20 ui-bd-b">
		<div class="tab_name">
	   		${tab}
		</div>
	</div>
</c:if>

<form id="subForm" action="${formAction}" method="post">
	<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
	    <div class="fl leftSide">
	    	${leftSide}
	    </div>
	    <div class="fr rightSide">
	    	${rightSide}
	    </div>
	</div>
</form>

<div role="grid">
	<div class="table">
		${grid}
	</div>
</div>

<c:if test="${pages.count >= 1}">
	<div class="foot-page">
		<a href="javascript:page(1);" class='page-index'>首页</a>
		<a href="javascript:page(${pages.prior});">上一页</a>
		<a href="javascript:page(${pages.next});">下一页</a>
		<a href="javascript:page(${pages.count});" class="page-last">尾页</a>
		笔数：${pages.recordCount}, 
		页数：${pages.current} / ${pages.count}
	</div>
</c:if>

</div>

<%@include file="footer.jspf"%>