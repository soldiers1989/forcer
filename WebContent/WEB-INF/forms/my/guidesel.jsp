<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<div class="header2">
    <input type="hidden" value="${type}" name="type">
    <a href="FrmMore.userCenter" class="prev"></a>
    <div class="head_title font18">使用指南</div>
</div>
<div class="main_content" id="use_guide">
    <div id="mat"></div>
    <div class="list">
	    <ul class="message_list">
			<li>
				<a href="FrmUseProcess.processShow?type=${type }" class="flexLayout">
					<div class="list_left">使用流程</div>
					<div class="list_right"><img src="../../img/rightArrows.png" alt=""></div>
				</a>
			</li>    
	    </ul>
	    <ul class="message_list">
		    <c:forEach items="${values }" var="value">
				<li class="border_t">
					<a href="FrmGuideList.guideDetails?id_=${value.items.id_ }" class="flexLayout">
						<div class="list_left">${value.items.title_ }</div>
						<div class="list_right"><img src="../../img/rightArrows.png" alt=""></div>
					</a>
				</li>
			</c:forEach>
	    </ul>
    </div>
<%-- 	<a href="FrmGuideList.selArcitle?id_=${value.items.id_}" class="concat_kefu font14 text-gold mt_30">联系客服</a> 
 --%></div>
</body>
</html>