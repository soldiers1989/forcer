<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
     <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一启享</title>
</head>
<style>
.no_content img{
    	position: absolute;
    	left: 50%;
    	top: 50%;
    	transform: translate(-50%,-50%)
    }
</style>
<body>
<div class="header2">
    <!-- <a href="FrmMore.lijiqiandao" class="prev"></a> -->
    <a href="FrmMore.userCenter" class="prev"></a>
    <div class="head_title font18">我的积分</div>
    <div class="more font15"><a href="FrmIntegral.jiFenExplain">积分说明</a></div>
</div>
<div class="main_content" id="mIntegral">
    <div id="mat"></div>
    <div class="mIntegral flexLayout">
        <div class="myVip"><img alt="" src="${cdn }/img/vip2.png"> </div>
        <div class="mIntegral_num">
			<c:if test="${not empty integral.items.signNum}">
				<div class="specific_num">${integral.items.signNum }</div>
         	</c:if>
         	<c:if test="${empty integral.items.signNum}">
				<div class="specific_num">0</div>
         	</c:if>
            <div class="font14">当前积分</div>
        </div>
        <div class="integral_exchange"><!-- <div>积分兑换</div> --></div>
    </div>
    <div class="integral_hint">积分记录</div>
    <div class="no_content">
  	  	<c:if test="${empty myIntegrals }">
			<img alt="" src="${cdn }/img/zwsj.png" style="width: 3rem;">
  		</c:if>
   </div>
       <ul class="integral_list">
        <c:forEach items="${myIntegrals }" var="in">
            <li>
                <a href="#" class="flexLayout">
                    <div class="integral_left">
                        <div class="integral_title">${in.items.type_ == '0'?"签到":"邀请" }</div>
                        <div class="integral_time"><fmt:formatDate value="${in.items.createTime_ }" pattern="yyyy-MM-dd"/></div>
                    </div>
                    <div class="integral_right">+${in.items.integral_ }</div>
                </a>    
            </li>
           </c:forEach>
       </ul>
</div>
<%-- <div>
<p><a href="FrmMore.userCenter">返回</a></p>
    <h2>我的积分</h2> 
    <p><a href="FrmIntegral.jiFenExplain">积分说明</a></p>
    <p>当前积分：${integral.items.signNum }</p>
    <p>当前等级：${integral.items.grade_  }</p>
</div>
<div>
    <h3>积分记录</h3>
     <c:forEach items="${myIntegrals }" var="in">
         <p>${in.items.type_ == '0'?"签到":"邀请" }</p>
         <p>${in.items.integral_ }</p>
         <p>
             <fmt:formatDate value="${in.items.createTime_ }" pattern="yyyy-MM-dd"/>
         </p>
     </c:forEach>
</div> --%>
</body>
</html>