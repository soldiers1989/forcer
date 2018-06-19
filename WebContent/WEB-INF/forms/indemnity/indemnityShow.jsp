<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${cdn }/css/order.css">
<title>一启享</title>
<style></style>
</head>
<body>
<div class="header2">
    <a href="javascript:history.back(-1)" class="prev"></a>
    <div class="head_title font18">赔付单</div>
    
</div>
<div class="main_content" id="idea_feedback">
    <div id="mat"></div>
    <form action="">
	    <c:forEach items="${indemnity }" var="in">
	    <a href="FrmIndemnity.indemnityDetails?operateId_=${in.items.operateId_}&orderId_=${in.items.orderId_}&zhuCode_=${in.items.zhuCode_}">
		    <div class="indmnity">
		    	<div class="indmnityTitle">
			    	<span class="addr">${in.items.communityName_ }</span>
			    	<c:if test="${in.items.orderType_  == '1'}">
						<span class="way">自取租赁</span>
					</c:if>
					<c:if test="${in.items.orderType_  == '2'}">
						<span class="way">寄送上门 </span>
					</c:if>
					<c:if test="${in.items.orderType_  == '3'}">
						<span class="way">寄送到柜</span>
					</c:if>
		    	</div>
			    <div class="indmnityDetail flexLayout">
			    	<div class="indmnityImg"><img src="${in.items.proZsImges_ }" alt=""></div>
			    	<div class="indmnityMess">
			    		<div class="font14">${in.items.name_ }</div>
			    		<div class="mon">赔付金额：<span class="font15">${in.items.pay_ }</span></div>
			    	</div>
			    	<div class="indmnityMore"><img alt="" src="${cdn }/img/right.png"></div>
			    </div>
		   </div>
		  </a>
	  </c:forEach> 
   </form>
 </div>
    <%-- <div class="indmnity">
    	<div class="indmnityTitle"><span class="addr">宏昌花园 5598854启享柜</span><span class="way">自取租赁</span></div>
	    <div class="indmnityDetail flexLayout">
	    	<div class="indmnityImg"><img src="${cdn }/img/1.jpg"></div>
	    	<div class="indmnityMess">
	    		<div class="font14">佳能750D单反相机</div>
	    		<div class="mon">赔付金额：<span class="font15">￥200</span></div>
	    	</div>
	    	<div class="indmnityMore"><img alt="" src="${cdn }/img/right.png"></div>
	    </div>
   </div> --%>
<%-- <h2>赔付单</h2>
<form action="">
	<c:forEach items="${indemnity }" var="in">
	<a href="FrmIndemnity.indemnityDetails?operateId_=${in.items.operateId_}&orderId_=${in.items.orderId_}&zhuCode_=${in.items.zhuCode_}">
		<p>
			<c:if test="${in.items.orderType_  == '1'}">
				自取租赁
			</c:if>
			<c:if test="${in.items.orderType_  == '2'}">
				寄送上门 
			</c:if>
			<c:if test="${in.items.orderType_  == '3'}">
				寄送到柜
			</c:if>
		</p>
		<p>${in.items.communityName_ } ${in.items.name_ }</p>
		<p>${in.items.proName_ }</p>
		<p>赔付金额￥${in.items.pay_ }</p>
		<p>
			<img alt="" src="${in.items.proZsImges_ }" style="width:150px;">
		</p>
	</a>
	</c:forEach>
</form> --%>
</body>
</html>