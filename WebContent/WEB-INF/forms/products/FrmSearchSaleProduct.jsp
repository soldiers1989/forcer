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
    	text-align: center;
    	padding: .51rem 0;
    }
    .searchBtn{
    height: 70% !important;
    width: 17% !important;
    font-size: 0.256rem !important;
    }
</style>
</head>
<body>
<div class="header1">
    <a href="javascript:history.go(-1);" class="prev"></a>
    <div class="head_title font18">搜索</div>
</div>
<div id="mat2"></div>
<form class="headSearch" style="top:.769rem;" action="FrmRentWei.searchSaleProduct">
    <img src="../../img/search1.png" alt="">
    <input type="hidden" name="submit" value="submit">
    <input type="text" class="searchBox font13"  name="searchText" placeholder="请输入要搜索的商品名称" value="${searchText }">
    <input type="submit" class="searchBtn" value="搜索" >
<!--     <button class="searchBtn" id="searchImg">搜索</button> -->
</form>
<!-- <div style="padding: 50px">
    <input type="text" id="searchText" placeholder="请输入要搜索的商品名称">
    <img src="../../img/search.png" alt="" id="searchImg">
</div> -->
<div class="main_content" id="rent_list">
    
    <div>
        <c:if test="${ empty saleProducts}">
            <div class="no_result font13">
                <p>抱歉，没有相关商品</p>
                <p>请重新输入你要查找的商品名称</p>
            </div>
        </c:if>
        <c:if test="${not empty saleProducts}">
            <ul class="online_commodityList clearfix">
            <c:forEach items="${saleProducts}" var="product">
                <li>
                    <a href="FrmWeiPro.saleProDetail?ruKuId_=${product.items.ruKuId_}">
                        <div class="homepage_commodity_img"><img src="${product.items.proZsImges_ }" alt=""></div>
<%--                         <div class="cabinet_address">${product.items.communityName_}${product.items.boxId_}号箱子</div> --%>
                        <div class="homepage_commodity_name">${product.items.proName_ }</div>
                        <div class="cash_pledge text-gold font10 tl pl_15"><span>售价：￥</span><span>${product.items.salePrice_ }</span></div>
                        <div class="cash_pledge text-gold font10 tl pl_15"><span>会员价：￥</span><span>${product.items.saleMemPrice_ }</span></div>
                    </a>
                </li>
            </c:forEach>
            </ul>
        </c:if>
    </div>
<%--     <div>
        <p class="recommend_hint">-----------<span class="">附近商品推荐</span>-----------</p>
        <ul class="online_commodityList clearfix">
        <c:forEach items="${nears}" var="near">
            <li>
                <a href="FrmWeiPro?zhuCode_=${near.items.zhuCode_}">
                    <div class="homepage_commodity_img"><img src="${near.items.twoImgUrl_ }" alt=""></div>
                    <div class="cabinet_address">${near.items.communityName_}${near.items.boxId_}号箱子</div>
                    <div class="homepage_commodity_name">${near.items.proName_ }</div>
                    <div class="homepage_commodity_price">
                    <c:if test="${near.items.isDiscount_=='0' }">
                        <div class="homepage_commodity_price"><span class="red">￥${near.items.dayRentMoney_ }</span></div>
                    </c:if>
                    <c:if test="${near.items.isDiscount_=='1' }">
                        <div class="homepage_commodity_price"><span class="red">￥${near.items.discountPrice_ }</span><span class="old_price">￥${near.items.dayRentMoney_ }</span></div>
                    </c:if>
                    </div>
                    <div class="cash_pledge text-gold font10 tl pl_15"><span>押金：￥</span><span>${near.items.cashPledge_ }</span></div>
                </a>
            </li>
        </c:forEach>
        </ul>
    </div> --%>
    <c:if test="${!empty msg}">
        <div style="color: red;" class="msg">${msg}</div>
    </c:if>
</div>
</body>
<script type="text/javascript">
    /* $("#searchImg").on("click",function(){
        var searchText = $("#searchText").val();
        alert(searchText);
        window.location.href="FrmRentWei.searchSaleProduct?sub=submit&searchText="+searchText;
    }) */
</script>
</html>