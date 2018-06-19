<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>一起享</title>
</head>
<style>
 .no_content img{
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translate(-50%,-50%)
    } 
    .no_content{
      height:100%;
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
    </div>
</body>
</html>