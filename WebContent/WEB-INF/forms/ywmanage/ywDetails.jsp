<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
<style type="text/css">
.ywDetailPart1{
	width:100%;
	margin-top:2px ;
	background-color:#fff;
	padding:0.2rem .239rem;
	box-sizing:border-box;
	font-size: 0.222rem;
}
.ywDetailPart1 ul li,.ywDetailPart2 ul li{
	line-height:.4rem;
	border-bottom:1px solid #f5f5f5;
}
.ywDetailPart1 ul li:last-child,.ywDetailPart2 ul li:last-child{
	border-bottom:0
}
.ywDetailPart2{
	width:100%;
	margin-top:.2rem; ;
	background-color:#fff;
	padding:.2rem .239rem;
	box-sizing:border-box;
	font-size: 0.222rem;
}

.ywDetailPart2 .messageText{
	line-height:.5rem;
}
.ywDetailPart2 .message textarea{
	width:100%;
	height: 1.698rem;
	border-radius: 0.128rem;
	border: solid 0.009rem #ececec;
}
.ywDetailPart2 .ywPic img{
	width: 1.655rem;
	height: 1.288rem;
	background-color: #f9f9f9;
	border-radius: 0.128rem;
	margin:0 .2rem .2rem 0; 
}
</style>
</head>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">运维清单</div>
</div>
<div class="main-contnet" id="maintain_management">
    <div id="mat"></div>
	<div class="ywDetailPart1">
		<ul>
			<li>物品名称：<label>${yunwei.items.proName_}</label></li>
			<li>识别码：<label>${yunwei.items.zhuCode_}</label></li>
			<li>箱子编号：<label>${yunwei.items.boxId_}</label></li>
			<li>状态：<label>开箱</label></p>
			<li>本次运维订单编号：<label>${yunwei.items.operateId_}</label></li>
			<li>累计租借时长：<label>${yunwei.items.sumTime_}/天</label></li>
			<li>历史检查维护：
				<c:if test="${empty yunwei.items.hisOpeCount}">
					0次
				</c:if>
				<c:if test="${not empty yunwei.items.hisOpeCount}">
					<label>${yunwei.items.hisOpeCount}次</label>
				</c:if>
			</li>
		</ul>
	</div>
	<div  class="ywDetailPart2">
		<ul>
			<li>本次运维定义折损率：<label>${yunwei.items.nowLoss_}%</label></li>
			<li>本次订单开锁次数：<label>${yunwei.items.openTime}次</label></li>
			<li>物品上次归还时间：<label>
				<fmt:formatDate value="${yunwei.items.returnOverTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</label></li>
			<li>订单上次归还人电话：<label>${yunwei.items.recPhone_}</label></li>
			<li>物品上次归还人租借前是否有运维：<label>${yunwei.items.lastState_ =='0'?"有运维":"无运维"}</label></li>
			<li>物品本次运维开箱时间：<label>
				<fmt:formatDate value="${yunwei.items.OpenBoxTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</label></li>
			<li>物品本次运维关箱时间：<label>${yunwei.items.CloseBoxTime_}</label></li>
			<li>上报人员：<label>${yunwei.items.operateManName_}</label></li>
			<li>上报时间：<label>
				<fmt:formatDate value="${yunwei.items.createDate_}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</label></li>
			<li>更新时间：<label>
				<fmt:formatDate value="${yunwei.items.updateDate_}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</label></li>
		</ul>
	</div>
	<!-- 留言 -->
	<div class="ywDetailPart2">
		<div class="messageText">留言</div>
		<div class="message"><textarea >${yunwei.items.leaveMess_}</textarea></div>
		<div class="messageText">相关图片</div>
		<div class="ywPic">
			<c:if test="${empty yunwei.items.imgPath_}">
				<div style="color:#666;font-size:.186rem;">暂无图片</div>
			</c:if>
			<c:if test="${not empty yunwei.items.imgPath_}">
			</c:if>
			<c:forEach items="${yunwei.items.imgPath_}" var="img">
				<img alt="" src="${img}">
			</c:forEach>
		</div>
	</div>


	<%-- <h2>运维清单</h2>
	<p>物品名称:<label>${yunwei.items.proName_}</label></p>
	<p>识别码:<label>${yunwei.items.zhuCode_}</label></p>
	<p>箱子编号:<label>${yunwei.items.boxId_}</label></p>
	<p>状态:<label>开箱</label></p>
	<p>本次运维订单编号:<label>${yunwei.items.operateId_}</label></p>
	<p>累计租借时长:<label>${yunwei.items.sumTime_}/天</label></p>
	<p>历史检查维护:
		<c:if test="${empty yunwei.items.hisOpeCount}">
			0次
		</c:if>
		<c:if test="${not empty yunwei.items.hisOpeCount}">
			<label>${yunwei.items.hisOpeCount}次</label>
		</c:if>
	</p>
	<p>历史折损率:
		<c:if test="${empty yunwei.items.hisLoss_}">
			0
		</c:if>
		<c:if test="${not empty yunwei.items.hisLoss_}">
			<label>${yunwei.items.hisLoss_}</label>
		</c:if>
	</p>
	<p>本次运维定义折损率<label>${yunwei.items.nowLoss_}%</label></p>
	<p>本次订单开锁次数:<label>${yunwei.items.openTime}次</label></p>
	<p>物品上次归还时间:<label>
		<fmt:formatDate value="${yunwei.items.returnOverTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
	</label></p>
	<p>订单上次归还人电话:<label>${yunwei.items.recPhone_}</label></p>
	<p>物品上次归还人租借前是否有运维:<label>${yunwei.items.lastState_ =='0'?"有运维":"无运维"}</label></p>
	<p>物品本次运维开箱时间:<label>
		<fmt:formatDate value="${yunwei.items.OpenBoxTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
	</label></p>
	<p>物品本次运维关箱时间:<label>${yunwei.items.CloseBoxTime_}</label></p>
	<p>上报人员:<label>${yunwei.items.operateManName_}</label></p>
	<p>上报时间:<label>
		<fmt:formatDate value="${yunwei.items.createDate_}" pattern="yyyy-MM-dd HH:mm:ss"/>
	</label></p>
	<p>更新时间:<label>
		<fmt:formatDate value="${yunwei.items.updateDate_}" pattern="yyyy-MM-dd HH:mm:ss"/>
	</label></p>
	<p>运维留言:<label>${yunwei.items.leaveMess_}</label></p>
	<p>相关图片:
	<c:forEach items="${yunwei.items.imgPath_}" var="img">
		<img alt="" src="${img}">
	</c:forEach>
	</p> --%>
</body>
</html>