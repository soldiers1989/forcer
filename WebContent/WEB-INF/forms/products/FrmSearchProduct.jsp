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
      height: 4rem;
    text-align: center;
    padding: .51rem 0;
    background-image: url(../../img/zwsj.png);
    background-position: center 1.5rem;
    background-repeat: no-repeat;
    background-size: 27%;
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
    <a class="searchBtn" id="searchBtn" style="float:none">搜索</a>
</form> 
<!-- <div class="header1">
    <a  class="search"></a>
    <div class="head_title font18">
        <input type="text" class="searchBox fl" id="searchText" value="" placeholder="搜索你想要的 " onkeydown="searchenter1(this);">
    </div>
    </div> -->
<!-- <div style="padding: 50px">
    <input type="text" id="searchText" placeholder="请输入要搜索的商品名称">
    <img src="../../img/search.png" alt="" id="searchImg">
</div> -->
<div class="main_content" id="rent_list">
    <div >
        <c:if test="${empty products}">
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
                        <div class="homepage_commodity_img"><img src="${product.items.twoImgUrl_ }" alt=""></div>
                        <div class="cabinet_address">${product.items.communityName_}${product.items.boxId_}号箱子</div>
                        <div class="homepage_commodity_name">${product.items.proName_ }</div>
                        <div class="homepage_commodity_price">
                        <c:if test="${product.items.isDiscount_=='0' }">
                            <div class="homepage_commodity_price"><span class="red">￥${product.items.dayRentMoney_ }</span></div>
                        </c:if>
                        <c:if test="${product.items.isDiscount_=='1' }">
                            <div class="homepage_commodity_price"><span class="red">￥${product.items.discountPrice_ }</span><span class="old_price">￥${product.items.dayRentMoney_ }</span></div>
                        </c:if>
                        </div>
                        <div class="cash_pledge text-gold font10 tl pl_15"><span>押金：￥</span><span>${product.items.cashPledge_ }</span></div>
                    </a>
                </li>
            </c:forEach>
            </ul>
           </c:if>
    </div>
    <div>
  
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
    </div>
    <c:if test="${!empty msg}">
        <div style="color: red;" class="msg">${msg}</div>
    </c:if>
</div>
</body>
<script type="text/javascript">
$("#searchIMG").on("click",function(){
	 var lng ="${lng}";
     var lat ="${lat}";
    var searchText = $("#searchText").val();
    window.location.href="FrmRentWei.searchProduct?submit=submit&lng="+lng+"&lat="+lat+"&searchText="+searchText;
})
$("#searchBtn").on("click",function(){
	 var lng ="${lng}";searchBtn
     var lat ="${lat}";
    var searchText = $("#searchText").val();
    window.location.href="FrmRentWei.searchProduct?submit=submit&lng="+lng+"&lat="+lat+"&searchText="+searchText;
})

/* function searchenter1(event) {
	document.onkeydown=keyListener;
	 var lng ="${lng}";
     var lat ="${lat}";
	 var searchText = $("#searchText").val();
	function keyListener(e){
	    e = e ? e : event;// 兼容FF
	    if(e.keyCode == 13){
	    	 window.location.href="FrmRentWei.searchProduct?submit=submit&lng="+lng+"&lat="+lat+"&searchText="+searchText;
	    }
	}    
} */


    /* $("#searchImg").on("click",function(){
        var searchText = $("#searchText").val();
        alert(searchText);
        var lng ="${lng}";
        var lat ="${lat}";
        alert("lng="+lng + "lat="+lat);
   	 window.location.href="FrmRentWei.searchProduct?submit=submit&lng="+lng+"&lat="+lat+"&searchText="+searchText;
    }) */
</script>
</html>