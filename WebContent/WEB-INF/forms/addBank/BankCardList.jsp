
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../jspf/head1.jspf"%>
  <%@  taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href=""></link>
<title>一起享</title>
<style>
	.cash_pledge_list li{
		width:100%;
		height: 0.819rem;
		border-bottom: 1px solid #e6e6e6;
		margin:auto;
		line-height:0.819rem;
	}
	.cash_pledge_list li a{
		width:100%;
		height: 100%;
		line-height:0.819rem;
		border-bottom: none;
	}
</style>
</head>
<body>
	<div class="header2">
		<a href="javascript:history.go(-1);" class="prev"></a>
		<div class="head_title font18">银行卡绑定</div>
	</div>
	<div class="header2">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">银行卡绑定</div>
    <div class="more"></div>
</div>
<div class="cardMain_content">
    <div id="mat"></div>
    <c:if test="${empty Lists}">
   		<div class="noCard"><img src="${cdn }/img/card.png" alt=""></div>
    	<div class="noCard_tishi">目前还没有绑定银行卡，快去添加</div>
    </c:if>
    <c:forEach items="${Lists}" var="lists">
     <div class="cardTypeAndMess">
        <div class="alogo"><img src="${cdn }/img/agriculture.png" alt=""></div>
        <div class="amess">
            <div class="font209">${lists.items.bankName_ }</div>
            <div class="font188">${lists.items.cardType_ }</div>
           <!--  <div class="mt_45 font41"><span>****</span><span>****</span><span>****</span><span>4584</span></div> -->
            <div class="mt_45 font20">${lists.items.cardNum_ }</div>
        </div>
    </div>
    </c:forEach>
    <div id="mat"></div>
    <div class="addCard"><a href="FrmAddBank.gotoAddCard">添加银行卡</a></div>
</div>
	<%-- <div class="main_content" id="cash_pledge">
		<div id="mat"></div>
			<div class="content">
			<c:forEach items="${Lists}" var="lists">
				<p>银行：${lists.items.bankName_ }</p>
				<p>银行卡类型:${lists.items.cardType_ }</p>
				<p>银行卡号：:${lists.items.cardNum_ }</p>	
				<p><a href="FrmAddBank.delBankCard?cardNum_=${lists.items.cardNum_}">删除</a></p>		
			</c:forEach></div>
		
		
			<a href="FrmAddBank.gotoAddCard">添加银行卡</a>
	</div> --%>

</body>
<script type="text/javascript">
	
</script>
</html>