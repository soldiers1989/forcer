<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@include file="../jspf/head1.jspf"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>消息管理</title>
<style>
	.no_result{
      height:7rem;
      text-align: center;
      padding: .51rem 0;
      background-image:url('../../img/zwsj.png');
      background-position:center  center;
      background-repeat: no-repeat;
    }
</style>
</head>
<body>
<!-- 消息列表 -->
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">消息列表</div>
</div>
<div class="main_content" id="myMessage_list">
    <div id="mat"></div>
    <ul class="myMessage_list">
            <c:if test="${empty values}"><!-- <img src="../../img/zwsj.png"> --><div class="no_result"></div></c:if>
            <c:if test="${not empty values}">
             <c:forEach items="${values }" var="value" varStatus="status">
              <li>
                 <a id="id_" href="FrmMessageList.getSystemDetails?id_=${value.items.id_}">
                    <div class="font15 myMessage_title"> ${value.items.title_}</div>
                    <div class="font12 text-gray"><fmt:formatDate value="${value.items.sendTime_ }" type="date" pattern="yyyy-MM-dd HH:mm:ss"/></div>  
                     <div class="font15 myMessage_title"> 
                     <c:if test="${fn:length(value.items.content_) > 10 }">
                          ${fn:substring(value.items.content_,0,10)}...
                                </c:if>
                    <c:if test="${fn:length(value.items.content_)  <= 10 }">
                                     ${value.items.content_}
                                    </c:if>
                     </div>
                </a>
             </li>
                 </c:forEach>
            </c:if>
          
       
    </ul>
</div>
</body>
</html>