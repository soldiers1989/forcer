<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="head1.jspf"%>
<style>
<!--
.hide {
	display: none;
}
-->
</style>
<script type="text/javascript">
	/* function page(pageno){
	 $("#subForm").append('<input type="hidden" name="pageno" value="'+ pageno +'">');
	 $("#subForm").submit();
	 } */
		$("select").on("change", function() {
			$("#subForm").attr("action", "FrmHealthData");
			$("#subForm").submit();
		});
		function page(pageno){
			  $("#subForm").append('<input type="hidden" name="pageno" value="'+ pageno +'">');
			  $("#subForm").submit();
			}
		$(function() {
		//根据输入页数跳转
		$("#goto_").click(function() {
			var pageNum1 = $("#pageNum1").val();
			var counts = $("#counts").val();
			//判断输入的页数是否超出总页数
			if (pageNum1 <= counts) {
				page(pageNum1);
			} else {
				alert("请输入有效的页数！");
			}
		})
	});
</script>
<%@include file="head2.jspf"%>
${jspPage.script} ${jspPage.css}
<!--中间内容-->
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20">
		<span class="min-col f16">${title}</span>
	</div>
	<c:if test="${not empty tab.components}">
		<div class="tab_box clear mr_20 mt_20 ml_20 ui-bd-b">
			<div class="tab_name">${tab}</div>
		</div>
	</c:if>

	<form id="subForm" action="" method="post">
		<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
			<div class="fl leftSide">${leftSide}</div>
			<div class="fr rightSide">${rightSide}</div>
		</div>
	</form>

	<div role="grid">
		<div class="table">${grid}</div>
	</div>

	<%-- <c:if test="${pages.count >= 1}">
	<div class="foot-page">
		<a href="javascript:page(1);" class='page-index'>首页</a>
		<a href="javascript:page(${pages.prior});">上一页</a>
		<a href="javascript:page(${pages.next});">下一页</a>
		<a href="javascript:page(${pages.count});" class="page-last">尾页</a>
		笔数：${pages.recordCount}, 
		页数：${pages.current} / ${pages.count}
		
		
	</div>
</c:if> --%>
<div class="foot-page">
	<a href="javascript:page(1);" class='page-index' id="pager">首页</a> <a
		href="javascript:page(${pages.prior});" id="pager"></a>
	<c:choose>
		<c:when test="${pages.current <= 5 }">
			<c:forEach var="i" begin="1" end="${pages.current}">
				<c:choose>
					<c:when test="${pages.current == i }">
						<span class="currentPage" id="pager"
							style="background: #108ee9; color: #fff; border: 1px solid #108ee9; border-radius: 4px;">${pages.current}</span>
					</c:when>
					<c:otherwise>
						<a href="javascript:page(${i })" id="pager">${i }</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<span class="pageBreak">...</span>
			<c:forEach var="i" begin="${pages.current - 3}"
				end="${pages.current}">
				<c:choose>
					<c:when test="${pages.current == i }">
						<span class="currentPage">${pages.current}</span>
					</c:when>
					<c:otherwise>
						<a href="javascript:page(${i })">${i }</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	<c:choose>
		<c:when
			test="${pages.current >= pages.count - 4 || pages.count - 4 <= 0}">
			<c:forEach var="i" begin="${pages.current + 1}" end="${pages.count}">
				<a href="javascript:page(${i })" id="pager">${i }</a>
			</c:forEach>
		</c:when>
		<c:otherwise>
			<c:forEach var="i" begin="${pages.current + 1}"
				end="${pages.current + 3}">
				<a href="javascript:page(${i })" id="pager">${i }</a>
			</c:forEach>
			<span class="pageBreak">...</span>
			<a href="javascript:page(${pages.count })">${pages.count}</a>
		</c:otherwise>
	</c:choose>
	<%-- next and last --%>
	<c:if test="${pages.count >= 1}">
		<!-- <div class="foot-page"> -->
		<a href="javascript:page(${pages.next});" id="pager">></a>
		<a href="javascript:page(${pages.count});" class="page-last"
			id="pager">尾页</a>
		<span id="page-num"> <input type="hidden" id="counts"
			value="${pages.count}" /> 页数：${pages.current} / ${pages.count}

		</span>
                                         跳至<input type="text"
			value="${pages.current }" size="2" id="pageNum1">页
                      <button type="button" id="goto_">GO</button>
	</c:if>
</div>
</div>
<%@include file="footer.jspf"%>