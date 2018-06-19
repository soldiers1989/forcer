<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../jspf/head1.jspf" %> 
<%@include file="../jspf/head2.jspf" %> 
<header class="head">
	<i class="fa fa-angle-left"></i>
</header>
<a href="FrmCityManage.executeAdd">增加</a>
 <table>
  <tr>
    <th>账号</th>
    <th>城市简称</th>
    <th>城市全称</th>
    <th>微信公众号</th>
    <th>账号类型</th>
  </tr>
  <c:forEach var ="item" items="${cityItems }">
  <tr>
    <td>${item.items.corpNo_ }</td>
    <td>${item.items.shortName_ }</td>
    <td>${item.items.name_ }</td>
    <td>${item.items.wx_account_ }</td>
    <td>${item.items.corpType_ == 0?"城市账号":"运营账号" }</td>
    <td><a href="FrmCityManage.executeDel?id=${item.items.UID_ }">删除</a>&nbsp;&nbsp; <a href="FrmCityManage.executeModify?corpNo=${item.items.corpNo_ }">修改</a></td>
  </tr>
  </c:forEach>
</table>
 <%@include file="../jspf/adminFooter.jspf"%>