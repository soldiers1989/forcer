<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../ui/head1.jspf"%>
<%@include file="../ui/head2.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
<style>
.ywimg {
	width: 150px;
	margin: 0 15px 15px 0;
}

.imgBox {
	margin-left: 12%;
}
.font_16{
	font-size:16px;
}
</style>
</head>
<body>
	<div class="mid-box fl" id="mid-box">
		<div class="top pl_20 pr_20">
			<span class="min-col f16">查看运维图片</span>
		</div>
		<div class="tab_box mt_20 mb_10 clear pr_20 pl_20">
			<div class="fl leftSide">
				<a href="FrmYunWeiBill" class="min-col btn_style">返回</a>
			</div>
			<div class="fr rightSide"></div>
		</div>
		<div class="easyui-panel tc mt_20 font_16">

			<div class="group-box" name="null" id="component1" visible="false">
				<label>图片:</label>
			</div>
			<div class="group-box" name="null" id="component1" visible="false">
				<div class="imgBox">
					<c:if test="${empty imgs.items.imgPath_ }">
					 	暂无运维图片
					</c:if>
					<c:forEach items="${imgs.items.imgPath_ }" var="img">
						<img alt="" src="${img}" class="ywimg">
					</c:forEach>
				</div>
			</div>
		</div>
	</div>


</body>
</html>