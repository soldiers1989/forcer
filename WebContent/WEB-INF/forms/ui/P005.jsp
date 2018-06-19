<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="head1.jspf"%>
<script type="text/javascript"
	src="${cdn}/admin/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="${cdn}/admin/js/messages_cn.js"></script>
<script type="text/javascript">
	$(function() {
		$("form").validate();
	});
</script>
<%@include file="head2.jspf"%>
<script type="text/javascript" src="${cdn}/admin/js/ajaxfileupload.js"></script>
<style type="text/css">
	.fhd  {
		margin-left : 10px;
		margin-right: 10px;
		margin-top: 10px;
		width: 20px;
		line-height:20px;
		border-radius: 5px;
		float: left;
	}
</style>

${jspPage.script} ${jspPage.css}
<!--中间内容-->
<div class="mid-box fl" id="mid-box">
	<div class="top pl_20 pr_20">
		<%-- <c:if test="${message != 'message' }">
			<c:choose>
				<c:when test="${message == 'FrmHealthData.getOneInfo' }">
					<span class="min-col f16">查看健康卡信息</span>
				</c:when>
				<c:otherwise>
					<span class="min-col f16">提交信息</span>
				</c:otherwise>
			</c:choose>
		</c:if> --%>
		<span class="min-col f16">${title }</span>
	</div>
	<div class="easyui-panel tc mt_20">
		<div class="tl ml_20 mb_20">
			<a href="javascript:window.history.go(-1);" class="min-col"
				style="padding: 4px 10px; background: #48b2bd; color: #fff; border-radius: 3px;">返回</a>
		</div>
		${content}
	</div>
	<c:if test="${message == 'FrmHealthData.getOneInfo' }">
		<div style="text-align:center; margin-top: 40px;margin-left: 430px;">
			<div class="fhd"  id="fhd1"><a  href="FrmHealthData.getOneInfo?pageNum=1&UID_=${UID_ }">1</a></div>
			<div class="fhd"  id="fhd2" ><a  href="FrmHealthData.getOneInfo?pageNum=2&UID_=${UID_ }">2</a></div>
			<div class="fhd"  id="fhd3"><a href="FrmHealthData.getOneInfo?pageNum=3&UID_=${UID_ }">3</a></div>
		</div>
	</c:if>
	<script type="text/javascript">
		var pageNum = ${pageNum};
		  if (pageNum == '1') {
			  $("#fhd1 a").css("color","#48b2bd");
		  }
		  if (pageNum == '2') {
			  $("#fhd2 a").css("color", "#48b2bd");
		  }
		  if (pageNum == '3') {
			  $("#fhd3 a").css("color", "#48b2bd");
		  }
	</script>
</div>

<%@include file="footer.jspf"%>