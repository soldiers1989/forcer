<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
</head>
<body>
	<h2>补货单</h2>
	<p>物品名称:<label>${buhuo.items.proName_}</label></p>
	<p>识别码:<label>${buhuo.items.zhuCode_}</label></p>
	<p>箱子编号:<label>${buhuo.items.boxId_}</label></p>
	<p>状态:<label>开箱</label></p>
	<p>本次运维订单编号:<label>${buhuo.items.operateId_}</label></p>
	<p>累计租借时长:
		<c:if test="${empty buhuo.items.sumTime_}">
			0天
		</c:if>
		<c:if test="${not empty buhuo.items.sumTime_}">
			<label>${buhuo.items.sumTime_}/天 </label>
		</c:if>
	</p>
	<p>历史检查维护:
		<c:if test="${empty buhuo.items.hisOpeCount}">
			0次
		</c:if>
		<c:if test="${not empty buhuo.items.hisOpeCount}">
			<label>${buhuo.items.hisOpeCount}次</label>
		</c:if>
	</p>
	<p>历史折损率:
		<c:if test="${empty buhuo.items.hisLoss_}">
			0
		</c:if>
		<c:if test="${not empty buhuo.items.hisLoss_}">
			<label>${buhuo.items.hisLoss_}</label>
		</c:if>
	</p>
	<p>本次运维定义折损率<label>${buhuo.items.nowLoss_}%</label></p>
	<p>本次订单开锁次数:<label>${buhuo.items.openTime}次</label></p>
	<p>物品上次归还时间:<label>
		<fmt:formatDate value="${buhuo.items.returnOverTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
	</label></p>
	<p>订单上次归还人电话:<label>${buhuo.items.recPhone_}</label></p>
	<p>物品上次归还人租借前是否有运维<label>${buhuo.items.lastState_ =='0'?"有运维":"无运维"}</label></p>
	<p>物品本次运维开箱时间:<label>
		<fmt:formatDate value="${buhuo.items.OpenBoxTime_}" pattern="yyyy-MM-dd HH:mm:ss"/>
	</label></p>
	<p>物品本次运维关箱时间:<label>${buhuo.items.CloseBoxTime_}</label></p>
	<p>上报人员:<label>${buhuo.items.operateManName_}</label></p>
	<p>上报时间:<label>
		<fmt:formatDate value="${buhuo.items.createDate_}" pattern="yyyy-MM-dd HH:mm:ss"/>
	</label></p>
	<p>更新时间:<label>
		<fmt:formatDate value="${buhuo.items.updateDate_}" pattern="yyyy-MM-dd HH:mm:ss"/>
	</label></p>
	<p>运维留言:<label>${buhuo.items.leaveMess_}</label></p>
	<p>相关图片:
		<c:forEach items="${buhuo.items.imgPath_}" var="img">
			<img alt="" src="${img}">		
		</c:forEach>
	</p>
</body>
</html>