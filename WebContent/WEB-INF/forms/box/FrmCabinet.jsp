<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../jspf/head1.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="${cdn}/js/jquery-1.9.1.min.js"></script>
<title>一启享</title>
<style>
    #fristName_{
            border: 0; 
            background: transparent;
    }
    .header1 .more{
        width: .5rem;
        text-align: right;
    }
    .header1 input{
        background-color: transparent;
        border: 0;
        color: #ffffff;
        -webkit-appearance: button;
        width: 1.3rem;
    }
    .head_title img{
        width: 0.3rem;
        height: .17rem;
        margin-left: .1rem;
    }
    .head_title.rotateActive img{
        transform: rotate(-180deg);
        /*transition: all .2s linear;*/
    }
    .head_title select option{
        /*background-color: #88213d;*/
        background-color: #00000085;
    }
    .homepage_commodity_name {
        padding: .17rem .255rem;
    }
    .homepage_commodity_img {
        height: 1.8rem;
        width: 100%;
    }
    .homepage_commodity_img img {
        width: 100%;
        height: 100%;
    }
    .headSearch{
        background-color: transparent;
    }
    .headSearch img {
        position: absolute;
        left: 0.425rem;
        top: .255rem;
    }
    .headSearch input {
        width: 80%;
        border: 0;
        outline: none;
        height: 65%;
        background-color: white;
        border-radius: .34rem;
        padding-left: 0.6rem;
        box-sizing: border-box;
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        -ms-box-sizing: border-box;
        -o-box-sizing: border-box;
    }
    .no_result{
      height:7rem;
      text-align: center;
      padding: .51rem 0;
      background-image:url('../../img/zwsj.png');
      background-position:center  1.5rem;
      background-repeat: no-repeat;
    }
    /* .no_result{
    	text-align: center;
    	padding: .51rem 0;
    } */
    .no_content img{
      position: absolute;
      left: 50%;
      top: 50%;
      transform: translate(-50%,-50%)
    } 
    .homepage_commodity_price .red{
    	margin-right:.1rem;
    }
</style>
</head>
<body>
<div class="header1">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">搜索</div>
</div>
<div id="mat2"></div>
 <form class="headSearch" style="top:.769rem;">
    <a id="searchIMG" class="search"><img src="../../img/search1.png" alt=""></a>
    <input type="text" class="searchBox font13"  id="searchText" value="${searchText}">
     <input type="hidden" value="${cabinetId}" id="cabinetId">
    <a class="searchBtn" id="searchBtn" style="float:none">搜索</a>
</form> 

<div class="main_content" id="rent_list">
    
    <div style="height:100%">
        <c:if test="${ empty products}">
            <div class="no_result font13">
                <p>没有搜索到结果</p>
                <p>目前暂未存放</p>
                <%-- <c:if test="${empty products}"><div  class="no_content"><img src="../../img/zwsj.png" style="width: 4rem;">
                </div></c:if> --%>
            </div>
        </c:if>
        <c:if test="${not empty products}">
            <ul class="online_commodityList clearfix">
            <c:forEach items="${products}" var="product">
                <li>
                    <a href="FrmWeiPro?zhuCode_=${product.items.zhuCode_}">
                        <div class="homepage_commodity_img"><img src="${product.items.proImage_ }" alt=""></div>
                        <div class="cabinet_address">${product.items.communityName_}${product.items.boxId_}号箱子</div>
                        <div class="homepage_commodity_name">${product.items.proName_ }</div>
                        <div class="homepage_commodity_price">
                        <c:if test="${product.items.isDiscount_=='0' }">
                            <div class="homepage_commodity_price"><span class="red">￥${product.items.dayRentMoney_ }/天</span></div>
                        </c:if>
                        <c:if test="${product.items.isDiscount_=='1' }">
                            <div class="homepage_commodity_price"><span class="red">￥${product.items.discountPrice_ }/天</span><span class="old_price">￥${product.items.dayRentMoney_ }/天</span></div>
                        </c:if>
                        </div>
                        <div class="cash_pledge text-gold font10 tl pl_15"><span>押金：￥</span><span>${product.items.cashPledge_ }/天</span></div>
                    </a>
                </li>
            </c:forEach>
            </ul>
  		</c:if>
    <div>
</div>
</body>
<script type="text/javascript">
$("#searchIMG").on("click",function(){
   var searchText = $("#searchText").val();
   var cabinetId = $("#cabinetId").val();
   window.location.href="FrmMyBoxGroup.ProductDetail?searchText="+searchText+"&cabinetId="+cabinetId;
})
$("#searchBtn").on("click",function(){
   var searchText = $("#searchText").val(); 
   var cabinetId = $("#cabinetId").val();
   window.location.href="FrmMyBoxGroup.ProductDetail?searchText="+searchText+"&cabinetId="+cabinetId;
})
</script>

</html>