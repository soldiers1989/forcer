<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户端柜组搜索页面</title>
</head>
<style>
 .no_content img{
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translate(-50%,-50%)
    } 
    .no_content{
      height:7rem;
      text-align: center;
      padding: .51rem 0;
      background-image:url('../../img/zwsj.png');
      background-position:center  1.5rem;
      background-repeat: no-repeat;
    }
</style>
<body>
<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">柜组搜索</div>
</div>
<div class="main_content" id="myOrder_search">
    <div id="mat"></div>
    <form action="FrmMyBoxGroupfind" method="post" class="order_search">
        <input type="text" id="id_cabinetId" placeholder="请输入关键词" name="address_">
        <input type="submit" value="搜索" class="searchBtn">
    </form>
     <c:if test="${empty values}">
        <div  class="no_content"><!-- <img src="../../img/zwsj.png" style="width: 4rem;"> -->
         </div>
      </c:if>
       <c:if test="${not empty values}">
    <div class="list mt_10">
        <ul class="message_list">
        
            <c:forEach items="${values }" var="value" varStatus="status">
                <li>
                    <a href="FrmMyBoxGroup?cabinetId=${value.items.id_ }" class="flexLayout">
                        <div class="list_left">
                            <div class="MyBoxGroup_name cont14">${value.items.communityName_}</div>
                            <div class="MyBoxGroup_address font12 text-gray">${value.items.address_}</div>
                        </div>
                        <div class="list_right"><img src="../../img/rightArrows.png" alt=""></div>
                    </a>
                </li>
            </c:forEach>
        </ul>
    </div>
     </c:if>
    <%-- <c:forEach items="${values }" var="value" varStatus="status">
    地址：${value.items.address_}
    社区：${value.items.communityName_}<br>
    <a href="FrmMyBoxGroup?cabinetId=${value.items.id_ }">详情</a><br>
    </c:forEach> --%>
</div>
<!-- <form action="FrmMyBoxGroupfind" method="post">
<input type="text" id="id_cabinetId" name="address_"> 
<input type="submit" value="搜索"> 
</form> -->
</body>
</html>